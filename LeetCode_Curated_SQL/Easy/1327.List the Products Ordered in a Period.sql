-- 1327.List the Products Ordered in a Period 列出期間內訂購的產品

-- Table: Products
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | product_id       | int     |
-- | product_name     | varchar |
-- | product_category | varchar |
-- +------------------+---------+
-- product_id is the primary key for this table.
-- This table contains data about the company's products.
-- 此表包含有關公司產品的資料

-- Table: Orders
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | order_date    | date    |
-- | unit          | int     |
-- +---------------+---------+
-- There is no primary key for this table. It may have duplicate rows.
-- product_id is a foreign key to Products table.
-- unit is the number of products ordered in order_date.
-- unit 單位是 order_date 中訂購的產品數量

-- Write an SQL query to get the names of products with "greater than or equal to 100 units"
-- ordered in "February 2020" and their amount.
-- 查詢以獲取"2020年2月"訂購的"大於或等於100"個產品的'產品名稱及其數量'

-- Return result table in any order.

-- The query result format is in the following example: 

-- Products table:
-- +-------------+-----------------------+------------------+
-- | product_id  | product_name          | product_category |
-- +-------------+-----------------------+------------------+
-- | 1           | Leetcode Solutions    | Book             |
-- | 2           | Jewels of Stringology | Book             |
-- | 3           | HP                    | Laptop           |
-- | 4           | Lenovo                | Laptop           |
-- | 5           | Leetcode Kit          | T-shirt          |
-- +-------------+-----------------------+------------------+

-- Orders table:
-- +--------------+--------------+----------+
-- | product_id   | order_date   | unit     |
-- +--------------+--------------+----------+
-- | 1            | 2020-02-05   | 60       |
-- | 1            | 2020-02-10   | 70       |
-- | 2            | 2020-01-18   | 30       |
-- | 2            | 2020-02-11   | 80       |
-- | 3            | 2020-02-17   | 2        |
-- | 3            | 2020-02-24   | 3        |
-- | 4            | 2020-03-01   | 20       |
-- | 4            | 2020-03-04   | 30       |
-- | 4            | 2020-03-04   | 60       |
-- | 5            | 2020-02-25   | 50       |
-- | 5            | 2020-02-27   | 50       |
-- | 5            | 2020-03-01   | 50       |
-- +--------------+--------------+----------+

-- Result table:
-- +--------------------+---------+
-- | product_name       | unit    |
-- +--------------------+---------+
-- | Leetcode Solutions | 130     |
-- | Leetcode Kit       | 100     |
-- +--------------------+---------+

-- Products with product_id = 1 is ordered in February a total of (60 + 70) = 130.
-- Products with product_id = 2 is ordered in February a total of 80.
-- Products with product_id = 3 is ordered in February a total of (2 + 3) = 5.
-- Products with product_id = 4 was not ordered in February 2020.
-- Products with product_id = 5 is ordered in February a total of (50 + 50) = 100.


-- Solution
-- 先將訂單資料表與產品資料表透過產品編號PRODUCT_ID關聯
-- 查詢條件訂單日ORDER_DATE取年等於2020、ORDER_DATE取月等於2
-- 使用產品名稱PRODUCT_NAME做資料分群，並透過HAVING篩選總合訂購量大於等於100
-- MySQL
SELECT P.PRODUCT_NAME, SUM(UNIT) "UNIT"
FROM ORDERS O JOIN PRODUCTS P
ON O.PRODUCT_ID = P.PRODUCT_ID
WHERE YEAR(ORDER_DATE) = 2020 AND MONTH(ORDER_DATE) = 2
GROUP BY P.PRODUCT_NAME
HAVING SUM(UNIT) >= 100
ORDER BY "UNIT" DESC;


-- Oracle
SELECT P.PRODUCT_NAME, SUM(UNIT) "UNIT"
FROM ORDERS O JOIN PRODUCTS P
ON O.PRODUCT_ID = P.PRODUCT_ID
WHERE TRUNC(ORDER_DATE, 'MONTH') = '2020-02-01'
GROUP BY P.PRODUCT_NAME
HAVING SUM(UNIT) >= 100
ORDER BY "UNIT" DESC;

