-- 1303.Find the Team Size 查詢團隊人數

-- Table: Employee
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | employee_id   | int     |
-- | team_id       | int     |
-- +---------------+---------+
-- employee_id is the primary key for this table.
-- Each row of this table contains the ID of each employee and their respective team.
-- 每一行包含每個員工及其各自團隊的ID
-- Write an SQL query to find the team size of each of the employees.
-- 查找每個員工的團隊規模

-- Return result table in any order.

-- The query result format is in the following example:

-- Employee Table:
-- +-------------+------------+
-- | employee_id | team_id    |
-- +-------------+------------+
-- |     1       |     8      |
-- |     2       |     8      |
-- |     3       |     8      |
-- |     4       |     7      |
-- |     5       |     9      |
-- |     6       |     9      |
-- +-------------+------------+

-- Result table:
-- +-------------+------------+
-- | employee_id | team_size  |
-- +-------------+------------+
-- |     1       |     3      |
-- |     2       |     3      |
-- |     3       |     3      |
-- |     4       |     1      |
-- |     5       |     2      |
-- |     6       |     2      |
-- +-------------+------------+
-- Employees with Id 1,2,3 are part of a team with team_id = 8.
-- ID為 1,2,3 員工是與 TEAM_ID = 8 團隊的一部分
-- Employees with Id 4 is part of a team with team_id = 7.
-- ID 4 員工與 TEAM_ID = 7 團隊的一部分。
-- Employees with Id 5,6 are part of a team with team_id = 9.
-- 用編號 5,6 員工與 TEAM_ID = 9 團隊的一部分。


-- Solution
-- 內查詢透過TEAM_ID團隊編號資料分群並且計算EMPLOYEE_ID的數量
-- 在與原先的EMPLOYEE員工資料表透過TEAM_ID團隊編號做關聯，列出每個員所屬團隊數量
SELECT EMPLOYEE_ID, B.TEAM_SIZE
FROM EMPLOYEE E JOIN (
  SELECT TEAM_ID, COUNT(EMPLOYEE_ID) AS TEAM_SIZE
  FROM EMPLOYEE
  GROUP BY TEAM_ID
) B
ON E.TEAM_ID = B.TEAM_ID
ORDER BY EMPLOYEE_ID;
