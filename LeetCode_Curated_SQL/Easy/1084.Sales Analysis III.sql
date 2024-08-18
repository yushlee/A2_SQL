-- 1084.Sales Analysis III

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
 

-- Write an SQL query that reports the products that were only sold in spring 2019.
-- 查詢僅在2019年春季銷售的產品
-- That is, between 2019-01-01 and 2019-03-31 inclusive.
-- 日期區間在 '2019-01-01' 和 '2019-03-31' 之間

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
-- +-------------+--------------+
-- | product_id  | product_name |
-- +-------------+--------------+
-- | 1           | S8           |
-- +-------------+--------------+
-- The product with id 1 was only sold in spring 2019 while the other two were sold after.
-- ID為1的產品'僅在'2019年春季銷售，而其它兩個產品則在之後有銷售紀錄


-- Solution
-- 外查詢:查詢銷售日介於'2019-01-01'和'2019-03-31'之間銷售的產品編號(1、2)
SELECT S1.PRODUCT_ID, P.PRODUCT_NAME, S1.SALE_DATE 
FROM SALES S1 JOIN PRODUCT P 
ON S1.PRODUCT_ID = P.PRODUCT_ID
WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'
-- 查詢不存在於非介於'2019-01-01'和'2019-03-31'之間銷售的產品編號(1)
AND NOT EXISTS (
  -- 內查詢:查詢銷售日非介於'2019-01-01'和'2019-03-31'之間銷售的產品編號(2、3)
  SELECT S.PRODUCT_ID, S.SALE_DATE
  FROM SALES S
  WHERE S.SALE_DATE NOT BETWEEN '2019-01-01' AND '2019-03-31'
  -- 將內外查詢關聯查詢出不存在於內查詢中的產品編號
  AND S1.PRODUCT_ID = S.PRODUCT_ID
);
