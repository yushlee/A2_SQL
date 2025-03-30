
SELECT STORE_NAME, SUBSTR(STORE_NAME, 3), 
	SUBSTR(STORE_NAME, 3, 3), 
    SUBSTR(STORE_NAME, 1, 3) 
FROM store_information;


SELECT STORE_NAME, LTRIM(STORE_NAME), RTRIM(STORE_NAME), TRIM(STORE_NAME) 
FROM store_information;


--   SQL UNION 聯集(不包含重覆值)
-- 1.資料會去重覆
-- 2.查詢語句之間「欄位個數」必須相同
-- 3.查詢語句之間「欄位型態」必須相同
SELECT STORE_NAME FROM store_information
UNION
SELECT REGION_NAME  FROM geography
UNION
SELECT FIRST_NAME FROM  employees;


-- MySQL不支援FULL JOIN
-- 使用 UNION 聯集 LEFT JOIN + RIGHT JOIN
SELECT S.*, G.*
FROM store_information S LEFT JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
UNION
SELECT S.*, G.*
FROM store_information S RIGHT JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--   SQL UNION ALL 聯集(包含重覆值)
SELECT 'STORE' DATA_TYPE, STORE_NAME FROM store_information
UNION ALL
SELECT 'GEOG' DATA_TYPE, REGION_NAME  FROM geography;


--   SQL INTERSECT 交集
-- MySQL不支援 INTERSECT
-- 1,2,NULL
-- SELECT GEOGRAPHY_ID FROM STORE_INFORMATION
-- INTERSECT
-- 1,2,3
-- SELECT GEOGRAPHY_ID FROM GEOGRAPHY;


-- INNER JOIN + DISTINCT = INTERSECT 查詢交集結果
SELECT DISTINCT S.GEOGRAPHY_ID 
FROM STORE_INFORMATION S JOIN GEOGRAPHY G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--   SQL MINUS 排除(不包含重覆值) 

-- MS SQL(EXCEPT)
-- 1,2,3
-- SELECT GEOGRAPHY_ID FROM GEOGRAPHY
-- EXCEPT
-- 1,2,NULL
-- SELECT GEOGRAPHY_ID FROM STORE_INFORMATION;

-- Oracle(MINUS)
-- 1,2,3
-- SELECT GEOGRAPHY_ID FROM GEOGRAPHY
-- MINUS
-- 1,2,NULL
-- SELECT GEOGRAPHY_ID FROM STORE_INFORMATION;

-- LEFT JOIN + table2.id IS NULL = MINUS
SELECT G.GEOGRAPHY_ID
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;



--   SQL SubQuery 子查詢
--   SQL EXISTS 存在式關聯查詢
 --  SQL IF、CASE WHEN 條件式查詢



