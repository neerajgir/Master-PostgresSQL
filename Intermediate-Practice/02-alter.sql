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

ALTER TABLE employees ALTER department TYPE VARCHAR(100);

ALTER TABLE employees RENAME TO company_employees;

SELECT * FROM company_employees;

ALTER TABLE company_employees ADD CONSTRAINT salary_positive CHECK(salary > 0);

ALTER TABLE company_employees DROP COLUMN phone;

ALTER TABLE company_employees ALTER COLUMN department SET NOT NULL;

ALTER TABLE company_employees DROP CONSTRAINT salary_positive;

ALTER TABLE company_employees ALTER COLUMN is_active SET DEFAULT false;

