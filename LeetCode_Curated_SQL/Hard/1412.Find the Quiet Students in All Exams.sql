-- 1412.Find the Quiet Students in All Exams
-- 查找成績處於中間的學生

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
-- "quite" student 是至少參加了一次考試"並且既未獲得高分也未獲得低分"的學生

-- Write an SQL query to report the students (student_id, student_name) being "quiet" in ALL exams.
-- 查詢在所有考試中 quite student，返回student_id 及student_name

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


-- Solution One
WITH T AS (
  -- 所有獲得最高分、最低分的學生
  SELECT DISTINCT STUDENT_ID FROM (
    SELECT EXAM_ID, STUDENT_ID, SCORE,
      MAX(SCORE) OVER (PARTITION BY EXAM_ID) MAX_SCORE,
      MIN(SCORE) OVER (PARTITION BY EXAM_ID) MIN_SCORE
    FROM EXAM
  ) WHERE SCORE = MAX_SCORE OR SCORE = MIN_SCORE  
)
SELECT S.STUDENT_ID, S.STUDENT_NAME FROM (
  -- 所有考過試的學生"減去"所有獲得最高分、最低分的學生
  -- 等於剩下中間分數的學生
  SELECT DISTINCT STUDENT_ID FROM EXAM
  MINUS
  SELECT STUDENT_ID FROM T
) E JOIN STUDENT S ON E.STUDENT_ID = S.STUDENT_ID;

-- Solution Two
WITH T AS (
  SELECT STUDENT_ID  FROM (
    -- 學生3雖在 EXAM_ID:30為中間，但在EXAM_ID:10得過第一名，所以必須排除
    SELECT EXAM_ID, STUDENT_ID, SCORE,
      RANK() OVER(PARTITION BY EXAM_ID ORDER BY SCORE DESC ) SCORE_DESC,
      RANK() OVER(PARTITION BY EXAM_ID ORDER BY SCORE ASC) SCORE_ASC
    FROM EXAM
    ORDER BY STUDENT_ID
  ) GROUP BY STUDENT_ID
  -- 未曾經得過第一名和最後一名
  HAVING MIN(SCORE_DESC) != 1  AND MIN(SCORE_ASC) != 1
)
SELECT S.STUDENT_ID, S.STUDENT_NAME
FROM T JOIN STUDENT S 
ON T.STUDENT_ID = S.STUDENT_ID
ORDER BY S.STUDENT_ID;
