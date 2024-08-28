-- 1484.Group Sold Products By The Date

-- Table: Activities
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | sell_date   | date    |
-- | product     | varchar |
-- +-------------+---------+
-- There is no primary key for this table, it may contains duplicates.
-- Each row of this table contains the product name and the date it was sold in a market.
-- 該表的每一行都包含產品名稱和在市場上出售的日期。

-- Write an SQL query to find for each date, the number of "distinct products" 'sold' and their 'names'.
-- 查找每個日期所售"不同產品"的'數量'及其'名稱'

-- The sold-products names for each date should be sorted lexicographically. 
-- 每個日期的已售產品名稱應按字典順序排序

-- Return the result table ordered by sell_date.
-- 返回按Sell_date排序的結果

-- The query result format is in the following example.

-- Activities table:
-- +------------+-------------+
-- | sell_date  | product     |
-- +------------+-------------+
-- | 2020-05-30 | Headphone   |
-- | 2020-06-01 | Pencil      |
-- | 2020-06-02 | Mask        |
-- | 2020-05-30 | Basketball  |
-- | 2020-06-01 | Bible       |
-- | 2020-06-02 | Mask        |
-- | 2020-05-30 | T-Shirt     |
-- +------------+-------------+

-- Result table:
-- +------------+----------+------------------------------+
-- | sell_date  | num_sold | products                     |
-- +------------+----------+------------------------------+
-- | 2020-05-30 | 3        | Basketball,Headphone,T-shirt |
-- | 2020-06-01 | 2        | Bible,Pencil                 |
-- | 2020-06-02 | 1        | Mask                         |
-- +------------+----------+------------------------------+
-- For 2020-05-30, Sold items were (Headphone, Basketball, T-shirt), we sort them lexicographically and separate them by comma.
-- 我們按字典順序對它們進行排序，並用逗號分隔它們。
-- For 2020-06-01, Sold items were (Pencil, Bible), we sort them lexicographically and separate them by comma.
-- For 2020-06-02, Sold item is (Mask), we just return it.


-- Solution
-- 先將資料依SELL_DATE出售日資料分群
-- 透過COUNT函數搭配DISTINCT計算去重覆後的PRODUCT產品數量
-- 透過GROUP_CONCAT搭配DISTINCT群組清單並且ORDER BY升幕排序PRODUCT產品名稱
-- MySQL
SELECT SELL_DATE,
	COUNT(DISTINCT PRODUCT) AS NUM_SOLD,
	GROUP_CONCAT(DISTINCT PRODUCT ORDER BY PRODUCT) AS PRODUCTS
FROM ACTIVITIES
GROUP BY SELL_DATE
ORDER BY SELL_DATE;


-- Oracle 19c and later
SELECT SELL_DATE, COUNT(DISTINCT PRODUCT) NUM_SOLD,
	LISTAGG(DISTINCT PRODUCT, ',') WITHIN GROUP (ORDER BY PRODUCT)
FROM　ACTIVITIES
GROUP BY SELL_DATE
ORDER BY SELL_DATE;

-- Oracle 18c and earlier
WITH SELL_DATE_ACT AS (
  SELECT DISTINCT SELL_DATE, PRODUCT
  FROM　ACTIVITIES  
  ORDER BY SELL_DATE, PRODUCT
)
SELECT SELL_DATE, COUNT(PRODUCT) NUM_SOLD,
	LISTAGG(PRODUCT, ',') WITHIN GROUP (ORDER BY PRODUCT) 
FROM　SELL_DATE_ACT
GROUP BY SELL_DATE
ORDER BY SELL_DATE;


