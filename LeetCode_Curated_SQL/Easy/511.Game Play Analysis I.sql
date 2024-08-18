-- 511.Game Play Analysis I

-- Table: Activity

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | player_id    | int     |
-- | device_id    | int     |
-- | event_date   | date    |
-- | games_played | int     |
-- +--------------+---------+
-- (player_id, event_date) is the primary key of this table.
-- This table shows the activity of players of some game.
-- Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
-- 該表記錄了遊戲用戶的行為信息，主鍵為(player_id, event_date)的組合。每一行記錄每個遊戲用戶登錄情況以及玩的遊戲數(玩的遊戲可能是0)。

-- Write an SQL query that reports the first login date for each player.
-- 查詢每個用戶首次登陸的日期
-- 編寫一個SQL查詢，每個玩家的首次登錄日期。

-- The query result format is in the following example:

-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-05-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+

-- Result table:
-- +-----------+-------------+
-- | player_id | first_login |
-- +-----------+-------------+
-- | 1         | 2016-03-01  |
-- | 2         | 2017-06-25  |
-- | 3         | 2016-03-02  |
-- +-----------+-------------+


-- Solution
-- 解題說明:以PLAYER_ID做為資料分群GROUP，並運用MIN函數查尋每位玩家最初登入的日期

SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN
FROM ACTIVITY
GROUP BY PLAYER_ID;