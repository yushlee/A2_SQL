-- 1350.Students With Invalid Departments 已不存在的科系中的學生

-- Table: Departments
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about the id of each department of a university.
-- 該表包含有關大學每個系的 ID 的資訊


-- Table: Students
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- | department_id | int     |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about the id of each student at a university and the id of the department he/she studies at.
-- 表格包含有關大學中每個學生的 id 以及他/她就讀的系所 id 的資訊。

-- Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exists.
-- 查找已不存在的系中所有已註冊學生的ID和名稱。

-- Return the result table in any order.

-- The query result format is in the following example:

-- Departments table:
-- +------+--------------------------+
-- | id   | name                     |
-- +------+--------------------------+
-- | 1    | Electrical Engineering   |
-- | 7    | Computer Engineering     |
-- | 13   | Bussiness Administration |
-- +------+--------------------------+

-- Students table:
-- +------+----------+---------------+
-- | id   | name     | department_id |
-- +------+----------+---------------+
-- | 23   | Alice    | 1             |
-- | 1    | Bob      | 7             |
-- | 5    | Jennifer | 13            |
-- | 2    | John     | 14            |
-- | 4    | Jasmine  | 77            |
-- | 3    | Steve    | 74            |
-- | 6    | Luis     | 1             |
-- | 8    | Jonathan | 7             |
-- | 7    | Daiana   | 33            |
-- | 11   | Madelynn | 1             |
-- +------+----------+---------------+


-- Result table:
-- +------+----------+
-- | id   | name     |
-- +------+----------+
-- | 2    | John     |
-- | 7    | Daiana   |
-- | 4    | Jasmine  |
-- | 3    | Steve    |
-- +------+----------+

-- John, Daiana戴安娜, Steve and Jasmine are enrolled(註冊) in departments 14, 33, 74 and 77 respectively(分別).
-- department 14, 33, 74 and 77 doesn't exist in the Departments table.


-- Solution
-- 透過LEFT JOIN將"全部"學生資料與科系資料表，使用科系編號DEPARTMENT_ID、ID關聯
-- 篩選D.ID IS NULL科系編號為空值，去除右側資料表 DEPARTMENTS 的結果
SELECT S.ID, S.NAME
FROM STUDENTS S LEFT JOIN DEPARTMENTS D
ON S.DEPARTMENT_ID = D.ID
WHERE D.ID IS NULL;
