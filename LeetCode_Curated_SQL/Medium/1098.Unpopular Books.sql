-- 1098.Unpopular Books 冷門書籍

--  Table: Books
--  +----------------+---------+
--  | Column Name    | Type    |
--  +----------------+---------+
--  | book_id        | int     |
--  | name           | varchar |
--  | available_from | date    |
--  +----------------+---------+
--  book_id is the primary key of this table.

--  Table: Orders
--  +----------------+---------+
--  | Column Name    | Type    |
--  +----------------+---------+
--  | order_id       | int     |
--  | book_id        | int     |
--  | quantity       | int     |
--  | dispatch_date  | date    |
--  +----------------+---------+
--  order_id is the primary key of this table.
--  book_id is a foreign key to the Books table.

--  Write an SQL query that reports the books that have sold less than 10 copies in the last year, 
--  excluding books that have been available for less than 1 month from today. Assume today is 2019-06-23.
--  假設今天是 '2019年6月23日' 找出 "去年銷量" "少於10本" 的書籍編號及名稱
--  注意：排除"(上市時間)小於一個月"的書籍

--  The query result format is in the following example:

--  Books table:
--  +---------+--------------------+----------------+
--  | book_id | name               | available_from |
--  +---------+--------------------+----------------+
--  | 1       | "Kalila And Demna" | 2010-01-01     |
--  | 2       | "28 Letters"       | 2012-05-12     |
--  | 3       | "The Hobbit"       | 2019-06-10     |
--  | 4       | "13 Reasons Why"   | 2019-06-01     |
--  | 5       | "The Hunger Games" | 2008-09-21     |
--  +---------+--------------------+----------------+

--  Orders table:
--  +----------+---------+----------+---------------+
--  | order_id | book_id | quantity | dispatch_date |
--  +----------+---------+----------+---------------+
--  | 1        | 1       | 2        | 2018-07-26    |
--  | 2        | 1       | 1        | 2018-11-05    |
--  | 3        | 3       | 8        | 2019-06-11    |
--  | 4        | 4       | 6        | 2019-06-05    |
--  | 5        | 4       | 5        | 2019-06-20    |
--  | 6        | 5       | 9        | 2009-02-02    |
--  | 7        | 5       | 8        | 2010-04-13    |
--  +----------+---------+----------+---------------+

--  Result table:
--  +-----------+--------------------+
--  | book_id   | name               |
--  +-----------+--------------------+
--  | 1         | "Kalila And Demna" |
--  | 2         | "28 Letters"       |
--  | 5         | "The Hunger Games" |
--  +-----------+--------------------+


-- Solution
-- Note:書籍訂單日期不在去年的，等同去年銷量為0
-- 因此不能直接將書籍及訂單表格做 join(會將去年以前的也刪除掉)

-- SELECT B.BOOK_ID, NAME, QUANTITY, DISPATCH_DATE FROM (
SELECT B.BOOK_ID, NAME FROM (
  -- 排除上市時間小於一個月的書籍 '2019-05-23'
  SELECT *
  FROM BOOKS
  WHERE AVAILABLE_FROM < TO_DATE('2019-06-23','YYYY-mm-DD') - INTERVAL '1' MONTH
) B LEFT JOIN (
  -- "過去一年內"的訂單 '2018-06-23'
  SELECT *
  FROM ORDERS
  WHERE DISPATCH_DATE > TO_DATE('2019-06-23','YYYY-mm-DD') - INTERVAL '1' YEAR
) A
ON A.BOOK_ID = B.BOOK_ID
GROUP BY B.BOOK_ID, NAME
-- 銷量少於10本
HAVING NVL(SUM(QUANTITY),0) < 10
ORDER BY B.BOOK_ID;

-- SELECT SYSDATE  - INTERVAL '1' DAY FROM DUAL;

-- MySQL
SELECT BOOK_ID, NAME FROM BOOKS 
WHERE AVAILABLE_FROM < DATE_SUB("2019-06-23", INTERVAL 1 MONTH)
AND BOOK_ID NOT IN (
  SELECT DISTINCT BOOK_ID FROM ORDERS
  WHERE DISPATCH_DATE > DATE_SUB("2019-06-23", INTERVAL 1 YEAR)
  GROUP BY BOOK_ID
  HAVING SUM(QUANTITY) >= 10
);
