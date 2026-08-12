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

-- Child table with foreign keys, - Foreign key constraints
CREATE TABLE active_subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    subscriber_id INTEGER NOT NULL,
    plan_id INTEGER NOT NULL,
    start_date DATE DEFAULT CURRENT_DATE,
    auto_renew BOOLEAN DEFAULT true,
    FOREIGN KEY (subscriber_id) REFERENCES subscribers(subscriber_id),
    FOREIGN KEY (plan_id) REFERENCES subscription_plans(plan_id)
);

-- Insert parent data first
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

-- View the data
SELECT * FROM subscribers;
SELECT * FROM subscription_plans;
SELECT * FROM active_subscriptions;