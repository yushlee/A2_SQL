-- 1173.Immediate Food Delivery I 即時食品外送

-- Table: Delivery
-- +-----------------------------+---------+
-- | Column Name                 | Type    |
-- +-----------------------------+---------+
-- | delivery_id                 | int     |
-- | customer_id                 | int     |
-- | order_date                  | date    |
-- | customer_pref_delivery_date | date    |
-- +-----------------------------+---------+
-- customer_pref_delivery_date 顧客預期交貨日期

-- delivery_id is the primary key of this table.
-- The table holds information about food delivery to customers that make orders 
-- 該表包含有關向訂購客戶交付食物的信息
-- at some date and specify a preferred delivery date (on the same order date or after it).
-- 在某個日期並指定首選的交貨日期(在同一訂單日期或之後)

-- If the "preferred delivery date" of the customer is the same as the "order date"
-- then the order is called immediate otherwise it's called scheduled.
-- 如果客戶的首選交貨日期與訂單日期相同，則該訂單稱為"即時訂單"，否則稱為"計劃訂單"

-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
-- 在表格中找到"即時訂單"所佔的百分比(四捨五入到小數點後兩位)

-- The query result format is in the following example:

-- Delivery table:
-- +-------------+-------------+------------+-----------------------------+
-- | delivery_id | customer_id | order_date | customer_pref_delivery_date |
-- +-------------+-------------+------------+-----------------------------+
-- | 1           | 1           | 2019-08-01 | 2019-08-02                  |
-- | 2           | 5           | 2019-08-02 | 2019-08-02                  |
-- | 3           | 1           | 2019-08-11 | 2019-08-11                  |
-- | 4           | 3           | 2019-08-24 | 2019-08-26                  |
-- | 5           | 4           | 2019-08-21 | 2019-08-22                  |
-- | 6           | 2           | 2019-08-11 | 2019-08-13                  |
-- +-------------+-------------+------------+-----------------------------+

-- Result table:
-- +----------------------+
-- | immediate_percentage |
-- +----------------------+
-- | 33.33                |
-- +----------------------+
-- The orders with delivery id 2 and 3 are immediate while the others are scheduled.
-- 交貨ID為2和3的訂單是"即時訂單"的，而其他的則是"計劃訂單"


-- Solution one
WITH IMMEDIATE_ORDER AS (
  -- 即時訂單數量
  SELECT COUNT(DELIVERY_ID) IMMEDIATE_COUNT
  FROM DELIVERY 
  WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE
),
TOTAL_ORDER AS (
  -- 訂單總數
  SELECT COUNT(DELIVERY_ID) TOTAL_COUNT FROM DELIVERY
)
-- 即時訂單數量/訂單總數,透過ROUND函數取四捨五入到小數點後兩位
SELECT ROUND(IMMEDIATE_COUNT/TOTAL_COUNT*100,2) "IMMEDIATE_PERCENTAGE"
FROM IMMEDIATE_ORDER, TOTAL_ORDER;


-- Solution two
-- 透過CASE WHEN來判斷CASE WHEN 每一筆 DELIVERY 送貨資料紀錄的"訂單日期"與"交貨日期"
-- 是否為同一日即為"即時訂單"值1、否則0
-- 最後使用AVG平均函數算出"即時訂單"所佔的比例再乘100計算百分比
SELECT ROUND(
  -- 最後使用AVG平均函數算出"即時訂單"所佔的比例再乘100計算百分比
  AVG (
    -- 先查詢出"即時訂單"並輸出為1否則為0
    CASE WHEN ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE 
    THEN 1 ELSE 0 END
  ) * 100, 2
) AS IMMEDIATE_PERCENTAGE
FROM DELIVERY;


SELECT
	D.*,
	CASE WHEN ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE 
	THEN 1 ELSE 0 END AS INSTANT_ORDER
FROM DELIVERY D;
