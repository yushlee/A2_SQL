-- 1225.Report Contiguous Dates 連續日期

-- Table: Failed
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | fail_date    | date    |
-- +--------------+---------+
-- Primary key for this table is fail_date.
-- Failed table contains the days of failed tasks.
-- 該表中包含任務失敗的日期，其中fail_date 為主鍵。


-- Table: Succeeded
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | success_date | date    |
-- +--------------+---------+
-- Primary key for this table is success_date.
-- Succeeded table contains the days of succeeded tasks.
-- 該表中包含任務成功的日期，其中success_date 為主鍵。


-- A system is running one task every day. Every task is independent of the previous tasks. The tasks can fail or succeed.
-- 系統每天運行一項任務。每個任務都獨立於之前的任務。任務可以失敗也可以成功。

-- Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.
-- 查詢以生成2019-01-01至2019-12-31期間的連續時間的period_state報告

-- period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded. Interval of days are retrieved as start_date and end_date.
-- 如果此間隔中的任務失敗，則period_state為"失敗"，如果此間隔中的任務成功，則為"成功"。取天的間隔作為開始日期和結束日期。

-- Order result by start_date.
-- 查詢結果按開始日期升序排序

-- Failed table:
-- +-------------------+
-- | fail_date         |
-- +-------------------+
-- | 2018-12-28        |
-- | 2018-12-29        |
-- | 2019-01-04        |
-- | 2019-01-05        |
-- +-------------------+


-- Succeeded table:
-- +-------------------+
-- | success_date      |
-- +-------------------+
-- | 2018-12-30        |
-- | 2018-12-31        |
-- | 2019-01-01        |
-- | 2019-01-02        |
-- | 2019-01-03        |
-- | 2019-01-06        |
-- +-------------------+  


-- The query result format is in the following example:
-- Result table:
-- +--------------+--------------+--------------+
-- | period_state | start_date   | end_date     |
-- +--------------+--------------+--------------+
-- | succeeded    | 2019-01-01   | 2019-01-03   |
-- | failed       | 2019-01-04   | 2019-01-05   |
-- | succeeded    | 2019-01-06   | 2019-01-06   |
-- +--------------+--------------+--------------+

-- The report ignored the system state in 2018 as we care about the system in the period 2019-01-01 to 2019-12-31.
-- From 2019-01-01 to 2019-01-03 all tasks succeeded and the system state was "succeeded".
-- From 2019-01-04 to 2019-01-05 all tasks failed and system state was "failed".
-- From 2019-01-06 to 2019-01-06 all tasks succeeded and system state was "succeeded".
-- 說明：該報告忽略了2018年的系統狀態，因為我們關心的是2019-01-01至2019-12-31期間的系統。
-- 從2019-01-01到2019-01-03，所有任務成功完成，並且系統狀態為"成功"。
-- 從2019-01-04到2019-01-05，所有任務均失敗，並且系統狀態為"失敗"。
-- 從2019-01-06到2019-01-06，所有任務成功完成，並且系統狀態為"成功"。


-- Solution
-- Step1:
-- 聯集FAILED資料表與SUCCEEDED資料表所有日期資料FAIL_DATE、SUCCESS_DATE
-- 並且分別標記STATE狀態'failed'、'succeeded'
-- Step2:
-- 篩選資料日期DATE介於'2019-01-01' ~ '2019-12-31'之間
-- 使用RANK函數透過STATE狀態將資料劃分並按照DATE資料日期排序取得「狀態日期天數」
-- 「DATE資料日期」減「狀態日期天數」取得「狀態日期群組」STATE_DATE_GROUP
-- 「狀態日期群組」日期相同代表為同一個連續日期區間
-- Step3:
-- 資料依兩個欄位STATE狀態、STATE_DATE_GROUP狀態日期群組將資料分群
-- 依每個資料群取DATE最小值(開始日期)、取DATE最大值(結束日期)
WITH T1 AS (
	SELECT FAIL_DATE DATE, 'failed' STATE FROM FAILED
	UNION ALL
	SELECT SUCCESS_DATE DATE, 'succeeded' STATE FROM SUCCEEDED
	ORDER BY DATE
),
T2 AS (
	SELECT DATE, STATE,
		RANK() OVER (PARTITION BY STATE ORDER BY DATE) RANK_STATE_DAY,
		SUBDATE(DATE, INTERVAL RANK() OVER (PARTITION BY STATE ORDER BY DATE) DAY) STATE_DATE_GROUP
	FROM T1
	WHERE DATE BETWEEN  '2019-01-01' AND '2019-12-31'
	ORDER BY DATE
)
SELECT STATE PERIOD_STATE, MIN(DATE) START_DATE, MAX(DATE) END_DATE
FROM T2
GROUP BY STATE, STATE_DATE_GROUP;


