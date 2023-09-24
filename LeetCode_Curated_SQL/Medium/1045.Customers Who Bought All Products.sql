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
--  購買了所有產品（5 和 6）的客戶是 ID 為 1 和 3 的客戶


-- Solution
SELECT CUSTOMER_ID
FROM CUSTOMER
GROUP BY CUSTOMER_ID
HAVING COUNT(DISTINCT PRODUCT_KEY) = (
  SELECT COUNT(DISTINCT PRODUCT_KEY) FROM PRODUCT
);
