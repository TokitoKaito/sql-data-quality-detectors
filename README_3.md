# SQL Data Quality Detectors

Twelve SQL queries that detect data integrity defects in a small game-store database. Each query targets one category of defect and returns the offending rows; an empty result means no violations of that category.

Part of a QA portfolio alongside [steam-store-search-qa](https://github.com/TokitoKaito/steam-store-search-qa) (manual UI testing) and [steam-web-api-postman](https://github.com/TokitoKaito/steam-web-api-postman) (API testing). Same discipline applied at the data layer.

## Why this matters

An interface can look correct on top of broken data. A purchase pointing at a product that does not exist, a review written by someone who never bought the game, a negative price — none of these are visible from the UI unless you happen to open the exact record, and no one browses a million rows by hand.

A detector is the data-layer equivalent of a test case: one expectation, one query, an unambiguous verdict.

## Contents

| File | Description |
|---|---|
| `01-schema.sql` | Table definitions. Foreign keys are deliberately not enforced — the exercise is to find broken references, not to prevent them |
| `02-seed.sql` | Sample data containing planted defects |
| `03-detectors.sql` | The twelve detectors |

## How to run

No installation required. Open [sqliteonline.com](https://sqliteonline.com), select SQLite, then run `01-schema.sql`, `02-seed.sql`, and the detectors — one query at a time.

## Detectors

| # | Detector | Category | Rows found |
|---|---|---|---|
| 1 | Purchases referencing a non-existent game | Referential integrity | 1 |
| 2 | Users without an email address | Required field | 1 |
| 3 | Duplicate email addresses | Uniqueness | 2 |
| 4 | Ratings outside the 1–10 scale | Impossible value | 2 |
| 5 | Reviews without a matching purchase | State consistency | 1 |
| 6 | Purchases dated before the game release | Date logic | 1 |
| 7 | Games referencing a non-existent developer | Referential integrity | 1 |
| 8 | Games without a release date | Required field | 1 |
| 9 | Games with a negative price | Impossible value | 1 |
| 10 | The same game purchased twice by the same user | Uniqueness | 1 |
| 11 | Purchases dated in the future | Date logic | 1 |
| 12 | Price paid differs from the current game price | See open questions | 2 |

## Notes on method

**`LEFT JOIN` plus a `NULL` check on the primary key** is the standard way to find records with no counterpart. The check must use the key, not an arbitrary column: a non-key column can be `NULL` on a row that does exist, and the detector would then report a false positive.

**`NULL` is checked explicitly where it can hide a violation.** A `NULL` rating satisfies neither `< 1` nor `> 10`, and a `NULL` release date makes every date comparison unknown. In both cases the offending row would silently drop out of the result. Detector 8 exists precisely because a missing release date removes rows from detector 6.

**One detector, one category.** Detector 6 deliberately does not also report missing release dates, even though the two are related. Mixing categories produces a result set that cannot be acted on: the reader cannot tell which rows need which fix.

**Detectors show both sides of a contradiction.** Detectors 6 and 11 select both dates being compared, so the violation is visible in the row itself rather than requiring the reader to look the second value up.

**`ON` defines how tables relate; `WHERE` performs the check.** Putting a comparison in `ON` changes which rows get joined and can produce a query that returns nothing under any data.

## Open questions

Two findings are recorded as questions rather than defects, because the answer does not follow from the data.

**What does `price_paid = 0` mean?**
The schema does not distinguish a genuinely free product from a gift, a refund, or a billing error. All four would be stored identically. This affects the interpretation of detectors 9 and 12.

**Should the price paid match the current game price?**
Detector 12 compares `purchases.price_paid` against the current value of `games.price`. The schema stores no price history, so a mismatch may reflect a legitimate price change between the purchase date and today rather than a defect. The underlying question is whether the system needs to record the price at the moment of purchase — a schema question, not a data question.

## Author

Daniil, danya.desimus@gmail.com, https://www.linkedin.com/in/daniil-demchenko-qa/
