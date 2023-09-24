-- 1511.Customer Order Frequency

--  Table: Customers
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | customer_id   | int     |
--  | name          | varchar |
--  | country       | varchar |
--  +---------------+---------+
--  customer_id is the primary key for this table.
--  This table contains information of the customers in the company.
--  
--  Table: Product
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | product_id    | int     |
--  | description   | varchar |
--  | price         | int     |
--  +---------------+---------+
--  product_id is the primary key for this table.
--  This table contains information of the products in the company.
--  price is the product cost.
--  
--  
--  
--  Table: Orders
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | order_id      | int     |
--  | customer_id   | int     |
--  | product_id    | int     |
--  | order_date    | date    |
--  | quantity      | int     |
--  +---------------+---------+
--  order_id is the primary key for this table.
--  This table contains information on customer orders.
--  customer_id is the id of the customer who bought "quantity" products with id "product_id".
--  customer_id 是購買了 ID 為 "product_id" 的 "數量" 產品的客戶的 ID
--  Order_date is the date in format ('YYYY-MM-DD') when the order was shipped.
--  Order_date 是訂單出貨時格式 ('YYYY-MM-DD') 的日期。

-- Write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 in each month of June and July 2020.
-- 2020年 6月 和 7月 的每個月至少花費 100 美元的客戶的 customer_id 和 customer_name

--  Return the result table in any order.

--  The query result format is in the following example.
--  Customers
--  +--------------+-----------+-------------+
--  | customer_id  | name      | country     |
--  +--------------+-----------+-------------+
--  | 1            | Winston   | USA         |
--  | 2            | Jonathan  | Peru        |
--  | 3            | Moustafa  | Egypt       |
--  +--------------+-----------+-------------+

--  Product
--  +--------------+-------------+-------------+
--  | product_id   | description | price       |
--  +--------------+-------------+-------------+
--  | 10           | LC Phone    | 300         |
--  | 20           | LC T-Shirt  | 10          |
--  | 30           | LC Book     | 45          |
--  | 40           | LC Keychain | 2           |
--  +--------------+-------------+-------------+

--  Orders
--  +--------------+-------------+-------------+-------------+-----------+
--  | order_id     | customer_id | product_id  | order_date  | quantity  |
--  +--------------+-------------+-------------+-------------+-----------+
--  | 1            | 1           | 10          | 2020-06-10  | 1         |
--  | 2            | 1           | 20          | 2020-07-01  | 1         |
--  | 3            | 1           | 30          | 2020-07-08  | 2         |
--  | 4            | 2           | 10          | 2020-06-15  | 2         |
--  | 5            | 2           | 40          | 2020-07-01  | 10        |
--  | 6            | 3           | 20          | 2020-06-24  | 2         |
--  | 7            | 3           | 30          | 2020-06-25  | 2         |
--  | 9            | 3           | 30          | 2020-05-08  | 3         |
--  +--------------+-------------+-------------+-------------+-----------+

--  Result table:
--  +--------------+------------+
--  | customer_id  | name       |  
--  +--------------+------------+
--  | 1            | Winston    |
--  +--------------+------------+ 
--  Winston spent $300 (300 * 1) in June and $100 ( 10 * 1 + 45 * 2) in July 2020.
--  Jonathan spent $600 (300 * 2) in June and $20 ( 2 * 10) in July 2020.
--  Moustafa spent $110 (10 * 2 + 45 * 2) in June and $0 in July 2020.


-- Solution
SELECT CUSTOMER_ID, NAME FROM CUSTOMERS
WHERE CUSTOMER_ID IN (
  SELECT A.CUSTOMER_ID 
  FROM ORDERS A JOIN PRODUCT B  
  ON A.PRODUCT_ID = B.PRODUCT_ID
  WHERE A.ORDER_DATE BETWEEN '2020-06-01' AND '2020-06-30'
  GROUP BY A.CUSTOMER_ID
  HAVING SUM(A.QUANTITY * B.PRICE) >= 100
)
AND CUSTOMER_ID IN (
  SELECT A.CUSTOMER_ID 
  FROM ORDERS A JOIN PRODUCT B  
  ON A.PRODUCT_ID = B.PRODUCT_ID
  WHERE A.ORDER_DATE BETWEEN '2020-07-01' AND '2020-07-31'
  GROUP BY A.CUSTOMER_ID
  HAVING SUM(A.QUANTITY * B.PRICE) >= 100
);
