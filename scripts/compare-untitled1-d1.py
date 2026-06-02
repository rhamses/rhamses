#!/usr/bin/env python3
import json
import os
import re
import subprocess
import urllib.parse

PATH = "/Users/rhamses/.cursor/projects/Users-rhamses-Sites-farra-media-site-edgepress/uploads/Untitled-1-L1-L222-0.txt"
TAGS_KEY = '["{\\"videos\\"'
OUT_SQL = "drizzle/seed/migrate-jobs-sync-untitled-1.sql"


def sql_str(value: str) -> str:
    return value.replace("'", "''")


def parse_line(line: str):
    if not line.startswith("INSERT"):
        return None
    if 'language\\":\\"ptbr\\"' not in line or 'posttype\\":\\"jobs\\"' not in line:
        return None
    m_id = re.search(r"VALUES\('([^']+)'", line)
    if not m_id:
        return None
    lid = m_id.group(1)
    im = re.search(r",(\d+),(\d+),'(https://bucket\.farra\.media/[^']*)',", line)
    if not im:
        return None
    image = im.group(3)
    tm = re.search(r"VALUES\('[^']+','((?:''|[^'])*)'", line)
    title = tm.group(1).replace("''", "'") if tm else ""
    start = line.find(TAGS_KEY)
    if start == -1:
        return None
    end = line.find('}"]', start)
    if end == -1:
        return None
    raw = line[start : end + 3]
    tags = json.loads(raw)[0]
    tags = json.loads(tags)
    return {
        "legacy_id": lid,
        "title": title.strip(),
        "image": image,
        "videos": tags.get("videos"),
        "fichaTecnica": tags.get("fichaTecnica") or [],
    }


def jnorm(v):
    if v is None or v == "null":
        return None
    if isinstance(v, str):
        try:
            if v.startswith("[") or v.startswith("{"):
                return json.loads(v)
        except json.JSONDecodeError:
            pass
    return v


def norm_url(u):
    return urllib.parse.unquote((u or "").strip())


def main():
    legacy_by_id = {}
    legacy_by_title = {}
    with open(PATH, "r", encoding="utf-8") as f:
        for line in f:
            rec = parse_line(line)
            if not rec:
                continue
            legacy_by_id[rec["legacy_id"]] = rec
            legacy_by_title[rec["title"].lower()] = rec

    proc = subprocess.run(
        [
            "wrangler",
            "d1",
            "execute",
            "edgepress",
            "--local",
            "--json",
            "--command",
            """SELECT p.id, p.title, p.slug,
            json_extract(p.meta_values, '$.legacy_id') as legacy_id,
            json_extract(p.meta_values, '$.image') as image,
            json_extract(p.meta_values, '$.videos') as videos,
            json_extract(p.meta_values, '$.fichaTecnica') as ficha,
            (SELECT att.id FROM posts_media pm JOIN posts att ON att.id=pm.media_id WHERE pm.post_id=p.id LIMIT 1) as att_id,
            (SELECT json_extract(att.meta_values, '$.attachment_path') FROM posts_media pm JOIN posts att ON att.id=pm.media_id WHERE pm.post_id=p.id LIMIT 1) as att_path,
            (SELECT json_extract(att.meta_values, '$.attachment_file') FROM posts_media pm JOIN posts att ON att.id=pm.media_id WHERE pm.post_id=p.id LIMIT 1) as att_file
            FROM posts p
            WHERE json_extract(p.meta_values, '$.posttype') = 'jobs'
            AND p.id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR')
            AND p.status = 'published'""",
        ],
        capture_output=True,
        text=True,
        check=True,
    )
    d1_rows = json.loads(proc.stdout[proc.stdout.find("[") :])[0]["results"]

    fixes = []
    for r in d1_rows:
        leg = legacy_by_id.get(r["legacy_id"]) or legacy_by_title.get(r["title"].strip().lower())
        if not leg:
            continue
        changes = {}
        if leg["legacy_id"] != r["legacy_id"]:
            changes["legacy_id"] = leg["legacy_id"]
        if norm_url(r["image"]) != norm_url(leg["image"]):
            changes["image"] = leg["image"]
        if norm_url(r["att_path"]) != norm_url(leg["image"]):
            changes["att_path"] = leg["image"]
        new_file = os.path.basename(urllib.parse.unquote(leg["image"]))
        if r["att_file"] and r["att_file"] != new_file:
            changes["att_file"] = new_file
        dv, lv = jnorm(r["videos"]), jnorm(leg["videos"])
        if json.dumps(dv, ensure_ascii=False) != json.dumps(lv, ensure_ascii=False):
            changes["videos"] = lv
        df, lf = jnorm(r["ficha"]) or [], leg["fichaTecnica"] or []
        if json.dumps(df, ensure_ascii=False) != json.dumps(lf, ensure_ascii=False):
            changes["fichaTecnica"] = lf
        if changes:
            fixes.append(
                {
                    "id": r["id"],
                    "slug": r["slug"],
                    "title": r["title"],
                    "att_id": r["att_id"],
                    "changes": changes,
                }
            )

    lines = [
        "-- Sync jobs pt_BR com Untitled-1 (farra.sql)",
        "-- Idempotente: pode rodar mais de uma vez",
        "",
    ]
    for f in fixes:
        cid = f["id"]
        ch = f["changes"]
        meta = "meta_values"
        if "legacy_id" in ch:
            meta = f"json_set({meta}, '$.legacy_id', '{sql_str(ch['legacy_id'])}')"
        if "image" in ch:
            meta = f"json_set({meta}, '$.image', '{sql_str(ch['image'])}')"
        if "videos" in ch:
            vjson = json.dumps(ch["videos"], ensure_ascii=False)
            meta = f"json_set({meta}, '$.videos', json('{sql_str(vjson)}'))"
        if "fichaTecnica" in ch:
            fj = json.dumps(ch["fichaTecnica"], ensure_ascii=False)
            meta = f"json_set({meta}, '$.fichaTecnica', json('{sql_str(fj)}'))"
        lines.append(f"-- {f['title']} (id={cid})")
        lines.append(f"UPDATE posts SET meta_values = {meta} WHERE id = {cid};")

        if f.get("att_id") and ("att_path" in ch or "att_file" in ch or "image" in ch):
            img = ch.get("att_path") or ch.get("image")
            fname = ch.get("att_file") or os.path.basename(urllib.parse.unquote(img))
            att_meta = json.dumps(
                {
                    "show_in_menu": False,
                    "menu_options": [],
                    "icon": "line-md:file",
                    "mime_type": "image/png",
                    "attachment_file": fname,
                    "attachment_path": img,
                    "attachment_alt": f["title"],
                },
                ensure_ascii=False,
            )
            lines.append(
                f"UPDATE posts SET title = '{sql_str(fname)}', meta_values = '{sql_str(att_meta)}' WHERE id = {f['att_id']};"
            )
        lines.append("")

    with open(OUT_SQL, "w", encoding="utf-8") as out:
        out.write("\n".join(lines))

    print(f"legacy parsed: {len(legacy_by_id)}")
    print(f"fixes: {len(fixes)}")
    for f in fixes:
        print(f"[{f['id']}] {f['title']}: {', '.join(f['changes'].keys())}")


if __name__ == "__main__":
    main()
