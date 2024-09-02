-- 1112.Highest Grade For Each Student 每個學生的最高成績

--  Table: Enrollments (招生人數)
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | student_id    | int     |
--  | course_id     | int     |
--  | grade         | int     |
--  +---------------+---------+
--  (student_id, course_id) is the primary key of this table.

--  Write a SQL query to find the "highest grade" with its corresponding course for each student. 
--  查找每個學生的最高成績及其對應課程
--  In case of a tie, you should find the course with the smallest course_id.
--  如果最高成績相同則，輸出課程編號course_id最小的課程
--  The output must be sorted by increasing student_id.
--  查詢結果按照student_id升序排列

--  The query result format is in the following example:
--  Enrollments table:
--  +------------+-------------------+
--  | student_id | course_id | grade |
--  +------------+-----------+-------+
--  | 2          | 2         | 95    |
--  | 2          | 3         | 95    |
--  | 1          | 1         | 90    |
--  | 1          | 2         | 99    |
--  | 3          | 1         | 80    |
--  | 3          | 2         | 75    |
--  | 3          | 3         | 82    |
--  +------------+-----------+-------+

--  Result table:
--  +------------+-------------------+
--  | student_id | course_id | grade |
--  +------------+-----------+-------+
--  | 1          | 2         | 99    |
--  | 2          | 2         | 95    |
--  | 3          | 3         | 82    |
--  +------------+-----------+-------+


-- Solution
-- 使用RANK函數依照STUDENT_ID學生編號將資料劃分
-- 再依GRADE成績分數降幕排序、COURSE_ID課程編號升幕排序
-- 使用子查詢篩選出每位學生排名第一的資料列，最後按STUDENT_ID學生編號升幕排序
WITH T AS (
  SELECT STUDENT_ID, COURSE_ID, GRADE,
  RANK() OVER (PARTITION BY STUDENT_ID ORDER BY GRADE DESC, COURSE_ID) GRADE_RANK
  FROM ENROLLMENTS
)
SELECT STUDENT_ID, COURSE_ID, GRADE
FROM T WHERE GRADE_RANK = 1
ORDER BY STUDENT_ID;

