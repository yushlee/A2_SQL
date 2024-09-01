-- 550.Game Play Analysis IV

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
--  該表記錄了遊戲用戶的行為信息，主鍵為(player_id, event_date)的組合。每一行記錄每個遊戲用戶登錄情況以及玩的遊戲數(玩的遊戲可能是0)。

--  Write an SQL query that reports the fraction of players that logged in again on the day after the day they first logged in,
--  查詢第一次登錄後的"第二天再次登錄"的玩家比例
--  rounded to 2 decimal places. In other words, 
--  四捨五入到小數點後兩位
--  you need to count the number of players that logged in for at least two consecutive days starting from their first login date, 
--  換句話說，計算從第一次登錄之日起至少連續兩天登錄的玩家數量
--  then divide that number by the total number of players.
--  然後將該數字除以玩家總數


--  The query result format is in the following example:

--  Activity table:
--  +-----------+-----------+------------+--------------+
--  | player_id | device_id | event_date | games_played |
--  +-----------+-----------+------------+--------------+
--  | 1         | 2         | 2016-03-01 | 5            |
--  | 1         | 2         | 2016-03-02 | 6            |
--  | 2         | 3         | 2017-06-25 | 1            |
--  | 3         | 1         | 2016-03-02 | 0            |
--  | 3         | 4         | 2018-07-03 | 5            |
--  +-----------+-----------+------------+--------------+

--  Result table:
--  +-----------+
--  | fraction  |
--  +-----------+
--  | 0.33      |
--  +-----------+
--  Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
--  只有 id 為 1 的玩家在他登錄的第一天之後重新登錄，所以答案是 1/3 = 0.33


-- Solution 1
WITH MIN_LOGIN_DATE_ACTIVITY AS (
  -- 找出各別玩家的最初登入日期
  SELECT PLAYER_ID, MIN(EVENT_DATE) "MIN_DATE"
  FROM ACTIVITY
  GROUP BY PLAYER_ID
),
DIFF_ONE_DAY AS (
  SELECT A.PLAYER_ID, 
  -- 將每一次登入日期 "減" 各別玩家的最初登入日期
  -- 若是差距為1天的為1否則為0
  CASE WHEN (A.EVENT_DATE - B.MIN_DATE = 1) THEN 1 ELSE 0 END DIFF_DAY
  FROM ACTIVITY A JOIN MIN_LOGIN_DATE_ACTIVITY B
  ON A.PLAYER_ID = B.PLAYER_ID
)
SELECT ROUND(SUM(DIFF_DAY) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION  
FROM DIFF_ONE_DAY;


-- Solution 2
-- 找出每列資料各別玩家分別的最初登入日期
-- 再將每一次登入日期 "減" 各別玩家的最初登入日期
-- 若是差距為1天的為1否則為0
-- 將所有差距為1天的資料個數加總"除"玩家總數(去重覆)
WITH T AS (
  SELECT PLAYER_ID, EVENT_DATE,  
	  MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS MIN_EVENT_DATE,
	  CASE WHEN (EVENT_DATE - MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) = 1)
		THEN 1 ELSE 0
	  END AS DIFF_DAY
  FROM ACTIVITY
)
SELECT ROUND( SUM(T.DIFF_DAY) / COUNT(DISTINCT T.PLAYER_ID), 2) AS FRACTION 
FROM T;
