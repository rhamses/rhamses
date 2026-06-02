/**
 * Cloudflare Pages reserves the ASSETS binding; the platform injects it automatically.
 * @astrojs/cloudflare still adds assets.binding=ASSETS to dist/server/wrangler.json when
 * pages_build_output_dir is set — remove it so `wrangler deploy` succeeds on Pages CI.
 */
import { existsSync, readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const wranglerJsonPath = join(process.cwd(), "dist/server/wrangler.json");

if (!existsSync(wranglerJsonPath)) {
  console.warn("[patch-pages-wrangler] dist/server/wrangler.json not found; skipping.");
  process.exit(0);
}

const config = JSON.parse(readFileSync(wranglerJsonPath, "utf8"));
const isPages = Boolean(config.pages_build_output_dir);

if (!isPages) {
  console.log("[patch-pages-wrangler] Not a Pages project; no changes.");
  process.exit(0);
}

if (!config.assets) {
  console.log("[patch-pages-wrangler] No assets binding present; no changes.");
  process.exit(0);
}

delete config.assets;
writeFileSync(wranglerJsonPath, JSON.stringify(config));
console.log("[patch-pages-wrangler] Removed ASSETS binding (reserved on Cloudflare Pages).");
