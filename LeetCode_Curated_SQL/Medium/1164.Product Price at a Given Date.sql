-- 1164.Product Price at a Given Date 給定日期的產品價格

-- Table: Products
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | new_price     | int     |
-- | change_date   | date    |
-- +---------------+---------+
-- (product_id, change_date) is the primary key of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.
-- 此表的每一行都表示某個產品的價格在某個日期更改為新價格

-- Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
-- 查詢所有產品在2019-08-16的價格。假設所有產品的價格在變化之前均為10

-- The query result format is in the following example:
-- Products table:
-- +------------+-----------+-------------+
-- | product_id | new_price | change_date |
-- +------------+-----------+-------------+
-- | 1          | 20        | 2019-08-14  |
-- | 2          | 50        | 2019-08-14  |
-- | 1          | 30        | 2019-08-15  |
-- | 1          | 35        | 2019-08-16  |
-- | 2          | 65        | 2019-08-17  |
-- | 3          | 20        | 2019-08-18  |
-- +------------+-----------+-------------+

-- Result table:
-- +------------+-------+
-- | product_id | price |
-- +------------+-------+
-- | 2          | 50    |
-- | 1          | 35    |
-- | 3          | 10    |
-- +------------+-------+


-- Solution
-- 目標找出所有商品在2019-08-16當天的商品價格
-- 篩選商品價格更換日小於等於'2019-08-16'，透過RNAK排名函數計算劃分每個商品在最後價格更換日的排名
-- 以原先的PRODUCTS商品資料表為主左外側連結T暫存資料表，透過PRODUCT_ID商品編號、CHANGE_DATE價格更換日兩個欄位關聯
-- 篩選在'2019-08-16'日期前排名第一的商品，或排名NULL的商品(如編號3商品在'2019-08-16'前還未存在)
-- 最後透過PRODUCT_ID資料分群，再使用MAX函數找出最高商品價格，若價格為空則預設價格為10
WITH T AS (
	SELECT PRODUCT_ID, NEW_PRICE, CHANGE_DATE,
		RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY CHANGE_DATE DESC) PRODUCT_RANK
	FROM PRODUCTS
	WHERE CHANGE_DATE  <= '2019-08-16'
)
SELECT P.PRODUCT_ID, IFNULL(MAX(T.NEW_PRICE), 10) PRICE
FROM PRODUCTS P
LEFT JOIN T ON P.PRODUCT_ID = T.PRODUCT_ID AND P.CHANGE_DATE = T.CHANGE_DATE
WHERE T.PRODUCT_RANK = 1 OR T.PRODUCT_RANK IS NULL
GROUP BY P.PRODUCT_ID;


WITH T AS (
	SELECT PRODUCT_ID, NEW_PRICE, CHANGE_DATE,
		RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY CHANGE_DATE DESC) PRODUCT_RANK
	FROM PRODUCTS
	WHERE CHANGE_DATE  <= '2019-08-16'
)
SELECT P.*, T.*
FROM PRODUCTS P
LEFT JOIN T ON P.PRODUCT_ID = T.PRODUCT_ID AND P.CHANGE_DATE = T.CHANGE_DATE
WHERE T.PRODUCT_RANK = 1 OR T.PRODUCT_RANK IS NULL;
