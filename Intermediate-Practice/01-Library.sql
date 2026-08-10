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


