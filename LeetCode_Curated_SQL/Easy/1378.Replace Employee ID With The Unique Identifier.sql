-- 1378.Replace Employee ID With The Unique Identifier
-- 用唯一的識別替換員工ID

-- Table: Employees
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key for this table.
-- Each row of this table contains the id and the name of an employee in a company.
-- 表格的每一行包含公司中員工的 ID 和姓名

-- Table: EmployeeUNI
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | unique_id     | int     |
-- +---------------+---------+
-- (id, unique_id) is the primary key for this table.
-- Each row of this table contains the id and the corresponding unique id of an employee in the company.
-- 表格的每一行包含公司中員工的 id 和對應的唯一 id

-- Write an SQL query to show the unique ID of each user, If a user doesn't have a unique ID replace just show null.
-- Return the result table in any order.
-- 查詢以顯示每個用戶的unique ID，如果用戶沒有unique ID，則替換為null，以任何順序返回結果表。

-- Employees table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 1  | Alice    |
-- | 7  | Bob      |
-- | 11 | Meir     |
-- | 90 | Winston  |
-- | 3  | Jonathan |
-- +----+----------+


-- EmployeeUNI table:
-- +----+-----------+
-- | id | unique_id |
-- +----+-----------+
-- | 3  | 1         |
-- | 11 | 2         |
-- | 90 | 3         |
-- +----+-----------+

-- The query result format is in the following example:
-- +-----------+----------+
-- | unique_id | name     |
-- +-----------+----------+
-- | null      | Alice    |
-- | null      | Bob      |
-- | 2         | Meir     |
-- | 3         | Winston  |
-- | 1         | Jonathan |
-- +-----------+----------+
-- Alice and Bob don't have a unique ID, We will show null instead.
-- The unique ID of Meir is 2.
-- The unique ID of Winston is 3.
-- The unique ID of Jonathan is 1.


-- Solution
-- 以EMPLOYEES員工資料表為主使用LEFT JOIN左外側連接
-- 查詢EMPLOYEEUNI員工識別編號資料表UNIQUE_ID識別編號、員工資料表員工姓名NAME
SELECT U.UNIQUE_ID, E.NAME
FROM EMPLOYEES E LEFT JOIN EMPLOYEEUNI U
ON E.ID = U.ID
ORDER BY E.ID;
