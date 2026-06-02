/**
 * Ajustes em dist/server/wrangler.json após `astro build`.
 *
 * - Projetos Pages (pages_build_output_dir): remove assets explícito (ASSETS é reservado no wrangler).
 * - Projetos Worker (rhamses): mantém assets — o handler @astrojs/cloudflare usa env.ASSETS.fetch.
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
  if (!config.assets?.binding) {
    config.assets = { binding: "ASSETS", directory: "../client" };
    writeFileSync(wranglerJsonPath, JSON.stringify(config));
    console.log("[patch-pages-wrangler] Ensured ASSETS binding for Worker deploy.");
  } else {
    console.log("[patch-pages-wrangler] Worker project; ASSETS binding kept.");
  }
  process.exit(0);
}

if (!config.assets) {
  console.log("[patch-pages-wrangler] Pages project; no assets block to remove.");
  process.exit(0);
}

delete config.assets;
writeFileSync(wranglerJsonPath, JSON.stringify(config));
console.log("[patch-pages-wrangler] Removed ASSETS binding (reserved on Cloudflare Pages).");
