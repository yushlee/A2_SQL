-- 1407.Top Travellers

-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key for this table.
-- name is the name of the user. 


-- Table: Rides
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | user_id       | int     |
-- | distance      | int     |
-- +---------------+---------+
-- id is the primary key for this table.
-- user_id is the id of the user who travelled the distance "distance".
-- user_id 用戶編號，distance 是該用戶行駛的距離


-- Write an SQL query to report the distance travelled by each user.

-- Return the result table ordered by travelled_distance in descending order, 
-- if two or more users travelled the same distance, order them by their name in ascending order.

-- 查詢以報告每個用戶的行進距離，查詢結果按 travelled_distance 降序排列，如果兩個或多個用戶旅行相同的距離，請按其名稱(name) 升序排列。

-- The query result format is in the following example. 

-- Users table:
-- +------+-----------+
-- | id   | name      |
-- +------+-----------+
-- | 1    | Alice     |
-- | 2    | Bob       |
-- | 3    | Alex      |
-- | 4    | Donald    |
-- | 7    | Lee       |
-- | 13   | Jonathan  |
-- | 19   | Elvis     |
-- +------+-----------+
  
  
-- Rides table:
-- +------+----------+----------+
-- | id   | user_id  | distance |
-- +------+----------+----------+
-- | 1    | 1        | 120      |
-- | 2    | 2        | 317      |
-- | 3    | 3        | 222      |
-- | 4    | 7        | 100      |
-- | 5    | 13       | 312      |
-- | 6    | 19       | 50       |
-- | 7    | 7        | 120      |
-- | 8    | 19       | 400      |
-- | 9    | 7        | 230      |
-- +------+----------+----------+


-- Result table:
-- +----------+--------------------+
-- | name     | travelled_distance |
-- +----------+--------------------+
-- | Elvis    | 450                |
-- | Lee      | 450                |
-- | Bob      | 317                |
-- | Jonathan | 312                |
-- | Alex     | 222                |
-- | Alice    | 120                |
-- | Donald   | 0                  |
-- +----------+--------------------+

-- Elvis and Lee travelled 450 miles, Elvis is the top traveller as his name is alphabetically smaller than Lee.
-- Bob, Jonathan, Alex and Alice have only one ride and we just order them by the total distances of the ride.
-- Donald didn't have any rides, the distance travelled by him is 0.
-- Elvis和Lee走了450英里，Elvis是排名最高的旅行者，因為他的名字順序靠前。
-- Bob，Jonathan，Alex和Alice都只有一次旅行，我們只是按照總距離對他們進行排序。
-- Donald沒有旅行，他的行進距離是0。


-- Solution
-- Oracle
SELECT U.NAME,
	NVL(SUM(R.DISTANCE), 0) AS TRAVELLED_DISTANCE 
FROM USERS U LEFT JOIN RIDES R
ON R.USER_ID = U.ID
GROUP BY NAME
ORDER BY TRAVELLED_DISTANCE DESC, NAME;

-- MySQL
SELECT U.NAME,
	IFNULL(SUM(R.DISTANCE), 0) AS TRAVELLED_DISTANCE 
FROM USERS U LEFT JOIN RIDES R
ON R.USER_ID = U.ID
GROUP BY NAME
ORDER BY TRAVELLED_DISTANCE DESC, NAME;
