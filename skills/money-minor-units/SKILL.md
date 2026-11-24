---
name: money-minor-units
description: Use whenever code stores, calculates, rounds, displays or tests money, prices, taxes (VAT/TVA), discounts or invoice totals. Also use when reviewing such code.
---

# Money in minor units

## Rules

- Store every amount as an **integer in minor units** (cents, centimes). Never `float`, never `number` with decimals, never `toFixed` for math.
- Quantities that can be fractional: integer thousandths (`qty_milli`). Rates: integer basis points (20% = `2000`).
- Database: `bigint` / `integer` columns for amounts. Currency code (ISO 4217, e.g. `MAD`, `EUR`) stored next to every amount or on the parent record.
- One currency per document. No silent conversion.
- All money math lives in one pure module (e.g. `src/lib/money`). UI and API only call it.
- Format for display only at the edge, with `Intl.NumberFormat(locale, { style: 'currency', currency })`.

## Rounding (default, change only if the user specifies)

- Round **half-up per line**, then sum lines for totals.
- line_net = round(qty_milli × unit_price_minor / 1000) − discount
- line_tax = round(line_net × rate_bp / 10000)
- Document which rule is used in the spec and test it.

## Tests that must exist

Table-driven tests including: 0, 1 minor unit, very large values, repeating decimals (3 × 0.333), 100% discount, 0% tax, mixed tax rates on one invoice, and a total that equals the sum of the rounded lines.

## Gotchas

- `0.1 + 0.2 !== 0.3`. If you see a decimal literal in money code, it is a bug.
- `Math.round` rounds -2.5 to -2. Write an explicit half-up helper and test negatives (credit notes).
- Totals computed in the browser and on the server will drift. Compute once, on the server, with the shared module.
- Legal invoice fields (tax IDs, sequential numbers, tax per rate) vary by country. Ask the user; do not invent them.
