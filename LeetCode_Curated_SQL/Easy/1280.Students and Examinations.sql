-- 1280.Students and Examinations 學生與考試

-- Table: Students
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | student_id    | int     |
-- | student_name  | varchar |
-- +---------------+---------+
-- student_id is the primary key for this table.
-- Each row of this table contains the ID and the name of one student in the school.
-- 表格的每一行包含學校一名學生的 ID 和姓名
 

-- Table: Subjects
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | subject_name | varchar |
-- +--------------+---------+
-- subject_name is the primary key for this table.
-- Each row of this table contains the name of one subject in the school.
-- 表格的每一行包含學校一個科目的名稱

-- Table: Examinations
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | student_id   | int     |
-- | subject_name | varchar |
-- +--------------+---------+
-- There is no primary key for this table. It may contain duplicates.
-- Each student from the Students table takes every course from Subjects table.
-- 每個學生都可以從"主題"表中選擇每個課程
-- Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
-- 每一行表示ID為 Student_id 的學生參加了 subject_name 的考試

-- Write an SQL query to find the number of times each student attended each exam.
-- 查找每個學生參加每項考試的次數

-- Order the result table by student_id and subject_name.
-- 按 student_id 和 subject_name 排序

-- The query result format is in the following example:

-- Students table:
-- +------------+--------------+
-- | student_id | student_name |
-- +------------+--------------+
-- | 1          | Alice        |
-- | 2          | Bob          |
-- | 13         | John         |
-- | 6          | Alex         |
-- +------------+--------------+

-- Subjects table:
-- +--------------+
-- | subject_name |
-- +--------------+
-- | Math         |
-- | Physics      |
-- | Programming  |
-- +--------------+

-- Examinations table:
-- +------------+--------------+
-- | student_id | subject_name |
-- +------------+--------------+
-- | 1          | Math         |
-- | 1          | Physics      |
-- | 1          | Programming  |
-- | 2          | Programming  |
-- | 1          | Physics      |
-- | 1          | Math         |
-- | 13         | Math         |
-- | 13         | Programming  |
-- | 13         | Physics      |
-- | 2          | Math         |
-- | 1          | Math         |
-- +------------+--------------+

-- Result table:
-- +------------+--------------+--------------+----------------+
-- | student_id | student_name | subject_name | attended_exams |
-- +------------+--------------+--------------+----------------+
-- | 1          | Alice        | Math         | 3              |
-- | 1          | Alice        | Physics      | 2              |
-- | 1          | Alice        | Programming  | 1              |
-- | 2          | Bob          | Math         | 1              |
-- | 2          | Bob          | Physics      | 0              |
-- | 2          | Bob          | Programming  | 1              |
-- | 6          | Alex         | Math         | 0              |
-- | 6          | Alex         | Physics      | 0              |
-- | 6          | Alex         | Programming  | 0              |
-- | 13         | John         | Math         | 1              |
-- | 13         | John         | Physics      | 1              |
-- | 13         | John         | Programming  | 1              |
-- +------------+--------------+--------------+----------------+

-- The result table should contain all students and all subjects.
-- 查詢結果應包含所有學生和所有學科
-- Alice attended Math exam 3 times, Physics exam 2 times and Programming exam 1 time.
-- 愛麗絲（Alice）參加了3次數學考試，2次物理考試和1次編程考試。
-- Bob attended Math exam 1 time, Programming exam 1 time and didn't attend the Physics exam.
-- 鮑勃（Bob）參加了1次數學考試，1次參加了編程考試，並且沒有參加物理考試。
-- Alex didn't attend any exam.
-- 亞歷克斯沒有參加任何考試。
-- John attended Math exam 1 time, Physics exam 1 time and Programming exam 1 time.
-- 約翰參加數學考試1次，物理1考試時間和考試的編程1次。


-- Solution
-- 學生和科目先交叉連接(學生與科目的所有組合)，再外連接考試資料表計算每位學生的各科考試次數
-- MySQL
SELECT A.STUDENT_ID, A.STUDENT_NAME, A.SUBJECT_NAME, IFNULL(B.ATTENDED_EXAMS,0) AS ATTENDED_EXAMS
FROM (
  SELECT STUDENT_ID, STUDENT_NAME, SUBJECT_NAME
  FROM STUDENTS CROSS JOIN SUBJECTS  
  ORDER BY STUDENT_ID, SUBJECT_NAME
) A
LEFT JOIN 
(
  SELECT STUDENT_ID, SUBJECT_NAME, COUNT(STUDENT_ID) AS ATTENDED_EXAMS
  FROM EXAMINATIONS
  GROUP BY STUDENT_ID, SUBJECT_NAME
  ORDER BY STUDENT_ID, SUBJECT_NAME
) B
ON A.STUDENT_ID = B.STUDENT_ID 
AND A.SUBJECT_NAME = B.SUBJECT_NAME
ORDER BY A.STUDENT_ID ASC, A.SUBJECT_NAME ASC;

