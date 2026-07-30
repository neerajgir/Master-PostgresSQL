# PostgreSQL Master 🚀

Welcome to my **PostgreSQL Master Repository**.

Is repository me main PostgreSQL ko beginner se advanced level tak practice kar raha hoon. Har topic ko simple Hinglish me explain kiya gaya hai taake easily samajh aaye.

---

# 📚 Topics Covered

- Create Table
- UUID Primary Key
- VARCHAR
- UNIQUE
- NOT NULL
- JSONB
- DEFAULT
- TIMESTAMP
- INSERT INTO
- SELECT
- JSONB Operators (`->>`)

---

# 1. CREATE TABLE

Table create karne ke liye `CREATE TABLE` use hota hai.

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    preferences JSONB DEFAULT '{}'::JSONB,
    created_at TIMESTAMP DEFAULT NOW()
);
```

## Explanation

### id

```sql
id UUID PRIMARY KEY DEFAULT gen_random_uuid()
```

- Har user ka unique id generate hota hai.
- `PRIMARY KEY` duplicate nahi hone deta.
- `gen_random_uuid()` automatically id bana deta hai.

Example:

```
6c85112d-4f95-4c9b-9c49-8f17a3a0dc8e
```

---

### name

```sql
name VARCHAR(255) NOT NULL
```

- User ka name store karega.
- Maximum 255 characters.
- `NOT NULL` ka matlab name dena zaroori hai.

✅ Correct

```sql
'Adi Gir'
```

❌ Wrong

```sql
NULL
```

---

### email

```sql
email VARCHAR(255) NOT NULL UNIQUE
```

- Email bhi required hai.
- Same email dobara insert nahi ho sakti.

Example

✅

```
adi@gmail.com
```

❌

```
adi@gmail.com
adi@gmail.com
```

Second insert error dega.

---

### preferences

```sql
preferences JSONB DEFAULT '{}'::JSONB
```

JSON format me extra data store karne ke liye.

Agar value na do to empty object save hoga.

```json
{}
```

Example

```json
{
    "theme":"dark",
    "language":"urdu"
}
```

---

### created_at

```sql
created_at TIMESTAMP DEFAULT NOW()
```

Record create hote hi current date aur time save ho jata hai.

Example

```
2026-07-30 18:30:22
```

---

# 2. INSERT INTO

Table me data insert karne ke liye.

```sql
INSERT INTO users (
    name,
    email,
    preferences
)
VALUES (
    'Adi Gir',
    'adigir@gmail.com',
    '{
        "theme":"light",
        "language":"sindh-pk",
        "notification":true
    }'
);
```

## Output

| Name | Email | Theme |
|------|-------|-------|
| Adi Gir | adigir@gmail.com | light |

---

## Multiple Rows Insert

Ek hi query me multiple users insert kar sakte hain.

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
        "language":"sindh-pk",
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

## Insert Without JSON

Agar preferences na do to default value save hogi.

```sql
INSERT INTO users (
    name,
    email
)
VALUES (
    'Tulsi Gir',
    'tulsi@gmail.com'
);
```

Database automatically save karega

```json
{}
```

---

# 3. SELECT

Saara data dekhne ke liye

```sql
SELECT * FROM users;
```

Output

| id | name | email | preferences | created_at |
|----|------|-------|-------------|------------|

---

## Sirf Specific Columns

```sql
SELECT
name,
preferences
FROM users;
```

---

# 4. JSONB Data Read

JSON ke andar ki value nikalne ke liye `->>` operator use hota hai.

```sql
SELECT
name,
preferences->>'theme'
FROM users;
```

Output

| name | theme |
|------|-------|
| Adi Gir | light |
| Paras Gir | dark |

---

## Column Rename (Alias)

Readable output ke liye alias use karte hain.

```sql
SELECT
name AS username,
preferences->>'theme' AS theme
FROM users;
```

Output

| username | theme |
|----------|-------|
| Adi Gir | light |
| Paras Gir | dark |

---

## Multiple JSON Values

```sql
SELECT
name AS username,
preferences->>'theme' AS theme,
preferences->>'language' AS user_language
FROM users;
```

Output

| username | theme | user_language |
|----------|-------|---------------|
| Adi Gir | light | sindh-pk |
| Paras Gir | dark | urdu-pk |

---

# Example 1

Insert user

```sql
INSERT INTO users(name,email)
VALUES(
    'Ali',
    'ali@gmail.com'
);
```

Output

```json
preferences = {}
```

---

# Example 2

Read JSON data

```sql
SELECT
preferences->>'theme'
FROM users;
```

Output

```
light
```

or

```
dark
```

---

# Summary

| Keyword | Purpose |
|----------|----------|
| CREATE TABLE | Table banata hai |
| UUID | Unique ID generate karta hai |
| PRIMARY KEY | Har row ko unique banata hai |
| VARCHAR | Text store karta hai |
| NOT NULL | Value dena compulsory hai |
| UNIQUE | Duplicate values allow nahi hoti |
| JSONB | JSON data store karta hai |
| DEFAULT | Default value set karta hai |
| TIMESTAMP | Date aur Time store karta hai |
| INSERT INTO | Data insert karta hai |
| SELECT | Data retrieve karta hai |
| ->> | JSON ki value read karta hai |
| AS | Column ka naam change karta hai |

---

## Happy Learning ❤️

Agar aap PostgreSQL seekh rahe hain, to har topic ko khud practice karein. SQL me jitni zyada practice hogi, utni hi concepts strong honge.

⭐ Don't forget to star the repository if you find it helpful.