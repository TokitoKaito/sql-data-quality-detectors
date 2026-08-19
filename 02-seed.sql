-- Game store — seed data

INSERT INTO developers (id, name, country) VALUES
(1, 'Northwind Games',   'Poland'),
(2, 'Blue Harbor Studio','Finland'),
(3, 'Pixelforge',        'Ukraine'),
(4, 'Ninefold',          'Germany'),
(5, 'Solstice Interactive','Sweden');

INSERT INTO users (id, username, email, country, registered_at) VALUES
(1,  'annak',      'anna.k@example.com',    'Finland', '2024-02-11'),
(2,  'dmytro_v',   'dmytro.v@example.com',  'Ukraine', '2024-03-05'),
(3,  'lauri88',    'lauri88@example.com',   'Finland', '2024-04-19'),
(4,  'mkowalski',  'm.kowalski@example.com','Poland',  '2024-05-02'),
(5,  'sara_j',     'sara.j@example.com',    'Sweden',  '2024-06-27'),
(6,  'tomh',       'tom.h@example.com',     'Germany', '2024-08-14'),
(7,  'olena_p',    NULL,                    'Ukraine', '2024-09-30'),
(8,  'jonas_b',    'jonas.b@example.com',   'Sweden',  '2024-11-08'),
(9,  'katrin',     'katrin@example.com',    'Germany', '2025-01-16'),
(10, 'petro_s',    'petro.s@example.com',   'Ukraine', '2025-02-23'),
(11, 'lauri_new',  'lauri88@example.com',   'Finland', '2025-03-30'),
(12, 'nina_r',     'nina.r@example.com',    'Poland',  '2025-05-12');

INSERT INTO games (id, title, price, release_date, developer_id) VALUES
(1,  'Harbor Lights',      399.00, '2024-01-20', 2),
(2,  'Ironroot',           899.00, '2024-03-14', 1),
(3,  'Pale Meridian',      249.00, '2024-06-01', 3),
(4,  'Signal Lost',          0.00, '2024-07-11', 4),
(5,  'Coldwater',          599.00, '2024-10-05', 2),
(6,  'Ninefold Arena',     449.00, NULL,         4),
(7,  'Thornfield',        -199.00, '2025-01-09', 1),
(8,  'Quiet Orbit',        329.00, '2025-04-22', 99),
(9,  'Last Ferry',         749.00, '2025-08-30', 5),
(10, 'Winterlight',        199.00, '2026-03-15', 3);

INSERT INTO purchases (id, user_id, game_id, price_paid, purchased_at) VALUES
(1,  1,  1,  399.00, '2024-02-15'),
(2,  1,  2,  899.00, '2024-04-02'),
(3,  2,  3,  249.00, '2024-06-10'),
(4,  3,  1,  399.00, '2024-05-01'),
(5,  3,  5,  599.00, '2024-11-11'),
(6,  4,  2,  899.00, '2024-05-20'),
(7,  4,  7,    0.00, '2025-02-01'),
(8,  5,  9,  749.00, '2025-09-14'),
(9,  5,  3,  249.00, '2024-07-03'),
(10, 6,  5,  599.00, '2024-10-30'),
(11, 6,  5,  599.00, '2024-10-30'),
(12, 7,  4,    0.00, '2024-10-02'),
(13, 8,  2,  899.00, '2025-01-05'),
(14, 8,  8,  329.00, '2025-05-19'),
(15, 9,  1,  399.00, '2025-02-01'),
(16, 9, 999,  199.00, '2025-02-02'),
(17, 10, 3,  249.00, '2025-03-08'),
(18, 10, 9,  749.00, '2025-09-01'),
(19, 11, 1,  399.00, '2025-04-04'),
(20, 12, 6,  449.00, '2025-06-21'),
(21, 12, 10, 199.00, '2025-12-01'),
(22, 2,  5,  650.00, '2025-07-15'),
(23, 6,  3,  249.00, '2024-12-24'),
(24, 1,  9,  749.00, '2027-01-10'),
(25, 4,  4,    0.00, '2025-03-17');

INSERT INTO reviews (id, user_id, game_id, rating, created_at) VALUES
(1,  1,  1,  9,  '2024-02-20'),
(2,  1,  2,  7,  '2024-04-10'),
(3,  2,  3,  8,  '2024-06-15'),
(4,  3,  1, 10,  '2024-05-08'),
(5,  4,  2,  6,  '2024-06-01'),
(6,  5,  9,  9,  '2025-09-20'),
(7,  6,  5, 11,  '2024-11-05'),
(8,  8,  2,  4,  '2025-01-20'),
(9,  9,  1,  8,  '2025-02-10'),
(10, 10, 3,  7,  '2025-03-15'),
(11, 12, 6,  5,  '2025-07-02'),
(12, 3,  9,  9,  '2025-10-01'),
(13, 2,  5,  0,  '2025-07-20'),
(14, 8,  8,  7,  '2025-05-25');
