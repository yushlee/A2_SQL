-- 1225.Report Contiguous Dates

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
-- Oracle
WITH T AS (
  -- 通過 partition rank和date的"時間差"，把每一輪fail和success區分開 
  SELECT AP_DATE, STATUS,
    RANK() OVER (PARTITION BY STATUS ORDER BY AP_DATE) RANK_DATE,
    AP_DATE - RANK() OVER (PARTITION BY STATUS ORDER BY AP_DATE) DIFF_DATE
  FROM (
    -- 先把兩張表合成一張表並區分success、fail
    SELECT SUCCESS_DATE AP_DATE, 'success' STATUS
    FROM SUCCEEDED
    UNION ALL
    SELECT FAIL_DATE AP_DATE, 'fail' STATUS
    FROM FAILED
  ) WHERE AP_DATE BETWEEN '2019-01-01' and '2019-12-31'
)
-- 分群STATUS和DIFF_DATE，分別群組內AP_DATE"最小"和"最大"是開始與結束日期
SELECT STATUS PERIOD_STATE, MIN(AP_DATE) START_DATE, MAX(AP_DATE) END_DATE
FROM T
GROUP BY STATUS,DIFF_DATE
ORDER BY START_DATE;

-- MySQL
SELECT STATE PERIOD_STATE, 
	MIN(DATE) START_DATE, 
	MAX(DATE) END_DATE
FROM (
    SELECT *, SUBDATE(DATE,INTERVAL RANK() OVER (PARTITION BY STATE ORDER BY DATE) DAY) REF
    FROM (
        SELECT FAIL_DATE DATE,'failed' STATE FROM FAILED
        UNION ALL
        SELECT SUCCESS_DATE DATE,'succeeded' STATE FROM SUCCEEDED
        ORDER BY DATE
      ) A
    WHERE DATE BETWEEN  '2019-01-01' AND '2019-12-31'
  ) B
GROUP BY STATE, REF
ORDER BY START_DATE;

