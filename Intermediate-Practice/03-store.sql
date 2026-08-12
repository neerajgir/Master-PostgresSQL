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
ALTER TABLE customers RENAME COLUMN phone TO phone_number;

ALTER TABLE customers DROP COLUMN city;

ALTER TABLE customers ALTER COLUMN email SET NOT NULL;

SELECT * FROM customers;



CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    total NUMERIC(10, 2),
    status VARCHAR(30),
    created_at TIMESTAMP
);

ALTER TABLE orders ALTER COLUMN customer_id SET NOT NULL;

ALTER TABLE orders ADD CONSTRAINT orders_total_positive CHECK (total > 0);

ALTER TABLE orders ALTER COLUMN created_at SET DEFAULT NOW();

ALTER TABLE orders ADD COLUMN is_paid BOOLEAN DEFAULT false;

ALTER TABLE orders RENAME COLUMN status TO order_status; 

ALTER TABLE orders ALTER COLUMN order_status TYPE VARCHAR(50);

ALTER TABLE orders 
ADD CONSTRAINT orders_customer_fk 
FOREIGN KEY (customer_id) REFERENCES customers (id);


SELECT * FROM orders;

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2),
    stock INT,
    category VARCHAR(50)
);

ALTER TABLE products ALTER COLUMN name SET NOT NULL;

ALTER TABLE products ADD CONSTRAINT products_price_positive CHECK (price > 0);
ALTER TABLE products ADD CONSTRAINT products_stock_non_negative CHECK (stock >= 0);

ALTER TABLE products ALTER COLUMN category TYPE VARCHAR(100);

ALTER TABLE products ADD COLUMN sku VARCHAR(50) UNIQUE;
ALTER TABLE products
ADD CONSTRAINT products_sku_unique UNIQUE (sku);

ALTER TABLE products ADD COLUMN description TEXT;

SELECT * FROM products;





