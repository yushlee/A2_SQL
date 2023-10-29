/*
SQL 練習題(四)
HR DB 資料查詢
查詢每個部門高於平均部門薪資的員工
(結果依部門平均薪資降冪排序)
*/

-- 簡單子查詢
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID, 
    D.DEPARTMENT_NAME,
    T_DEP_AVG.DEP_AVG_SALARY
FROM (
	-- 各別部門平均薪資
	SELECT E.DEPARTMENT_ID, FLOOR(AVG(SALARY)) "DEP_AVG_SALARY"
	FROM employees E
	GROUP BY E.DEPARTMENT_ID
) T_DEP_AVG, employees E, departments D
WHERE T_DEP_AVG.DEPARTMENT_ID = E.DEPARTMENT_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.SALARY > T_DEP_AVG.DEP_AVG_SALARY
ORDER BY T_DEP_AVG.DEP_AVG_SALARY DESC, E.SALARY DESC;



WITH T_DEP_AVG AS (
	-- 各別部門平均薪資
	SELECT E.DEPARTMENT_ID, FLOOR(AVG(SALARY)) "DEP_AVG_SALARY"
	FROM employees E
	GROUP BY E.DEPARTMENT_ID
),
DEP_EMP AS (
	-- 員工大於平均部份薪資的員工(38位)
    SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
		T_DEP_AVG.DEP_AVG_SALARY
    FROM employees E, T_DEP_AVG
    WHERE T_DEP_AVG.DEPARTMENT_ID = E.DEPARTMENT_ID
    AND E.SALARY > T_DEP_AVG.DEP_AVG_SALARY
)
SELECT DEP_EMP.*, D.DEPARTMENT_NAME
-- 此處DEP_EMP員工數只有38筆，只需找出這38筆員工的部門名稱，故效能較好
FROM DEP_EMP, departments D
WHERE DEP_EMP.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY DEP_EMP.DEP_AVG_SALARY DESC, DEP_EMP.SALARY DESC;
