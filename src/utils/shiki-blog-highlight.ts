/**
 * Syntax highlighting (Shiki, tema nord) alinhado ao blog legado / Astro MDX.
 */
import { marked } from "marked";
import { codeToHtml, type ShikiTransformer } from "shiki";

const SHIKI_THEME = "nord";

const astroCodeTransformer: ShikiTransformer = {
  name: "edgepress-astro-code",
  pre(hast) {
    this.addClassToHast(hast, "astro-code");
    this.addClassToHast(hast, "nord");
    hast.properties.tabindex = 0;
  },
};

export async function highlightCodeBlock(
  code: string,
  lang?: string | null,
): Promise<string> {
  const language = (lang?.trim() || "text").toLowerCase();
  try {
    return await codeToHtml(code, {
      lang: language,
      theme: SHIKI_THEME,
      transformers: [astroCodeTransformer],
    });
  } catch {
    try {
      return await codeToHtml(code, {
        lang: "text",
        theme: SHIKI_THEME,
        transformers: [astroCodeTransformer],
      });
    } catch {
      const escaped = code
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");
      return `<pre class="astro-code nord" tabindex="0"><code>${escaped}</code></pre>`;
    }
  }
}

function decodeHtmlEntities(text: string): string {
  return text
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&amp;/g, "&")
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'");
}

const PLAIN_PRE_CODE_RE =
  /<pre(?:\s[^>]*)?><code(?:\s+class="language-([^"]*)")?[^>]*>([\s\S]*?)<\/code><\/pre>/gi;

/** Re-highlighta blocos `<pre><code>` sem classes Shiki/Astro no HTML já salvo. */
export async function highlightPlainCodeInHtml(html: string): Promise<string> {
  if (!html || html.includes("astro-code") || html.includes('class="shiki')) {
    return html;
  }

  const parts: string[] = [];
  let lastIndex = 0;
  let match: RegExpExecArray | null;
  PLAIN_PRE_CODE_RE.lastIndex = 0;

  while ((match = PLAIN_PRE_CODE_RE.exec(html)) !== null) {
    parts.push(html.slice(lastIndex, match.index));
    const lang = match[1] ?? "text";
    const code = decodeHtmlEntities(match[2] ?? "");
    parts.push(await highlightCodeBlock(code, lang));
    lastIndex = match.index + match[0].length;
  }

  parts.push(html.slice(lastIndex));
  return parts.join("");
}

/** Markdown → HTML com blocos de código destacados (tema nord, classe astro-code). */
export async function markdownToHighlightedHtml(markdown: string): Promise<string> {
  const rawHtml = await marked.parse(markdown);
  return highlightPlainCodeInHtml(String(rawHtml));
}
