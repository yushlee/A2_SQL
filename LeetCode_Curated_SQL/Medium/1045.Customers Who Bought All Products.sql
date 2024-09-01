-- 1045.Customers Who Bought All Products

--  Table: Customer
--  +-------------+---------+
--  | Column Name | Type    |
--  +-------------+---------+
--  | customer_id | int     |
--  | product_key | int     |
--  +-------------+---------+
--  product_key is a foreign key to Product table.

--  Table: Product
--  +-------------+---------+
--  | Column Name | Type    |
--  +-------------+---------+
--  | product_key | int     |
--  +-------------+---------+
--  product_key is the primary key column for this table.

--  Write an SQL query for a report that provides the customer ids from the Customer table that bought all the products in the Product table.
--  查詢購買了全部產品的顧客

--  For example:
--  Customer table:
--  +-------------+-------------+
--  | customer_id | product_key |
--  +-------------+-------------+
--  | 1           | 5           |
--  | 2           | 6           |
--  | 3           | 5           |
--  | 3           | 6           |
--  | 1           | 6           |
--  +-------------+-------------+
 

--  Product table:
--  +-------------+
--  | product_key |
--  +-------------+
--  | 5           |
--  | 6           |
--  +-------------+

--  Result table:
--  +-------------+
--  | customer_id |
--  +-------------+
--  | 1           |
--  | 3           |
--  +-------------+
--  The customers who bought all the products (5 and 6) are customers with id 1 and 3.
--  購買了所有產品(5 和 6)的客戶是ID為1和3的客戶


-- Solution
-- 顧客資料表透過CUSTOMER_ID顧客編號資料分群
-- 使用HAVING篩選透過COUNT函數搭配DISTINCT計算去重覆後的PRODUCT_KEY購買商品總數
-- 等於PRODUCT商品資料表的資料總數，即為購買全商品的顧客
SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS BUY_COUNT
FROM CUSTOMER
GROUP BY CUSTOMER_ID
HAVING COUNT(DISTINCT PRODUCT_KEY) = (
  SELECT COUNT(PRODUCT_KEY) FROM PRODUCT
);
