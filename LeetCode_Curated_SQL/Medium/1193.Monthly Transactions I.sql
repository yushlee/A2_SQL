-- 1193.Monthly Transactions I

-- Table: Transactions
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | country       | varchar |
-- | state         | enum    |
-- | amount        | int     |
-- | trans_date    | date    |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"].
-- 下表包含一些交易信息，id是此表的主鍵。state 列可能的值為["批准"、"拒絕"]

-- Write an SQL query to find for each month and country, the number of transactions and their total amount,
-- the number of approved transactions and their total amount.
-- 查詢每個月和每個國家/地區的 "交易次數" 及其 "總金額"，批准的 "交易次數" 及其 "總金額"

-- The query result format is in the following example:
-- Transactions table:
-- +------+---------+----------+--------+------------+
-- | id   | country | state    | amount | trans_date |
-- +------+---------+----------+--------+------------+
-- | 121  | US      | approved | 1000   | 2018-12-18 |
-- | 122  | US      | declined | 2000   | 2018-12-19 |
-- | 123  | US      | approved | 2000   | 2019-01-01 |
-- | 124  | DE      | approved | 2000   | 2019-01-07 |
-- +------+---------+----------+--------+------------+

-- Result table:
-- +----------+---------+-------------+----------------+--------------------+-----------------------+
-- | month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
-- +----------+---------+-------------+----------------+--------------------+-----------------------+
-- | 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
-- | 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
-- | 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
-- +----------+---------+-------------+----------------+--------------------+-----------------------+


-- Solution
-- Oracle
WITH T1 AS(
  -- 依照月份、國家計算全部交易的 "交易次數","總金額"
  SELECT TRUNC(TRANS_DATE,'MONTH') AS MONTH, COUNTRY, COUNT(STATE) AS TRANS_COUNT, SUM(AMOUNT) AS TRANS_TOTAL_AMOUNT
  FROM TRANSACTIONS
  GROUP BY COUNTRY, TRUNC(TRANS_DATE,'MONTH')
),
T2 AS (
  -- 依照月份、國家計算被批准交易的 "交易次數","總金額"
  SELECT TRUNC(TRANS_DATE,'MONTH') AS MONTH, COUNTRY, COUNT(STATE) AS TRANS_COUNT, SUM(AMOUNT) AS TRANS_TOTAL_AMOUNT
  FROM TRANSACTIONS
  WHERE STATE = 'approved'
  GROUP BY COUNTRY, TRUNC(TRANS_DATE,'MONTH')
)
-- LEFT JOIN 連結全部交易、批准交易
SELECT T1.MONTH, T1.COUNTRY, NVL(T1.TRANS_COUNT,0) AS TRANS_COUNT, NVL(T2.TRANS_COUNT,0) AS APPROVED_COUNT, 
       NVL(T1.TRANS_TOTAL_AMOUNT,0) AS TRANS_TOTAL_AMOUNT, NVL(T2.TRANS_TOTAL_AMOUNT,0) AS APPROVED_TOTAL_AMOUNT
FROM T1 LEFT JOIN T2
ON T1.COUNTRY = T2.COUNTRY AND T1.MONTH = T2.MONTH;

-- MySQL
WITH T1 AS(
  SELECT DATE_FORMAT(TRANS_DATE,'%Y-%m') AS MONTH, COUNTRY, COUNT(STATE) AS TRANS_COUNT, SUM(AMOUNT) AS TRANS_TOTAL_AMOUNT
  FROM TRANSACTIONS
  GROUP BY COUNTRY, MONTH(TRANS_DATE)
),
T2 AS (
  SELECT DATE_FORMAT(TRANS_DATE,'%Y-%m') AS MONTH, COUNTRY, COUNT(STATE) AS APPROVED_COUNT, SUM(AMOUNT) AS APPROVED_TOTAL_AMOUNT
  FROM TRANSACTIONS
  WHERE STATE = 'approved'
  GROUP BY COUNTRY, MONTH(TRANS_DATE)
)
SELECT T1.MONTH, T1.COUNTRY, COALESCE(T1.TRANS_COUNT,0) AS TRANS_COUNT, COALESCE(T2.APPROVED_COUNT,0) AS APPROVED_COUNT, COALESCE(T1.TRANS_TOTAL_AMOUNT,0) AS TRANS_TOTAL_AMOUNT, COALESCE(T2.APPROVED_TOTAL_AMOUNT,0) AS APPROVED_TOTAL_AMOUNT
FROM T1 LEFT JOIN T2
ON T1.COUNTRY = T2.COUNTRY AND T1.MONTH = T2.MONTH;
