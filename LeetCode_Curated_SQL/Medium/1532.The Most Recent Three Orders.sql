-- 1532.The Most Recent Three Orders 最近期的三筆訂單

--  Table: Customers
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | customer_id   | int     |
--  | name          | varchar |
--  +---------------+---------+
--  customer_id is the primary key for this table.
--  This table contains information about customers.
--  該表包含有關客戶的資訊


--  Table: Orders
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | order_id      | int     |
--  | order_date    | date    |
--  | customer_id   | int     |
--  | cost          | int     |
--  +---------------+---------+
--  order_id is the primary key for this table.
--  This table contains information about the orders made customer_id.
--  表格包含有關所下訂單的 customer_id 的資訊。
--  Each customer has one order per day.
--  每個客戶每天有一個訂單

-- Write an SQL query to find the most recent 3 orders of each user. If a user ordered less than 3 orders return all of their orders.
-- 查詢每個用戶的最新的3個訂單。如果用戶訂購的訂單少於3個，則返回其所有訂單。

-- Return the result table sorted by customer_name in ascending order and in case of a tie by the customer_id in ascending order. 
-- If there still a tie, order them by the order_date in descending order.
-- 查詢結果按customer_name 升序排序；如果出現相同則按customer_id 升序排序。如果仍然有相同，則按order_date 降序排序。

--  Customers
--  +-------------+-----------+
--  | customer_id | name      |
--  +-------------+-----------+
--  | 1           | Winston   |
--  | 2           | Jonathan  |
--  | 3           | Annabelle |
--  | 4           | Marwan    |
--  | 5           | Khaled    |
--  +-------------+-----------+

--  Orders
--  +----------+------------+-------------+------+
--  | order_id | order_date | customer_id | cost |
--  +----------+------------+-------------+------+
--  | 1        | 2020-07-31 | 1           | 30   |
--  | 2        | 2020-07-30 | 2           | 40   |
--  | 3        | 2020-07-31 | 3           | 70   |
--  | 4        | 2020-07-29 | 4           | 100  |
--  | 5        | 2020-06-10 | 1           | 1010 |
--  | 6        | 2020-08-01 | 2           | 102  |
--  | 7        | 2020-08-01 | 3           | 111  |
--  | 8        | 2020-08-03 | 1           | 99   |
--  | 9        | 2020-08-07 | 2           | 32   |
--  | 10       | 2020-07-15 | 1           | 2    |
--  +----------+------------+-------------+------+

--  The query result format is in the following example:
--  Result table:
--  +---------------+-------------+----------+------------+
--  | customer_name | customer_id | order_id | order_date |
--  +---------------+-------------+----------+------------+
--  | Annabelle     | 3           | 7        | 2020-08-01 |
--  | Annabelle     | 3           | 3        | 2020-07-31 |
--  | Jonathan      | 2           | 9        | 2020-08-07 |
--  | Jonathan      | 2           | 6        | 2020-08-01 |
--  | Jonathan      | 2           | 2        | 2020-07-30 |
--  | Marwan        | 4           | 4        | 2020-07-29 |
--  | Winston       | 1           | 8        | 2020-08-03 |
--  | Winston       | 1           | 1        | 2020-07-31 |
--  | Winston       | 1           | 10       | 2020-07-15 |
--  +---------------+-------------+----------+------------+
--  Winston has 4 orders, we discard the order of "2020-06-10" because it is the oldest order.
--  Annabelle has only 2 orders, we return them.
--  Jonathan has exactly 3 orders.
--  Marwan ordered only one time.
--  We sort the result table by customer_name in ascending order, by customer_id in ascending order and by order_date in descending order in case of a tie.
--  Winston 有 4 筆訂單, 排除了 "2020-06-10" 的訂單, 因為它是最老的訂單。
--  Annabelle 只有 2 筆訂單, 全部返回。
--  Jonathan 恰好有 3 筆訂單。
--  Marwan 只有 1 筆訂單。
--  結果表我們按照 customer_name 升序排列，customer_id 升序排列，order_date 降序排列。


-- Solution
-- CUSTOMERS顧客資料表與ORDERS訂單資料表，並透過CUSTOMER_ID顧客編號欄位關聯查詢
-- 使用RANK函式並依照CUSTOMER_ID做資料劃分,並按照ORDER_DATE排序名次
-- 篩選每個顧客的近三筆訂單
WITH T AS (
  SELECT C.NAME, C.CUSTOMER_ID , O.ORDER_ID, O.ORDER_DATE,	  
	  RANK() OVER (PARTITION BY C.CUSTOMER_ID ORDER BY O.ORDER_DATE DESC) ORDE_RANK
  FROM CUSTOMERS C JOIN ORDERS O
  ON C.CUSTOMER_ID = O.CUSTOMER_ID
  ORDER BY C.NAME, C.CUSTOMER_ID, O.ORDER_DATE DESC
)
SELECT NAME CUSTOMER_NAME, CUSTOMER_ID, ORDER_ID, ORDER_DATE
FROM T
WHERE ORDE_RANK <= 3;

