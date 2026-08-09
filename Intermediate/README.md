# 🐘 PostgreSQL Intermediate Guide (Hinglish Edition)

Is folder me hum PostgreSQL ke **Intermediate level** topics cover karte hain. Agar aapne Basics section already complete kar liya hai, toh aap bilkul perfect jagah par ho. Yahan hum seekhenge:

1. [ALTER TABLE — Structure Badalna](#1-🔧-alter-table--structure-badalna)
2. [ALTER TABLE — Real-Life Example](#2-📺-alter-table--real-life-example)
3. [CASE Expressions — Conditional Logic](#3-🎭-case-expressions--conditional-logic)

---

## 1. 🔧 ALTER TABLE — Structure Badalna

`ALTER TABLE` command se aap **existing table ka structure** change kar sakte ho. Data delete nahi hota, sirf table ka layout badalta hai. Yeh real-life me bahut zaroori hai kyunki aapka app shuru se sab kuch perfect nahi bana sakta — requirement change hoti hai, naye columns add karne padte hain.

### ➕ Column Add Karna

```sql
-- Basic table banate hain
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INT
);

-- Ek single column add karo
ALTER TABLE movies ADD COLUMN director VARCHAR(100);

-- Ek saath multiple columns add karo
ALTER TABLE movies
ADD COLUMN budget DECIMAL(12, 2),
ADD COLUMN box_office DECIMAL(12, 2);

-- Default value ke saath column add karo
ALTER TABLE movies
ADD COLUMN rating VARCHAR(10) DEFAULT 'PG-13';

ALTER TABLE movies
ADD COLUMN duration_minutes INTEGER NOT NULL DEFAULT 120;
```

> **Real-Life Usage:** Netflix jaise app me jab nayi feature aati hai (jaise movie ke duration dikhana), toh puri table dobara nahi banate. Sirf `ADD COLUMN` se naya column jodte hain. `DEFAULT` isliye zaroori hai kyunki purane rows me bhi value automatically fill ho jayegi.

### ➖ Column Delete Karna

```sql
-- Ek column drop karo
ALTER TABLE movies DROP COLUMN rating;

-- Multiple columns ek saath drop karo
ALTER TABLE movies
DROP COLUMN box_office,
DROP COLUMN duration_minutes;

-- CASCADE ke saath drop (dependents bhi drop ho jayenge)
ALTER TABLE movies
DROP COLUMN director CASCADE;
```

> ⚠️ **Warning:** `DROP COLUMN` se column ka **poora data hamesha ke liye** delete ho jata hai. Ek baar drop kar diya, toh wapas nahi aayega. `CASCADE` tab use karo jab column par views ya constraints bhi depend karte hon.

### ✏️ Column Rename Karna

```sql
-- Column ka naam badlo
ALTER TABLE movies RENAME COLUMN title TO movie_title;

-- Poora table rename karo
ALTER TABLE movies RENAME TO films;
ALTER TABLE films RENAME TO movies;
```

### 🔄 Data Type Change Karna

```sql
-- Type change karo
ALTER TABLE movies ALTER COLUMN release_year TYPE SMALLINT;

-- Complex conversion ke liye USING clause use karo
ALTER TABLE movies
ALTER COLUMN rating TYPE VARCHAR(20)
USING rating::VARCHAR(20);

-- Zyada precision ke liye
ALTER TABLE movies
ALTER COLUMN release_year TYPE NUMERIC(4, 0);
```

> **Real-Life Usage:** Jab aap samajhte ho ki `INT` chhota pad gaya ya data large ho raha hai (jaise release_year INT se NUMERIC), toh `ALTER COLUMN TYPE` se upgrade karte ho. `USING` clause tab lagta hai jab type ka automatic conversion possible na ho.

### 🎯 Default Value Set / Drop Karna

```sql
-- Default set karo
ALTER TABLE movies
ALTER COLUMN rating SET DEFAULT 'Not Rated';

-- Default drop karo
ALTER TABLE movies
ALTER COLUMN rating DROP DEFAULT;

-- Current date ke saath default
ALTER TABLE movies
ADD COLUMN added_date DATE DEFAULT CURRENT_DATE;

-- Expression as default
ALTER TABLE movies
ALTER COLUMN added_date SET DEFAULT NOW();
```

### 🔒 NOT NULL Constraint

```sql
-- NOT NULL add karo
ALTER TABLE movies
ALTER COLUMN movie_title SET NOT NULL;

-- NOT NULL drop karo
ALTER TABLE movies
ALTER COLUMN rating DROP NOT NULL;

-- Safe workflow: pehle NULL values handle karo, phir NOT NULL lagao
UPDATE movies SET director = 'Unknown' WHERE director IS NULL;

ALTER TABLE movies
ALTER COLUMN director SET DEFAULT 'Unknown';
ALTER TABLE movies
ALTER COLUMN director SET NOT NULL;
```

> **Real-Life Usage:** `NOT NULL` ka matlab — yeh column hamesha value deni hogi. Jab aap manually director input karte ho, kai rows me director khali reh sakta hai. Pehle `UPDATE` se NULL ko `'Unknown'` se replace karo, tabhi constraint safe hai. Warna ALTER fail ho jayegi!

---

## 2. 📺 ALTER TABLE — Real-Life Example

Ab ek **streaming platform** (Netflix/PrimeVideo style) ka real example dekhte hain. Ek simple `streaming_users` table se start karke structure ko grow karte hain.

```sql
CREATE TABLE streaming_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100)
);

-- Structure expand karo: email + plan details add karo
ALTER TABLE streaming_users
ADD COLUMN email VARCHAR(100) UNIQUE NOT NULL,
ADD COLUMN signup_date DATE DEFAULT CURRENT_DATE,
ADD COLUMN subscription_type VARCHAR(50) DEFAULT 'free';

-- Email pehle se NULL values ho sakti hain, isliye pehle NOT NULL enforce karo
ALTER TABLE streaming_users
ALTER COLUMN email SET NOT NULL;

-- Payment info add karo
ALTER TABLE streaming_users
ADD COLUMN payment_method VARCHAR(50),
ADD COLUMN last_payment_date DATE;

-- Column rename karo
ALTER TABLE streaming_users
RENAME COLUMN subscription_type TO plan_type;

-- Payment method ab zaroorat nahi (feature remove)
ALTER TABLE streaming_users
DROP COLUMN payment_method;

-- Username ki limit kam karo
ALTER TABLE streaming_users
ALTER COLUMN username TYPE VARCHAR(30);

SELECT * FROM streaming_users;
```

> **Real-Life Usage:** Streaming app ka business grow hota hai — pehle sirf username tha, phir email zaroori hua, phir plan system aaya (`free` → `premium`), phir payment method remove hua. Har step me aap `ALTER TABLE` se hi structure update karte ho. Table dobara banane ki zaroorat nahi padti, data safe rehta hai.

---

## 3. 🎭 CASE Expressions — Conditional Logic

`CASE` expression SQL me **if-else logic** lagane ka tarika hai. Agar programming se aate ho toh socho: `if (condition) { } else if { } else { }` — bas SQL version.

### 🟢 Basic CASE

```sql
-- Sample data
CREATE TABLE viewer_activity (
    activity_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    movie_id INTEGER,
    watch_percentage INTEGER,
    watched_date DATE
);

INSERT INTO viewer_activity (user_id, movie_id, watch_percentage, watched_date) VALUES
(1, 101, 100, '2025-01-01'),
(2, 102, 45, '2025-01-02'),
(3, 103, 75, '2025-01-02'),
(4, 104, 20, '2025-01-03'),
(5, 105, 90, '2025-01-03');

SELECT activity_id, user_id, watch_percentage,
CASE
    WHEN watch_percentage >= 90 THEN 'Completed'
    WHEN watch_percentage >= 50 THEN 'Partial'
    WHEN watch_percentage >= 20 THEN 'Started'
    ELSE 'Barely Watches'
END AS viewing_status
FROM viewer_activity;
```

> **Real-Life Usage:** YouTube jaise platform par view ka status dikhana — 90%+ dekha toh "Completed", 50%+ toh "Partial", etc. Yeh sab SQL me hi calculate hota hai, app code me nahi.

### 🟡 Complex CASE (Multiple Conditions)

```sql
CREATE TABLE platform_movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    genre VARCHAR(50),
    rating DECIMAL(3, 1),
    release_year INTEGER,
    content_rating VARCHAR(10)
);

INSERT INTO platform_movies (title, genre, rating, release_year, content_rating) VALUES
('Stellar Voyage', 'Sci-Fi', 8.7, 2023, 'PG-13'),
('Dark Alley', 'Thriller', 7.2, 2022, 'R'),
('Laugh Factory', 'Comedy', 6.5, 2024, 'PG'),
('Epic Quest', 'Fantasy', 9.1, 2023, 'PG-13'),
('True Crime Story', 'Documentary', 8.0, 2024, 'R');

-- AND + IN ke saath complex conditions
SELECT
    title,
    rating,
    content_rating,
    CASE
        WHEN rating >= 9.0 THEN 'Must Watch'
        WHEN rating >= 8.0 AND content_rating IN ('PG', 'PG-13') THEN 'Family Friendly Hit'
        WHEN rating >= 7.0 THEN 'Worth Watching'
        WHEN rating >= 6.0 THEN 'Average'
        ELSE 'Skip'
    END AS recommendation,
    CASE
        WHEN release_year >= 2024 THEN 'New Release'
        WHEN release_year >= 2022 THEN 'Recent'
        ELSE 'Catalog'
    END AS recency
FROM platform_movies;
```

### 🔵 CASE in WHERE

```sql
-- Genre ke hisaab se alag-alag filtering criteria
SELECT title, genre, rating
FROM platform_movies
WHERE
    CASE
        WHEN genre = 'Documentary' THEN rating >= 7.5
        WHEN genre = 'Comedy' THEN rating >= 6.0
        ELSE rating >= 8.0
    END;
```

> **Real-Life Usage:** Recommendation engine me har genre ka alag threshold hota hai. Documentary ke liye 7.5 acceptable hai, comedy ke liye 6.0, baaki ke liye 8.0+. Yeh condition SQL me hi handle ho jaati hai.

### 🟣 Custom Sorting

```sql
SELECT title, genre, rating
FROM platform_movies
ORDER BY
    CASE
        WHEN genre = 'Fantasy' THEN 1
        WHEN genre = 'Sci-Fi' THEN 2
        WHEN genre = 'Thriller' THEN 3
        ELSE 4
    END,
    rating DESC;
```

> **Real-Life Usage:** Kabhi kabhi aapko alphabetical order nahi chahiye — jaise homepage par "Fantasy" movies pehle dikhani hain, phir Sci-Fi. `CASE` se custom priority bana ke sort karte ho.

### 🟠 CASE with COUNT (Conditional Counting)

```sql
SELECT
    COUNT(*) AS total_movies,
    COUNT(CASE WHEN rating >= 8.0 THEN 1 END) AS highly_rated,
    COUNT(CASE WHEN rating < 7.0 THEN 1 END) AS low_rated,
    COUNT(CASE WHEN content_rating = 'R' THEN 1 END) AS mature_content
FROM platform_movies;
```

### 🟤 CASE with AVG (Conditional Aggregation)

```sql
SELECT
    content_rating,
    AVG(CASE WHEN genre = 'Sci-Fi' THEN rating END) AS avg_scifi_rating,
    AVG(CASE WHEN genre = 'Comedy' THEN rating END) AS avg_comedy_rating,
    AVG(rating) AS overall_avg
FROM platform_movies
GROUP BY content_rating;
```

### 🚀 Nested CASE (Recommendation Engine)

```sql
SELECT
    title,
    genre,
    rating,
    release_year,
    CASE
        WHEN rating >= 8.5 THEN
            CASE
                WHEN release_year >= 2024 THEN 'Trending Masterpiece'
                WHEN release_year >= 2022 THEN 'Recent Classic'
                ELSE 'Timeless Gem'
            END
        WHEN rating >= 7.0 THEN
            CASE
                WHEN genre IN ('Sci-Fi', 'Fantasy') THEN 'Solid Genre Pick'
                ELSE 'Good Watch'
            END
        ELSE 'Filler Content'
    END AS platform_tag
FROM platform_movies;
```

> **Real-Life Usage:** Netflix/Amazon ka "Trending" ya "Top Picks" section aise hi nested logic se banta hai. Andar wala `CASE` tabhi check hota hai jab bahar wali condition match hoti hai.

### 🟥 CASE in UPDATE

```sql
-- Records conditionally update karo
UPDATE platform_movies
SET content_rating =
    CASE
        WHEN rating >= 8.0 AND content_rating = 'R' THEN 'R - Premium'
        WHEN rating < 6.5 THEN content_rating || ' - Limited'
        ELSE content_rating
    END;

-- Verify update
SELECT title, rating, content_rating FROM platform_movies;
```

### 🟦 CASE in INSERT

```sql
-- Insert time par hi conditional value
INSERT INTO platform_movies (title, genre, rating, release_year, content_rating)
VALUES
    ('New Action Film', 'Action', 7.5, 2025,
     CASE
         WHEN 7.5 >= 8.0 THEN 'Premium'
         ELSE 'Standard'
     END);

SELECT * FROM platform_movies;
```

---

## 📌 Quick Recap Table

| Topic | Command | Use Case |
| :--- | :--- | :--- |
| Column add | `ALTER TABLE t ADD COLUMN ...` | Naye data fields jodna |
| Column drop | `ALTER TABLE t DROP COLUMN ...` | Unused fields hatana |
| Column rename | `ALTER TABLE t RENAME COLUMN a TO b` | Better naming |
| Type change | `ALTER TABLE t ALTER COLUMN c TYPE ...` | Data upgrade/downgrade |
| Default set | `ALTER TABLE t ALTER COLUMN c SET DEFAULT ...` | Auto-fill values |
| NOT NULL | `ALTER TABLE t ALTER COLUMN c SET NOT NULL` | Mandatory fields |
| CASE in SELECT | `CASE WHEN ... THEN ... ELSE ... END` | Derived/label columns |
| CASE in WHERE | `WHERE CASE ... END` | Condition-based filtering |
| CASE in ORDER BY | `ORDER BY CASE ... END` | Custom priority sorting |
| CASE in COUNT/AVG | `COUNT(CASE WHEN ... THEN 1 END)` | Conditional aggregation |
| CASE in UPDATE | `UPDATE ... SET col = CASE ... END` | Bulk conditional updates |
| CASE in INSERT | `INSERT ... VALUES (CASE ... END)` | Smart insertion |

---

🎯 **Pro Tip:** `CASE` me order **bahut matter karta hai** — SQL pehli matching condition ko pick karta hai. Isliye most specific condition pehle likho (jaise `rating >= 9.0`), generic baad me (`rating >= 7.0`). Aur `ALTER TABLE` karte waqt hamesha pehle production backup le lo! 😄

Happy Coding! 🚀
