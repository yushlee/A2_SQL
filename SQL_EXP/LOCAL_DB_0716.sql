-- SQL UNION 聯集(不包含重覆值)
-- UNION 指令的目的是將兩個 SQL 語句的結果合併起來
-- 1.資料會去重覆
-- 2.查詢之間欄位"個數"必須相同
-- 3.查詢之間欄位"型態"相同(MySQL無此限制)
SELECT REGION_NAME FROM GEOGRAPHY
UNION
SELECT STORE_NAME FROM STORE_INFORMATION;

-- MySQL可透過UNION的方式將LEFT JOIN + RIGHT JOIN = FULL JOIN
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
UNION
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE
FROM GEOGRAPHY G RIGHT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- SQL UNION ALL 聯集(包含重覆值)
-- UNION ALL 會將每一筆符合條件的資料都列出來，無論資料值有無重複
SELECT REGION_NAME FROM GEOGRAPHY
UNION ALL
SELECT STORE_NAME FROM STORE_INFORMATION;


-- SQL INTERSECT 交集
-- PS:MySQL不支援INTERSECT
/*
-- 1,2,3
SELECT GEOGRAPHY_ID FROM GEOGRAPHY
INTERSECT
-- null,1,2
SELECT GEOGRAPHY_ID FROM STORE_INFORMATION;
*/

-- MySQL INTERSECT 替代寫法
-- INNER JOIN + DISTINCT = INTERSECT 查詢交集結果
SELECT DISTINCT G.GEOGRAPHY_ID 
FROM GEOGRAPHY G JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- SQL MINUS 排除(不包含重覆值) 
/*
 MINUS (Oracle)、EXCEPT (MS SQL)指令是運用在兩個 SQL 語句上
它先找出第一個 SQL 語句所產生的結果，
然後看這些結果「有沒有在第二個 SQL 語句的結果中」。
如果「有」的話，那這一筆資料就被「去除」，而不會在最後的結果中出現。
如果「沒有」的話，那這一筆資料就被「保留」，而就會在最後的結果中出現。
請注意，在 MINUS 指令下，不同的值只會被列出一次。 
*/

-- MINUS(Oracle)
/*
-- 1,2,3
SELECT GEOGRAPHY_ID FROM GEOGRAPHY
MINUS
-- null,1,2
SELECT GEOGRAPHY_ID FROM STORE_INFORMATION;
*/

-- EXCEPT(MS SQL)
/*
-- 1,2,3
SELECT GEOGRAPHY_ID FROM GEOGRAPHY
EXCEPT
-- null,1,2
SELECT GEOGRAPHY_ID FROM STORE_INFORMATION;
*/

-- MySQL MINUS 替代寫法
-- LEFT JOIN + table2.id IS NULL = MINUS
-- LEFT JOIN - INNER JOIN
SELECT G.GEOGRAPHY_ID
FROM GEOGRAPHY G 
LEFT JOIN STORE_INFORMATION S ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;

-- SQL SubQuery 子查詢
-- 『簡單子查詢』 (Simple Subquery)
-- 查詢最高營業額的商店資料
-- 外查詢
SELECT STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID 
FROM STORE_INFORMATION
WHERE SALES = (
	-- 內查詢
	SELECT MAX(SALES)
	FROM STORE_INFORMATION
);

-- 『相關子查詢』(Correlated Subquery)
-- 外查詢
SELECT SUM(SALES)
FROM STORE_INFORMATION S
WHERE S.GEOGRAPHY_ID IN (
	-- 內查詢
	SELECT G.GEOGRAPHY_ID
	FROM GEOGRAPHY G
    WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
);

-- 每個子查詢都可視為一個資料查詢的結果集
-- 查詢與查詢之間彼此獨立不能互相使用對方的欄位
-- 只能在查詢的最後再做連接(join)查詢

-- 簡單子查詢
SELECT G.*, S.*
FROM (
	SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
) G, (
	SELECT STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID FROM STORE_INFORMATION
) S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 相關子查詢
WITH G AS (
	SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
), 
S AS (
	SELECT STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID FROM STORE_INFORMATION
)
SELECT G.*, S.* 
FROM G, S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- HR DB 資料查詢
-- 查詢每個部門高於平均部門薪資的員工
-- (結果依部門平均薪資降冪排序)
-- 1.查詢平均部門薪資
-- 2.找出高於平均部門薪資的員工

