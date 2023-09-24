-- 1445.Apples & Oranges

-- Table: Sales
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | sale_date     | date    |
-- | fruit         | enum    | 
-- | sold_num      | int     | 
-- +---------------+---------+
-- (sale_date,fruit) is the primary key for this table.
-- This table contains the sales of "apples" and "oranges" sold each day.
-- 該表包含每天售出的"蘋果"和"橙子"的數量

-- Write an SQL query to report the difference between number of apples and oranges sold each day.
-- Return the result table ordered by sale_date in format ('YYYY-MM-DD').
-- 查詢以報告每天售出的蘋果和橙子數量之間的差異，結果按照返sale_date升序排序

-- Sales table:
-- +------------+------------+-------------+
-- | sale_date  | fruit      | sold_num    |
-- +------------+------------+-------------+
-- | 2020-05-01 | apples     | 10          |
-- | 2020-05-01 | oranges    | 8           |
-- | 2020-05-02 | apples     | 15          |
-- | 2020-05-02 | oranges    | 15          |
-- | 2020-05-03 | apples     | 20          |
-- | 2020-05-03 | oranges    | 0           |
-- | 2020-05-04 | apples     | 15          |
-- | 2020-05-04 | oranges    | 16          |
-- +------------+------------+-------------+

-- The query result format is in the following example:
-- Result table:
-- +------------+--------------+
-- | sale_date  | diff         |
-- +------------+--------------+
-- | 2020-05-01 | 2            |
-- | 2020-05-02 | 0            |
-- | 2020-05-03 | 20           |
-- | 2020-05-04 | -1           |
-- +------------+--------------+
-- Day 2020-05-01, 10 apples and 8 oranges were sold (Difference  10 - 8 = 2).
-- Day 2020-05-02, 15 apples and 15 oranges were sold (Difference 15 - 15 = 0).
-- Day 2020-05-03, 20 apples and 0 oranges were sold (Difference 20 - 0 = 20).
-- Day 2020-05-04, 15 apples and 16 oranges were sold (Difference 15 - 16 = -1).


-- Solution
SELECT SA.SALE_DATE, (SA.SOLD_NUM - SO.SOLD_NUM) DIFF
FROM (
  -- 查詢'apples'出售日、售價
  SELECT SALE_DATE, SOLD_NUM
  FROM SALES
  WHERE FRUIT = 'apples'
) SA LEFT JOIN (
  -- 查詢'oranges'出售日、售價
  SELECT SALE_DATE, SOLD_NUM
  FROM SALES
  WHERE FRUIT = 'oranges'
)SO
-- 依出售日連接join
ON SA.SALE_DATE = SO.SALE_DATE
ORDER BY SA.SALE_DATE;
