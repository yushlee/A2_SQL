-- SQL 練習題(四)
-- 查詢每個部門高於平均部門薪資的員工
-- (結果依部門平均薪資降冪排序)

SELECT DEPARTMENT_ID, FLOOR(AVG(SALARY)) DEP_AVG_SALARY
FROM employees
GROUP BY DEPARTMENT_ID;