---
name: money
description: Use whenever code stores, calculates, rounds, displays or tests money, prices, taxes (VAT, TVA, sales tax), discounts, or invoice and order totals, in any language. Also use when reviewing such code.
---

# Money

## Rules

- Store every amount as an **integer in minor units** (cents, centimes), or in the language's exact decimal type (`Decimal`, `BigDecimal`, `NUMERIC` in SQL). Never binary floating point.
- Fractional quantities: integer thousandths. Rates: integer basis points (20% = 2000).
- Store the currency code (ISO 4217, such as `EUR`, `USD`, `MAD`) with every amount or on its parent record. Not every currency has 2 decimals (JPY has 0, KWD has 3).
- One currency per document. No silent conversion. A converted amount stores the rate and the date used.
- All money math lives in one pure module. Interfaces and endpoints only call it.
- Format amounts for display at the edge only, with the platform's locale-aware formatter.

## Rounding

Default, unless the user says otherwise: round **half-up per line**, then add the lines.

- line net = round(quantity × unit price) − discount
- line tax = round(line net × rate)
- totals = sums of the rounded lines

Write the rule in the spec and test it. Tax rules differ by country; ask which applies.

## Tests that must exist

Table-driven cases: zero, one minor unit, very large values, repeating decimals (3 × 0.333), 100% discount, 0% tax, several tax rates on one document, negative amounts (refunds, credit notes), and a total equal to the sum of its rounded lines.

## Gotchas

- 0.1 + 0.2 is not 0.3 in floating point. A float anywhere in money code is a bug.
- Built-in rounding often surprises: banker's rounding in Python and .NET, and JavaScript rounds −2.5 to −2. Write an explicit rounding helper and test negatives.
- Totals computed in two places drift apart. Compute once, on the server, and show that result.
- Issued invoices and paid orders do not change. Corrections are new documents (credit note, refund).
- Legal fields on invoices (tax IDs, sequential numbers, tax per rate) depend on the country. Ask the user; never invent them.
