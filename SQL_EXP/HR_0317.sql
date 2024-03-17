-- SQL 練習題(四)
-- HR DB 資料查詢
-- 查詢每個部門高於平均部門薪資的員工
-- (結果依部門平均薪資降冪排序)

-- 平均部門薪資
SELECT E.DEPARTMENT_ID, FLOOR(AVG(SALARY)) DEP_AVG_SALARY
FROM employees E
GROUP BY E.DEPARTMENT_ID;