-- 1205.Monthly Transactions II

-- Table: Transactions
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | country        | varchar |
-- | state          | enum    |
-- | amount         | int     |
-- | trans_date     | date    |
-- +----------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"].
-- 下表包含一些交易信息，id是此表的主鍵。state 列可能的值為["批准"、"拒絕"]

-- Table: Chargebacks
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | trans_id       | int     |
-- | trans_date    | date    |
-- +----------------+---------+
-- Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
-- trans_id is a foreign key to the id column of Transactions table.
-- Each chargeback corresponds to a transaction made previously even if they were not approved.
-- Chargebacks 包含有關來自放置在 Transactions 表中的某些交易退款的信息
-- trans_id 是 Transactions 表的 id 列的外鍵
-- 每個退款都對應於先前進行的交易，即使它們未獲批准

-- Write an SQL query to find for each month and country, the number of approved transactions and their total amount,
-- the number of chargebacks and their total amount.
-- 查詢 "每個月" 和 "國家/地區" 的 '批准' "交易數量" 及其 "總金額"、'退款' "數量"及其"總金額"

-- Note: In your query, given the month and country, ignore rows with all zeros.
-- 在查詢中，給定月份和國家/地區，請忽略全零的行

-- The query result format is in the following example:
-- Transactions table:
-- +------+---------+----------+--------+------------+
-- | id   | country | state    | amount | trans_date |
-- +------+---------+----------+--------+------------+
-- | 101  | US      | approved | 1000   | 2019-05-18 |
-- | 102  | US      | declined | 2000   | 2019-05-19 |
-- | 103  | US      | approved | 3000   | 2019-06-10 |
-- | 104  | US      | approved | 4000   | 2019-06-13 |
-- | 105  | US      | approved | 5000   | 2019-06-15 |
-- +------+---------+----------+--------+------------+

-- Chargebacks table:
-- +------------+------------+
-- | trans_id   | trans_date |
-- +------------+------------+
-- | 102        | 2019-05-29 |
-- | 101        | 2019-06-30 |
-- | 105        | 2019-09-18 |
-- +------------+------------+


-- Result table:
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
-- | 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
-- | 2019-09  | US      | 0              | 0               | 1                 | 5000               |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+


-- Solution
-- Oracle
WITH T1 AS (
  SELECT COUNTRY, TRUNC(TRANS_DATE, 'MONTH') DATE_PART, COUNT(*) APPROVED_COUNT, SUM(AMOUNT) APPROVED_AMOUNT
  FROM TRANSACTIONS
  WHERE STATE = 'approved'
  GROUP BY COUNTRY, TRUNC(TRANS_DATE, 'MONTH')
),
T2 AS(
  SELECT T.COUNTRY, TRUNC(C.TRANS_DATE, 'MONTH') DATE_PART, COUNT(*) CHARGEBACK_COUNT, SUM(AMOUNT) CHARGEBACK_AMOUNT
  FROM CHARGEBACKS C LEFT JOIN TRANSACTIONS T
  ON C.TRANS_ID = T.ID
  GROUP BY T.COUNTRY, TRUNC(C.TRANS_DATE, 'MONTH')
)
SELECT SUBSTR(NVL(T1.DATE_PART, T2.DATE_PART),0,7) MONTH, NVL(T1.COUNTRY, T2.COUNTRY) COUNTRY, 
       NVL(T1.APPROVED_COUNT,0) APPROVED_COUNT, NVL(T1.APPROVED_AMOUNT,0) APPROVED_AMOUNT,
       NVL(T2.CHARGEBACK_COUNT,0) CHARGEBACK_COUNT, NVL(T2.CHARGEBACK_AMOUNT,0) CHARGEBACK_AMOUNT
FROM T1 FULL JOIN T2 
ON T1.DATE_PART = T2.DATE_PART AND T1.COUNTRY = T2.COUNTRY;

-- MySQL
WITH T1 AS (
  SELECT COUNTRY, EXTRACT('month' FROM TRANS_DATE) DATE_PART, STATE, COUNT(*) AS APPROVED_COUNT, SUM(AMOUNT) AS APPROVED_AMOUNT
  FROM TRANSACTIONS
  WHERE STATE = 'approved'
  GROUP BY 1, 2, 3
),
T2 AS(
  SELECT T.COUNTRY, EXTRACT('month' FROM C.TRANS_DATE) DATE_PART, SUM(AMOUNT) AS CHARGEBACK_AMOUNT, COUNT(*) AS CHARGEBACK_COUNT
  FROM CHARGEBACKS C LEFT JOIN TRANSACTIONS T 
  ON TRANS_ID = ID
  GROUP BY T.COUNTRY, EXTRACT('month' FROM C.TRANS_DATE)
),
T3 AS(
  SELECT T2.DATE_PART, T2.COUNTRY, NVL(APPROVED_COUNT,0) AS APPROVED_COUNT, NVL(APPROVED_AMOUNT,0) AS APPROVED_AMOUNT, NVL(CHARGEBACK_COUNT,0) AS CHARGEBACK_COUNT, NVL(CHARGEBACK_AMOUNT,0) AS CHARGEBACK_AMOUNT
  FROM T2 LEFT JOIN T1 
  ON T2.DATE_PART = T1.DATE_PART AND T2.COUNTRY = T1.COUNTRY
),
T4 AS(
  SELECT T1.DATE_PART, T1.COUNTRY, NVL(APPROVED_COUNT,0) AS APPROVED_COUNT, NVL(APPROVED_AMOUNT,0) AS APPROVED_AMOUNT, NVL(CHARGEBACK_COUNT,0) AS CHARGEBACK_COUNT, NVL(CHARGEBACK_AMOUNT,0) AS CHARGEBACK_AMOUNT
  FROM T2 RIGHT JOIN T1 
  ON T2.DATE_PART = T1.DATE_PART AND T2.COUNTRY = T1.COUNTRY
)
SELECT * FROM T3
UNION
SELECT * FROM T4;
