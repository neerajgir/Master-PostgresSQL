# 🐘 Basics — PostgreSQL Shuruat (Hinglish Edition)

Yeh folder PostgreSQL ki **foundation** cover karta hai — database banana, table create karna, data insert/update/delete karna, aur ek chhota **Employee Mini Project**. Saari files me queries comment me hain; pehle uncomment karke run karo, phir khud practice karo.

---

## 📁 Folder Structure

| File | Kya Seekhenge |
|------|---------------|
| [`01-First_PostgresSQL.sql`](01-First_PostgresSQL.sql) | Database, Table, CRUD (Create, Read, Update, Delete) |
| [`Employe_Mini_Project/Employe_Mini_Project.sql`](Employe_Mini_Project/Employe_Mini_Project.sql) | Real-world table design — salary, dept, constraints |

---

## 📌 Index

1. [Pehle Setup Kaise Karein](#1-pehle-setup-kaise-karein)
2. [File 1 — First PostgreSQL (Student Table)](#2-file-1--first-postgresql-student-table)
3. [File 2 — Employee Mini Project](#3-file-2--employee-mini-project)
4. [Important Concepts Summary](#4-important-concepts-summary)
5. [Quick Cheat Sheet](#5-quick-cheat-sheet)

---

## 1. Pehle Setup Kaise Karein

Terminal me PostgreSQL se connect karo:

```bash
psql -U postgres
```

Naya database banao (file me naam `postgressql_basics` hai):

```sql
CREATE DATABASE postgressql_basics;
\c postgressql_basics;
```

> **Note:** Har SQL statement ke end me semicolon (`;`) lagana mat bhoolna — warna psql wait karta rahega!

---

## 2. File 1 — First PostgreSQL (Student Table)

**File:** `01-First_PostgresSQL.sql`

Yeh file ek simple `student` table banati hai aur us par basic CRUD operations sikhati hai.

### 🏗️ Table Create Karna

```sql
CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    age INT NOT NULL CHECK (age >= 18),
    created_at TIMESTAMP DEFAULT NOW()
);
```

### Samjho Har Column Ko

| Column | Datatype | Constraint | Matlab (Hinglish) |
|--------|----------|------------|-------------------|
| `id` | `SERIAL` | `PRIMARY KEY` | Auto-increment unique ID — har row ka apna number |
| `name` | `TEXT` | `NOT NULL` | Naam dena **compulsory** hai |
| `email` | `TEXT` | `UNIQUE` | Ek hi email do baar nahi aa sakti |
| `age` | `INT` | `CHECK (age >= 18)` | Sirf 18 ya usse zyada age allowed |
| `created_at` | `TIMESTAMP` | `DEFAULT NOW()` | Row banate hi current date-time save ho jayega |

### ➕ Insert Data

```sql
INSERT INTO student (name, email, age)
VALUES ('Paras', 'paras@gmail.com', 19);
```

> ⚠️ **Dhyan do:** File me table naam `student` hai lekin insert me `students` likha hai — yeh typo hai. Sahi naam use karo: `INSERT INTO student ...`

Agar age 18 se kam ho to PostgreSQL error dega — `CHECK` constraint kaam kar raha hai.

### 📖 Read (SELECT)

```sql
-- Saara data
SELECT * FROM student;

-- Sirf specific columns
SELECT name, email FROM student;
```

### ✏️ Update

Existing row modify karo — hamesha `WHERE` lagao warna **saari rows** update ho jayengi!

```sql
UPDATE student SET age = 20 WHERE id = 1;
```

### 🗑️ Delete

```sql
DELETE FROM student WHERE id = 1;
```

### 💥 Table Hataana

```sql
DROP TABLE student;
```

---

## 3. File 2 — Employee Mini Project

**File:** `Employe_Mini_Project/Employe_Mini_Project.sql`

Yeh thoda advanced hai — real company jaisa `employees` table jisme salary, department, hire date sab hai.

### 🏗️ Table Structure

```sql
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    dept VARCHAR(50) NOT NULL,
    salary NUMERIC(10, 2) CHECK (salary > 0),
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Naye Concepts Jo Yahan Seekhoge

| Concept | Example | Explanation |
|---------|---------|-------------|
| `VARCHAR(50)` | `fname VARCHAR(50)` | Fixed max length text — 50 characters se zyada nahi |
| `NUMERIC(10, 2)` | `salary NUMERIC(10, 2)` | Paisa/decimal ke liye — 10 digits total, 2 decimal places (e.g. `85000.00`) |
| `DATE` | `hire_date DATE` | Sirf date store karta hai (time nahi) |
| `DEFAULT CURRENT_DATE` | hire_date par | Agar date na do to aaj ki date automatically set ho jayegi |
| `CHECK (salary > 0)` | salary column | Negative salary allow nahi hogi |

### ➕ Sample Data Insert

File me 10 employees ka ready-made data hai — Engineering, HR, Marketing, Finance, Data Science departments ke saath:

```sql
INSERT INTO employees (fname, lname, email, dept, salary, hire_date) VALUES
('Aarav', 'Sharma', 'aarav.sharma@example.com', 'Engineering', 85000.00, '2024-03-15'),
('Diya', 'Patel', 'diya.patel@example.com', 'Human Resources', 62000.00, '2023-08-22');
-- ... aur 8 rows file me hain
```

### Practice Queries (Khud Try Karo)

```sql
-- Saare employees dekho
SELECT * FROM employees;

-- Sirf Engineering department
SELECT fname, lname, salary FROM employees WHERE dept = 'Engineering';

-- Sabse zyada salary wala employee
SELECT fname, lname, salary FROM employees ORDER BY salary DESC LIMIT 1;

-- Department wise count
SELECT dept, COUNT(*) FROM employees GROUP BY dept;
```

---

## 4. Important Concepts Summary

### CRUD — Chaar Basic Operations

| Operation | SQL Command | Kaam |
|-----------|-------------|------|
| **C**reate | `INSERT INTO` | Nayi row add karna |
| **R**ead | `SELECT` | Data padhna / dekhna |
| **U**pdate | `UPDATE ... SET ... WHERE` | Existing data badalna |
| **D**elete | `DELETE FROM ... WHERE` | Row hataana |

### Constraints — Data Safe Rakhne Ke Rules

| Constraint | Matlab |
|------------|--------|
| `PRIMARY KEY` | Har row uniquely identify hoti hai |
| `NOT NULL` | Value dena zaroori hai |
| `UNIQUE` | Duplicate value allowed nahi |
| `CHECK` | Custom rule (jaise age >= 18, salary > 0) |
| `DEFAULT` | Value na do to automatic value set ho jati hai |

### SERIAL vs Manual ID

```sql
id SERIAL PRIMARY KEY   -- PostgreSQL khud 1, 2, 3... badhata rahega
```

Manual ID dene ki zaroorat nahi — `SERIAL` auto-increment handle karta hai.

### DROP vs TRUNCATE vs DELETE

| Command | Kya Hota Hai |
|---------|--------------|
| `DELETE FROM table WHERE ...` | Specific rows delete |
| `TRUNCATE TABLE table` | Saara data delete, table structure rehta hai |
| `DROP TABLE table` | Poora table + data permanent delete |

---

## 5. Quick Cheat Sheet

```sql
-- Connect & Setup
psql -U postgres
CREATE DATABASE postgressql_basics;
\c postgressql_basics;

-- Create Table
CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    age INT CHECK (age >= 18)
);

-- Insert
INSERT INTO student (name, email, age) VALUES ('Neeraj', 'n@mail.com', 22);

-- Read
SELECT * FROM student WHERE age > 20;

-- Update
UPDATE student SET age = 23 WHERE name = 'Neeraj';

-- Delete Row
DELETE FROM student WHERE id = 1;

-- Drop Table
DROP TABLE student;

-- psql Commands
\dt          -- tables list
\d student   -- table structure
\q           -- exit
```

---

## 🎯 Pro Tips

1. **Hamesha `WHERE` use karo** UPDATE aur DELETE me — warna poori table affect ho jayegi.
2. **Pehle SELECT, phir UPDATE/DELETE** — `WHERE` condition test karne ke liye pehle SELECT chalao.
3. File me queries **comment** (`--`) me hain — ek-ek karke uncomment karke run karo.
4. `Employe_Mini_Project` me `NUMERIC(10,2)` use kiya hai — money/financial data ke liye yeh best practice hai, `FLOAT` se better.

---

Happy Learning! 🚀 Agla step: [`Datatypes/`](../Datatypes/) folder — wahan advanced datatypes aur JSONB seekhoge.
