CREATE TABLE Employees(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    salary NUMERIC(10,2) NOT NULL,
    department VARCHAR(255) NOT NULL,
    joining_date DATE NOT NULL DEFAULT CURRENT_DATE,
    is_manager BOOLEAN DEFAULT true
);

