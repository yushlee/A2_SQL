/*
HR DB 資料查詢
查詢所有部門資訊如下：
1.所在地(國家、洲省、城市)
2.部門(部門編號、部門名稱)
3.部門管理者(員工編號、員工姓名、員工職稱)
*/

-- Step1:找出「資料表」、「資料欄」
-- locations(COUNTRY_ID, STATE_PROVINCE, CITY)
-- departments(DEPARTMENT_ID, DEPARTMENT_NAME,MANAGER_ID)
-- employees(EMPLOYEE_ID, FIRST_NAME,JOB_ID)
-- jobs(JOB_ID, JOB_TITLE)

-- Step2:「資料表」與「資料表」之間關聯欄位
-- locations (LOCATION_ID) departments
-- departments (MANAGER_ID, EMPLOYEE_ID) employees
-- employees (JOB_ID) jobs

-- Step3:寫SQL
-- HR DB 資料查詢
-- 查詢所有部門資訊如下：
-- 1.所在地(國家、洲省、城市)
-- 2.部門(部門編號、部門名稱)
-- 3.部門管理者(員工編號、員工姓名、員工職稱)

SELECT L.COUNTRY_ID, L.STATE_PROVINCE, L.CITY,
	D.DEPARTMENT_ID, D.DEPARTMENT_NAME,
    IFNULL(E.EMPLOYEE_ID, 100), IFNULL(E.FIRST_NAME, 'Stave'), E.JOB_ID,
    J.JOB_ID, J.JOB_TITLE
FROM locations L 
JOIN departments D ON L.LOCATION_ID = D.LOCATION_ID 
LEFT JOIN employees E ON D.MANAGER_ID = E.EMPLOYEE_ID
LEFT JOIN jobs J ON E.JOB_ID = J.JOB_ID;


SELECT L.COUNTRY_ID, L.STATE_PROVINCE, L.CITY,
	D.DEPARTMENT_ID, D.DEPARTMENT_NAME,
    E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID,
    J.JOB_ID, J.JOB_TITLE
FROM locations L 
JOIN departments D ON L.LOCATION_ID = D.LOCATION_ID 
JOIN employees E ON IFNULL(D.MANAGER_ID, 100) = E.EMPLOYEE_ID
JOIN jobs J ON E.JOB_ID = J.JOB_ID;




