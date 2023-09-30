-- Drop the database if it exists
DROP DATABASE IF EXISTS twitter_db;

-- Create a new database
CREATE DATABASE twitter_db;

-- Use the created database
USE twitter_db;

-- Drop the users table if it exists
DROP TABLE IF EXISTS users;

-- Create the users table
CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT,
    user_handle VARCHAR(50) NOT NULL UNIQUE,
    email_address VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phonenumber CHAR(10) UNIQUE,
    follower_count INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (user_id)
);

-- Insert generic user data
INSERT INTO users (user_handle, email_address, first_name, last_name, phonenumber)
VALUES
    ('user_1', 'user1@example.com', 'User', 'One', '1234567890'),
    ('user_2', 'user2@example.com', 'User', 'Two', '2345678901'),
    ('user_3', 'user3@example.com', 'User', 'Three', '3456789012'),
    ('user_4', 'user4@example.com', 'User', 'Four', '4567890123'),
    ('user_5', 'user5@example.com', 'User', 'Five', '5678901234'),
    ('user_6', 'user6@example.com', 'User', 'Six', '6789012345');

-- Drop the followers table if it exists
DROP TABLE IF EXISTS followers;

-- Create the followers table
CREATE TABLE followers (
    follower_id INT NOT NULL,
    following_id INT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(user_id),
    FOREIGN KEY (following_id) REFERENCES users(user_id),
    PRIMARY KEY (follower_id, following_id)
);

-- Insert generic follower data
INSERT IGNORE INTO followers (follower_id, following_id)
VALUES
    (1, 2),
    (2, 1),
    (3, 6),
    (4, 3),
    (5, 2),
    (6, 5);

-- Add a constraint to prevent a user from following themselves
ALTER TABLE followers
ADD CONSTRAINT check_follower_id
CHECK (follower_id <> following_id);
