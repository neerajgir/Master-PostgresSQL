-- ON DELETE CASCADE: Delete child records when parent is deleted
CREATE TABLE streaming_devices (
    device_id SERIAL PRIMARY KEY,
    subscriber_id INTEGER NOT NULL,
    device_name VARCHAR(50),
    device_type VARCHAR(30),
    registered_date DATE DEFAULT CURRENT_DATE,
    
    FOREIGN KEY (subscriber_id) REFERENCES subscribers(subscriber_id) 
        ON DELETE CASCADE  -- If subscriber deleted, delete their devices too
        ON UPDATE CASCADE  -- If subscriber_id changes, update device records
);

INSERT INTO streaming_devices (subscriber_id, device_name, device_type) VALUES
(1, 'Living Room TV', 'Smart TV'),
(1, 'iPhone 12', 'Mobile'),
(2, 'Laptop', 'Computer');

-- If we delete subscriber 1, their 2 devices are automatically deleted
-- DELETE FROM subscribers WHERE subscriber_id = 1;

-- ON DELETE SET NULL: Keep child records but remove parent reference
CREATE TABLE watchlist (
    watchlist_id SERIAL PRIMARY KEY,
    subscriber_id INTEGER,
    movie_title VARCHAR(200),
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    priority INTEGER DEFAULT 5,
    
    FOREIGN KEY (subscriber_id) REFERENCES subscribers(subscriber_id) 
        ON DELETE SET NULL  -- If subscriber deleted, keep watchlist but set subscriber_id to NULL
);

INSERT INTO watchlist (subscriber_id, movie_title, priority) VALUES
(1, 'Inception', 10),
(2, 'Interstellar', 8);

-- If we delete subscriber 1, their watchlist entry remains but subscriber_id becomes NULL

-- ON DELETE RESTRICT: Prevent deletion if child records exist
CREATE TABLE payment_methods (
    payment_id SERIAL PRIMARY KEY,
    subscriber_id INTEGER NOT NULL,
    card_type VARCHAR(20),
    card_last_four CHAR(4),
    expiry_date DATE,
    
    FOREIGN KEY (subscriber_id) REFERENCES subscribers(subscriber_id) 
        ON DELETE RESTRICT  -- Cannot delete subscriber if they have payment methods
);

INSERT INTO payment_methods (subscriber_id, card_type, card_last_four, expiry_date) VALUES
(1, 'Visa', '1234', '2026-12-31'),
(2, 'Mastercard', '5678', '2027-06-30');

-- This would fail - cannot delete subscriber because payment method exists
-- DELETE FROM subscribers WHERE subscriber_id = 1;
-- Must delete payment method first, then subscriber

-- ON DELETE NO ACTION (default): Similar to RESTRICT
-- ON DELETE SET DEFAULT: Set to default value when parent is deleted

SELECT * FROM streaming_devices;
SELECT * FROM watchlist;
SELECT * FROM payment_methods;