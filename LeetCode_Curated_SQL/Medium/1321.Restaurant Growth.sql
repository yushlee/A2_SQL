-- 1321.Restaurant Growth

-- Table: Customer
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | customer_id   | int     |
-- | name          | varchar |
-- | visited_on    | date    |
-- | amount        | int     |
-- +---------------+---------+
-- (customer_id, visited_on) is the primary key for this table.
-- This table contains data about customer transactions in a restaurant.
-- 該表包含一家餐館的顧客交易數據
-- visited_on is the date on which the customer with ID (customer_id) have visited the restaurant.
-- visited_on 表示 (customer_id) 的顧客在 visited_on 那天訪問了餐館
-- amount is the total paid by a customer.
-- amount 是一個顧客某一天的消費總額

-- You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day)
-- Write an SQL query to compute moving average of how much customer paid in a 7 days window (current day + 6 days before)
-- 您是餐廳的老闆，並且您想分析店鋪可能的擴展(每天至少有一位客戶)
-- 查詢在7天(當前天+6天之前)內客戶支付的移動平均值

-- Return result table ordered by visited_on.
-- 返回由visited_on排序的結果表

-- average_amount should be rounded to 2 decimal places, all dates are in the format ('YYYY-MM-DD').
-- average_amount 應該四捨五入到小數點後兩位，所有日期均採用('YYYY-MM-DD')格式。 

-- Customer table:
-- +-------------+--------------+--------------+-------------+
-- | customer_id | name         | visited_on   | amount      |
-- +-------------+--------------+--------------+-------------+
-- | 1           | Jhon         | 2019-01-01   | 100         |
-- | 2           | Daniel       | 2019-01-02   | 110         |
-- | 3           | Jade         | 2019-01-03   | 120         |
-- | 4           | Khaled       | 2019-01-04   | 130         |
-- | 5           | Winston      | 2019-01-05   | 110         | 
-- | 6           | Elvis        | 2019-01-06   | 140         | 
-- | 7           | Anna         | 2019-01-07   | 150         |
-- | 8           | Maria        | 2019-01-08   | 80          |
-- | 9           | Jaze         | 2019-01-09   | 110         | 
-- | 1           | Jhon         | 2019-01-10   | 130         | 
-- | 3           | Jade         | 2019-01-10   | 150         | 
-- +-------------+--------------+--------------+-------------+

-- The query result format is in the following example:
-- Result table:
-- +--------------+--------------+----------------+
-- | visited_on   | amount       | average_amount |
-- +--------------+--------------+----------------+
-- | 2019-01-07   | 860          | 122.86         |
-- | 2019-01-08   | 840          | 120            |
-- | 2019-01-09   | 840          | 120            |
-- | 2019-01-10   | 1000         | 142.86         |
-- +--------------+--------------+----------------+

-- 1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
-- 2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
-- 3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
-- 4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86

-- 第一個七天消費平均值從 2019-01-01 到 2019-01-07 是 (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
-- 第二個七天消費平均值從 2019-01-02 到 2019-01-08 是 (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
-- 第三個七天消費平均值從 2019-01-03 到 2019-01-09 是 (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
-- 第四個七天消費平均值從 2019-01-04 到 2019-01-10 是 (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86


-- Solution
-- Oracle
WITH T AS (
  SELECT VISITED_ON,
    -- 依據 VISITED_ON 排序"加總" PRECEDING 前6天 AMOUNT
    SUM(AMOUNT) OVER(ORDER BY VISITED_ON ROWS 6 PRECEDING) AMOUNT,
    -- 依據 VISITED_ON 排序"平均" PRECEDING 前6天 AMOUNT
    ROUND(AVG(AMOUNT) OVER(ORDER BY VISITED_ON ROWS 6 PRECEDING),2) AVERAGE_AMOUNT,
    ROW_NUMBER() OVER (ORDER BY VISITED_ON) ROW_NO
  FROM (
    -- 先依據日期 VISITED_ON 做各日加總整合
    SELECT VISITED_ON, SUM(AMOUNT) AS AMOUNT
    FROM CUSTOMER
    GROUP BY VISITED_ON
    ORDER BY VISITED_ON
  ) A
  ORDER BY VISITED_ON
)
-- 第七天開始返回結果
SELECT　T.VISITED_ON, T.AMOUNT, T.AVERAGE_AMOUNT
FROM T WHERE　ROW_NO > 6;

-- MySQL
SELECT VISITED_ON, SUM(AMOUNT) OVER(ORDER BY VISITED_ON ROWS 6 PRECEDING),
ROUND(AVG(AMOUNT) OVER(ORDER BY VISITED_ON ROWS 6 PRECEDING),2)
FROM 
(
	SELECT VISITED_ON, SUM(AMOUNT) AS AMOUNT
	FROM CUSTOMER
	GROUP BY VISITED_ON
	ORDER BY VISITED_ON
) A
ORDER BY VISITED_ON OFFSET 6 ROWS;
