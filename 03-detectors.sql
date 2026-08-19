-- Game store — data quality detectors
--
-- Each query targets one category of data defect and returns the offending rows.
-- An empty result means no violations of that category were found.
-- Run 01-schema.sql and 02-seed.sql first.


-- 1. Purchases referencing a non-existent game
-- Referential integrity. A purchase points to a game that is not in the catalogue:
-- the user paid for a product that does not exist.
SELECT p.id, p.user_id, p.game_id, p.purchased_at
FROM purchases p
LEFT JOIN games g ON g.id = p.game_id
WHERE g.id IS NULL;


-- 2. Users without an email address
-- Required field. An account with no email cannot receive password resets or receipts.
SELECT u.id, u.username, u.email
FROM users u
WHERE u.email IS NULL;


-- 3. Duplicate email addresses
-- Uniqueness. Two accounts sharing an address means either a duplicate registration
-- or missing validation. Returns every offending account, not just the address.
SELECT u.id, u.username, u.email
FROM users u
WHERE u.email IN (
    SELECT email
    FROM users
    WHERE email IS NOT NULL
    GROUP BY email
    HAVING COUNT(*) > 1
);


-- 4. Ratings outside the 1-10 scale
-- Impossible values. NULL is checked explicitly: a NULL rating satisfies neither
-- comparison and would otherwise be silently skipped.
SELECT r.id, r.user_id, r.game_id, r.rating
FROM reviews r
WHERE r.rating IS NULL OR r.rating < 1 OR r.rating > 10;


-- 5. Reviews without a matching purchase
-- State consistency. A review may only exist for a game the user owns.
-- Joined on both user and game: the pair must match, not just one side.
-- The NULL check uses the primary key, which is never NULL on a real row.
SELECT r.id, r.user_id, r.game_id, r.rating
FROM reviews r
LEFT JOIN purchases p ON p.user_id = r.user_id AND p.game_id = r.game_id
WHERE p.id IS NULL;


-- 6. Purchases dated before the game was released
-- Date logic. Both dates are selected so the contradiction is visible in one row.
-- Games with a NULL release_date are not reported here: the comparison yields
-- unknown and the row is skipped. Detector 8 covers that case separately.
SELECT p.id, p.user_id, g.title, p.purchased_at, g.release_date
FROM purchases p
JOIN games g ON g.id = p.game_id
WHERE p.purchased_at < g.release_date;


-- 7. Games referencing a non-existent developer
-- Referential integrity. Also catches games with no developer_id at all.
SELECT g.id, g.title, g.developer_id
FROM games g
LEFT JOIN developers d ON d.id = g.developer_id
WHERE d.id IS NULL;


-- 8. Games without a release date
-- Required field. Beyond being incomplete, a missing release date silently removes
-- the row from every date comparison, including detector 6.
SELECT g.id, g.title, g.release_date
FROM games g
WHERE g.release_date IS NULL;


-- 9. Games with a negative price
-- Impossible values. NULL is checked explicitly for the same reason as in detector 4.
SELECT g.id, g.title, g.price
FROM games g
WHERE g.price IS NULL OR g.price < 0;


-- 10. The same game purchased twice by the same user
-- Uniqueness across two columns. A game is either owned or not; it cannot be
-- bought twice by one account.
SELECT user_id, game_id, COUNT(*) AS cnt
FROM purchases
GROUP BY user_id, game_id
HAVING COUNT(*) > 1;


-- 11. Purchases dated in the future
-- Date logic. Current date is selected alongside so the contradiction is visible.
SELECT p.id, p.user_id, p.game_id, p.purchased_at, date('now') AS today
FROM purchases p
WHERE p.purchased_at > date('now');


-- 12. Price paid differs from the current game price
-- NOT a defect detector on its own — see "Open questions" in the README.
-- IS NOT is used deliberately instead of <>: it also reports rows where one of the
-- two values is NULL, which <> would silently skip.
SELECT p.id, p.user_id, g.title, p.price_paid, g.price
FROM purchases p
JOIN games g ON g.id = p.game_id
WHERE g.price IS NOT p.price_paid;
