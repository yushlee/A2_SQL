-- 1336.Number of Transactions per Visit 每次訪問的交易數量

-- Table: Visits
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | visit_date    | date    |
-- +---------------+---------+
-- (user_id, visit_date) is the primary key for this table.
-- Each row of this table indicates that user_id has visited the bank in visit_date.
-- 該表的每一行表示user_id 在visit_date 訪問過銀行

-- Table: Transactions
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | user_id          | int     |
-- | transaction_date | date    |
-- | amount           | int     |
-- +------------------+---------+
-- There is no primary key for this table, it may contain duplicates.
-- 同一個user在同一天可以交易多次
-- Each row of this table indicates that user_id has done a transaction of amount in transaction_date.
-- It is guaranteed that the user has visited the bank in the transaction_date.(i.e The Visits table contains (user_id, transaction_date) in one row)
-- 該表的每一行表示user_id 在transaction_date 中完成了amount 的交易。
-- 保證用戶在transaction_date中訪問過銀行。即Visits表裡包含了Transactions表中所有的(user_id、transaction_date)

-- A bank wants to draw a chart of the number of transactions bank visitors did in one visit to the bank and the corresponding number of visitors who have done this number of transaction in one visit.
-- 一家銀行想繪製一張圖表來顯示銀行訪問者在一次訪問中完成的"交易數量"以及相應的在"一次訪問"中完成該交易數量的"訪問者數量"

-- Write an SQL query to find how many users visited the bank and didn't do any transactions, how many visited the bank and did one transaction and so on.
-- 查詢有多少用戶訪問了銀行並且沒有進行任何交易，有多少用戶訪問了銀行並進行了一次交易等等。

-- The result table will contain two columns:
-- 結果表將包含兩欄：

-- 1.transactions_count which is the number of transactions done in one visit.
-- 1.transaction_count 是一次訪問完成的交易數

-- 2.visits_count which is the corresponding number of users who did transactions_count in one visit to the bank.
-- 2.visits_count 是一次訪問銀行交易次數為 transaction_count 的用戶數

-- transactions_count should take all values from 0 to max(transactions_count) done by one or more users.
-- transactions_count 取值區間為0至一個或多個用戶完成最多交易數(transactions_count)

-- Order the result table by transactions_count.
-- 查詢結果按transactions_count 升序排列


-- Visits table:
-- +---------+------------+
-- | user_id | visit_date |
-- +---------+------------+
-- | 1       | 2020-01-01 |
-- | 2       | 2020-01-02 |
-- | 12      | 2020-01-01 |
-- | 19      | 2020-01-03 |
-- | 1       | 2020-01-02 |
-- | 2       | 2020-01-03 |
-- | 1       | 2020-01-04 |
-- | 7       | 2020-01-11 |
-- | 9       | 2020-01-25 |
-- | 8       | 2020-01-28 |
-- +---------+------------+

-- Transactions table:
-- +---------+------------------+--------+
-- | user_id | transaction_date | amount |
-- +---------+------------------+--------+
-- | 1       | 2020-01-02       | 120    |
-- | 2       | 2020-01-03       | 22     |
-- | 7       | 2020-01-11       | 232    |
-- | 1       | 2020-01-04       | 7      |
-- | 9       | 2020-01-25       | 33     |
-- | 9       | 2020-01-25       | 66     |
-- | 8       | 2020-01-28       | 1      |
-- | 9       | 2020-01-25       | 99     |
-- +---------+------------------+--------+

-- The query result format is in the following example:
-- Result table:
-- +--------------------+--------------+
-- | transactions_count | visits_count |
-- +--------------------+--------------+
-- | 0                  | 4            |
-- | 1                  | 5            |
-- | 2                  | 0            |
-- | 3                  | 1            |
-- +--------------------+--------------+
-- * For transactions_count = 0, The visits (1, "2020-01-01"), (2, "2020-01-02"), (12, "2020-01-01") and (19, "2020-01-03") did no transactions so visits_count = 4.
-- * For transactions_count = 1, The visits (2, "2020-01-03"), (7, "2020-01-11"), (8, "2020-01-28"), (1, "2020-01-02") and (1, "2020-01-04") did one transaction so visits_count = 5.
-- * For transactions_count = 2, No customers visited the bank and did two transactions so visits_count = 0.
-- * For transactions_count = 3, The visit (9, "2020-01-25") did three transactions so visits_count = 1.
-- * For transactions_count >= 4, No customers visited the bank and did more than three transactions so we will stop at transactions_count = 3

-- * 對於transactions_count = 0，訪問次數 (1, "2020-01-01"), (2, "2020-01-02"), (12, "2020-01-01") 和 (19, "2020- 01-03") 沒有交易，所以visits_count = 4。
-- * 對於transactions_count = 1，訪問次數 (2, "2020-01-03"), (7, "2020-01-11"), (8, "2020 -01-28"), (1, "2020-01-02") 和 (1, "2020-01-04") 做了一筆交易，所以visits_count = 5。
-- * 對於transactions_count = 2，沒有客戶訪問銀行並且做了兩筆交易，所以visits_count = 0。
-- * 對於transactions_count = 3，訪問(9，"2020-01-25")做了三筆交易，所以visits_count = 1。
-- * 對於transactions_count >= 4，沒有客戶訪問銀行並進行了超過三筆交易，因此我們將停止在交易數 = 3


-- Solution
-- 開啟CTE遞迴RECURSIVE查詢
WITH RECURSIVE T1 AS(
  -- 訪問資料表與交易資料表關聯，查詢每個日期的訪問次數和交易次數
  SELECT VISIT_DATE,
    IFNULL(NUM_VISITS,0) NUM_VISITS,
    IFNULL(NUM_TRANS,0) NUM_TRANS
  FROM (
	-- VISITS訪問資料表每個訪問日的訪問次數
    SELECT VISIT_DATE, USER_ID, COUNT(USER_ID) AS NUM_VISITS      
    FROM VISITS
    GROUP BY VISIT_DATE, USER_ID
    ORDER BY VISIT_DATE
  ) V LEFT JOIN (
	-- TRANSACTIONS交易資料表每個交易日的交易次數
    SELECT TRANSACTION_DATE, USER_ID, COUNT(USER_ID) AS NUM_TRANS
    FROM TRANSACTIONS
    GROUP BY TRANSACTION_DATE, USER_ID
  ) T ON V.VISIT_DATE = T.TRANSACTION_DATE  
  AND V.USER_ID = T.USER_ID
),
T2 AS (
	-- 取得最高的交易次數(3次)
	SELECT MAX(NUM_TRANS) AS TRANS FROM T1
    -- 遞迴查詢T2最高的交易次數每次減1取得(2、1、0)
    -- T2將產生一個0 ~ 3代表全部交易次數的資料表
	UNION ALL
	SELECT TRANS-1 FROM T2 WHERE TRANS >= 1
)
-- 關聯回T2資料表對應(0次 ~ 3次)交易次數的每個訪問次數
SELECT T2.TRANS AS TRANSACTIONS_COUNT,
  IFNULL(T.VISITS_COUNT, 0) AS VISITS_COUNT
FROM T2 LEFT JOIN (
    -- 取得每個交易次數(0、1、3)與其對應的訪問數(4、5、1)
    SELECT NUM_TRANS AS TRANSACTIONS_COUNT,
      COUNT(NUM_VISITS) AS VISITS_COUNT
    FROM T1
    GROUP BY NUM_TRANS
    ORDER BY NUM_TRANS
) T ON T2.TRANS = T.TRANSACTIONS_COUNT
ORDER BY TRANS;