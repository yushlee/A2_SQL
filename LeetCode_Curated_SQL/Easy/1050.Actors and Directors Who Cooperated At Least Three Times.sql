-- 1050.Actors and Directors Who Cooperated At Least Three 
-- 合作過至少3次的演員和導演

-- Table: ActorDirector
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | actor_id    | int     |
-- | director_id | int     |
-- | timestamp   | int     |
-- +-------------+---------+
-- timestamp is the primary key column for this table.
 

-- Write a SQL query for a report that provides the pairs (actor_id, director_id)
-- where the actor have cooperated with the director at least 3 times.
-- 查詢合作至少3次的演員和導演

-- Example:

-- ActorDirector table:
-- +-------------+-------------+-------------+
-- | actor_id    | director_id | timestamp   |
-- +-------------+-------------+-------------+
-- | 1           | 1           | 0           |
-- | 1           | 1           | 1           |
-- | 1           | 1           | 2           |
-- | 1           | 2           | 3           |
-- | 1           | 2           | 4           |
-- | 2           | 1           | 5           |
-- | 2           | 1           | 6           |
-- +-------------+-------------+-------------+

-- Result table:
-- +-------------+-------------+
-- | actor_id    | director_id |
-- +-------------+-------------+
-- | 1           | 1           |
-- +-------------+-------------+
-- The only pair is (1, 1) where they cooperated exactly 3 times.
-- 唯一的一對是(1, 1)，他們恰好合作3次。


-- Solution
-- 將演員編號和導演編號做資料分群，再透過HAVING COUNT找出次數大於3次以上的組合
SELECT ACTOR_ID, DIRECTOR_ID, COUNT(ACTOR_ID)
FROM ACTORDIRECTOR
GROUP BY ACTOR_ID, DIRECTOR_ID
HAVING COUNT(ACTOR_ID) >= 3;
