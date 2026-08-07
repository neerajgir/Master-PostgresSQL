CREATE TABLE Employees (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    salary NUMERIC(10,2) NOT NULL,
    department VARCHAR(50) NOT NULL,
    experience_year DATE DEFAULT CURRENT_DATE,
    is_manager BOOLEAN DEFAULT FALSE,
    joining_date DATE DEFAULT CURRENT_DATE
);