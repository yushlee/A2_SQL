-- 1075.Project Employees I

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
 

-- Write an SQL query that reports the average experience years 
-- of all the employees for each project, rounded to 2 digits.
-- 查詢每個專案項目的所有員工的平均工作經驗年限，四捨五入到2位數字。

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
-- +-------------+---------------+
-- | project_id  | average_years |
-- +-------------+---------------+
-- | 1           | 2.00          |
-- | 2           | 2.50          |
-- +-------------+---------------+
-- The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00 
-- and for the second project is (3 + 2) / 2 = 2.50


-- Solution
-- 先將專案資料表與員工資料表透過員工編號關聯，再使用專案編號做資料群組
-- 並且將員工工作經驗年限做AVG平均且四捨五入到2位數字。
SELECT P.PROJECT_ID, ROUND(AVG(E.EXPERIENCE_YEARS),2) AS AVERAGE_YEARS
FROM PROJECT P JOIN EMPLOYEE E
ON P.EMPLOYEE_ID = E.EMPLOYEE_ID
GROUP BY P.PROJECT_ID;

