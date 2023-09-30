-- Drop the tweets table if it exists
DROP TABLE IF EXISTS tweets;

-- Create the tweets table
CREATE TABLE tweets (
    tweet_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    tweet_text VARCHAR(280) NOT NULL,
    num_likes INT DEFAULT 0,
    num_retweets INT DEFAULT 0,
    num_comments INT DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    PRIMARY KEY (tweet_id)
);

-- Insert generic tweet data
INSERT INTO tweets (user_id, tweet_text)
VALUES
    (1, 'This is a tweet from user 1.'),
    (2, 'This is a tweet from user 2.'),
    (3, 'This is a tweet from user 3.'),
    (1, 'Another tweet from user 1.'),
    (2, 'Another tweet from user 2.'),
    (3, 'Another tweet from user 3.');

-- Get the tweet count for each user
SELECT user_id, COUNT(*) AS tweet_count
FROM tweets
GROUP BY user_id;

-- Get tweets from users with more than 2 followers
SELECT tweet_id, tweet_text, user_id
FROM tweets
WHERE user_id IN (
    SELECT following_id
    FROM followers
    GROUP BY following_id
    HAVING COUNT(*) > 2
);

-- Update the comment count for a tweet
UPDATE tweets SET num_comments = num_comments + 1 WHERE tweet_id = 2;

-- Drop the tweet_likes table if it exists
DROP TABLE IF EXISTS tweet_likes;

-- Create the tweet_likes table
CREATE TABLE tweet_likes (
    user_id INT NOT NULL,
    tweet_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (tweet_id) REFERENCES tweets(tweet_id),
    PRIMARY KEY (user_id, tweet_id)
);

-- Insert generic like data
INSERT INTO tweet_likes (user_id, tweet_id)
VALUES (1, 3), (2, 3), (3, 1), (2, 1);

-- Get the number of likes for each tweet
SELECT tweet_id, COUNT(*) AS like_count
FROM tweet_likes
GROUP BY tweet_id;
