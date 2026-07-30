# 📘 Master PostgreSQL - Day 1

Welcome to the **Master PostgreSQL** repository! 🚀

Is repository me hum PostgreSQL ko **step by step** aur **simple Hinglish** me seekhenge.

## 📚 Topics Covered

- PostgreSQL Data Types
- Creating Tables
- Inserting Data
- Default Values
- Constraints
- JSONB Data Type
- Accessing JSONB Data

---

# 1️⃣ PostgreSQL Data Types

Data Type batata hai ke kisi column me kis type ka data store hoga.

| Data Type | Description | Example |
|-----------|-------------|---------|
| `SERIAL` | Auto Increment Integer | 1,2,3... |
| `VARCHAR(n)` | String/Text with max length | "Laptop" |
| `INT` | Integer Number | 100 |
| `BIGINT` | Large Integer | 5000000000 |
| `NUMERIC(p,s)` | Decimal Numbers | 250.50 |
| `BOOLEAN` | True or False | true |
| `UUID` | Unique ID | 550e8400-e29b... |
| `JSONB` | JSON Format Data | {"theme":"dark"} |
| `TIMESTAMP` | Date & Time | 2026-07-30 |

---

# 2️⃣ Creating Products Table

```sql
CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    stock INT DEFAULT 0,
    ratings BIGINT DEFAULT 0,
    price NUMERIC(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT true
);
```

## Explanation

### `id SERIAL PRIMARY KEY`

- `SERIAL` automatically ID generate karta hai.
- `PRIMARY KEY` har row ko unique banata hai.

Example

```
1
2
3
4
```

---

### `VARCHAR(100)`

Maximum 100 characters store kar sakta hai.

Example

```
Laptop
iPhone 17 Pro
```

---

### `INT DEFAULT 0`

Agar value nahi doge to automatically `0` store hogi.

Example

```sql
stock = 0
```

---

### `BIGINT`

Bahut bade integer numbers store karne ke liye.

Example

```
5000
10000000000
```

---

### `NUMERIC(10,2)`

Decimal values ke liye use hota hai.

Format

```
NUMERIC(total_digits, decimal_digits)
```

Example

```sql
NUMERIC(10,2)
```

Means

- Total digits = 10
- Decimal ke baad = 2

Valid Examples

```
250.00
99999999.99
```

---

### `BOOLEAN`

Sirf do values hoti hain.

```
true
false
```

---

# 3️⃣ Insert Data

```sql
INSERT INTO products (
    product_name,
    stock,
    ratings,
    price,
    is_available
)
VALUES
(
    'Peanut Butter',
    100,
    4000,
    250,
    true
),
(
    'iPhone 17 Pro',
    50,
    1000,
    200000,
    true
),
(
    'Samsung S26 Ultra',
    20,
    5000,
    250000,
    true
);
```

## Explanation

Har `()` ek new row represent karta hai.

Example Table

| Product | Stock | Price |
|---------|-------|--------|
| Peanut Butter |100|250|
| iPhone 17 Pro |50|200000|
| Samsung S26 Ultra|20|250000|

---

# 4️⃣ Default Values

Agar kisi column ki value nahi doge to PostgreSQL default value use karega.

Example

```sql
INSERT INTO products (
    product_name,
    ratings,
    price
)
VALUES (
    'Google FitBit Air',
    5000,
    15000
);
```

Humne `stock` aur `is_available` nahi diye.

Automatically

```
stock = 0
is_available = true
```

---

# 5️⃣ Fetch Data

```sql
SELECT * FROM products;
```

### Output

Ye products table ki sari rows aur columns return karega.

---

# 6️⃣ JSONB Data Type

`JSONB` PostgreSQL ka special data type hai.

Isme hum JSON format me data store kar sakte hain.

Example

```json
{
    "theme":"dark",
    "language":"urdu-pk",
    "notification":true
}
```

### JSONB kyu use kare?

- Flexible data store kar sakte hain.
- Fast searching.
- Easy updates.
- Nested objects support karta hai.

---

# 7️⃣ Users Table

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    preferences JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
```

## Explanation

### UUID

Random unique ID generate karta hai.

Example

```
3d7d39f8-bdb6-4b95-8cb2-6b65bde5cb78
```

---

### UNIQUE

Duplicate values allow nahi karta.

Example

✅ Allowed

```
abc@gmail.com
xyz@gmail.com
```

❌ Not Allowed

```
abc@gmail.com
abc@gmail.com
```

---

### JSONB

User ki settings JSON format me save hongi.

Example

```json
{
    "theme":"light",
    "language":"sin-pk",
    "notification":true
}
```

---

# 8️⃣ Insert JSONB Data

```sql
INSERT INTO users (
    name,
    email,
    preferences
)
VALUES
(
    'Adi Gir',
    'adigir@gmail.com',
    '{
        "theme":"light",
        "language":"sin-pk",
        "notification":true
    }'
),
(
    'Paras Gir',
    'parasgir@gmail.com',
    '{
        "theme":"dark",
        "language":"urdu-pk",
        "notification":true
    }'
);
```

---

# 9️⃣ Fetch Complete JSON

```sql
SELECT
    name,
    preferences
FROM users;
```

Output

| Name | Preferences |
|------|-------------|
| Adi Gir | {"theme":"light","language":"sin-pk"} |
| Paras Gir | {"theme":"dark","language":"urdu-pk"} |

---

# 🔟 Get Specific JSON Value

Agar sirf ek key ki value chahiye to `->>` operator use karte hain.

```sql
SELECT
    name,
    preferences->>'theme' AS theme
FROM users;
```

Output

| Name | Theme |
|------|-------|
| Adi Gir | light |
| Paras Gir | dark |

### Difference

`->`

Returns JSON.

```sql
preferences->'theme'
```

Output

```json
"dark"
```

---

`->>`

Returns Text.

```sql
preferences->>'theme'
```

Output

```
dark
```

---

# 📌 Quick Revision

✅ `SERIAL` → Auto Increment ID

✅ `VARCHAR` → Text

✅ `INT` → Integer

✅ `BIGINT` → Large Integer

✅ `NUMERIC` → Decimal Numbers

✅ `BOOLEAN` → true / false

✅ `UUID` → Unique ID

✅ `JSONB` → Store JSON Data

✅ `TIMESTAMP` → Date & Time

✅ `DEFAULT` → Automatic Value

✅ `PRIMARY KEY` → Unique Row Identifier

✅ `UNIQUE` → Duplicate Values Not Allowed

✅ `SELECT *` → Get All Data

✅ `->` → Returns JSON

✅ `->>` → Returns Text

---

Happy Learning! 🚀