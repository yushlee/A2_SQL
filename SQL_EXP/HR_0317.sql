-- SQL 練習題(四)
-- HR DB 資料查詢
-- 查詢每個部門高於平均部門薪資的員工
-- (結果依部門平均薪資降冪排序)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID, D.DEPARTMENT_NAME,
	T_DEP_AVG.DEP_AVG_SALARY
FROM employees E 
JOIN departments D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN (
	-- 平均部門薪資
	SELECT E.DEPARTMENT_ID, FLOOR(AVG(SALARY)) DEP_AVG_SALARY
	FROM employees E
	GROUP BY E.DEPARTMENT_ID
) T_DEP_AVG ON E.DEPARTMENT_ID = T_DEP_AVG.DEPARTMENT_ID
WHERE E.SALARY > T_DEP_AVG.DEP_AVG_SALARY
ORDER BY T_DEP_AVG.DEP_AVG_SALARY DESC, E.SALARY DESC;

WITH T_DEP_AVG AS (
	-- 平均部門薪資
	SELECT E.DEPARTMENT_ID, FLOOR(AVG(SALARY)) DEP_AVG_SALARY
	FROM employees E
	GROUP BY E.DEPARTMENT_ID
)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID, D.DEPARTMENT_NAME,  T_DEP_AVG.DEP_AVG_SALARY
FROM T_DEP_AVG 
JOIN employees E ON E.DEPARTMENT_ID = T_DEP_AVG.DEPARTMENT_ID
JOIN departments D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.SALARY > T_DEP_AVG.DEP_AVG_SALARY
ORDER BY T_DEP_AVG.DEP_AVG_SALARY DESC, E.SALARY DESC;

-- CTE結合關聯式子查詢寫法
WITH T_DEP_AVG AS (
	-- 平均部門薪資
	SELECT E.DEPARTMENT_ID, FLOOR(AVG(SALARY)) DEP_AVG_SALARY
	FROM employees E
	GROUP BY E.DEPARTMENT_ID
), EMP_AVG AS (
	SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID, T_DEP_AVG.DEP_AVG_SALARY
    FROM employees E
    JOIN T_DEP_AVG ON  E.DEPARTMENT_ID = T_DEP_AVG.DEPARTMENT_ID
    WHERE E.SALARY > T_DEP_AVG.DEP_AVG_SALARY
)
SELECT EMP_AVG.*, D.DEPARTMENT_NAME
FROM EMP_AVG JOIN departments D ON EMP_AVG.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMP_AVG.DEP_AVG_SALARY DESC, EMP_AVG.SALARY DESC;

