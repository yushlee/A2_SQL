-- SQL UNION 聯集(不包含重覆值)
-- 1.多個SQL語句的結果合併起來
-- 2.UNION與JOIN差別在於，JOIN...ON必須指定欄位關聯(連接)
-- 3.所有SQL子句的查詢"欄位個數"必須一致、"欄位型態"必須一致 MySQL無此限制
SELECT STORE_ID,STORE_NAME FROM store_information
UNION
SELECT GEOGRAPHY_ID,REGION_NAME FROM geography
UNION
SELECT EMPLOYEE_ID, FIRST_NAME FROM employees;

-- MySQL FULL JOIN = LEFT JOIN UNION RIGHT JOIN
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S LEFT JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
UNION
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S RIGHT JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- SQL UNION ALL 聯集(包含重覆值)
SELECT STORE_NAME FROM store_information
UNION ALL
SELECT REGION_NAME FROM geography;


-- SQL INTERSECT 交集
-- MySQL沒有支援INTERSECT
/*
SELECT GEOGRAPHY_ID FROM store_information
INTERSECT
SELECT GEOGRAPHY_ID FROM geography;
*/

-- https://www.yiibai.com/mysql/sql-union-mysql.html
-- INNER JOIN + DISTINCT = INTERSECT 查詢交集結果
SELECT DISTINCT S.GEOGRAPHY_ID 
FROM store_information S
JOIN geography G ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- SQL MINUS 排除(不包含重覆值) 
-- MySQL沒有支援 MINUS
/*
-- 1,2,3
-- 1,2,null
-- MINUS = 3
SELECT GEOGRAPHY_ID FROM geography
MINUS
SELECT GEOGRAPHY_ID FROM store_information;
*/

-- https://www.yiibai.com/mysql/minus.html
-- LEFT JOIN + table2.id IS NULL = MINUS
SELECT G.GEOGRAPHY_ID
FROM geography G
LEFT JOIN store_information S ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE  S.GEOGRAPHY_ID IS NULL;

-- SQL SubQuery 子查詢
-- 查詢"最高營業額"的"商店資料"
-- 外查詢
SELECT STORE_ID, STORE_NAME, SALES 
FROM store_information
WHERE SALES = (
	-- 內查詢
	SELECT MAX(SALES) FROM store_information
);

-- 簡單子查詢
-- 外查詢
-- SELECT SUM(SALES)
SELECT STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID 
FROM store_information
WHERE GEOGRAPHY_ID IN (
	-- 內查詢
	SELECT GEOGRAPHY_ID FROM geography 
    WHERE REGION_NAME = 'West' OR REGION_NAME = 'East'
);

-- 相關子查詢
-- 外查詢
SELECT STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID 
FROM store_information S
WHERE GEOGRAPHY_ID IN (
	-- 內查詢
	SELECT GEOGRAPHY_ID FROM geography G
    WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
);

SELECT G.*, S.*
FROM (
	SELECT GEOGRAPHY_ID,REGION_NAME FROM geography
) G,
(
	SELECT STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID FROM store_information
) S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


SELECT G.*, S.*
FROM (
	SELECT GEOGRAPHY_ID,REGION_NAME FROM geography
) G JOIN
(
	SELECT STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID FROM store_information
) S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- SQL EXISTS 存在式關聯查詢
-- SQL CASE WHEN 條件查詢
