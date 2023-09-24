-- 1097.Game Play Analysis V

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
-- 此表顯示了某些遊戲的玩家的活動。每一行都是一個玩家的記錄，該玩家在某天使用某種設備登錄並玩了許多遊戲(可能是0個)，然後再退出。

-- We define the install date of a player to be the first login day of that player.
-- 我們將玩家的 "安裝日期" 定義為該玩家的 "第一個登錄日"

-- We also define day 1 retention of some date X to be the number of players whose install date is X and they logged back in on the day right after X,
-- divided by the number of players whose install date is X, rounded to 2 decimal places.
-- 安裝日的留存率 = 安裝日"後的第一天"登錄的用戶比例/安裝日安裝的用戶數，四捨五入為 2小數位。

-- Write an SQL query that reports for each install date, the number of players that installed the game on that day and the day 1 retention.
-- 查詢每個安裝日，安裝遊戲的玩家數量以及第1天的留存率

-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-03-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-01 | 0            |
-- | 3         | 4         | 2016-07-03 | 5            |
-- +-----------+-----------+------------+--------------+

-- The query result format is in the following example:
-- Result table:
-- +------------+----------+----------------+
-- | install_dt | installs | Day1_retention |
-- +------------+----------+----------------+
-- | 2016-03-01 | 2        | 0.50           |
-- | 2017-06-25 | 1        | 0.00           |
-- +------------+----------+----------------+
-- Player 1 and 3 installed the game on 2016-03-01 but only player 1 logged back in on 2016-03-02 
-- so the day 1 retention of 2016-03-01 is 1 / 2 = 0.50
-- 玩家 1 和 3 於 2016 年 3 月 1 日安裝了遊戲，但只有玩家 1 於 2016 年 3 月 2 日重新登錄，
-- 因此 2016-03-01 的第 1 天留存率為 1 / 2 = 0.50

-- Player 2 installed the game on 2017-06-25 but didn't log back in on 2017-06-26 
-- so the day 1 retention of 2017-06-25 is 0 / 1 = 0.00
-- 玩家 2 於 2017 年 6 月 25 日安裝了遊戲，但沒有在 2017 年 6 月 26 日重新登錄，
-- 因此 2017 年 6 月 25 日的第 1 天留存率為 0 / 1 = 0.00


-- Solution
WITH T1 AS (
  SELECT PLAYER_ID, EVENT_DATE,
    -- 依照PLAYER_ID資料劃分，最小的EVENT_DATE
    MIN(EVENT_DATE) OVER(PARTITION BY PLAYER_ID) AS INSTALL_DT,
    -- 依照PLAYER_ID資料劃分，且按EVENT_DATE排序的，下一筆EVENT_DATE 資料 NXT_DATE
    LEAD(EVENT_DATE,1) OVER(PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NXT_DATE
  FROM ACTIVITY
)
SELECT T1.INSTALL_DT,
  -- 相同的PLAYER_ID只能算一次安裝
  COUNT(DISTINCT T1.PLAYER_ID) AS INSTALLS,
  ROUND(
    -- 若是NXT_DATE等於EVENT_DATE+1(EVENT_DATE加一天)計數1並且SUM加總
    SUM(CASE WHEN NXT_DATE = EVENT_DATE+1 THEN 1 ELSE 0 END) / 
    COUNT(DISTINCT T1.PLAYER_ID)
    ,2  
  ) AS DAY1_RETENTION
FROM T1
GROUP BY T1.INSTALL_DT
ORDER BY T1.INSTALL_DT;
