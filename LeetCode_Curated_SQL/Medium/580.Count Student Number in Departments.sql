-- 580.Count Student Number in Departments

--  A university uses 2 data tables, student and department, to store data about its students and the departments associated with each major.
--  某大學使用student 表和department 表來記錄各部門學生的情況。

--  Write a query to print the respective department name and number of students majoring in each department 
--  for all departments in the department table (even ones with no current students).
--  Sort your results by descending number of students; if two or more departments have the same number of students, 
--  then sort those departments alphabetically by department name.
-- 查詢每個部門下的學生數，要列出所有部門，即使該部門沒有學生。結果按學生數降序、部門名稱升序排列

--  The STUDENT is described as follow:
--  | Column Name  | Type      |
--  |--------------|-----------|
--  | student_id   | Integer   |
--  | student_name | String    |
--  | gender       | Character |
--  | dept_id      | Integer   |
--  where student_id is the student's ID number, student_name is the student's name, gender is their gender,
--  and dept_id is the department ID associated with their declared major.
--  該表中包含學生編號、學生姓名、學生性別以及所屬部門

--  And the DEPARTMENT table is described as below:
--  | Column Name | Type    |
--  |-------------|---------|
--  | dept_id     | Integer |
--  | dept_name   | String  |
--  where dept_id is the department's ID number and dept_name is the department name.
--  該表中包含部門名稱及部門編號

--  Here is an example input:
--  STUDENT table:
--  | STUDENT_ID | STUDENT_NAME | GENDER | DEPT_ID |
--  |------------|--------------|--------|---------|
--  | 1          | Jack         | M      | 1       |
--  | 2          | Jane         | F      | 1       |
--  | 3          | Mark         | M      | 2       |
  
--  DEPARTMENT table:
--  | DEPT_ID | DEPT_NAME   |
--  |---------|-------------|
--  | 1       | Engineering |
--  | 2       | Science     |
--  | 3       | Law         |

--  The Output should be:
--  | dept_name   | student_number |
--  |-------------|----------------|
--  | Engineering | 2              |
--  | Science     | 1              |
--  | Law         | 0              |


-- Solution
SELECT DEPT_NAME, COUNT(S.DEPT_ID) AS STUDENT_NUMBER
FROM DEPARTMENT D LEFT JOIN STUDENT S
ON D.DEPT_ID = S.DEPT_ID
GROUP BY D.DEPT_NAME
ORDER BY STUDENT_NUMBER DESC, DEPT_NAME;
