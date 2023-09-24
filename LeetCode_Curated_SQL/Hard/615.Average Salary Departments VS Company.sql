-- 615.Average Salary: Departments VS Company

-- Given two tables as below, write a query to display the comparison result (higher/lower/same) of the 
-- average salary of employees in a department to the company's average salary.
-- 查詢各部門平均工資(月)與公司平均工資(月)的比較結果（高/低/相同）

-- Table: salary
-- | id | employee_id | amount | pay_date   |
-- |----|-------------|--------|------------|
-- | 1  | 1           | 9000   | 2017-03-31 |
-- | 2  | 2           | 6000   | 2017-03-31 |
-- | 3  | 3           | 10000  | 2017-03-31 |
-- | 4  | 1           | 7000   | 2017-02-28 |
-- | 5  | 2           | 6000   | 2017-02-28 |
-- | 6  | 3           | 8000   | 2017-02-28 |


-- Table: employee
-- The employee_id column refers to the employee_id in the following table employee.
-- | employee_id | department_id |
-- |-------------|---------------|
-- | 1           | 1             |
-- | 2           | 2             |
-- | 3           | 2             |

-- So for the sample data above, the result is:
-- | pay_month | department_id | comparison  |
-- |-----------|---------------|-------------|
-- | 2017-03   | 1             | higher      |
-- | 2017-03   | 2             | lower       |
-- | 2017-02   | 1             | same        |
-- | 2017-02   | 2             | same        | 

-- Explanation
-- In March, the company's average salary is (9000+6000+10000)/3 = 8333.33...
-- 3月份公司平均工資為(9000+6000+10000)/3=8333.33...

-- The average salary for department '1' is 9000, which is the salary of employee_id '1' since there is only one employee in this department. 
-- So the comparison result is 'higher' since 9000 > 8333.33 obviously.
-- 部門'1'的平均工資是9000，這是employee_id '1'的工資，因為這個部門只有一個員工。所以比較結果顯然是"更高"，因為 9000 > 8333.33。

-- The average salary of department '2' is (6000 + 10000)/2 = 8000, which is the average of employee_id '2' and '3'. 
-- So the comparison result is 'lower' since 8000 < 8333.33.
-- 部門'2'的平均工資為(6000 + 10000)/2 = 8000，即employee_id '2'和'3'的平均值。因此比較結果是"較低"，因為 8000 < 8333.33。

-- With he same formula for the average salary comparison in February, 
-- the result is 'same' since both the department '1' and '2' have the same average salary with the company, which is 7000.
-- 使用相同的公式進行 2 月份的平均工資比較，結果"相同"，因為部門'1'和'2'與公司的平均工資相同，即 7000。


-- Solution
-- Oracle
WITH T AS (
  SELECT TO_CHAR(S.PAY_DATE, 'yyyy-MM') PAY_MONTH, E.DEPARTMENT_ID,
    AVG(S.AMOUNT) OVER (PARTITION BY TO_CHAR(S.PAY_DATE, 'yyyy-MM'), E.DEPARTMENT_ID) AVG_DEP,
    AVG(S.AMOUNT) OVER (PARTITION BY TO_CHAR(S.PAY_DATE, 'yyyy-MM')) COMP_DEP
  FROM SALARY S JOIN EMPLOYEE E
  ON S.EMPLOYEE_ID = E.EMPLOYEE_ID  
)
SELECT DISTINCT PAY_MONTH, DEPARTMENT_ID,
  CASE WHEN AVG_DEP > COMP_DEP THEN 'higher'
       WHEN AVG_DEP < COMP_DEP THEN 'lower'
       ELSE 'same' END COMPARISON
FROM T ORDER BY PAY_MONTH DESC;

-- MySQL
WITH T1 AS(
  SELECT DATE_FORMAT(PAY_DATE,'%Y-%m') AS PAY_MONTH, DEPARTMENT_ID, 
  AVG(AMOUNT) OVER(PARTITION BY MONTH(PAY_DATE),DEPARTMENT_ID) AS DEPT_AVG, 
  AVG(AMOUNT) OVER(PARTITION BY MONTH(PAY_DATE)) AS COMP_AVG
  FROM SALARY S JOIN EMPLOYEE E
  USING (EMPLOYEE_ID)
)
SELECT DISTINCT PAY_MONTH, DEPARTMENT_ID, 
CASE WHEN DEPT_AVG>COMP_AVG THEN "higher"
WHEN DEPT_AVG = COMP_AVG THEN "same"
ELSE "lower"
END AS COMPARISON
FROM T1
ORDER BY PAY_MONTH DESC;
