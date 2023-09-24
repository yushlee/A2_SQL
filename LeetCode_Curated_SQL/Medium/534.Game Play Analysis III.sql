-- 534.Game Play Analysis III

--  Table: Activity
--  +--------------+---------+
--  | Column Name  | Type    |
--  +--------------+---------+
--  | player_id    | int     |
--  | device_id    | int     |
--  | event_date   | date    |
--  | games_played | int     |
--  +--------------+---------+
--  (player_id, event_date) is the primary key of this table.
--  This table shows the activity of players of some game.
--  Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
-- 該表記錄了遊戲用戶的行為信息，主鍵為(player_id, event_date)的組合。每一行記錄每個遊戲用戶登錄情況以及玩的遊戲數(玩的遊戲可能是0)。

-- Write an SQL query that reports for each player and date, how many games played so far by the player.
-- That is, the total number of games played by the player until that date. Check the example for clarity.
-- 按照日期，查詢每個用戶"累積"玩的遊戲數

--  The query result format is in the following example:
--  Activity table:
--  +-----------+-----------+------------+--------------+
--  | player_id | device_id | event_date | games_played |
--  +-----------+-----------+------------+--------------+
--  | 1         | 2         | 2016-03-01 | 5            |
--  | 1         | 2         | 2016-05-02 | 6            |
--  | 1         | 3         | 2017-06-25 | 1            |
--  | 3         | 1         | 2016-03-02 | 0            |
--  | 3         | 4         | 2018-07-03 | 5            |
--  +-----------+-----------+------------+--------------+

--  Result table:
--  +-----------+------------+---------------------+
--  | player_id | event_date | games_played_so_far |
--  +-----------+------------+---------------------+
--  | 1         | 2016-03-01 | 5                   |
--  | 1         | 2016-05-02 | 11                  |
--  | 1         | 2017-06-25 | 12                  |
--  | 3         | 2016-03-02 | 0                   |
--  | 3         | 2018-07-03 | 5                   |
--  +-----------+------------+---------------------+
--  For the player with id 1, 5 + 6 = 11 games played by 2016-05-02, and 5 + 6 + 1 = 12 games played by 2017-06-25.
--  For the player with id 3, 0 + 5 = 5 games played by 2018-07-03.
--  Note that for each player we only care about the days when the player logged in.


-- Solution 1
-- self join 自我表格連結 
SELECT A.PLAYER_ID, A.EVENT_DATE, SUM(B.GAMES_PLAYED) GAMES_PLAYED_SO_FAR
FROM ACTIVITY A, ACTIVITY B
WHERE A.PLAYER_ID = B.PLAYER_ID
AND A.EVENT_DATE >= B.EVENT_DATE
GROUP BY A.PLAYER_ID, A.EVENT_DATE
ORDER BY A.PLAYER_ID, A.EVENT_DATE;

-- Solution 2
-- SELECT 於欄位中關聯式子查詢
SELECT A.PLAYER_ID, A.EVENT_DATE,( 
  SELECT SUM(GAMES_PLAYED)
  FROM ACTIVITY B
  WHERE A.PLAYER_ID = B.PLAYER_ID
  AND A.EVENT_DATE >= B.EVENT_DATE
) AS GAMES_PLAYED_SO_FAR
FROM ACTIVITY A
ORDER BY A.PLAYER_ID, A.EVENT_DATE;

-- Solution 3
-- 運用SUM函數將 "GAMES_PLAYED" 加總，並依照 "PLAYER_ID" 劃分PARTITION 資料
-- 並且依 "EVENT_DATE" 排序累計，達到累積總合
SELECT PLAYER_ID, EVENT_DATE, 
SUM(GAMES_PLAYED) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS GAMES_PLAYED_SO_FAR
FROM ACTIVITY
ORDER BY 1,2;
