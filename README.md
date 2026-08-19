# 🐘 Master PostgreSQL Guide (Hinglish Edition) - UserDefined Focus

Welcome! Yeh guide **User Defined Functions aur Procedures** seekhne ke liye ek complete reference hai PostgreSQL ke liye. Chahe aap beginner ho ya experience developer, isme functions aur procedures ka difference samajhne ke liye saare concepts deep level par cover kiye gaye hain.

---

## 📌 Index / Table of Contents

1. [PostgreSQL Ka Introduction](#1-postgresql-ka-introduction)
2. [User Defined Functions (UDF)](#2-user-defined-functions-udf)
3. [Procedures in PostgreSQL](#3-procedures-in-postgresql)
4. [Key Differences: Functions vs Procedures](#4-key-differences-functions-vs-procedures)
5. [Real-Life Usages](#5-real-life-usages)
6. [Quick Code Snippets](#6-quick-code-snippets)
7. [Terminal Commands Reference](#7-terminal-commands-reference)

---

## 1. 📖 PostgreSQL Ka Introduction

**PostgreSQL** (jise hum Postgres bhi kehte hain) ek super powerful, open-source **Relational Database Management System (RDBMS)** hai.

### Key Highlights:
- **Relational Data:** Yeh data ko Tables (Rows aur Columns) me store karta hai.
- **ACID Compliant:** Iska matlab aapka data hamesha safe, consistent, aur reliable rahega.
- **Free & Open Source:** Koi licensing cost nahi hai.
- **Used By Big Tech:** Apple, Netflix, Uber, Instagram sab Postgres use karte hain.

---

## 2. 🔧 User Defined Functions (UDF)

Functions in PostgreSQL **value return karte hain**. Inhe `CREATE FUNCTION` command se banata hai.

### Function Syntax:
```sql
CREATE FUNCTION function_name(parameters)
RETURNS return_type
LANGUAGE plpgsql
AS $$
BEGIN
    -- Logic
    RETURN value;
END;
$$;
```

### Real-Life Example: Count Total YouTubers
```sql
-- Function jo total rows count karta hai
CREATE FUNCTION total_youtubers()
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM tech_youtubers);
END;
$$;

-- Function call karna
SELECT total_youtubers();
-- Output: 5
```

### Example: Categorize Channel by Subscribers
```sql
-- Function jo channel category batata hai
CREATE FUNCTION channel_category(subs NUMERIC)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
BEGIN
    IF subs >= 1 THEN
        RETURN 'Big Channel';
    ELSE
        RETURN 'Growing Channel';
    END IF;
END;
$$;

-- Use karna
SELECT name, channel_category(subscribers_millions)
FROM tech_youtubers;
```

### Key Points About Functions:
- ✅ **Must return a value** (even if void/NULL)
- ✅ **Can be used in SQL queries** (SELECT, WHERE, JOIN)
- ✅ **Cannot have OUT parameters**
- ✅ **Can be deterministic or stochastic**
- ❌ **Cannot modify database state** (ideally, though PL/pgSQL can do it)

---

## 3. 🛠️ Procedures in PostgreSQL

Procedures in PostgreSQL **actions perform karte hain** (INSERT, UPDATE, DELETE) lekin **koi value return nahi karte**. Inhe PostgreSQL 11+ version se official support mila hai.

### Procedure Syntax:
```sql
CREATE PROCEDURE procedure_name(parameters)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Logic (INSERT, UPDATE, DELETE)
    -- No RETURN statement needed
END;
$$;
```

### Real-Life Example: Add a New YouTuber
```sql
-- Procedure jo nayi row insert karta hai
CREATE PROCEDURE add_youtuber(
    p_name VARCHAR,
    p_channel VARCHAR,
    p_tech VARCHAR,
    p_subs NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO tech_youtubers (name, channel, tech, subscribers_millions)
    VALUES (p_name, p_channel, p_tech, p_subs);
END;
$$;

-- Procedure call karna (CALL command se)
CALL add_youtuber('Tanay Pratap', 'Tanay Pratap', 'Web Development', 0.50);
```

### Example: Deactivate a Channel
```sql
-- Procedure jo channel ko deactivate karta hai
CREATE PROCEDURE deactivate_youtuber(p_channel VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE tech_youtubers
    SET active = false
    WHERE channel = p_channel;
END;
$$;

CALL deactivate_youtuber('Coding Shuttle');
```

### Example: Safe Delete with Transaction Handling
```sql
-- Procedure jo row delete karta hai aur check karta hai
CREATE PROCEDURE safe_delete(p_channel VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM tech_youtubers WHERE channel = p_channel;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Channel not found';
    END IF;
END;
$$;

CALL safe_delete('Non Existent Channel');
-- Error: Channel not found
```

### Key Points About Procedures:
- ✅ **No return value** needed (void)
- ✅ **Can have IN, OUT, INOUT parameters**
- ✅ **Can perform DML operations** (INSERT, UPDATE, DELETE)
- ✅ **Must be called using `CALL` command**
- ✅ **Can handle transactions** (COMMIT, ROLLBACK)
- ❌ **Cannot be used in SQL queries directly**

---

## 4. ⚖️ Key Differences: Functions vs Procedures

| Aspect | Function | Procedure |
|--------|----------|-----------|
| **Return Value** | Must return a value | No return value (void) |
| **Usage** | `SELECT function()` | `CALL procedure()` |
| **DML Operations** | ❌ Limited (READ only) | ✅ INSERT, UPDATE, DELETE allowed |
| **Parameters** | Only IN parameters | IN, OUT, INOUT parameters |
| **Transaction Control** | ❌ No COMMIT/ROLLBACK | ✅ Can use COMMIT, ROLLBACK |
| **Performance** | Can be used in expressions | Separate execution block |
| **PostgreSQL Version** | Always supported | PostgreSQL 11+ |

### Quick Comparison Example:

```sql
-- Function: Returns a value, can be used in SELECT
CREATE FUNCTION get_channel_count()
RETURNS INTEGER
AS $$ SELECT COUNT(*) FROM tech_youtubers; $$;

-- Procedure: Performs action, must be called separately
CREATE PROCEDURE add_new_youtuber(p_name VARCHAR)
LANGUAGE plpgsql
AS $$ INSERT INTO tech_youtubers (name) VALUES (p_name); $$;
```

---

## 5. 🌟 Real-Life Usages

### When to Use FUNCTIONS:
1. **Data Validation:** Validate input data before storing
2. **Calculations:** Compute values (tax, discounts, totals)
3. **Format Conversion:** Convert data formats (date to string, etc.)
4. **Business Logic:** Reusable logic across multiple queries
5. **Indexes & Views:** Can be used in CREATE VIEW, computed columns

### When to Use PROCEDURES:
1. **Batch Operations:** Multiple INSERT/UPDATE/DELETE in one call
2. **Complex Transactions:** Transactions with error handling
3. **Administrative Tasks:** Database maintenance, backup operations
4. **API-Like Endpoints:** Exposing database operations to applications
5. **Bulk Data Processing:** Process large datasets efficiently

### Real-World Scenario: E-Commerce Order Processing

**Function - Calculate Discount:**
```sql
CREATE FUNCTION calculate_discount(total_amount NUMERIC)
RETURNS NUMERIC
AS $$
DECLARE
    discount_percent NUMERIC := 0;
BEGIN
    IF total_amount > 10000 THEN
        discount_percent := 10;
    ELSIF total_amount > 5000 THEN
        discount_percent := 5;
    END IF;
    RETURN total_amount * (discount_percent / 100);
END;
$$;
```

**Procedure - Process Order:**
```sql
CREATE PROCEDURE process_order(
    p_customer_id INTEGER,
    p_product_id INTEGER,
    p_quantity INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_order_id INTEGER;
BEGIN
    -- Insert order
    INSERT INTO orders (customer_id, product_id, quantity, status)
    VALUES (p_customer_id, p_product_id, p_quantity, 'processing');
    
    GET DIAGNOSTICS v_order_id = ROW_COUNT;
    
    -- Update product stock
    UPDATE products SET stock = stock - p_quantity WHERE id = p_product_id;
    
    -- Log the transaction
    INSERT INTO order_log (order_id, action, timestamp)
    VALUES (v_order_id, 'order_processed', NOW());
    
    COMMIT;
END;
$$;

CALL process_order(123, 456, 2);
```

---

## 6. 💻 Quick Code Snippets

### Function with Table Reference
```sql
CREATE OR REPLACE FUNCTION get_youtubers_by_tech(p_tech VARCHAR)
RETURNS TABLE(name VARCHAR, channel VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT t.name, t.channel
    FROM tech_youtubers t
    WHERE t.tech = p_tech;
END;
$$;

-- Use: SELECT * FROM get_youtubers_by_tech('JavaScript');
```

### Procedure with OUT Parameter
```sql
CREATE PROCEDURE get_user_count(OUT count_val INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) INTO count_val FROM users;
END;
$$;

CALL get_user_count(/* output will be stored in this variable */);
```

---

## 7. ⌨️ Terminal Commands Reference

| Command | Description |
|---------|-------------|
| `\l` | List all databases |
| `\c db_name` | Connect to specific database |
| `\dt` | List all tables in current database |
| `\d table_name` | Show table structure/schema |
| `\du` | List all users and roles |
| `\df` | List all functions |
| `\dp` | List access privileges |
| `\p` | Show query buffer |
| `\i file.sql` | Execute SQL file |
| `\q` | Quit psql terminal |

---

## 🎯 Pro Tips (Hinglish)

1. **Function always return karega value** - भले hi koi value ho ya NULL.
2. **Procedure sirf kaam karega** - INSERT, UPDATE, DELETE karna.
3. **PostgreSQL 11+ mein Procedures official support karte hain** - Purane versions mein DO block use karna padta tha.
4. **Function ko SELECT query mein use kar sakte ho** - Procedure ko use nahi kar sakte.
5. **Procedure mein transaction handle kar sakte ho** - COMMIT aur ROLLBACK use kar sakte ho.

🚫 **Common Mistake:** Function mein INSERT/UPDATE mat karo (generally), warna confusion ho sakti hai. Procedures ke liye banaya gaya hai.

---

Happy Coding! 🐘💻

*(Yeh guide 2026 ke hisaab se banaya gaya hai, PostgreSQL latest features cover karta hai.)*