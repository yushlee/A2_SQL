-- 1076.Project Employees II


-- Table: Project
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | project_id  | int     |
-- | employee_id | int     |
-- +-------------+---------+
-- (project_id, employee_id) is the primary key of this table.
-- employee_id is a foreign key to Employee table.


-- Table: Employee
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | employee_id      | int     |
-- | name             | varchar |
-- | experience_years | int     |
-- +------------------+---------+
-- employee_id is the primary key of this table.
 

-- Write an SQL query that reports all the projects that have the most employees.
-- 查詢擁有最多員工的專案項目

-- The query result format is in the following example:

-- Project table:
-- +-------------+-------------+
-- | project_id  | employee_id |
-- +-------------+-------------+
-- | 1           | 1           |
-- | 1           | 2           |
-- | 1           | 3           |
-- | 2           | 1           |
-- | 2           | 4           |
-- +-------------+-------------+

-- Employee table:
-- +-------------+--------+------------------+
-- | employee_id | name   | experience_years |
-- +-------------+--------+------------------+
-- | 1           | Khaled | 3                |
-- | 2           | Ali    | 2                |
-- | 3           | John   | 1                |
-- | 4           | Doe    | 2                |
-- +-------------+--------+------------------+

-- Result table:
-- +-------------+
-- | project_id  |
-- +-------------+
-- | 1           |
-- +-------------+
-- The first project has 3 employees while the second one has 2.
-- 第一個項目有3名員工，而第二個項目有2名員工


-- Solution
-- 依專案編號為資料分群，透過RNAK函數將 COUNT EMPLOYEE_ID 的數量降幕排序排名
-- 最後在取專案員工數量排名第一的專案編號
SELECT A.PROJECT_ID
FROM (
  -- 依專案為群組 COUNT EMPLOYEE_ID 的數量並排名
  SELECT PROJECT_ID,
  COUNT(EMPLOYEE_ID),
  RANK() OVER(ORDER BY COUNT(EMPLOYEE_ID) DESC) AS RK
  FROM project
  GROUP BY PROJECT_ID
) A
-- 只查排名第一的最多員工數量的專案
WHERE A.RK = 1;
