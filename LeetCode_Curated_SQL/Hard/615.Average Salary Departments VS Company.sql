-- 615.Average Salary: Departments VS Company 平均薪資：部門 VS 公司

-- Given two tables as below, write a query to display the comparison result (higher/lower/same) of the 
-- average salary of employees in a department to the company's average salary.
-- 查詢各部門平均工資(月)與公司平均工資(月)的比較結果(高/低/相同)

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
-- SALARY薪資資料表與EMPLOYEE員工資料表，透過EMPLOYEE_ID關聯查詢
-- PAY_DATE薪資日期取年月
-- 資料劃分透過S.PAY_DATE薪資日期取年月、E.DEPARTMENT_ID部門編號，計算取得部門平均月薪資
-- 資料劃分透過S.PAY_DATE薪資日期取年月，計算取得公司平均月薪資
-- 透過CASE WHEN多條件判斷式
-- 當DEPT_AVG > COMP_AVG 部門平均月薪資大於公司平均月薪資為"higher"
-- 當DEPT_AVG < COMP_AVG 部門平均月薪資小於公司平均月薪資為"lower"
-- 上述情皆不是則為"same"
-- 最後將欄位PAY_MONTH薪資日期年月、DEPARTMENT_ID部門號、COMPARISON比較結果，資料去重覆
WITH T AS(
  SELECT DATE_FORMAT(S.PAY_DATE,'%Y-%m') AS PAY_MONTH, E.DEPARTMENT_ID, 
	  AVG(S.AMOUNT) OVER (PARTITION BY DATE_FORMAT(S.PAY_DATE,'%Y-%m'), E.DEPARTMENT_ID) AS DEPT_AVG, 
	  AVG(S.AMOUNT) OVER (PARTITION BY DATE_FORMAT(S.PAY_DATE,'%Y-%m')) AS COMP_AVG
  FROM SALARY S JOIN EMPLOYEE E
  ON S.EMPLOYEE_ID = E.EMPLOYEE_ID
  ORDER BY PAY_MONTH DESC
)
SELECT DISTINCT PAY_MONTH, DEPARTMENT_ID, 
	CASE 
		WHEN DEPT_AVG > COMP_AVG THEN "higher"
		WHEN DEPT_AVG < COMP_AVG THEN "lower"
		ELSE "same"
	END AS COMPARISON
FROM T
ORDER BY PAY_MONTH DESC;


