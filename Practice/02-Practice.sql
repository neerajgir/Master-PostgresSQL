CREATE TABLE products (
    id SERIAL,
    product_name VARCHAR(255) NOT NULL,
    price NUMERIC,
    stock INT NOT NULL,
    category VARCHAR(255) NOT NULL,
    rating BIGINT 
)

