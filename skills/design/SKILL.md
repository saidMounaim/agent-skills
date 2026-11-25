---
name: design
description: Use to create or update design.md, the project's design rules and tokens, from screens in plan/references/, from the existing UI code, or from a short brief. Use before the first UI feature, when the user adds screens or mockups, or when the UI looks inconsistent. Does not build or restyle screens.
---

# Design

One file, `design.md` at the repo root, tells every agent how the product looks. `spec`, `build` and `verify` read it. Design skills such as Hallmark read it too.

## Pick the source

1. **Screens** in `plan/references/` (Figma exports, mockups, screenshots) → read every image.
2. **Existing UI** → read the theme, tokens, global styles and the most used components.
3. **Neither** → ask 4-5 questions (mood, light or dark, brand color, density, 1-2 products they like the look of). If a design skill is installed, the user can generate a first page with it, then run `design` on the result.

When screens and code disagree, ask which one wins.

## Write `design.md`

```markdown
# Design
Source: <screens | code | brief>, <date>

## Principles (3-5 lines)
## Colors
(by role: background, surface, text, muted, border, primary, success, warning, danger; light and dark values)
## Typography
(font families, size scale, weights, line heights)
## Spacing, radius, shadows
## Layout
(max widths, grid, breakpoints, page shell: nav, sidebar, header)
## Components
(for each: button, input, select, table, card, badge, dialog, toast...: variants and states: hover, focus, disabled, loading, error)
## States
(loading, empty, error, forbidden: how each looks)
## Motion
## Accessibility
(text contrast at least 4.5:1, visible focus, tap targets, labels)
## Do / Don't
## Screens
| Screen | Reference file | Build-plan ID |
```

## Then

1. Put the tokens where the stack expects them (CSS variables, Tailwind theme, a theme file for Flutter / SwiftUI / Compose, a tokens JSON). Show the diff. This is the only code this skill touches.
2. List what you could not determine and ask.
3. Name screens that exist as references but have no build-plan item, and the reverse.
4. Offer a commit: `docs: design system`.

## Gotchas

- An image shows layout, not exact values. Ask for hex codes, font names and spacing, or a Figma export, when it matters.
- Do not invent a brand. Missing values stay marked `TBD`.
- Never restyle existing screens here. Changes go through `spec`.
- Do not copy a reference product's logo, illustrations or exact look.
