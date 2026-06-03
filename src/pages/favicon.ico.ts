const FAVICON_URL = "/api/media/uploads/blog/favicon.ico";

export const GET = () =>
  new Response(null, {
    status: 302,
    headers: {
      Location: FAVICON_URL,
      "cache-control": "public, max-age=3600",
    },
  });
