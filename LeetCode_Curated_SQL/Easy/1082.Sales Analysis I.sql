-- 1082.Sales Analysis I

-- Table: Product
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- | unit_price   | int     |
-- +--------------+---------+
-- product_id is the primary key of this table.

-- Table: Sales
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | seller_id   | int     |
-- | product_id  | int     |
-- | buyer_id    | int     |
-- | sale_date   | date    |
-- | quantity    | int     |
-- | price       | int     |
-- +------ ------+---------+
-- This table has no primary key, it can have repeated rows.
-- product_id is a foreign key to Product table.
 

-- Write an SQL query that reports the best seller by total sales price, If there is a tie, report them all.
-- 查詢"總銷售額"最高的員工，若有並列第一，需完整列出

-- The query result format is in the following example:

-- Product table:
-- +------------+--------------+------------+
-- | product_id | product_name | unit_price |
-- +------------+--------------+------------+
-- | 1          | S8           | 1000       |
-- | 2          | G4           | 800        |
-- | 3          | iPhone       | 1400       |
-- +------------+--------------+------------+

-- Sales table:
-- +-----------+------------+----------+------------+----------+-------+
-- | seller_id | product_id | buyer_id | sale_date  | quantity | price |
-- +-----------+------------+----------+------------+----------+-------+
-- | 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
-- | 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
-- | 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
-- | 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
-- +-----------+------------+----------+------------+----------+-------+

-- Result table:
-- +-------------+
-- | seller_id   |
-- +-------------+
-- | 1           |
-- | 3           |
-- +-------------+
-- Both sellers with id 1 and 3 sold products with the most total price of 2800.
-- 編號為1和3的銷售員均以最高總價2800出售了產品


-- Solution
-- 以銷售員編號做資料分群，透過RNAK函數排序總和產品銷售額，最後再取排名第一的銷售員編號
SELECT A.SELLER_ID
FROM (  
  SELECT SELLER_ID,
  SUM(PRICE),
  RANK() OVER (ORDER BY SUM(PRICE) DESC) AS RK
  FROM SALES
  GROUP BY SELLER_ID
) A
WHERE A.RK = 1;
