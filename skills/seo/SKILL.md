---
name: seo
description: Use to check or improve search and sharing for public web pages (landing page, marketing site, blog, docs, public profiles) in any framework: titles, descriptions, sitemap, robots, share previews, structured data, speed and indexing. Use before a public launch or when the user mentions SEO, Google, ranking or link previews. Not for pages behind login or for non-web apps.
---

# SEO

Report first. Fixes go through `spec` (fix mode).

## 1. Map the public pages

List every public route. Pages behind login must be `noindex`. Ask for the target keywords, audience and languages if `plan/project-plan.md` does not say.

## 2. Check

**Crawling**
- `robots.txt` allows public pages, blocks app, admin and API routes, and names the sitemap.
- `sitemap.xml` lists every public page once, by its canonical URL.
- One canonical URL per page; `www` and trailing-slash variants redirect.
- Real 404 page, 301 for moved pages.
- The page's HTML already contains its content (view source). If the framework renders only in the browser, public pages need server rendering or pre-rendering.

**On the page**
- Unique title (about 50-60 characters) and description (about 150-160) on every page.
- One `h1`, headings in order, descriptive link text, `alt` on meaningful images.
- `lang` on the `html` element. `hreflang` for each language version; `dir="rtl"` for right-to-left languages.

**Sharing**
- Open Graph and Twitter card tags. A 1200×630 image for key pages.

**Structured data** (JSON-LD, only where it is true)
- `Organization` and `WebSite` on the home page, `SoftwareApplication` or `Product` for a product, `Article` for posts, `BreadcrumbList` for deep pages, `FAQPage` only for a real FAQ.

**Speed**
- Run Lighthouse or a similar tool against a production build, never a dev server.
- Usual fixes: sized and compressed images, fonts that do not shift the layout, less script on landing pages, third-party scripts loaded late.

Use the framework's own way of doing each item (its metadata API, sitemap and robots helpers, image component). Look it up in the framework's docs rather than hand-writing tags.

## 3. Report

A table: issue, page, impact (high, medium, low), fix. Offer to turn the high-impact items into one `spec`. Add to the next release's smoke test: live `robots.txt`, `sitemap.xml`, and one share preview.

## Gotchas

- No keyword stuffing and no thin generated pages.
- Staging and preview deployments must be `noindex`.
- Submitting the sitemap to search consoles is the user's step. Give them the URL.
