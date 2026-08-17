-- Active: 1785411209906@@127.0.0.1@5432@joins
CREATE TABLE classes (
  class_id INT PRIMARY KEY,
  class_name VARCHAR(50) NOT NULL
);

CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  class_id INT
);

INSERT INTO classes (class_id, class_name) VALUES
(101, 'JavaScript'),
(102, 'Python'),
(103, 'Java');

INSERT INTO students (student_id, name, class_id) VALUES
(1, 'Rahul', 101),
(2, 'Anjali', 102),
(3, 'Aman', 101),
(4, 'Neha', NULL);

SELECT * FROM students;
SELECT * FROM classes;

-- 1️⃣ INNER JOIN
SELECT s.name, c.class_name
FROM students s
INNER JOIN classes c
ON s.class_id = c.class_id;

-- 2️⃣ LEFT JOIN (LEFT OUTER JOIN)

SELECT s.name, c.class_name
FROM students s
LEFT JOIN classes c
ON s.class_id = c.class_id;

-- 3️⃣ RIGHT JOIN (RIGHT OUTER JOIN)

SELECT s.name, c.class_name
FROM students s
RIGHT JOIN classes c
ON s.class_id = c.class_id;

-- 4️⃣ FULL OUTER JOIN ✅ (Postgres Special)

SELECT s.name, c.class_name
FROM students s
FULL OUTER JOIN classes c
ON s.class_id = c.class_id;


-- 5️⃣ CROSS JOIN

SELECT s.name, c.class_name
FROM students s
CROSS JOIN classes c;

-- 6️⃣ SELF JOIN (Very Common in Postgres)

SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;

CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  manager_id INT
);

INSERT INTO employees (employee_id, name, manager_id) VALUES
(1, 'Rahul', NULL),      -- Top-level manager
(2, 'Anjali', 1),        -- Reports to Rahul
(3, 'Aman', 1),          -- Reports to Rahul
(4, 'Neha', 2);          -- Reports to Anjali

-- 🔁 SELF JOIN Query (Employee → Manager)

SELECT 
  e.name AS employee,
  m.name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;

-- VIEW QUERY (Optional but useful)

CREATE VIEW student_classes AS
SELECT s.name, c.class_name
FROM students s
INNER JOIN classes c
ON s.class_id = c.class_id;
SELECT * FROM student_classes;

-- HAVING QUERY

SELECT class_id, COUNT(*) AS total_students
FROM students
GROUP BY class_id
HAVING COUNT(*) > 1;

-- WHERE QUERY
SELECT *
FROM students
WHERE class_id = 101;

--  Combined Example (MOST IMPORTANT) First filter rows, then filter groups

SELECT class_id, COUNT(*) AS total_students
FROM students
WHERE class_id IS NOT NULL
GROUP BY class_id
HAVING COUNT(*) > 1;