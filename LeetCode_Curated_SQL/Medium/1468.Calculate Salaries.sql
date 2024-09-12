-- 1468.Calculate Salaries 計算工資

-- Table: Salaries
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | company_id    | int     |
-- | employee_id   | int     |
-- | employee_name | varchar |
-- | salary        | int     |
-- +---------------+---------+
-- (company_id, employee_id) is the primary key for this table.
-- This table contains the company id, the id, the name and the salary for an employee.
-- 表格包含公司 ID、員工 ID、姓名和薪資。

-- Write an SQL query to find the salaries of the employees after applying taxes.
-- 查找每個員工的稅後工資

-- The tax rate is calculated for each company based on the following criteria:
-- 0% If the max salary of any employee in the company is less than 1000$.
-- 24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
-- 49% If the max salary of any employee in the company is greater than 10000$.
-- Return the result table in any order. Round the salary to the nearest integer.
--  每個公司的稅率根據以下標準計算
--  如果這個公司員工最高工資不到 1,000，稅率為 0% 
--  如果這個公司員工最高工資在 1,000 到 10,000 之間，稅率為 24% 
--  如果這個公司員工最高工資大於 10,000，稅率為 49%
--  按任意順序返回結果，稅後工資結果四捨五入到整數

-- Salaries table:
-- +------------+-------------+---------------+--------+
-- | company_id | employee_id | employee_name | salary |
-- +------------+-------------+---------------+--------+
-- | 1          | 1           | Tony          | 2000   |
-- | 1          | 2           | Pronub        | 21300  |
-- | 1          | 3           | Tyrrox        | 10800  |
-- | 2          | 1           | Pam           | 300    |
-- | 2          | 7           | Bassem        | 450    |
-- | 2          | 9           | Hermione      | 700    |
-- | 3          | 7           | Bocaben       | 100    |
-- | 3          | 2           | Ognjen        | 2200   |
-- | 3          | 13          | Nyancat       | 3300   |
-- | 3          | 15          | Morninngcat   | 7777   |
-- +------------+-------------+---------------+--------+



-- The query result format is in the following example:
-- Result table:
-- +------------+-------------+---------------+--------+
-- | company_id | employee_id | employee_name | salary |
-- +------------+-------------+---------------+--------+
-- | 1          | 1           | Tony          | 1020   |
-- | 1          | 2           | Pronub        | 10863  |
-- | 1          | 3           | Tyrrox        | 5508   |
-- | 2          | 1           | Pam           | 300    |
-- | 2          | 7           | Bassem        | 450    |
-- | 2          | 9           | Hermione      | 700    |
-- | 3          | 7           | Bocaben       | 76     |
-- | 3          | 2           | Ognjen        | 1672   |
-- | 3          | 13          | Nyancat       | 2508   |
-- | 3          | 15          | Morninngcat   | 5911   |
-- +------------+-------------+---------------+--------+
-- For company 1, Max salary is 21300. Employees in company 1 have taxes = 49%
-- For company 2, Max salary is 700. Employees in company 2 have taxes = 0%
-- For company 3, Max salary is 7777. Employees in company 3 have taxes = 24%
-- The salary after taxes = salary - (taxes percentage / 100) * salary
-- For example, Salary for Morninngcat (3, 15) 
-- after taxes = 7777 - 7777 * (24 / 100) = 7777 - 1866.48 = 5910.52, which is rounded to 5911.

--  對於公司 1 ，最高工資是 21300 ，其每個員工的稅率為 49%
--  對於公司 2 ，最高工資是 700 ，其每個員工稅率為 0%
--  對於公司 3 ，最高工資是 7777 ，其每個員工稅率是 24%
--  稅後工資計算 = 工資 - ( 稅率 / 100) * 工資
--  對於上述案例，Morninngcat 的
--  稅後工資 = 7777 - 7777 * ( 24 / 100) = 7777 - 1866.48 = 5910.52，四捨五入到整數為 5911


-- Solution One
-- 透過COMPANY_ID公司編號將資料分群
-- 使用CASE WHEN多條件判斷式查詢各公司的員工"最高薪資"所對應的"稅率"
-- 資料結果儲存至暫存表T
-- 不到 1,000，稅率為 0%
-- 在 1,000 到 10,000 之間，稅率為 24% 
-- 大於 10,000，稅率為 49%
-- 暫存表T與SALARIES工資資料表透過COMPANY_ID公司編號欄位關聯查詢
-- 計算稅後工資
-- 工資 - 工資 * (稅率 / 100) = 稅後工資
WITH T AS (  
  SELECT COMPANY_ID, MAX(SALARY),         
    CASE 		
		WHEN MAX(SALARY) < 1000 THEN 0        
        WHEN MAX(SALARY) BETWEEN 1000 AND 10000 THEN 0.24        
        WHEN MAX(SALARY) > 1000 THEN 0.49
	END RATE
  FROM SALARIES  
  GROUP BY COMPANY_ID
)
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME,	
	ROUND(S.SALARY - S.SALARY * T.RATE) SALARY
FROM T JOIN SALARIES S
ON T.COMPANY_ID = S.COMPANY_ID;



-- Solution Two
WITH T1 AS (
  -- 查詢各公司的員工"最高薪資"
  SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY AS SA, 
    -- 透過 MAX()OVER()查詢各公司最高員工薪資，就不須要 GROUP，後續也節省不用再 JOIN SALARIES
    MAX(SALARY) OVER(PARTITION BY COMPANY_ID) AS MAXIMUM
  FROM SALARIES
)
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME,
  -- 工資 - 工資 * 稅率 = 稅後工資計算
  -- 工資 * (1 - 稅率) = 稅後工資計算
  CASE WHEN T1.MAXIMUM < 1000 THEN T1.SA
    WHEN T1.MAXIMUM BETWEEN 1000 AND 10000 THEN ROUND( T1.SA * 0.76)
    ELSE ROUND(T1.SA * 0.51)
    END AS SALARY
FROM T1;
