-- 586.Customer Placing the Largest Number of Orders
-- 客戶下達最大數量的訂單

-- Query the customer_number from the orders table for the customer who has placed the largest number of orders.
-- 從訂單表中查詢 customer_number，以獲取已下達最大訂單數的客戶。

-- It is guaranteed that exactly one customer will have placed more orders than any other customer.
-- 可以確保恰好有一位客戶下的訂單比其他任何一位客戶都多。

-- Table: Orders 
-- The orders table is defined as follows:
-- | Column            | Type      |
-- |-------------------|-----------|
-- | order_number (PK) | int       |
-- | customer_number   | int       |
-- | order_date        | date      |
-- | required_date     | date      |
-- | shipped_date      | date      |
-- | status            | char(15)  |
-- | comment           | char(200) |

-- Sample Input
-- | order_number | customer_number | order_date | required_date | shipped_date | status | comment |
-- |--------------|-----------------|------------|---------------|--------------|--------|---------|
-- | 1            | 1               | 2017-04-09 | 2017-04-13    | 2017-04-12   | Closed |         |
-- | 2            | 2               | 2017-04-15 | 2017-04-20    | 2017-04-18   | Closed |         |
-- | 3            | 3               | 2017-04-16 | 2017-04-25    | 2017-04-20   | Closed |         |
-- | 4            | 3               | 2017-04-18 | 2017-04-28    | 2017-04-25   | Closed |         |

-- Sample Output
-- | customer_number |
-- |-----------------|
-- | 3               |

-- Explanation
-- The customer with number '3' has two orders, 
-- 編號為'3'的客戶有兩個訂單，
-- which is greater than either customer '1' or '2' because each of them only has one order. 
-- 大於客戶'1'或'2'因為他們每個人只有一個訂單。
-- So the result is customer_number '3'.
-- 因此結果是customer_number'3'


-- Solution
-- 解題說明:
-- 先按照"CUSTOMER_NUMBER"資料分群, 並 COUNT CUSTOMER_NUMBER 做RANK函數排名
-- 最後找出排名第一訂單數量最多的顧客

WITH CUS_ORDER_COUNT AS (
  -- 計算每個顧客訂單數
  SELECT CUSTOMER_NUMBER, COUNT(ORDER_NUMBER) ORDER_COUNT
  FROM ORDERS 
  GROUP BY CUSTOMER_NUMBER
)
SELECT * FROM CUS_ORDER_COUNT
WHERE ORDER_COUNT = (
  SELECT MAX(ORDER_COUNT) FROM CUS_ORDER_COUNT
);

-- 利用 RANK COUNT 找出訂單數最多的顧客
WITH T_ORDER_RANK AS (
  SELECT CUSTOMER_NUMBER, COUNT(CUSTOMER_NUMBER),
	RANK() OVER ( ORDER BY COUNT(CUSTOMER_NUMBER) DESC ) AS RK
  FROM ORDERS
  GROUP BY CUSTOMER_NUMBER
)
SELECT CUSTOMER_NUMBER
FROM T_ORDER_RANK
WHERE RK = 1;

