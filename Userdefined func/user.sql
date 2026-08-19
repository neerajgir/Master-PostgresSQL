-- Active: 1785411209906@@127.0.0.1@5432@userdefined
CREATE TABLE tech_youtubers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    channel VARCHAR(100),
    tech VARCHAR(50),
    subscribers_millions NUMERIC(4,2),
    active BOOLEAN DEFAULT true
);

INSERT INTO tech_youtubers (name, channel, tech, subscribers_millions)
VALUES
('Hitesh Choudhary', 'Chai aur Code', 'JavaScript', 1.60),
('Anuj Bhaiya', 'Coding Shuttle', 'DSA', 0.85),
('Akshay Saini', 'Namaste JavaScript', 'JavaScript', 1.20),
('CodeWithHarry', 'CodeWithHarry', 'Full Stack', 5.80),
('Kunal Kushwaha', 'Kunal Kushwaha', 'DSA', 1.00);

SELECT * FROM tech_youtubers;

--  User Defined Functions (UDF)

CREATE FUNCTION total_youtubers()
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
    --Logic 
    RETURN (SELECT COUNT(*) FROM tech_youtubers);
END;
$$;

SELECT  total_youtubers();

-- Get YouTubers by Tech

CREATE OR REPLACE FUNCTION get_youtubers_by_tech(p_tech VARCHAR) 
RETURNS TABLE(name VARCHAR, channel VARCHAR) 
LANGUAGE plpgsql AS $$ 
BEGIN 
    RETURN QUERY 
    SELECT t.name, t.channel -- 't.' resolves the ambiguity
    FROM tech_youtubers t    -- 't' is the table alias
    WHERE t.tech = p_tech; 
END; 
$$;

SELECT * FROM get_youtubers_by_tech('JavaScript');

-- Check if Channel is Big or Small

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

SELECT name, channel_category(subscribers_millions)
FROM tech_youtubers;

-- Stored Procedures

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

CALL add_youtuber('Tanay Pratap', 'Tanay Pratap', 'Web Development', 0.50);


-- Deactivate a Channel
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

-- Transaction Handling
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