-- 1270.All People Report to the Given Manager

-- Table: Employees
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | employee_id   | int     |
-- | employee_name | varchar |
-- | manager_id    | int     |
-- +---------------+---------+
-- employee_id is the primary key for this table.
-- Each row of this table indicates that the employee with ID employee_id and name employee_name reports his
-- work to his/her direct manager with manager_id
-- The head of the company is the employee with employee_id = 1.
-- 該表的每一行表示ID為 employee_id 且名稱為 employee_name 的員工向他/她的直接經理報告其工作，其經理為manager_id
-- 公司負責人是 employee_id=1 的員工

-- Write an SQL query to find employee_id of all employees that directly or indirectly report their work to the head of the company.
-- 查詢直接或間接向公司負責人報告其工作的所有員工的 employee_id

-- The indirect relation between managers will not exceed 3 managers as the company is small.
-- Return result table in any order without duplicates.
-- 由於公司規模較小，經理之間的間接關係"不會超過3名經理"
-- 以任何順序返回結果表，沒有重複。

-- Employees table:
-- +-------------+---------------+------------+
-- | employee_id | employee_name | manager_id |
-- +-------------+---------------+------------+
-- | 1           | Boss          | 1          |
-- | 3           | Alice         | 3          |
-- | 2           | Bob           | 1          |
-- | 4           | Daniel        | 2          |
-- | 7           | Luis          | 4          |
-- | 8           | Jhon          | 3          |
-- | 9           | Angela        | 8          |
-- | 77          | Robert        | 1          |
-- +-------------+---------------+------------+


-- The query result format is in the following example:
-- Result table:
-- +-------------+
-- | employee_id |
-- +-------------+
-- | 2           |
-- | 77          |
-- | 4           |
-- | 7           |
-- +-------------+

-- The head of the company is the employee with employee_id 1.
-- The employees with employee_id 2 and 77 report their work directly to the head of the company.
-- The employee with employee_id 4 report his work indirectly to the head of the company 4 --> 2 --> 1. 
-- The employee with employee_id 7 report his work indirectly to the head of the company 7 --> 4 --> 2 --> 1.
-- The employees with employee_id 3, 8 and 9 don't report their work to head of company directly or indirectly.

-- 公司的負責人是 employee_id 為 1 的員工
-- employee_id 為 2 和 77 的員工直接向公司負責人報告工作
-- employee_id 為 4 的員工將其工作間接報告給公司負責人 4 -> 2 -> 1
-- employee_id 為 7 的員工將其工作間接報告給公司負責人 7 -> 4 -> 2 -> 1
-- employee_id 為 3、8 和 9 的員工不會直接或間接向公司負責人報告工作


-- Solution one
WITH LEVEL_1 AS (
  -- 找出(1)的直接下屬(2,77)
  SELECT EMPLOYEE_ID FROM EMPLOYEES
  WHERE MANAGER_ID = 1
  AND EMPLOYEE_ID <> 1
),
LEVEL_2 AS (
  -- 找出(2,77)的直接下屬(4)
  SELECT A.EMPLOYEE_ID FROM EMPLOYEES A
  JOIN LEVEL_1 B
  ON A.MANAGER_ID = B.EMPLOYEE_ID
),
LEVEL_3 AS (
  -- 找出(4)的直接下屬(7)
  SELECT A.EMPLOYEE_ID FROM EMPLOYEES A
  JOIN LEVEL_2 B
  ON A.MANAGER_ID = B.EMPLOYEE_ID
)
SELECT * FROM LEVEL_1
UNION
SELECT * FROM LEVEL_2
UNION
SELECT * FROM LEVEL_3;

-- Solution two
SELECT E1.EMPLOYEE_ID FROM EMPLOYEES E1 
JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID
JOIN EMPLOYEES E3 ON E2.MANAGER_ID = E3.EMPLOYEE_ID
WHERE E3.MANAGER_ID = 1 AND E1.EMPLOYEE_ID != 1;


SELECT E1.* ,E2.* ,E3.* 
FROM EMPLOYEES E1
-- 找出每個員工自已的上一層主管
LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID
LEFT JOIN EMPLOYEES E3 ON E2.MANAGER_ID = E3.EMPLOYEE_ID
--WHERE E3.MANAGER_ID = 1 AND E1.EMPLOYEE_ID != 1
ORDER BY E1.EMPLOYEE_ID;

SELECT E1.* ,E2.*, E3.*
FROM EMPLOYEES E1
-- 找出每個員工自已的下一層員工
RIGHT JOIN EMPLOYEES E2 ON E1.EMPLOYEE_ID = E2.MANAGER_ID
RIGHT JOIN EMPLOYEES E3 ON E2.EMPLOYEE_ID = E3.MANAGER_ID
-- WHERE E1.MANAGER_ID = 1 AND E3.EMPLOYEE_ID != 1
ORDER BY E3.EMPLOYEE_ID;


-- ORA-01436: CONNECT BY loop in user data
-- 編號1號員工的經理就是自已所以造成無窮迴圈連接
SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID != 1
START WITH EMPLOYEE_ID = 1
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID;