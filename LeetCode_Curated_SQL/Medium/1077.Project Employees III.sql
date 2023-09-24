-- 1077.Project Employees III
  
--  Table: Project
--  +-------------+---------+
--  | Column Name | Type    |
--  +-------------+---------+
--  | project_id  | int     |
--  | employee_id | int     |
--  +-------------+---------+
--  (project_id, employee_id) is the primary key of this table.
--  employee_id is a foreign key to Employee table.


--  Table: Employee
--  +------------------+---------+
--  | Column Name      | Type    |
--  +------------------+---------+
--  | employee_id      | int     |
--  | name             | varchar |
--  | experience_years | int     |
--  +------------------+---------+
--  employee_id is the primary key of this table.


--  Write an SQL query that reports the most experienced employees in each project. 
--  In case of a tie, report all employees with the maximum number of experience years.
--  查詢每個專案中最有經驗的員工

--  The query result format is in the following example:
--  Project table:
--  +-------------+-------------+
--  | project_id  | employee_id |
--  +-------------+-------------+
--  | 1           | 1           |
--  | 1           | 2           |
--  | 1           | 3           |
--  | 2           | 1           |
--  | 2           | 4           |
--  +-------------+-------------+

--  Employee table:
--  +-------------+--------+------------------+
--  | employee_id | name   | experience_years |
--  +-------------+--------+------------------+
--  | 1           | Khaled | 3                |
--  | 2           | Ali    | 2                |
--  | 3           | John   | 3                |
--  | 4           | Doe    | 2                |
--  +-------------+--------+------------------+

--  Result table:
--  +-------------+---------------+
--  | project_id  | employee_id   |
--  +-------------+---------------+
--  | 1           | 1             |
--  | 1           | 3             |
--  | 2           | 1             |
--  +-------------+---------------+
--  Both employees with id 1 and 3 have the most experience among the employees of the first project. 
--  id 為 1 和 3 的員工都有第一個項目的員工中最有經驗的
--  For the second project, the employee with id 1 has the most experience.
--  對於第二個項目，id 為 1 的員工最有經驗


-- Solution
WITH RANK_EMP AS (
  SELECT P.PROJECT_ID, E.EMPLOYEE_ID, E.NAME, E.EXPERIENCE_YEARS,
  -- 依照 PROJECT_ID 做資料劃分，並依 EXPERIENCE_YEARS 排名次
  RANK() OVER (PARTITION BY P.PROJECT_ID ORDER BY E.EXPERIENCE_YEARS DESC) RANK_YEAR
  FROM PROJECT P JOIN EMPLOYEE E
  ON P.EMPLOYEE_ID = E.EMPLOYEE_ID
  ORDER BY P.PROJECT_ID
)
SELECT PROJECT_ID, EMPLOYEE_ID
-- 查詢各專案年資第一名的員工
FROM RANK_EMP WHERE RANK_YEAR = 1;

