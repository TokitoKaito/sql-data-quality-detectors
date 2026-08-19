-- Game store — schema
-- SQLite. Foreign keys are intentionally NOT enforced:
-- the point of the exercise is to find broken references, not to prevent them.

DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS developers;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id            INTEGER PRIMARY KEY,
    username      TEXT,
    email         TEXT,
    country       TEXT,
    registered_at TEXT          -- YYYY-MM-DD
);

CREATE TABLE developers (
    id      INTEGER PRIMARY KEY,
    name    TEXT,
    country TEXT
);

CREATE TABLE games (
    id           INTEGER PRIMARY KEY,
    title        TEXT,
    price        REAL,          -- UAH
    release_date TEXT,          -- YYYY-MM-DD
    developer_id INTEGER
);

CREATE TABLE purchases (
    id           INTEGER PRIMARY KEY,
    user_id      INTEGER,
    game_id      INTEGER,
    price_paid   REAL,
    purchased_at TEXT           -- YYYY-MM-DD
);

CREATE TABLE reviews (
    id         INTEGER PRIMARY KEY,
    user_id    INTEGER,
    game_id    INTEGER,
    rating     INTEGER,         -- scale 1..10
    created_at TEXT             -- YYYY-MM-DD
);
