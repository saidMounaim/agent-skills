---
name: seo
description: Use to audit or improve SEO for public pages (marketing site, landing page, blog, docs, public profiles): metadata, sitemap, robots, Open Graph, structured data, performance and indexing. Use before a public launch or when the user mentions SEO, Google, ranking or share previews. Skip for pages behind login.
---

# SEO

## 1. Map the public surface

List public routes (exclude app pages behind auth, which should be `noindex`). For each: title, description, canonical, indexable? Ask the user for target keywords and the main audience/language if not in `plan/project-plan.md`.

## 2. Audit (report first, then fix through a spec)

**Technical**
- `robots.txt` exists, allows public pages, blocks app/admin/API, points to the sitemap.
- `sitemap.xml` lists every public, canonical URL (Next.js: `app/sitemap.ts`, `app/robots.ts`).
- One canonical URL per page; `www`/non-`www` and trailing slash handled by a redirect.
- Correct status codes: real 404 page, 301 for moved pages, no soft 404s.
- Pages render meaningful HTML on the server (view source shows the content).

**On-page**
- Unique `<title>` (about 50-60 chars) and meta description (about 150-160) per page. Next.js: `metadata` / `generateMetadata`, with a `title.template` in the root layout.
- One `<h1>`, logical heading order, descriptive link text, `alt` on meaningful images.
- `lang` on `<html>`; `hreflang` alternates if the site has FR/AR/EN versions (and `dir="rtl"` for Arabic).

**Sharing**
- Open Graph and Twitter card tags; a 1200×630 OG image per key page (Next.js `opengraph-image.tsx` can generate them).

**Structured data**
- JSON-LD where it fits: `Organization` and `WebSite` on home, `SoftwareApplication` or `Product` for a SaaS, `Article` for posts, `FAQPage` only for real FAQs, `BreadcrumbList` for deep pages. Validate the JSON shape.

**Performance (Core Web Vitals)**
- Run Lighthouse (`npx lighthouse <url> --only-categories=performance,seo,accessibility --output=json`) if available, against a production build, not dev.
- Usual fixes: `next/image` with sizes, `next/font`, no layout shift from late banners, lazy third-party scripts, small JS on landing pages.

## 3. Output

A table: issue, page, impact (high/med/low), fix. Then offer to turn the high-impact items into one `spec` (fix mode) and build it. Add a `## Smoke test` line to the next release: check the live `robots.txt`, `sitemap.xml` and one OG preview.

## Gotchas

- Do not stuff keywords or generate thin pages; it hurts more than it helps.
- `noindex` the app, staging and preview deployments (check `X-Robots-Tag` or metadata on preview URLs).
- Submitting the sitemap in Google Search Console is a step the user does; give them the URL.
