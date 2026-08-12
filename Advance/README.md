# 🐘 PostgreSQL Advance: Keys & Relationships (Hinglish Edition)

Swagat hai aapka **Advance** section me! Basics seekhne ke baad, ab time hai database ka sabse important part samajhne ka — **Primary Keys, Foreign Keys aur Relationships**.

Real duniya me data kabhi alag-alag (isolated) nahi hota. Ek user ke paas subscription hai, ek film ke paas kai actors, ek director ki kai movies. Yeh relationships ko sahi tarike se model karna hi **good database design** ka asli funda hai. Is folder me wahi seekhenge! 🚀

---

## 📌 Index / Table of Contents

1. [Primary Key](#1-primary-key)
2. [Foreign Key](#2-foreign-key)
3. [Foreign Key Actions (CASCADE / SET NULL / RESTRICT)](#3-foreign-key-actions)
4. [One-to-One Relationship](#4-one-to-one-relationship)
5. [One-to-Many Relationship](#5-one-to-many-relationship)
6. [Many-to-Many Relationship](#6-many-to-many-relationship)
7. [Complete Real-World Example](#7-complete-real-world-example)
8. [Quick Cheat Sheet](#8-quick-cheat-sheet)

---

## 1. 🔑 Primary Key

Har table ko ek **unique identifier** chahiye hota hai — taaki har row ko pehchana ja sake. Isi ko kehte hain **Primary Key**.

### Key Points:
- **Unique** — do rows me same value nahi ho sakti.
- **NOT NULL** — empty nahi ho sakta.
- Har table me **sirf ek** primary key ho sakti hai (par usme multiple columns ho sakte hain).

### 1️⃣ Single Column Primary Key (SABSE common)

```sql
CREATE TABLE streaming_platforms (
    platform_id SERIAL PRIMARY KEY,  -- Auto-incrementing primary key
    platform_name VARCHAR(50) NOT NULL,
    founded_year INTEGER
);

INSERT INTO streaming_platforms (platform_name, founded_year) VALUES
('StreamFlix', 2010),
('WatchNow', 2015),
('VideoHub', 2018);

SELECT * FROM streaming_platforms;
```

> 💡 **`SERIAL`** khud-ek-ek karke (1, 2, 3...) ID generate karta hai — aapko khud number dena nahi padta.

### 2️⃣ Composite Primary Key (Multiple columns milke)

Jab **do columns milkar** ek unique combination banate hain, use kehte hain composite key.

```sql
CREATE TABLE subscription_history (
    user_id INTEGER,
    plan_change_date DATE,
    new_plan VARCHAR(30),
    PRIMARY KEY (user_id, plan_change_date)  -- Both columns together are unique
);

INSERT INTO subscription_history VALUES
(1, '2024-01-15', 'Basic'),
(1, '2024-06-20', 'Premium'),  -- Same user, different date (allowed)
(2, '2024-01-15', 'Standard'); -- Different user, same date (allowed)
-- (1, '2024-01-15', 'Pro') would fail - duplicate composite key
```

> 🤔 **Samajh lo:** Ek user same date par do baar plan change nahi kar sakta (duplicate fail), par alag-alag dates par kai baar kar sakta hai. Yeh **user_id + plan_change_date** ka combination hi unique hai.

### 3️⃣ Existing table me primary key add karna

```sql
CREATE TABLE content_ratings (
    rating_code VARCHAR(10),
    description TEXT
);

-- Add primary key constraint after table creation
ALTER TABLE content_ratings
ADD PRIMARY KEY (rating_code);
```

> 📂 **File:** `primarykey.sql`

---

## 2. 🔗 Foreign Key

Foreign Key woh column hai jo **doosre table ki primary key** ko reference karta hai. Yeh do tables ko aapas me **link** karta hai.

### Example: Streaming Subscription Model

```sql
-- Parent table (must be created first)
CREATE TABLE subscribers (
    subscriber_id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    username VARCHAR(50) NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE
);

-- Another parent table
CREATE TABLE subscription_plans (
    plan_id SERIAL PRIMARY KEY,
    plan_name VARCHAR(30) NOT NULL,
    monthly_price DECIMAL(5, 2) NOT NULL,
    max_screens INTEGER DEFAULT 1
);

-- Child table with foreign keys
CREATE TABLE active_subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    subscriber_id INTEGER NOT NULL,
    plan_id INTEGER NOT NULL,
    start_date DATE DEFAULT CURRENT_DATE,
    auto_renew BOOLEAN DEFAULT true,
    FOREIGN KEY (subscriber_id) REFERENCES subscribers(subscriber_id),
    FOREIGN KEY (plan_id) REFERENCES subscription_plans(plan_id)
);
```

### Data insert karte waqt order IMPORTANT hai:
1. Pehle **parent** data insert karo (subscribers, plans).
2. Phir **child** data (active_subscriptions) — kyunki child ko parent ke IDs reference karne padte hain.

```sql
INSERT INTO subscribers (email, username) VALUES
('alice@example.com', 'alice_movies'),
('bob@example.com', 'bob_streams');

INSERT INTO subscription_plans (plan_name, monthly_price, max_screens) VALUES
('Basic', 9.99, 1),
('Standard', 14.99, 2),
('Premium', 19.99, 4);

-- Now insert child data (referencing parent IDs)
INSERT INTO active_subscriptions (subscriber_id, plan_id) VALUES
(1, 3),  -- Alice has Premium plan
(2, 2);  -- Bob has Standard plan

-- This would fail - subscriber_id 999 doesn't exist
-- INSERT INTO active_subscriptions (subscriber_id, plan_id) VALUES (999, 1);
```

> ⚠️ **Referential Integrity:** Agar aapne aisi ID reference ki jo parent me exist hi nahi karti (jaise 999), toh query **fail** ho jayegi. Yahi Foreign Key ka kaam hai — galt data ko andar aane se rokna!

> 📂 **File:** `foreignkey.sql`

---

## 3. 🎯 Foreign Key Actions

Jab parent row delete hoti hai, toh child rows ka kya hoga? Yeh decide karta hai **ON DELETE** action. Teeno sabse common actions:

### 1️⃣ `ON DELETE CASCADE` — Parent delete → Child bhi delete

Agar subscriber delete hua, toh uske saare devices bhi **automatic delete** ho jayenge.

```sql
CREATE TABLE streaming_devices (
    device_id SERIAL PRIMARY KEY,
    subscriber_id INTEGER NOT NULL,
    device_name VARCHAR(50),
    device_type VARCHAR(30),
    registered_date DATE DEFAULT CURRENT_DATE,

    FOREIGN KEY (subscriber_id) REFERENCES subscribers(subscriber_id)
        ON DELETE CASCADE  -- If subscriber deleted, delete their devices too
        ON UPDATE CASCADE  -- If subscriber_id changes, update device records too
);

INSERT INTO streaming_devices (subscriber_id, device_name, device_type) VALUES
(1, 'Living Room TV', 'Smart TV'),
(1, 'iPhone 12', 'Mobile'),
(2, 'Laptop', 'Computer');

-- Agar hum yeh chalayen:
-- DELETE FROM subscribers WHERE subscriber_id = 1;
-- Toh subscriber 1 ke 2 devices (TV + iPhone) bhi khud delete ho jayenge!
```

> 💡 CASCADE ko "**jab parent jaye, bachche bhi saath jayenge**" aise yaad rakho.

### 2️⃣ `ON DELETE SET NULL` — Parent delete → Child data rahe, par reference NULL

Watchlist entries save rehti hain, sirf `subscriber_id` NULL ho jata hai.

```sql
CREATE TABLE watchlist (
    watchlist_id SERIAL PRIMARY KEY,
    subscriber_id INTEGER,
    movie_title VARCHAR(200),
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    priority INTEGER DEFAULT 5,

    FOREIGN KEY (subscriber_id) REFERENCES subscribers(subscriber_id)
        ON DELETE SET NULL  -- If subscriber deleted, keep watchlist but set subscriber_id to NULL
);
```

> 💡 Note: SET NULL ke liye column ko **NULL allowed** hona chahiye (i.e. `NOT NULL` nahi likha hona chahiye).

### 3️⃣ `ON DELETE RESTRICT` — Parent delete → BLOCK kar do agar child exist karta hai

Payment methods wale subscriber ko delete nahi kar sakte jab tak uska payment method exist karta hai.

```sql
CREATE TABLE payment_methods (
    payment_id SERIAL PRIMARY KEY,
    subscriber_id INTEGER NOT NULL,
    card_type VARCHAR(20),
    card_last_four CHAR(4),
    expiry_date DATE,

    FOREIGN KEY (subscriber_id) REFERENCES subscribers(subscriber_id)
        ON DELETE RESTRICT  -- Cannot delete subscriber if they have payment methods
);

-- This would fail - cannot delete subscriber because payment method exists
-- DELETE FROM subscribers WHERE subscriber_id = 1;
-- Pehle payment_method delete karna padega, phir subscriber.
```

### 🆚 Action ka quick comparison

| Action | Parent delete par child ka kya hoga | Kab use karein |
| :--- | :--- | :--- |
| **CASCADE** | Child bhi delete ho jata hai | Data ka koi matlab nahi agar parent nahi (jaise devices) |
| **SET NULL** | Child rehta hai, reference NULL | Data ka apna existence hai (jaise watchlist history) |
| **RESTRICT** | Delete rok diya jata hai | Child important hai aur delete karna risky hai (jaise payment methods) |
| **NO ACTION** (default) | RESTRICT jaisa | Default behavior |

> 📂 **File:** `foreignkeyActions.sql`

---

## 4. 🤝 One-to-One Relationship (1:1)

Ek user ka **sirf ek** profile, aur ek profile **sirf ek** user ka. Iska raaz: Foreign Key column par **`UNIQUE`** constraint lagana.

```sql
CREATE TABLE stream_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE user_preferences (
    preference_id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE NOT NULL,  -- UNIQUE makes it one-to-one
    theme VARCHAR(20) DEFAULT 'dark',
    autoplay BOOLEAN DEFAULT true,
    subtitle_language VARCHAR(20) DEFAULT 'English',
    FOREIGN KEY (user_id) REFERENCES stream_users(user_id) ON DELETE CASCADE
);

-- Insert data
INSERT INTO stream_users (username, email) VALUES
('cinephile_jane', 'jane@email.com'),
('binge_watcher_bob', 'bob@email.com');

INSERT INTO user_preferences (user_id, theme, autoplay) VALUES
(1, 'dark', true),
(2, 'light', false);
```

> 🤔 **Funda:** Normal foreign key me ek user ke **kai** preferences ho sakte (1:N). Par `UNIQUE` lagane se **ek user = ek preference** fix ho jata hai (1:1).

> 📂 **File:** `1to1.sql`

---

## 5. 👨‍🎬 One-to-Many Relationship (1:N)

Ek director ki **kai movies**, par har movie ka **sirf ek** director. Isme foreign key par **NO `UNIQUE`** constraint hota hai.

```sql
CREATE TABLE directors (
    director_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INTEGER,
    nationality VARCHAR(50)
);

CREATE TABLE director_movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    director_id INTEGER NOT NULL,  -- No UNIQUE here, allows multiple movies per director
    release_year INTEGER,
    budget DECIMAL(12, 2),
    FOREIGN KEY (director_id) REFERENCES directors(director_id) ON DELETE RESTRICT
);

-- Insert directors
INSERT INTO directors (name, birth_year, nationality) VALUES
('Christopher Nolan', 1970, 'British-American'),
('Greta Gerwig', 1983, 'American'),
('Denis Villeneuve', 1967, 'Canadian');

-- Insert movies (multiple movies per director)
INSERT INTO director_movies (title, director_id, release_year, budget) VALUES
('Inception', 1, 2010, 160000000),
('Interstellar', 1, 2014, 165000000),
('Dunkirk', 1, 2017, 100000000),
('Lady Bird', 2, 2017, 10000000),
('Little Women', 2, 2019, 40000000),
('Arrival', 3, 2016, 47000000),
('Blade Runner 2049', 3, 2017, 150000000);
```

### Per director movie count nikalna (GROUP BY)

```sql
SELECT
    director_id,
    COUNT(*) AS movie_count
FROM director_movies
GROUP BY director_id;
```

| director_id | movie_count |
| :--- | :--- |
| 1 (Nolan) | 3 |
| 2 (Gerwig) | 2 |
| 3 (Villeneuve) | 2 |

> 🤔 **Funda:** `director_id` me 1 (Nolan) teen baar aaya — yahi hai "one" director ke paas "many" movies. Bina UNIQUE ke foreign key = One-to-Many.

> 📂 **File:** `1tomany.sql`

---

## 6. 🌐 Many-to-Many Relationship (N:N)

Ek actor **kai films** me kaam karta hai, aur ek film me **kai actors**. Isko directly 2 tables me nahi bana sakte — ek **junction (bridge) table** chahiye hota hai.

### Structure: 2 main tables + 1 junction table

```sql
-- First main table
CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INTEGER,
    country VARCHAR(50)
);

-- Second main table
CREATE TABLE films (
    film_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INTEGER,
    genre VARCHAR(50)
);

-- Junction table (bridges the many-to-many relationship)
CREATE TABLE film_cast (
    cast_id SERIAL PRIMARY KEY,
    film_id INTEGER NOT NULL,
    actor_id INTEGER NOT NULL,
    character_name VARCHAR(100),
    role_type VARCHAR(20) DEFAULT 'supporting',
    FOREIGN KEY (film_id) REFERENCES films(film_id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id) ON DELETE CASCADE,
    UNIQUE(film_id, actor_id)  -- Prevents same actor being cast twice in same film
);
```

### Insert data

```sql
INSERT INTO actors (name, birth_year, country) VALUES
('Leonardo DiCaprio', 1974, 'USA'),
('Marion Cotillard', 1975, 'France'),
('Tom Hardy', 1977, 'UK'),
('Anne Hathaway', 1982, 'USA'),
('Matthew McConaughey', 1969, 'USA');

INSERT INTO films (title, release_year, genre) VALUES
('Inception', 2010, 'Sci-Fi'),
('The Dark Knight Rises', 2012, 'Action'),
('Interstellar', 2014, 'Sci-Fi'),
('Dunkirk', 2017, 'War');

-- Create the many-to-many relationships through the junction table
INSERT INTO film_cast (film_id, actor_id, character_name, role_type) VALUES
-- Inception has 3 actors
(1, 1, 'Dom Cobb', 'lead'),
(1, 2, 'Mal Cobb', 'supporting'),
(1, 3, 'Eames', 'supporting'),
-- The Dark Knight Rises has 2 actors
(2, 3, 'Bane', 'lead'),
(2, 4, 'Catwoman', 'lead'),
-- Interstellar has 2 actors
(3, 4, 'Brand', 'supporting'),
(3, 5, 'Cooper', 'lead'),
-- Dunkirk has 1 actor
(4, 3, 'Farrier', 'supporting');
```

### Useful queries: kitni films har actor ki / kitne actors har film me

```sql
-- How many films each actor has
SELECT
    actor_id,
    COUNT(*) AS film_count
FROM film_cast
GROUP BY actor_id
ORDER BY film_count DESC;

-- How many actors each film has
SELECT
    film_id,
    COUNT(*) AS actor_count
FROM film_cast
GROUP BY film_id
ORDER BY actor_count DESC;
```

> 🤔 **Funda:** `film_cast` table me `UNIQUE(film_id, actor_id)` hai — matlab same actor same film me **2 baar** cast nahi ho sakta. Junction table ka **ek row = ek relationship** hota hai.

> 📂 **File:** `manytomany.sql`

---

## 7. 🏗️ Complete Real-World Example

Ab saare concepts ko ek sath ek **streaming platform** me model karte hain — jisme 1:1, 1:N, aur N:N teeno relationships hain.

### Tables ka map:
- `platform_users` → main table
- `user_profiles` → **1:1** (ek user = ek profile)
- `watch_history` → **1:N** (ek user ki kai watch records)
- `genres` + `user_genre_preferences` → **N:N** (user kai genres, genre kai users)

```sql
-- Users (main table)
CREATE TABLE platform_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- One-to-One: User Profile (each user has ONE profile)
CREATE TABLE user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE NOT NULL,  -- UNIQUE makes it one-to-one
    full_name VARCHAR(100),
    date_of_birth DATE,
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES platform_users(user_id) ON DELETE CASCADE
);

-- One-to-Many: User Watch History (each user has MANY watch records)
CREATE TABLE watch_history (
    history_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,  -- No UNIQUE, allows multiple records per user
    content_title VARCHAR(200),
    watched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completion_percentage INTEGER,
    FOREIGN KEY (user_id) REFERENCES platform_users(user_id) ON DELETE CASCADE
);

-- Many-to-Many Setup: Users and Genres
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);

-- Junction table for many-to-many
CREATE TABLE user_genre_preferences (
    preference_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    preference_level INTEGER CHECK (preference_level BETWEEN 1 AND 10),
    FOREIGN KEY (user_id) REFERENCES platform_users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE,
    UNIQUE(user_id, genre_id)  -- Each user can rate each genre only once
);
```

### Sample data insert

```sql
INSERT INTO platform_users (username, email) VALUES
('movie_buff', 'buff@example.com'),
('series_fan', 'fan@example.com');

INSERT INTO user_profiles (user_id, full_name, date_of_birth) VALUES
(1, 'Alex Johnson', '1990-05-15'),
(2, 'Sam Williams', '1985-08-22');

INSERT INTO watch_history (user_id, content_title, completion_percentage) VALUES
(1, 'Stellar Voyage', 100),
(1, 'Epic Quest', 67),
(1, 'Dark Alley', 45),
(2, 'True Crime Story', 100),
(2, 'Laugh Factory', 80);

INSERT INTO genres (genre_name) VALUES
('Sci-Fi'), ('Fantasy'), ('Thriller'), ('Documentary'), ('Comedy');

INSERT INTO user_genre_preferences (user_id, genre_id, preference_level) VALUES
(1, 1, 9),  -- movie_buff loves Sci-Fi (9/10)
(1, 2, 8),  -- movie_buff likes Fantasy (8/10)
(1, 3, 6),  -- movie_buff neutral on Thriller (6/10)
(2, 3, 9),  -- series_fan loves Thriller (9/10)
(2, 4, 7),  -- series_fan likes Documentary (7/10)
(2, 5, 8);  -- series_fan likes Comedy (8/10)
```

### Analysis queries (GROUP BY + AVG)

```sql
-- Count watch history per user
SELECT
    user_id,
    COUNT(*) AS total_watched,
    AVG(completion_percentage) AS avg_completion
FROM watch_history
GROUP BY user_id;

-- Count genre preferences per user
SELECT
    user_id,
    COUNT(*) AS genres_rated,
    AVG(preference_level) AS avg_preference
FROM user_genre_preferences
GROUP BY user_id;
```

> 💡 **Bonus:** `CHECK (preference_level BETWEEN 1 AND 10)` — yeh constraint ensure karta hai ki rating sirf 1 se 10 ke beech me ho. Data-level validation ka best practice!

> 📂 **File:** `completeExample.sql`

---

## 8. ⚡ Quick Cheat Sheet

```sql
-- 1. PRIMARY KEY (single column, auto-increment)
CREATE TABLE t1 (id SERIAL PRIMARY KEY, name VARCHAR(50));

-- 2. COMPOSITE PRIMARY KEY
CREATE TABLE t2 (a INT, b INT, PRIMARY KEY (a, b));

-- 3. Add PRIMARY KEY later
ALTER TABLE t1 ADD PRIMARY KEY (id);

-- 4. FOREIGN KEY (simple)
CREATE TABLE child (
    id SERIAL PRIMARY KEY,
    parent_id INT REFERENCES t1(id)
);

-- 5. FOREIGN KEY with actions
CREATE TABLE child2 (
    id SERIAL PRIMARY KEY,
    parent_id INT REFERENCES t1(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 6. One-to-One: UNIQUE on foreign key
CREATE TABLE profile (
    profile_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE REFERENCES t1(id) ON DELETE CASCADE
);

-- 7. One-to-Many: NO UNIQUE on foreign key
CREATE TABLE posts (
    post_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES t1(id) ON DELETE CASCADE
);

-- 8. Many-to-Many: junction table with 2 FKs + UNIQUE pair
CREATE TABLE tag (
    tag_id SERIAL PRIMARY KEY,
    name VARCHAR(30)
);
CREATE TABLE post_tag (
    post_id INT REFERENCES posts(post_id) ON DELETE CASCADE,
    tag_id INT REFERENCES tag(tag_id) ON DELETE CASCADE,
    PRIMARY KEY (post_id, tag_id)
);
```

---

## 🎯 Final Summary (Ek Nazar Me)

| Concept | File | Ek Line Me Funda |
| :--- | :--- | :--- |
| Primary Key | `primarykey.sql` | Har row ki unique pehchaan |
| Foreign Key | `foreignkey.sql` | Doosri table ki PK ko reference karta hai |
| FK Actions | `foreignkeyActions.sql` | Parent delete par child ka fate tay karta hai |
| One-to-One | `1to1.sql` | FK par `UNIQUE` = 1:1 |
| One-to-Many | `1tomany.sql` | FK bina UNIQUE = 1:N |
| Many-to-Many | `manytomany.sql` | Junction table = N:N |
| Complete Example | `completeExample.sql` | Saare relationships ek sath |

**Practice tip:** Har `.sql` file ko apne pgAdmin / psql me chalao, phir `ON DELETE` actions ko khud test karo (`DELETE FROM subscribers WHERE subscriber_id = 1;` wali commented lines uncomment karke dekho kya hota hai). Kuch bhi galti se delete ho jaye toh darr nahi — practice database me khul ke try karo!

Happy Coding! 🚀
