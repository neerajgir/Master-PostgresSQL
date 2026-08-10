-- Active: 1785411209906@@127.0.0.1@5432@intermediate_practice
CREATE TABLE books (
    id SERIAL PRIMARY KEY,    
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price NUMERIC(5, 2) CHECK (price > 0),
    stock INT CHECK (stock >= 0),
    metadata JSONB DEFAULT '{}'::JSONB
);

CREATE TABLE members (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE borrow_history (
    id SERIAL PRIMARY KEY,
    books_id INT REFERENCES books(id),
    member_id INT REFERENCES members(id),
    borrow_date TIMESTAMP DEFAULT NOW(),
    returned BOOLEAN DEFAULT FALSE
);

INSERT INTO books (title, author, price, stock, metadata)
VALUES
('Atomic Habits', 'James Clear', 19.99, 12, '{"language":"English","pages":320,"publisher":"Avery"}'),
('Clean Code', 'Robert C. Martin', 29.99, 8, '{"language":"English","pages":464,"publisher":"Prentice Hall"}'),
('The Pragmatic Programmer', 'Andrew Hunt', 34.50, 5, '{"language":"English","pages":352,"publisher":"Addison-Wesley"}'),
('Deep Work', 'Cal Newport', 18.75, 10, '{"language":"English","pages":304,"publisher":"Grand Central"}'),
('Rich Dad Poor Dad', 'Robert Kiyosaki', 15.50, 20, '{"language":"English","pages":336,"publisher":"Plata Publishing"}'),
('Think and Grow Rich', 'Napoleon Hill', 14.25, 15, '{"language":"English","pages":238,"publisher":"The Ralston Society"}'),
('The Psychology of Money', 'Morgan Housel', 22.99, 9, '{"language":"English","pages":256,"publisher":"Harriman House"}'),
('Introduction to Algorithms', 'Thomas H. Cormen', 55.00, 4, '{"language":"English","pages":1312,"publisher":"MIT Press"}'),
('Eloquent JavaScript', 'Marijn Haverbeke', 27.99, 7, '{"language":"English","pages":472,"publisher":"No Starch Press"}'),
('Design Patterns', 'Erich Gamma', 42.00, 6, '{"language":"English","pages":395,"publisher":"Addison-Wesley"}');

INSERT INTO members (name, email, is_active)
VALUES
('Ali Khan', 'ali@example.com', TRUE),
('Sara Ahmed', 'sara@example.com', TRUE),
('Ahmed Raza', 'ahmed@example.com', TRUE),
('Fatima Noor', 'fatima@example.com', FALSE),
('Usman Tariq', 'usman@example.com', TRUE),
('Ayesha Malik', 'ayesha@example.com', TRUE),
('Bilal Hussain', 'bilal@example.com', FALSE),
('Zain Ali', 'zain@example.com', TRUE),
('Hina Shah', 'hina@example.com', TRUE),
('Hamza Iqbal', 'hamza@example.com', TRUE);

INSERT INTO borrow_history (books_id, member_id, borrow_date, returned)
VALUES
(1, 1, '2026-07-01 10:30:00', TRUE),
(2, 2, '2026-07-02 09:15:00', FALSE),
(3, 3, '2026-07-03 14:20:00', TRUE),
(4, 4, '2026-07-04 11:45:00', FALSE),
(5, 5, '2026-07-05 16:10:00', TRUE),
(6, 6, '2026-07-06 13:30:00', FALSE),
(7, 7, '2026-07-07 12:00:00', TRUE),
(8, 8, '2026-07-08 15:40:00', FALSE),
(9, 9, '2026-07-09 09:50:00', TRUE),
(10, 10, '2026-07-10 17:25:00', FALSE),
(2, 1, '2026-07-11 10:00:00', TRUE),
(5, 3, '2026-07-12 11:30:00', FALSE),
(7, 2, '2026-07-13 14:00:00', TRUE),
(1, 6, '2026-07-14 09:45:00', FALSE),
(4, 8, '2026-07-15 16:20:00', TRUE);


SELECT title, price FROM books ORDER BY price ASC;
SELECT title, price FROM books ORDER BY price DESC;

SELECT title, stock FROM books ORDER BY stock ASC;
SELECT title, stock FROM books ORDER BY stock DESC;

SELECT name FROM members ORDER BY name ASC;

SELECT title, price FROM books ORDER BY price DESC, title ASC;

-- LIMIT - Goal: Restrict the number of rows returned.
SELECT title FROM books LIMIT 5;

SELECT title, price FROM books LIMIT 3;

SELECT title, price FROM books ORDER BY price DESC, title ASC LIMIT 3;

SELECT * FROM members LIMIT 3;

SELECT title, stock FROM books ORDER BY stock DESC, title DESC LIMIT 3;


-- OFFSET - Goal: Skip a certain number of rows.

SELECT title, price FROM books ORDER BY price DESC, title ASC OFFSET 3;
SELECT title, price FROM books ORDER BY price DESC, title ASC LIMIT 3 OFFSET 3;
SELECT title, price FROM books ORDER BY price DESC, title ASC LIMIT 5 OFFSET 5;
SELECT title, price FROM books ORDER BY price DESC, title ASC LIMIT 5 OFFSET 10;

-- Page 1: Books 1 to 5 (Skip 0)
SELECT title, price FROM books ORDER BY price DESC, title ASC LIMIT 5 OFFSET 0;

-- Page 2: Books 6 to 10 (Skip 5)
SELECT title, price FROM books ORDER BY price DESC, title ASC LIMIT 5 OFFSET 5;

-- Page 3: Books 11 to 15 (Skip 10)
SELECT title, price FROM books ORDER BY price DESC, title ASC LIMIT 5 OFFSET 10;

-- DISTINCT - Goal: Get unique values only.

SELECT DISTINCT author FROM books;

SELECT DISTINCT price FROM books ORDER BY price ASC;
SELECT DISTINCT stock FROM books ORDER BY stock ASC;

SELECT DISTINCT metadata->>'publisher' AS Publishers FROM books WHERE metadata->>'publisher' IS NOT NULL
ORDER BY publishers ASC;

SELECT DISTINCT metadata->>'language' AS Languages FROM books WHERE metadata->>'language' IS NOT NULL
ORDER BY Languages ASC;

-- LIKE - Goal: Search text using patterns.

SELECT title FROM books WHERE title LIKE 'The%';
SELECT title FROM books WHERE title LIKE '%Code';
SELECT title FROM books WHERE title LIKE '%Java%';
SELECT title, author FROM books WHERE author LIKE '%Martin%';

SELECT title FROM books WHERE title LIKE '%Money%';

SELECT name FROM members WHERE name LIKE 'A%';
SELECT name FROM members WHERE name LIKE '%n';
SELECT name FROM members WHERE name LIKE '%ah%';

-- ILIKE - ILIKE is PostgreSQL's case-insensitive version of LIKE.

SELECT title FROM books WHERE title ILIKE '%code%';

SELECT title FROM books WHERE title ILIKE '%JAVA%';
SELECT name FROM members WHERE name ILIKE '%ALI%';

SELECT title, author FROM books WHERE author ILIKE '%robert%';
SELECT title, author FROM books WHERE title ILIKE '%program%';

-- IN - Goal: Check whether a value matches one of several values.

SELECT title, author FROM books WHERE author IN ('James Clear', 'Morgan Housel', 'Cal Newport');
SELECT title, stock FROM books WHERE stock IN (4, 5, 10, 15) ORDER BY price DESC, title ASC;

SELECT id,name FROM members WHERE id IN (1,3,5,7);
SELECT title,price FROM books WHERE price IN (15.50,22.99,29.99) ORDER BY price DESC, title ASC;

SELECT id,name FROM members WHERE id NOT IN (2,4,6);

-- BETWEEN - Goal: Find values inside a range.

SELECT title, price FROM books WHERE price BETWEEN 15 AND 30;
SELECT title, price FROM books WHERE price BETWEEN 20 AND 40;
SELECT title, stock FROM books WHERE stock BETWEEN 5 AND 15;
SELECT borrow_date FROM borrow_history WHERE borrow_date BETWEEN '2026-07-07 12:00:00' AND '2026-07-10 17:25:00';

SELECT title, price FROM books WHERE price BETWEEN 25 AND 50 ORDER BY price DESC, title ASC;


-- IS NULL - This one is very important
-- WHERE column IS NULL
-- WHERE column IS NOT NULL

-- 10. Aggregate Functions - These are extremely important for backend development.

SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM members;
SELECT COUNT(*) FROM members WHERE is_active = true;
SELECT COUNT(*) FROM borrow_history WHERE returned = true;
SELECT COUNT(*) FROM books WHERE stock > 5;

SELECT SUM(stock) FROM books;
SELECT SUM(price) FROM books;
SELECT SUM(stock) FROM books WHERE stock > 5;

SELECT AVG(price) FROM books;
SELECT AVG(stock) FROM books;

SELECT AVG(price) AS average_price FROM books WHERE price > 20;

SELECT MIN(price) FROM books;

SELECT MIN(stock) FROM books;
SELECT MIN(borrow_date) FROM borrow_history;

SELECT MAX(price) FROM books;
SELECT MAX(stock) FROM books;
SELECT MAX(borrow_date) FROM borrow_history;


-- GROUP BY - This is where PostgreSQL starts becoming more interesting. 🔥

SELECT author, COUNT(*) FROM books GROUP BY author;
SELECT author, AVG(price) FROM books GROUP BY author;
SELECT author, COUNT(stock) FROM books GROUP BY author;
SELECT author, MIN(price) FROM books GROUP BY author;
SELECT author, MAX(price) FROM books GROUP BY author;

SELECT metadata->>'publisher', COUNT(*) FROM books GROUP BY metadata->>'publisher';
SELECT metadata->>'publisher', AVG(price) FROM books GROUP BY metadata->>'publisher';
SELECT metadata->>'publisher', COUNT(stock) FROM books GROUP BY metadata->>'publisher';

-- HAVING - HAVING is used to filter groups created by GROUP BY.

SELECT author, COUNT(*) FROM books GROUP BY author HAVING COUNT(*) > 1;

SELECT author, COUNT(*) FROM books GROUP BY author HAVING COUNT(*) > 2;

SELECT author, AVG(price) AS average_book_price FROM books GROUP BY author HAVING AVG(price) > 20 ORDER BY average_book_price DESC;

SELECT 
    metadata->>'publisher' AS publisher, 
    COUNT(*) AS book_count
FROM books
WHERE metadata->>'publisher' IS NOT NULL
GROUP BY metadata->>'publisher'
HAVING COUNT(*) > 1;


SELECT author, SUM(stock) as total_stock FROM books GROUP BY author HAVING SUM(stock) > 10 ORDER BY total_stock DESC;