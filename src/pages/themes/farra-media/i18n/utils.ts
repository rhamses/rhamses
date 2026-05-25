import { defaultLang, ui } from "./ui";

function isLangSegment(segment: string | undefined): segment is keyof typeof ui {
  return segment != null && segment in ui;
}

/** Caminho público sem prefixo interno `/themes/{slug}[/pages]`. */
export function getPublicPathFromUrl(url: URL): string {
  const segments = url.pathname.split("/").filter(Boolean);
  const themesIdx = segments.indexOf("themes");

  if (themesIdx >= 0) {
    let start = themesIdx + 2; // após o slug do tema
    if (segments[start] === "pages") {
      start += 1;
    }
    const rest = segments.slice(start);
    if (rest.length === 0) return "/";
    return `/${rest.join("/")}`;
  }

  const normalized = url.pathname.replace(/\/+$/, "") || "/";
  return normalized;
}

export function getLanguageFromUrl(url: URL) {
  const segments = url.pathname.split("/").filter(Boolean);

  // EdgePress reescreve /en/... → /themes/{themeSlug}/en/...
  // e o roteador do tema → /themes/{themeSlug}/pages/en/...
  const themesIdx = segments.indexOf("themes");
  if (themesIdx >= 0) {
    const afterTheme = segments[themesIdx + 2];
    if (afterTheme === "pages") {
      const maybeLang = segments[themesIdx + 3];
      if (isLangSegment(maybeLang)) {
        return maybeLang;
      }
    }

    const maybeLang = segments[themesIdx + 2];
    if (isLangSegment(maybeLang)) {
      return maybeLang;
    }
  }

  const first = segments[0];
  if (isLangSegment(first)) {
    return first;
  }

  return defaultLang;
}
export function useTranslations(lang: keyof typeof ui) {
  return function t(key: keyof (typeof ui)[typeof defaultLang]) {
    return ui[lang][key] || ui[defaultLang][key];
  };
}

/** Prefixo de URL pública para páginas de portfolio/trabalho. */
export function portfolioBasePath(lang: keyof typeof ui): string {
  return lang === defaultLang ? "/portfolio" : `/${lang}/portfolio`;
}
