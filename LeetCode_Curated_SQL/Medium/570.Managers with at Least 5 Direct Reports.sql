-- 570.Managers with at Least 5 Direct Reports

--  The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.
--  Employee 表包含所有員工，包括他們的經理。每個員工都有一個 ID，還有一個經理 ID 
--  +------+----------+-----------+----------+
--  |Id    |Name 	    |Department |ManagerId |
--  +------+----------+-----------+----------+
--  |101   |John 	    |A 	        |null      |
--  |102   |Dan 	    |A 	        |101       |
--  |103   |James 	    |A 	        |101       |
--  |104   |Amy 	    |A 	        |101       |
--  |105   |Anne 	    |A 	        |101       |
--  |106   |Ron 	    |B 	        |101       |
--  +------+----------+-----------+----------+
--  Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. 
--  查詢出至少管理5個員工的經理的名稱

--  For the above table, your SQL query should return:
--  +-------+
--  | Name  |
--  +-------+
--  | John  |
--  +-------+
-- Note: No one would report to himself.


-- Solution
WITH LEAST_5_MANAGER AS (
  SELECT MANAGERID, COUNT(ID) EMP_COUNT
  FROM EMPLOYEE
  WHERE MANAGERID IS NOT NULL
  GROUP BY MANAGERID
  HAVING COUNT(ID) >= 5
)
SELECT E.NAME 
FROM EMPLOYEE E JOIN LEAST_5_MANAGER M
ON E.ID = M.MANAGERID;
