-- Active: 1785411209906@@127.0.0.1@5432@intermediate_practice
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(30),
    city VARCHAR(50)
);

ALTER TABLE customers ALTER COLUMN name SET NOT NULL; 

ALTER TABLE customers ADD CONSTRAINT customers_email_unique UNIQUE (email);

ALTER TABLE customers ALTER COLUMN city TYPE VARCHAR(100);

ALTER TABLE customers ADD COLUMN registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE customers RENAME phone TO phone_number;

SELECT * FROM customers;



CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    total NUMERIC(10, 2),
    status VARCHAR(30),
    created_at TIMESTAMP
);



CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2),
    stock INT,
    category VARCHAR(50)
);

