CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    salary NUMERIC(10, 2),
    department VARCHAR(50),
    is_active BOOLEAN DEFAULT true
);

SELECT * FROM employees;

ALTER TABLE employees ADD COLUMN phone VARCHAR(20);
ALTER TABLE employees ADD COLUMN joining_date TIMESTAMP DEFAULT NOW();

ALTER TABLE employees RENAME COLUMN name TO full_name; 

ALTER TABLE employees ALTER COLUMN department TYPE VARCHAR(100);

ALTER TABLE employees RENAME TO company_employees;

SELECT * FROM company_employees;

ALTER TABLE company_employees ADD CONSTRAINT salary_positive CHECK(salary > 0);

ALTER TABLE company_employees DROP COLUMN phone;

ALTER TABLE company_employees ALTER COLUMN department SET NOT NULL;

ALTER TABLE company_employees DROP CONSTRAINT salary_positive;

ALTER TABLE company_employees ALTER COLUMN is_active SET DEFAULT false;

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2),
    stock INT,
    category VARCHAR(50)
);

ALTER TABLE products ADD COLUMN description TEXT;
ALTER TABLE products ADD COLUMN sku VARCHAR(50) UNIQUE;

ALTER TABLE products RENAME COLUMN name TO product_name;

ALTER TABLE products ALTER COLUMN category TYPE VARCHAR(100);

ALTER TABLE products ADD CONSTRAINT price_non_negative CHECK(price >= 0);
ALTER TABLE products ADD CONSTRAINT stock_non_negative CHECK(stock >= 0);

ALTER TABLE products ADD COLUMN is_available BOOLEAN DEFAULT true;

ALTER TABLE products DROP COLUMN description;

ALTER TABLE products RENAME TO store_products;


ALTER TABLE store_products ALTER COLUMN product_name SET NOT NULL;
ALTER TABLE store_products ADD CONSTRAINT unique_sku UNIQUE (sku);

ALTER TABLE store_products ADD CONSTRAINT price CHECK(price > 0);
ALTER TABLE store_products ADD CONSTRAINT stock CHECK(stock >= 0);

ALTER TABLE store_products ALTER COLUMN is_available SET DEFAULT true;




SELECT * FROM store_products;