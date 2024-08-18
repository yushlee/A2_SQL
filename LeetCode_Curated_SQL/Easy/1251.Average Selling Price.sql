-- 1251.Average Selling Price

-- Table: Prices

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | start_date    | date    |
-- | end_date      | date    |
-- | price         | int     |
-- +---------------+---------+
-- (product_id, start_date, end_date) is the primary key for this table.
-- Each row of this table indicates the price of the product_id in the period from start_date to end_date.
-- 該表的每一行指示從 start_date 到 end_date 期間 product_id 的價格
-- For each product_id there will be no two overlapping periods.
-- 對於每個 product_id，將沒有兩個重疊的時間段
-- That means there will be no two intersecting periods for the same product_id.
-- 這意味著同一個 product_id 不會有兩個相交的時間段

-- Table: UnitsSold(售出單位)

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | purchase_date | date    | 購買日
-- | units         | int     | 購買單位
-- +---------------+---------+
-- There is no primary key for this table, it may contain duplicates.
-- Each row of this table indicates the date, units and product_id of each product sold.
-- 該表的每一行均指示每種已售產品的日期，購買單位和 product_id

-- Write an SQL query to find the average selling price for each product.
-- 查詢計算每個產品的平均售價
-- average_price should be rounded to 2 decimal places.
-- average_price 應該四捨五入到小數點後兩位
-- The query result format is in the following example:

-- Prices table:
-- +------------+------------+------------+--------+
-- | product_id | start_date | end_date   | price  |
-- +------------+------------+------------+--------+
-- | 1          | 2019-02-17 | 2019-02-28 | 5      |
-- | 1          | 2019-03-01 | 2019-03-22 | 20     |
-- | 2          | 2019-02-01 | 2019-02-20 | 15     |
-- | 2          | 2019-02-21 | 2019-03-31 | 30     |
-- +------------+------------+------------+--------+
 
-- UnitsSold table:
-- +------------+---------------+-------+
-- | product_id | purchase_date | units |
-- +------------+---------------+-------+
-- | 1          | 2019-02-25    | 100   |
-- | 1          | 2019-03-01    | 15    |
-- | 2          | 2019-02-10    | 200   |
-- | 2          | 2019-03-22    | 30    |
-- +------------+---------------+-------+

-- Result table:
-- +------------+---------------+
-- | product_id | average_price |
-- +------------+---------------+
-- | 1          | 6.96          |
-- | 2          | 16.96         |
-- +------------+---------------+  
-- Average selling price = Total Price of Product / Number of products sold.
-- Average selling price for product 1 = ((100 * $5) + (15 * $20)) / 115 = 6.96
-- 100 + 15 = 115
-- Average selling price for product 2 = ((200 * $15) + (30 * $30)) / 230 = 16.96
-- 200 + 30 = 230


-- Solution ONE
-- 將售價資料表與售出單位資料表透過 PRODUCT_ID 產品編號欄位關聯
-- 且透過 PURCHASE_DATE 購買日期欄位介於售價起始日與結束日之間
-- 查詢出每一筆產品銷售日所在銷售日期區間的售價
-- 依 PRODUCT_ID 產品編號資料分群後，將每一筆的銷售日期區間售價乘銷售數量的總合，除以銷售數量的總合
-- 取得每個產品的平均售價並取四捨五入到小數點後兩位
SELECT D.PRODUCT_ID, 
	ROUND(
	  SUM(PRICE * UNITS) / SUM(UNITS), 2
	) AS AVERAGE_PRICE,
	SUM(PRICE * UNITS), SUM(UNITS)
FROM (
  SELECT P.PRODUCT_ID, P.PRICE, P.START_DATE, P.END_DATE, U.PURCHASE_DATE, U.UNITS
  FROM PRICES P INNER JOIN UNITSSOLD U
  ON P.PRODUCT_ID = U.PRODUCT_ID
  AND U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE
) D
GROUP BY D.PRODUCT_ID;

-- Solution two
SELECT D.PRODUCT_ID, ROUND( SUM(PRICE*UNITS)/SUM(UNITS), 2) AS AVERAGE_PRICE
FROM (
  SELECT *
  -- 加上 NATURAL 這個關鍵字之後，兩資料表之間同名的欄位會被自動結合在一起,省去指定欄位 JOIN 的麻煩
  FROM PRICES P NATURAL JOIN UNITSSOLD U
  WHERE U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE
) D
GROUP BY D.PRODUCT_ID;
