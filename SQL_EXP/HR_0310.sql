-- SQL 練習題(五)
-- HR DB 資料查詢
-- 查詢所有部門資訊如下：
-- 1.所在地(國家、洲省、城市)
-- 2.部門(部門編號、部門名稱)
-- 3.部門管理者(員工編號、員工姓名、員工職稱)

-- Step1:找出資料欄與所屬資料表
-- COUNTRY_ID, STATE_PROVINCE, CITY (locations)
-- DEPARTMENT_ID, DEPARTMENT_NAME (departments)
-- EMPLOYEE_ID, FIRST_NAME (employees)
-- JOB_TITLE (jobs)

-- Step2:找出資料表與資料表之間相關聯欄位
-- locations (LOCATION_ID) departments
-- departments (MANAGER_ID, EMPLOYEE_ID) employees
-- employees(JOB_ID)jobs

-- Step3:撰寫SQL

SELECT L.COUNTRY_ID, L.STATE_PROVINCE, L.CITY, D.DEPARTMENT_ID, D.DEPARTMENT_NAME,
	IFNULL(E.EMPLOYEE_ID, 100), IFNULL(E.FIRST_NAME, 'Steven'), J.JOB_TITLE
FROM locations L 
JOIN departments D ON L.LOCATION_ID = D.LOCATION_ID
LEFT JOIN employees E ON D.MANAGER_ID = E.EMPLOYEE_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID;


SELECT L.COUNTRY_ID, L.STATE_PROVINCE, L.CITY, D.DEPARTMENT_ID, D.DEPARTMENT_NAME,
	E.EMPLOYEE_ID, E.FIRST_NAME, J.JOB_TITLE
FROM locations L 
JOIN departments D ON L.LOCATION_ID = D.LOCATION_ID
LEFT JOIN employees E ON IFNULL(D.MANAGER_ID, 101) = E.EMPLOYEE_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID;

