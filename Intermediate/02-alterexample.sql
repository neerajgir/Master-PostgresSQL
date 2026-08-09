CREATE TABLE streaming_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) 
);

-- Expand the structure
ALTER TABLE streaming_users 
ADD COLUMN email VARCHAR(100) UNIQUE NOT NULL,
ADD COLUMN signuo_date DATE DEFAULT CURRENT_DATE,
ADD COLUMN subscription_type VARCHAR(50) DEFAULT 'free';

ALTER TABLE streaming_users
ALTER COLUMN email SET NOT NULL;
ALTER TABLE streaming_users
ADD COLUMN payment_method VARCHAR(50),
ADD COLUMN last_payment_date DATE;
ALTER TABLE streaming_users
RENAME COLUMN subscription_type TO plan_type;

ALTER TABLE streaming_users 
DROP COLUMN payment_method;

ALTER TABLE streaming_users
ALTER COLUMN username TYPE VARCHAR(30);

SELECT * FROM streaming_users;