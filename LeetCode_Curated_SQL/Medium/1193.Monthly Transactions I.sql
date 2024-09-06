-- 1193.Monthly Transactions I 每月交易

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
-- 該表包含有關傳入交易的資訊
-- The state column is an enum of type ["approved", "declined"].
-- 下表包含一些交易信息，id是此表的主鍵。state列可能的值為["approved批准"、"declined拒絕"]

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
-- MySQL
-- 透過取TRANS_DATE交易日年月、COUNTRY國家兩個欄位將資料分群
-- COUNT(ID) 計算全部交易的分群次數
-- SUM(IF(STATE = 'approved',1 , 0)) 計算加總STATE狀態值為'approved'的分群數量
-- SUM(AMOUNT) 計算全部交易的分群總金額
-- SUM(IF(STATE='approved', AMOUNT, 0)) 計算加總STATE狀態值為'approved'的分群總金額
SELECT DATE_FORMAT(TRANS_DATE,'%Y-%m') MONTH,
	COUNTRY,
	COUNT(ID) TRANS_COUNT,
	SUM(IF(STATE = 'approved',1 , 0)) APPROVED_COUNT,
	SUM(AMOUNT) TRANS_TOTAL_AMOUNT,
	SUM(IF(STATE='approved', AMOUNT, 0)) APPROVED_TOTAL_AMOUNT
FROM TRANSACTIONS
GROUP BY MONTH, COUNTRY;


SELECT ID, COUNTRY, STATE, AMOUNT, TRANS_DATE,
	DATE_FORMAT(TRANS_DATE,'%Y-%m') MONTH,	
	IF(STATE = 'approved',1 , 0) APPROVED_COUNT,	
	IF(STATE='approved', AMOUNT, 0) APPROVED_TOTAL_AMOUNT
FROM TRANSACTIONS;


-- 依照月份、國家計算全部交易的 "交易次數","總金額"
-- 依照月份、國家計算被批准交易的 "交易次數","總金額"
-- LEFT JOIN 連結全部交易、批准交易
WITH T1 AS(
  SELECT DATE_FORMAT(TRANS_DATE,'%Y-%m') MONTH, COUNTRY, COUNT(STATE) TRANS_COUNT, SUM(AMOUNT) TRANS_TOTAL_AMOUNT
  FROM TRANSACTIONS
  GROUP BY COUNTRY, DATE_FORMAT(TRANS_DATE,'%Y-%m')
),
T2 AS (
  SELECT DATE_FORMAT(TRANS_DATE,'%Y-%m') MONTH, COUNTRY, COUNT(STATE) APPROVED_COUNT, SUM(AMOUNT) APPROVED_TOTAL_AMOUNT
  FROM TRANSACTIONS
  WHERE STATE = 'approved'
  GROUP BY COUNTRY, DATE_FORMAT(TRANS_DATE,'%Y-%m')
)
SELECT T1.MONTH, T1.COUNTRY, 
	IFNULL(T1.TRANS_COUNT,0) TRANS_COUNT, IFNULL(T2.APPROVED_COUNT,0) APPROVED_COUNT, 
    IFNULL(T1.TRANS_TOTAL_AMOUNT,0) TRANS_TOTAL_AMOUNT, IFNULL(T2.APPROVED_TOTAL_AMOUNT,0) APPROVED_TOTAL_AMOUNT
FROM T1 LEFT JOIN T2
ON T1.COUNTRY = T2.COUNTRY AND T1.MONTH = T2.MONTH;




