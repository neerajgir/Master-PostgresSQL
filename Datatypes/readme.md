# 📊 Datatypes — PostgreSQL Data Types & Queries (Hinglish Edition)

Yeh folder PostgreSQL ke **advanced datatypes** aur un par **real queries** cover karta hai — `JSONB`, `UUID`, `TEXT[]` (arrays), `BOOLEAN`, `NUMERIC`, aur bahut saari filtering/aggregation examples. Do files hain: ek comprehensive `course_enrollment` project aur ek focused `JSONB` users table.

---

## 📁 Folder Structure

| File | Kya Seekhenge |
|------|---------------|
| [`01-Datatypes_PostgresSQL.sql`](01-Datatypes_PostgresSQL.sql) | Saare datatypes + WHERE, LIKE, GROUP BY, aggregate functions |
| [`02-JSONB_PostgresSQL.sql`](02-JSONB_PostgresSQL.sql) | UUID, JSONB preferences, `->>` operator |

---

## 📌 Index

1. [Setup](#1-setup)
2. [File 1 — Course Enrollment (All Datatypes)](#2-file-1--course-enrollment-all-datatypes)
3. [File 2 — JSONB Users Table](#3-file-2--jsonb-users-table)
4. [Datatypes Cheat Sheet](#4-datatypes-cheat-sheet)
5. [Query Patterns Summary](#5-query-patterns-summary)
6. [Quick Reference Table](#6-quick-reference-table)

---

## 1. Setup

```bash
psql -U postgres
```

```sql
CREATE DATABASE postgressql_datatypes;
\c postgressql_datatypes;
```

Pehle file me table create + insert queries **comment** me hain — uncomment karke chalao, phir neeche wali SELECT queries practice karo.

---

## 2. File 1 — Course Enrollment (All Datatypes)

**File:** `01-Datatypes_PostgresSQL.sql`

Ek online learning platform jaisa table — students, courses, prices, ratings, JSON metadata, aur skills array.

### 🏗️ Table Create

```sql
CREATE TABLE course_enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    course_name VARCHAR(50) NOT NULL,
    level VARCHAR(20),
    price NUMERIC(8, 2) CHECK (price > 0),
    enrolled_on DATE DEFAULT CURRENT_DATE,
    completion_status BOOLEAN DEFAULT FALSE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    course_meta JSONB,
    skills TEXT[]
);
```

### Har Datatype Samjho

| Column | Type | Matlab (Hinglish) |
|--------|------|-------------------|
| `enrollment_id` | `SERIAL PRIMARY KEY` | Auto-increment unique ID |
| `student_name` | `VARCHAR(50)` | Max 50 characters ka naam |
| `email` | `VARCHAR(100) UNIQUE` | Duplicate email nahi |
| `course_name` | `VARCHAR(50)` | Course ka naam |
| `level` | `VARCHAR(20)` | Beginner / Intermediate / Advanced |
| `price` | `NUMERIC(8,2)` | Decimal price — 8 digits, 2 decimal (e.g. `2999.00`) |
| `enrolled_on` | `DATE` | Enrollment ki date |
| `completion_status` | `BOOLEAN` | `TRUE` = complete, `FALSE` = incomplete |
| `rating` | `INT CHECK (1-5)` | Sirf 1 se 5 ke beech rating |
| `course_meta` | `JSONB` | Flexible JSON data (instructor, duration, etc.) |
| `skills` | `TEXT[]` | PostgreSQL **array** — multiple skills ek column me |

### ➕ Sample Insert (Ek Row)

```sql
INSERT INTO course_enrollment (
    student_name, email, course_name, level, price,
    enrolled_on, completion_status, rating, course_meta, skills
) VALUES (
    'Rohan Malhotra', 'rohan.m@example.com', 'PostgreSQL Bootcamp',
    'Intermediate', 2999.00, '2026-01-15', TRUE, 5,
    '{"instructor": "Dr. Sen", "duration_weeks": 8}',
    ARRAY['SQL', 'PostgreSQL', 'Database Design']
);
```

File me **10 rows** ka ready data hai — PostgreSQL, Python, ML, UI/UX, Docker, React courses ke saath.

---

### 📖 Basic SELECT Queries

```sql
-- Saara data
SELECT * FROM course_enrollment;

-- Sirf beginner courses
SELECT * FROM course_enrollment WHERE level = 'Beginner';

-- Unique course names (duplicate hata ke)
SELECT DISTINCT course_name FROM course_enrollment;

-- Price ke hisaab se sort (mehnga pehle)
SELECT student_name, price FROM course_enrollment ORDER BY price DESC;
```

---

### 🔍 JSONB Read Karna

JSON ke andar ki value nikalne ke liye `->>` operator use hota hai (text return karta hai):

```sql
-- Instructor ka naam JSON se nikalo
SELECT course_meta->>'instructor' AS Instructor FROM course_enrollment;

-- Specific instructor ke students
SELECT student_name, course_name
FROM course_enrollment
WHERE course_meta->>'instructor' = 'Rajesh Kumar';
```

**Operators:**
| Operator | Return Type | Use |
|----------|-------------|-----|
| `->` | JSON object | Nested JSON access |
| `->>` | Text | Final value as string |

---

### 📦 Array (TEXT[]) Queries

```sql
-- Jinhone 'React' skill wala course kiya
SELECT * FROM course_enrollment WHERE 'React' = ANY(skills);

-- Git skill wale
SELECT student_name, course_name FROM course_enrollment WHERE 'Git' = ANY(skills);
```

> `ANY(skills)` matlab — array me yeh value hai kya?

---

### 🔎 LIKE & ILIKE (Pattern Matching)

```sql
-- Naam 'A' se shuru
SELECT * FROM course_enrollment WHERE student_name LIKE 'A%';

-- Naam 'ena' se khatam
SELECT * FROM course_enrollment WHERE student_name LIKE '%ena';

-- Kahin bhi 'an' ho
SELECT * FROM course_enrollment WHERE student_name LIKE '%an%';

-- Case-insensitive (PostgreSQL special)
SELECT * FROM course_enrollment WHERE student_name ILIKE 'a%';

-- 'Z' se shuru wale exclude
SELECT * FROM course_enrollment WHERE student_name NOT LIKE 'Z%';
```

| Pattern | Matlab |
|---------|--------|
| `%` | Zero ya zyada characters |
| `_` | Exactly ek character |
| `ILIKE` | Case-insensitive LIKE |

---

### ⚖️ Comparison & Logical Operators

```sql
-- Price filters
SELECT * FROM course_enrollment WHERE price > 1000;
SELECT * FROM course_enrollment WHERE price BETWEEN 3000 AND 4000;

-- AND / OR
SELECT * FROM course_enrollment
WHERE level = 'Intermediate' AND completion_status = true;

SELECT * FROM course_enrollment
WHERE level = 'Beginner' OR level = 'Advanced';

-- IN operator
SELECT * FROM course_enrollment
WHERE course_name IN ('Docker & Kubernetes');
```

---

### 📊 Aggregate Functions (Summary Calculations)

```sql
SELECT COUNT(*) FROM course_enrollment;           -- Total rows
SELECT SUM(price) FROM course_enrollment;           -- Total revenue
SELECT AVG(price) FROM course_enrollment;           -- Average price
SELECT MIN(price) FROM course_enrollment;           -- Sabse sasta
SELECT MAX(price) FROM course_enrollment;           -- Sabse mehnga
```

### GROUP BY & HAVING

```sql
-- Har course ka total revenue
SELECT course_name, SUM(price) AS revenue
FROM course_enrollment
GROUP BY course_name;

-- Course wise average rating (sirf jahan rating hai)
SELECT course_name, AVG(rating) AS avg_rating
FROM course_enrollment
GROUP BY course_name
HAVING AVG(rating) IS NOT NULL;

-- Complete vs incomplete count
SELECT completion_status, COUNT(*)
FROM course_enrollment
GROUP BY completion_status;
```

> **GROUP BY** — data ko groups me baant ke summary nikalna  
> **HAVING** — grouped results par filter (WHERE groups ke baad lagta hai)

---

### 🔤 String Functions

```sql
SELECT UPPER(student_name) FROM course_enrollment;
SELECT LOWER(student_name) FROM course_enrollment;
SELECT student_name, LENGTH(student_name) FROM course_enrollment;
SELECT CONCAT(student_name, ' enrolled_in ', course_name) FROM course_enrollment;
SELECT SUBSTRING(email FROM 1 FOR 5) FROM course_enrollment;
SELECT TRIM('   PostgreSQL   ');   -- Spaces hata deta hai
```

---

### 🎯 Combined Practice Query

Real interview-style query — intermediate courses, price sort, top 3:

```sql
SELECT student_name, course_name, price
FROM course_enrollment
WHERE level = 'Intermediate'
ORDER BY price DESC
LIMIT 3;
```

Sabse zyada enrollments wala course:

```sql
SELECT course_name, COUNT(*) AS total_enrollments
FROM course_enrollment
GROUP BY course_name
ORDER BY total_enrollments DESC
LIMIT 1;
```

---

## 3. File 2 — JSONB Users Table

**File:** `02-JSONB_PostgresSQL.sql`

Ek modern app jaisa `users` table — UUID primary key aur JSONB preferences.

### 🏗️ Table Create

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    preferences JSONB DEFAULT '{}'::JSONB,
    created_at TIMESTAMP DEFAULT NOW()
);
```

### Naye Concepts

| Concept | Code | Matlab |
|---------|------|--------|
| **UUID** | `gen_random_uuid()` | Random unique ID — distributed systems me popular |
| **JSONB** | `'{"theme":"dark"}'` | Binary JSON — fast search & indexing |
| **Default empty JSON** | `DEFAULT '{}'::JSONB` | Preferences na do to `{}` save hoga |

UUID example output:
```
6c85112d-4f95-4c9b-9c49-8f17a3a0dc8e
```

### ➕ Insert With JSON Preferences

```sql
INSERT INTO users (name, email, preferences)
VALUES (
    'Adi Gir',
    'adigir@gmail.com',
    '{
        "theme": "light",
        "language": "sin-pk",
        "notification": true
    }'
);
```

### ➕ Insert Without JSON (Default Use Hoga)

```sql
INSERT INTO users (name, email)
VALUES ('Tulsi Gir', 'tulsi@gmail.com');
-- preferences automatically {} save hoga
```

### 📖 JSONB Read Queries

```sql
-- Saara data
SELECT * FROM users;

-- Theme nikalo
SELECT name, preferences->>'theme' AS theme FROM users;

-- Alias ke saath readable output
SELECT
    name AS username,
    preferences->>'theme' AS theme,
    preferences->>'language' AS user_language
FROM users;
```

| name | theme | user_language |
|------|-------|---------------|
| Adi Gir | light | sin-pk |
| Paras Gir | dark | urdu-pk |
| Tulsi Gir | null | null |

---

## 4. Datatypes Cheat Sheet

```sql
-- Text
VARCHAR(255)    -- Fixed max length string
TEXT            -- Unlimited length string

-- Numbers
INT / INTEGER   -- Whole numbers (-2B to +2B)
SERIAL          -- Auto-increment INT (for IDs)
NUMERIC(10,2)   -- Exact decimal (money ke liye best)
FLOAT / REAL    -- Approximate decimal (avoid for money)

-- Date & Time
DATE            -- 2026-08-06
TIME            -- 14:30:00
TIMESTAMP       -- Date + Time together
NOW()           -- Current timestamp

-- Boolean
BOOLEAN         -- TRUE / FALSE / NULL

-- Special PostgreSQL Types
UUID            -- Universal unique identifier
JSONB           -- Binary JSON (searchable, indexable)
TEXT[]          -- Array of text values
```

---

## 5. Query Patterns Summary

### Filtering Flow

```
SELECT columns          → Kya dikhega
FROM table              → Kahan se
WHERE condition         → Row-level filter
GROUP BY column         → Groups banao
HAVING condition        → Group-level filter
ORDER BY column         → Sort karo
LIMIT n                 → Sirf n rows
```

### Common Patterns

```sql
-- Pattern 1: Simple filter
SELECT * FROM table WHERE column = 'value';

-- Pattern 2: Range
SELECT * FROM table WHERE price BETWEEN 100 AND 500;

-- Pattern 3: List match
SELECT * FROM table WHERE dept IN ('HR', 'Finance');

-- Pattern 4: JSON extract
SELECT data->>'key' FROM table;

-- Pattern 5: Array contains
SELECT * FROM table WHERE 'skill' = ANY(skills_array);

-- Pattern 6: Aggregation
SELECT category, COUNT(*), AVG(price)
FROM table
GROUP BY category
HAVING COUNT(*) > 1;
```

---

## 6. Quick Reference Table

| Keyword / Operator | Purpose |
|--------------------|---------|
| `CREATE TABLE` | Naya table banata hai |
| `SERIAL` | Auto-increment integer ID |
| `UUID` + `gen_random_uuid()` | Random unique ID generate |
| `PRIMARY KEY` | Har row uniquely identify |
| `VARCHAR(n)` | Max n characters text |
| `NOT NULL` | Value dena compulsory |
| `UNIQUE` | Duplicate allow nahi |
| `CHECK` | Custom validation rule |
| `DEFAULT` | Default value set karta hai |
| `NUMERIC(p,s)` | Exact decimal number |
| `BOOLEAN` | True / False store |
| `DATE` | Sirf date |
| `TIMESTAMP` | Date + time |
| `JSONB` | JSON data (fast & searchable) |
| `TEXT[]` | Text ka array |
| `INSERT INTO` | Data daalna |
| `SELECT` | Data padhna |
| `WHERE` | Filter rows |
| `LIKE / ILIKE` | Pattern matching |
| `AND / OR` | Multiple conditions |
| `IN` | List me se match |
| `BETWEEN` | Range filter |
| `ORDER BY` | Sort karna |
| `LIMIT` | Rows ki limit |
| `DISTINCT` | Duplicates hata ke |
| `COUNT/SUM/AVG/MIN/MAX` | Aggregate functions |
| `GROUP BY` | Group wise summary |
| `HAVING` | Group par filter |
| `->>` | JSON value as text |
| `ANY(array)` | Array me value check |
| `AS` | Column alias / rename |

---

## 🎯 Pro Tips

1. **Money ke liye `NUMERIC` use karo**, `FLOAT` nahi — floating point rounding errors aate hain.
2. **JSONB > JSON** — PostgreSQL me JSONB binary format me store hota hai, queries faster hain.
3. **`ILIKE`** PostgreSQL ka apna operator hai — MySQL me sirf `LIKE` hota hai case-sensitive.
4. Pehle `SELECT ... WHERE` chalao, confirm karo sahi rows aa rahi hain, phir `UPDATE`/`DELETE` karo.
5. `GROUP BY` me jo columns SELECT me hain (aggregate ke alawa), wo sab `GROUP BY` me honi chahiye.

---

Happy Learning! 🚀 Pehle [`Basics/`](../Basics/) folder complete karo agar abhi nahi kiya, phir yahan aao.
