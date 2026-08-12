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
