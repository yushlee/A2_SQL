--   SQL UNION 聯集(不包含重覆值)


-- 1.SQL查詢子句之間，欄位個數必須一致
-- 2.SQL查詢子句之間，欄位型態必須一致(MySQL無此限制)
-- 3.SQL查詢子句之間，欄位名稱不須一致
-- NULL,1,2
SELECT GEOGRAPHY_ID FROM store_information
UNION
-- 1,2,3
SELECT GEOGRAPHY_ID FROM geography;

-- FULL JOIN = LEFT JOIN + RIGHT JOIN
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, S.STORE_DATE
FROM geography G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
UNION
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, S.STORE_DATE
FROM geography G RIGHT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 3.SQL查詢子句之間，欄位名稱不須一致
SELECT STORE_NAME FROM store_information
UNION
-- 1,2,3
SELECT REGION_NAME FROM geography;

--   SQL UNION ALL 聯集(包含重覆值)
-- NULL,1,2
SELECT GEOGRAPHY_ID FROM store_information
UNION ALL
-- 1,2,3
SELECT GEOGRAPHY_ID FROM geography;


--   SQL INTERSECT 交集
-- MySQL不支援INTERSECT

/*
-- NULL,1,2
SELECT GEOGRAPHY_ID FROM store_information
INTERSECT
-- 1,2,3
SELECT GEOGRAPHY_ID FROM geography;
*/

-- MySQL INTERSECT 替代方案
-- https://www.yiibai.com/mysql/sql-union-mysql.html
-- INNER JOIN + DISTINCT = INTERSECT 查詢交集結果
SELECT DISTINCT S.GEOGRAPHY_ID 
FROM store_information S 
JOIN geography G ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;


--   SQL MINUS 排除(不包含重覆值)
-- MySQL不支援
-- MINUS (Oracle)、EXCEPT (MS SQL)
/*
-- 1,2,3
SELECT GEOGRAPHY_ID FROM geography
MINUS
-- NULL,1,2
SELECT GEOGRAPHY_ID FROM store_information;
結果:3
*/

-- https://www.yiibai.com/mysql/minus.html
-- LEFT JOIN + table2.id IS NULL = MINUS
SELECT G.GEOGRAPHY_ID
FROM geography G
LEFT JOIN store_information S ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;

--   SQL SubQuery 子查詢

-- 『簡單子查詢』 (Simple Subquery)
-- 營業額最高的商店
-- 外查詢
SELECT * FROM store_information
WHERE SALES = (
	-- 內查詢
	SELECT MAX(SALES) FROM store_information
);

-- 『相關子查詢』(Correlated Subquery)
-- 外查詢
SELECT S.*
FROM store_information S
WHERE S.GEOGRAPHY_ID IN (
	-- 內查詢
	SELECT G.GEOGRAPHY_ID FROM geography G
    WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
);

SELECT G.*, S.*
FROM (
	SELECT GEOGRAPHY_ID, REGION_NAME FROM geography
) G,
(
	SELECT STORE_ID, SALES, STORE_NAME, STORE_DATE, GEOGRAPHY_ID FROM store_information
)S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

--   SQL EXISTS 存在式關聯查詢
--   SQL CASE WHEN 條件查詢




