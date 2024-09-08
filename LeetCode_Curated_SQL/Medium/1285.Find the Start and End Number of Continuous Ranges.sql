-- 1285.Find the Start and End Number of Continuous Ranges 找出連續範圍的開始和結束編號

-- Table: Logs
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | log_id        | int     |
-- +---------------+---------+
-- id is the primary key for this table.
-- Each row of this table contains the ID in a log Table.
-- 該表的每一行都包含日誌表中的ID

-- Since some IDs have been removed from Logs. Write an SQL query to find the start and end number of continuous ranges in table Logs.
-- Order the result table by start_id.
-- 由於某些 ID 已從日誌中刪除。編寫 SQL 查詢 Logs 中連續範圍的開始和結束編號
-- 按 start_id 對結果表進行排序

-- Logs table:
-- +------------+
-- | log_id     |
-- +------------+
-- | 1          |
-- | 2          |
-- | 3          |
-- | 7          |
-- | 8          |
-- | 10         |
-- +------------+

-- The query result format is in the following example:
-- Result table:
-- +------------+--------------+
-- | start_id   | end_id       |
-- +------------+--------------+
-- | 1          | 3            |
-- | 7          | 8            |
-- | 10         | 10           |
-- +------------+--------------+
-- The result table should contain all ranges in table Logs.
-- From 1 to 3 is contained in the table.
-- From 4 to 6 is missing in the table
-- From 7 to 8 is contained in the table.
-- Number 9 is missing in the table.
-- Number 10 is contained in the table.

-- 結果表應包含表日誌中的所有範圍
-- 從 1 到 3 包含在表中
-- 表中缺少從 4 到 6 
-- 表中包含從 7 到 8
-- 表中缺少數字 9
-- 數字 10 包含在表中


-- Solution
-- "自身編號"減去排序"欄位列編號"，相差值數字相同表示數字之間為連續編號
-- 在透過DIFF相差值將資料分群，從中取最小值MIN(LOG_ID)與最大值MAX(LOG_ID)
-- 即為每個數字群的數值範圍區間
SELECT MIN(LOG_ID) START_ID, MAX(LOG_ID) END_ID
FROM (
  SELECT LOG_ID, 
  ROW_NUMBER() OVER (ORDER BY LOG_ID) ROU_NUMBER,  
  (LOG_ID - ROW_NUMBER() OVER (ORDER BY LOG_ID)) DIFF
  FROM LOGS
) T
GROUP BY DIFF
ORDER BY START_ID;
