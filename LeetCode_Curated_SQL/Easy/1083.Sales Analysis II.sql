-- 1083.Sales Analysis II

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
 

-- Write an SQL query that reports the buyers who have bought 'S8' but not 'iPhone'.
-- 查詢已購買S8但未購買iPhone的買家
-- Note that S8 and iPhone are products present in the Product table.
-- 請注意，S8 和 iPhone 是產品表中存在的產品

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
-- | 2         | 1          | 3        | 2019-06-02 | 1        | 800   |
-- | 3         | 3          | 3        | 2019-05-13 | 2        | 2800  |
-- +-----------+------------+----------+------------+----------+-------+

-- Result table:
-- +-------------+
-- | buyer_id    |
-- +-------------+
-- | 1           |
-- +-------------+
-- The buyer with id 1 bought an S8 but didn't buy an iPhone. The buyer with id 3 bought both.
-- ID為1的買家購買了S8但沒有購買的iPhone。編號為3的買家同時購買了兩者。


-- Solution
-- 查詢有購買產品S8的購買者，查詢有購買產品iPhone的購買者
-- 最後再查詢有購買S8的購買者不在於"NOT IN"有購買產品iPhone的購買者
-- 外查詢:購買'S8'購買者1、3
SELECT DISTINCT S1.BUYER_ID, P.PRODUCT_ID, P.PRODUCT_NAME
FROM SALES S1 JOIN PRODUCT P
ON S1.PRODUCT_ID = P.PRODUCT_ID
WHERE P.PRODUCT_NAME = 'S8'
-- 有購買S8的購買者不在於"NOT IN"有購買產品iPhone的購買者
AND S1.BUYER_ID NOT IN (
  -- 內查詢:購買'iPhone'購買者3
  SELECT S.BUYER_ID
  FROM SALES S JOIN PRODUCT P
  ON S.PRODUCT_ID = P.PRODUCT_ID
  WHERE P.PRODUCT_NAME = 'iPhone'
);


SELECT DISTINCT A.BUYER_ID
FROM SALES A JOIN PRODUCT B
ON A.PRODUCT_ID = B.PRODUCT_ID
WHERE 
A.BUYER_ID IN (SELECT A.BUYER_ID FROM SALES A JOIN PRODUCT B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'S8') 
AND
A.BUYER_ID NOT IN (SELECT A.BUYER_ID FROM SALES A JOIN PRODUCT B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'iPhone');