-- 簡單子查詢
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,
	D.DEPARTMENT_NAME, DAS.DEP_AVG_SALARY
FROM (
	SELECT DEPARTMENT_ID, FLOOR(AVG(SALARY)) "DEP_AVG_SALARY"
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
) DAS , EMPLOYEES E, DEPARTMENTS D
WHERE DAS.DEPARTMENT_ID = E.DEPARTMENT_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.SALARY > DAS.DEP_AVG_SALARY
ORDER BY DAS.DEP_AVG_SALARY DESC, E.SALARY DESC;

-- 相關子查詢
-- WITH (Common Table Expressions)
-- 子查詢與子查詢之間join查詢，有個支援更為合適的SQL專用語法 WITH  AS，使用SQL子查詢在撰寫更有結構性及閱續性!
-- 且查詢與查詢之間可以相互使用欄位做關聯式查詢
WITH DAS AS (
	SELECT DEPARTMENT_ID, FLOOR(AVG(SALARY)) "DEP_AVG_SALARY"
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
), 
EMP AS (
	-- 38筆高於平均部門薪資的員工
	SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID, DAS.DEP_AVG_SALARY
    FROM EMPLOYEES E 
    JOIN DAS ON DAS.DEPARTMENT_ID = E.DEPARTMENT_ID
    WHERE E.SALARY > DAS.DEP_AVG_SALARY
)
-- CTE的做法效率較佳,因為拿的是已經條件篩選後的資料(資料筆數較少)和DEPARTMENTS JOIN
SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.SALARY, EMP.DEPARTMENT_ID,
	D.DEPARTMENT_NAME, EMP.DEP_AVG_SALARY
FROM EMP 
JOIN DEPARTMENTS D ON EMP.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMP.DEP_AVG_SALARY DESC, EMP.SALARY;


-- SQL EXISTS 存在式關聯查詢
-- EXISTS 是用來測試「內查詢」有沒有產生任何結果。
-- 如果有的話，系統就會執行「外查詢」中的 SQL。
-- 若是沒有的話，那整個 SQL 語句就不會產生任何結果。

-- SQL EXISTS 存在式簡單子查詢
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID 
FROM STORE_INFORMATION S 
WHERE EXISTS (
	SELECT GEOGRAPHY_ID, REGION_NAME 
    FROM GEOGRAPHY G
    WHERE G.GEOGRAPHY_ID = 1
);

-- SQL EXISTS 存在式關聯查詢
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID 
FROM STORE_INFORMATION S
-- 存在於 
WHERE EXISTS (
	SELECT GEOGRAPHY_ID, REGION_NAME 
    FROM GEOGRAPHY G
    WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
);


-- SQL NOT EXISTS 存在式關聯查詢
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID 
FROM STORE_INFORMATION S 
-- 不存在於
WHERE NOT EXISTS (
	SELECT GEOGRAPHY_ID, REGION_NAME 
    FROM GEOGRAPHY G
    WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
);

-- SQL CASE WHEN 條件查詢
-- CASE接欄位
SELECT STORE_ID, STORE_NAME, SALES,
	CASE STORE_NAME
		WHEN 'Los Angeles' THEN SALES * 2
        WHEN 'San Diego' THEN SALES * 1.5
	ELSE SALES END "NEW_SALES"
FROM STORE_INFORMATION;

-- CASE 不接欄位(條件判斷)
SELECT STORE_ID, STORE_NAME, SALES,
	CASE
		WHEN (SALES BETWEEN 0 AND 1000) THEN '0-1000'
        WHEN (SALES BETWEEN 1001 AND 2000) THEN '1001-2000'
        WHEN (SALES BETWEEN 2001 AND 3000) THEN '2001-3000'
        WHEN SALES > 3000 THEN '>3000'
	END "SALES_RANGE"
FROM STORE_INFORMATION
ORDER BY SALES;


