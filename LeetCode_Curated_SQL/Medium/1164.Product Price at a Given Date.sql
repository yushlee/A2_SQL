-- 1164.Product Price at a Given Date

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
WITH T1 AS (
  -- 找出商品在 '2019-08-16' 之前的價格 NEW_PRICE
  SELECT A.PRODUCT_ID, NEW_PRICE
  FROM(
    -- 找出商品在 '2019-08-16' 之前的最大 CHANGE_DATE
    SELECT PRODUCT_ID, MAX(CHANGE_DATE) AS "DATE"
    FROM PRODUCTS
    WHERE CHANGE_DATE <= '2019-08-16'
    GROUP BY PRODUCT_ID
  ) A JOIN PRODUCTS P
  ON A.PRODUCT_ID = P.PRODUCT_ID 
  AND A."DATE" = P.CHANGE_DATE
),
T2 AS (
  -- 找出全部的商品(去重覆) PRODUCT_ID
  SELECT DISTINCT PRODUCT_ID FROM PRODUCTS
)
-- 已全部商品為來源找出 '2019-08-16' 之前的價格 NEW_PRICE
SELECT T2.PRODUCT_ID, NVL(T1.NEW_PRICE,10) AS PRICE
FROM T2 LEFT JOIN T1
ON T2.PRODUCT_ID = T1.PRODUCT_ID
ORDER BY PRICE DESC;
