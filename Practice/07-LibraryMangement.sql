-- Mini Project
-- CREATE TABLE books (
--     id SERIAL PRIMARY KEY,    
--     title VARCHAR(255) NOT NULL,
--     author VARCHAR(255) NOT NULL,
--     price NUMERIC(5, 2) CHECK (price > 0),
--     stock INT CHECK (stock >= 0),
--     metadata JSONB DEFAULT '{}'::JSONB
-- );

-- CREATE TABLE members (
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     email VARCHAR(255) NOT NULL UNIQUE,
--     is_active BOOLEAN DEFAULT TRUE
-- );

-- CREATE TABLE borrow_history (
--     id SERIAL PRIMARY KEY,
--     books_id INT REFERENCES books(id),
--     member_id INT REFERENCES members(id),
--     borrow_date TIMESTAMP DEFAULT NOW(),
--     returned BOOLEAN DEFAULT FALSE
-- );

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