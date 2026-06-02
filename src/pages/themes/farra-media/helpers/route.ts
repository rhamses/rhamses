type AstroRouteContext = {
  props: Record<string, unknown>;
  params: Record<string, string | undefined>;
};

/** Redirecionamento seguro em páginas renderizadas pelo roteador do tema. */
export function themeRedirect(location: string): Response {
  return new Response(null, {
    status: 302,
    headers: { Location: location },
  });
}

/** Parâmetro de rota dinâmica quando a página é renderizada pelo roteador do tema. */
export function themeRouteParam(
  astro: AstroRouteContext,
  key: string,
): string | undefined {
  const fromProps = astro.props[key];
  if (fromProps != null && String(fromProps).length > 0) {
    return String(fromProps);
  }

  const fromParams = astro.params[key];
  if (fromParams != null && String(fromParams).length > 0) {
    return fromParams;
  }

  const slugPath = astro.params["slug"];
  if (typeof slugPath === "string" && slugPath.length > 0) {
    const segments = slugPath.split("/").filter(Boolean);
    if (segments.length > 0) {
      return segments[segments.length - 1];
    }
  }

  return undefined;
}
