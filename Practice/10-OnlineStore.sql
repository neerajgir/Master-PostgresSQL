CREATE TABLE Categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE Productss (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK(price >= 0),
    stock INT NOT NULL  DEFAULT 0 CHECK(stock >= 0),
    category_id INT NOT NULL,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE
);

CREATE TABLE Customerss (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL
);

-- First, insert sample categories to fulfill the foreign key constraint
INSERT INTO Categories (id, category_name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen'),
(4, 'Books')
ON CONFLICT (id) DO NOTHING;

-- Reset the category sequence if needed
SELECT setval('categories_id_seq', COALESCE((SELECT MAX(id) FROM Categories), 1));

-- Insert 20 products
INSERT INTO Productss (name, price, stock, category_id) VALUES
('Wireless Bluetooth Earbuds', 2499.00, 50, 1),
('Mechanical Gaming Keyboard', 4199.00, 30, 1),
('Ergonomic Wireless Mouse', 1299.00, 75, 1),
('1080p Web Camera with Mic', 3500.00, 20, 1),
('Portable 1TB External SSD', 8999.00, 15, 1),
('Smart Fitness Band', 2199.00, 60, 1),
('Men Plain Cotton T-Shirt', 599.00, 120, 2),
('Women Slim Fit Denim Jeans', 1899.00, 45, 2),
('Unisex Hooded Sweatshirt', 1499.00, 80, 2),
('Running Sports Shoes', 3299.00, 25, 2),
('Waterproof Winter Jacket', 4500.00, 12, 2),
('Stainless Steel Water Bottle', 799.00, 150, 3),
('Non-Stick Ceramic Frying Pan', 1350.00, 40, 3),
('Electric Drip Coffee Maker', 2899.00, 18, 3),
('Digital Kitchen Weight Scale', 650.00, 95, 3),
('Set of 4 Ceramic Coffee Mugs', 899.00, 35, 3),
('Introduction to PostgreSQL', 1199.00, 22, 4),
('Atomic Habits Paperback', 499.00, 200, 4),
('The Lean Startup', 650.00, 14, 4),
('Data Structures & Algorithms', 1599.00, 30, 4);

SELECT * FROM Productss;

UPDATE Productss SET stock = stock - 2 WHERE id = 1;

SELECT id, name, price FROM Productss WHERE price > 1000;