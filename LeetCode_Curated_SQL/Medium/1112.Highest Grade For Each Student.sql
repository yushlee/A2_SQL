-- 1112.Highest Grade For Each Student

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
--  查找每個學生的最高年級及其對應課程
--  In case of a tie, you should find the course with the smallest course_id.
--  如果最高成績相同則，輸出課程編號最小的課程
--  The output must be sorted by increasing student_id.
--  查詢結果按照student_id 升序排列

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
SELECT STUDENT_ID, COURSE_ID, GRADE　
FROM (
  SELECT STUDENT_ID, COURSE_ID, GRADE,
  RANK() OVER (PARTITION BY STUDENT_ID ORDER BY GRADE DESC, COURSE_ID) S_RANK
  FROM ENROLLMENTS
) WHERE　S_RANK = 1;
