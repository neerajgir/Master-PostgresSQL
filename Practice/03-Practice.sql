-- CREATE TABLE Employees(
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     salary NUMERIC(10,2) NOT NULL,
--     department VARCHAR(255) NOT NULL,
--     joining_date DATE NOT NULL DEFAULT CURRENT_DATE,
--     is_manager BOOLEAN DEFAULT true
-- );

INSERT INTO Employees (
    name,
    salary,
    department,
    joining_date,
    is_manager
)
VALUES (
    'Komal Kumari',
    50000,
    'Engineering',
    '2020-01-22',
    FALSE
),
(
    'Shan',
    30000,
    'Engineering',
    '2024-01-10',
    FALSE
),
(
    'Rabail',
    70000,
    'Marketing',
    '2025-06-01',
    TRUE
),
(
    'Anand',
    90000,
    'Marketing', 
    '2022-11-20',
    FALSE
),
(
    'Sahil',
    70000,
    'Sales',
    '2024-08-12',
    FALSE
),
(
    'Dilpat',
    50000,
    'Sales',
    '2023-05-19',
    FALSE
),
(
    'Vishwas',
    100000,
    'HR',
    '2025-02-14',
    FALSE
),
(
    'Hannah Abbott', 
    88000, 
    'HR', 
    '2021-04-05', 
    TRUE
),
(
    'Ian Malcolm', 
    105000, 
    'Finance', 
    '2020-10-01', 
    TRUE
),
(
    'Julia Roberts', 
    69000, 
    'Finance', 
    '2024-11-03', 
    FALSE
),
(
    'Kevin Bacon', 
    58000, 
    'Engineering', 
    '2025-07-22', 
    FALSE
),
(
    'Laura Croft', 
    73000, 
    'Sales', 
    '2023-09-30', 
    FALSE
);

SELECT * FROM Employees;

