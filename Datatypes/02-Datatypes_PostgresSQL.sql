-- CREATE TABLE products(
--     id SERIAL PRIMARY KEY,
--     product_name VARCHAR(100) NOT NULL,
--     stock INT DEFAULT 0,
--     ratings BIGINT DEFAULT 0,
--     -- TOTAL NUMBER OF DIGITS ALLOWED -> 10
--     -- TOTAL DIGITS AFTER THE DECIMAL -> 2
--     -- 0 - 99999999.99
--     price NUMERIC(10, 2) NOT NULL,
--     is_available BOOLEAN DEFAULT true
-- );

INSERT INTO products (
    product_name,
    stock,
    ratings,
    price,
    is_available
)
VALUES (
    'Peanut Butter',
    100,
    4000,
    250,
    true
),
(
    'Iphone 17 Pro',
    50,
    1000,
    200000,
    true
),
(
    'Samsung S26 Ultra',
    20,
    5000,
    250000,
    true
);

SELECT * FROM products;