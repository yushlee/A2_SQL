-- 1412.Find the Quiet Students in All Exams 查找成績處於中間的學生


-- Table: Student
-- +---------------------+---------+
-- | Column Name         | Type    |
-- +---------------------+---------+
-- | student_id          | int     |
-- | student_name        | varchar |
-- +---------------------+---------+
-- student_id is the primary key for this table.
-- student_name is the name of the student.
 

-- Table: Exam
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | exam_id       | int     |
-- | student_id    | int     |
-- | score         | int     |
-- +---------------+---------+
-- (exam_id, student_id) is the primary key for this table.
-- Student with student_id got score points in exam with id exam_id.
-- (exam_id, student_id)是此表的主鍵，score 表示該學生在本場考試中的成績 

-- A "quite" student is the one who took at least one exam and didn't score neither the high score nor the low score.
-- 成績處於中間的學生是指至少參加了一次測驗, 且得分既不是最高分也不是最低分的學生。

-- Write an SQL query to report the students (student_id, student_name) being "quiet" in ALL exams.
-- 寫一個SQL 語句，找出在所有測驗中都處於中間的學生(student_id, student_name)

-- Don't return the student who has never taken any exam. Return the result table ordered by student_id.
-- The query result format is in the following example.
-- 不需要返回從未參加過任何考試的學生。查詢結果按student_id 升序排列。 

-- Student table:
-- +-------------+---------------+
-- | student_id  | student_name  |
-- +-------------+---------------+
-- | 1           | Daniel        |
-- | 2           | Jade          |
-- | 3           | Stella        |
-- | 4           | Jonathan      |
-- | 5           | Will          |
-- +-------------+---------------+

-- Exam table:
-- +------------+--------------+-----------+
-- | exam_id    | student_id   | score     |
-- +------------+--------------+-----------+
-- | 10         |     1        |    70     |
-- | 10         |     2        |    80     |
-- | 10         |     3        |    90     |
-- | 20         |     1        |    80     |
-- | 30         |     1        |    70     |
-- | 30         |     3        |    80     |
-- | 30         |     4        |    90     |
-- | 40         |     1        |    60     |
-- | 40         |     2        |    70     |
-- | 40         |     4        |    80     |
-- +------------+--------------+-----------+

-- Result table:
-- +-------------+---------------+
-- | student_id  | student_name  |
-- +-------------+---------------+
-- | 2           | Jade          |
-- +-------------+---------------+

-- For exam 1: Student 1 and 3 hold the lowest and high score respectively.
-- For exam 2: Student 1 hold both highest and lowest score.
-- For exam 3 and 4: Studnet 1 and 4 hold the lowest and high score respectively.
-- Student 2 and 5 have never got the highest or lowest in any of the exam.
-- Since student 5 is not taking any exam, he is excluded from the result.
-- So, we only return the information of Student 2.
-- 對於考試1：學生1和3分別擁有最低和最高分數。
-- 對於考試2：學生1擁有最高和最低分數。
-- 對於考試3和4：學生1和4分別擁有最低和最高分數。
-- 學生2和5從未在任何考試中獲得最高或最低分數。
-- 由於學生5不參加任何考試，因此將他從成績中排除。因此，我們僅返回學生2的信息


-- Solution
-- 解題重點在於用RANK函數算出正排名和倒數排名，再篩選排除第一名、倒數第一名的學生
-- EXAM測試成績資料表與STUDENT學生資料表，透過STUDENT_ID學生編號關聯查詢
-- 透過E.EXAM_ID測驗編號將資料劃分，並按照E.SCORE測試成績降幕和升幕排序
-- 取得所有測驗成績的RNAK名次第一名與倒數第一名
-- 透過兩個欄位STUDENT_ID學生編號、STUDENT_NAME學生編號將資料分群
-- HAVING資料篩選MIN(RANK_EAXM_DESC) != 1排除成績第一名、MIN(RANK_EAXM_ASC) != 1倒數成績第一名的學生
WITH T AS(
  SELECT E.EXAM_ID, E.STUDENT_ID, S.STUDENT_NAME, E.SCORE, 
    RANK() OVER (PARTITION BY E.EXAM_ID ORDER BY E.SCORE DESC) RANK_EAXM_DESC, 
    RANK() OVER (PARTITION BY E.EXAM_ID ORDER BY E.SCORE ASC) RANK_EAXM_ASC
  FROM EXAM E
  JOIN STUDENT S ON E.STUDENT_ID = S.STUDENT_ID
)
SELECT STUDENT_ID, STUDENT_NAME
FROM T
GROUP BY STUDENT_ID, STUDENT_NAME
HAVING MIN(RANK_EAXM_DESC) != 1 AND MIN(RANK_EAXM_ASC) != 1
ORDER BY STUDENT_ID;

