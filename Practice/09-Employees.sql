-- Active: 1785411209906@@127.0.0.1@5432@postgressql_practice
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

INSERT INTO Employees (full_name, email, salary, department, experience_year, is_manager, joining_date) VALUES
('Aarav Sharma', 'aarav.sharma@company.com', 85000.00, 'IT', '2018-06-15', TRUE, '2018-06-15'),
('Aditi Patel', 'aditi.patel@company.com', 62000.00, 'Human Resources', '2021-03-10', FALSE, '2021-03-10'),
('Rohan Das', 'rohan.das@company.com', 95000.00, 'Engineering', '2016-11-01', TRUE, '2016-11-01'),
('Priya Nair', 'priya.nair@company.com', 54000.00, 'Marketing', '2023-01-20', FALSE, '2023-01-20'),
('Amit Verma', 'amit.verma@company.com', 78000.00, 'Finance', '2019-08-05', FALSE, '2019-08-05'),
('Sneha Reddy', 'sneha.reddy@company.com', 110000.00, 'Engineering', '2015-04-12', TRUE, '2015-04-12'),
('Vikram Malhotra', 'vikram.malhotra@company.com', 48000.00, 'Sales', '2024-05-18', FALSE, '2024-05-18'),
('Ananya Iyer', 'ananya.iyer@company.com', 69000.00, 'Data Science', '2020-10-01', FALSE, '2020-10-01'),
('Rahul Joshi', 'rahul.joshi@company.com', 125000.00, 'IT', '2014-02-28', TRUE, '2014-02-28'),
('Kavita Rao', 'kavita.rao@company.com', 57000.00, 'Operations', '2022-07-14', FALSE, '2022-07-14');

UPDATE Employees SET salary = salary * 1.10 WHERE department IN ('IT', 'Engineering', 'Data Science');

SELECT * FROM Employees;

DELETE FROM Employees WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, joining_date)) = 0;

SELECT id, full_name, department, salary FROM Employees WHERE salary > 80000.00;