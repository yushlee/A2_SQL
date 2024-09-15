-- 512.Game Play Analysis II 

-- Write a SQL query that reports the device that is first logged in for each player.
-- 編寫一個SQL查詢，每個玩家首次登錄的設備

-- The query result format is in the following example:

-- Table: Activity 
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
-- +-----------+-----------+
-- | player_id | device_id |
-- +-----------+-----------+
-- | 1         | 2         |
-- | 2         | 3         |
-- | 3         | 1         |
-- +-----------+-----------+


-- Solution1
-- 解題說明:
-- 先找出每個玩家最早登入日期
-- 在與原來的 ACTIVITY 資料表 JOIN ，透過最早登入日期條件查詢出 DEVICE_ID

WITH PLAYER_MIN_DATE AS (
  -- 先找出每個玩家最早登入日期
  SELECT PLAYER_ID, MIN(EVENT_DATE) MIN_EVENT_DATE
  FROM ACTIVITY GROUP BY PLAYER_ID
)
-- 在與原來的 ACTIVITY 資料表 JOIN 查詢出 DEVICE_ID
SELECT A.PLAYER_ID, A.DEVICE_ID, A.EVENT_DATE 
FROM ACTIVITY A INNER JOIN PLAYER_MIN_DATE P
ON A.PLAYER_ID = P.PLAYER_ID
AND A.EVENT_DATE = P.MIN_EVENT_DATE;

-- Solution2
-- 解題說明:
-- 先找出每個玩家最早登入日期
-- 運用 RANK PARTITION 劃分 PLAYER_ID 並依 EVENT_DATE 排名
-- 最後查詢每位玩家排名第一的EVENT_DATE
WITH T_EVENT_DATE AS (
   SELECT PLAYER_ID, DEVICE_ID, EVENT_DATE,
   RANK() OVER (
      PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC
   ) AS RK
   FROM ACTIVITY
)
SELECT PLAYER_ID, DEVICE_ID, EVENT_DATE
FROM T_EVENT_DATE
WHERE RK = 1;
