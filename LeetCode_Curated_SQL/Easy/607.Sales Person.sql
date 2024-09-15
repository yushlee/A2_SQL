-- 607.Sales Person
-- Given three tables: SALESPERSON, COMPANY, ORDERS.
-- 給出三個表：銷售員、公司、訂單
-- Output all the names in the table salesperson, who didn’t have sales to company 'RED'.
-- 找出沒有向公司RED賣過東西的銷售員

-- Example
-- Input

-- Table: salesperson
-- The table salesperson holds the salesperson information. Every salesperson has a sales_id and a name.
-- +----------+------+--------+-----------------+-----------+
-- | sales_id | name | salary | commission_rate | hire_date |
-- +----------+------+--------+-----------------+-----------+
-- |   1      | John | 100000 |     6           | 4/1/2006  |
-- |   2      | Amy  | 120000 |     5           | 5/1/2010  |
-- |   3      | Mark | 65000  |     12          | 12/25/2008|
-- |   4      | Pam  | 25000  |     25          | 1/1/2005  |
-- |   5      | Alex | 50000  |     10          | 2/3/2007  |
-- +----------+------+--------+-----------------+-----------+


-- Table: company
-- The table company holds the company information. Every company has a com_id and a name.
-- +---------+--------+------------+
-- | com_id  |  name  |    city    |
-- +---------+--------+------------+
-- |   1     |  RED   |   Boston   |
-- |   2     | ORANGE |   New York |
-- |   3     | YELLOW |   Boston   |
-- |   4     | GREEN  |   Austin   |
-- +---------+--------+------------+


-- Table: orders
-- The table orders holds the sales record information, salesperson and customer company are represented by sales_id and com_id.

-- +----------+------------+---------+----------+--------+
-- | order_id | order_date | com_id  | sales_id | amount |
-- +----------+------------+---------+----------+--------+
-- | 1        |   1/1/2014 |    3    |    4     | 100000 |
-- | 2        |   2/1/2014 |    4    |    5     | 5000   |
-- | 3        |   3/1/2014 |    1    |    1     | 50000  |
-- | 4        |   4/1/2014 |    1    |    4     | 25000  |
-- +----------+----------+---------+----------+--------+


-- output

-- +------+
-- | name | 
-- +------+
-- | Amy  | 
-- | Mark | 
-- | Alex |
-- +------+

-- Explanation
-- According to order '3' and '4' in table orders, it is easy to tell only salesperson 'John' and 'Pam' have sales to company 'RED',
-- 根據表格訂單中的訂單 '3' 和 '4'，很容易知道僅銷售人員 "John" 和 "Pam" 對 "RED" 公司有銷售
-- so we need to output all the other names in the table salesperson.
-- 因此我們需要在表銷售人員中輸出所有其他銷售人員名稱


-- Solution
-- 解題說明:
-- 先找出所有訂單(ORDERS)有銷售過RED公司(COMPANY)的銷售員(SALES_ID)
-- 最後從SALESPERSON找出"不存在於"(NOT IN)銷售過RED公司的銷售員姓名

SELECT SALES_ID, NAME
FROM SALESPERSON
-- 不存在於 NOT IN 銷售RED公司訂單的銷售人員
WHERE SALES_ID NOT IN (
  -- 找出所有有銷售RED公司訂單的銷售人員
  SELECT DISTINCT SALES_ID
  FROM ORDERS
  WHERE COM_ID IN (
    SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'
  )
);

