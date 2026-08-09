CREATE TABLE streaming_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) 
);

-- Expand the structure
ALTER TABLE streaming_users 
ADD COLUMN email VARCHAR(100) UNIQUE NOT NULL,
ADD COLUMN signuo_date DATE DEFAULT CURRENT_DATE,
ADD COLUMN subscription_type VARCHAR(50) DEFAULT 'free';

SELECT * FROM streaming_users;