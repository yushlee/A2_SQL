
-- UNION (聯集去重覆)
-- 1.查詢欄位個數必須一致
-- 2.查詢欄位型態必須一致(MySQL無此限制)
SELECT STORE_NAME FROM store_information
UNION
SELECT REGION_NAME FROM geography;

-- MySQL FULL JOIN替代方案
SELECT G.*, S.* 
FROM geography G  LEFT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
UNION
SELECT G.*, S.*  
FROM geography G  RIGHT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- UNION ALL(聯集包含重覆)
SELECT STORE_NAME FROM store_information
UNION ALL
SELECT REGION_NAME FROM geography;

-- INTERSECT(MySQL不支援)
-- SELECT GEOGRAPHY_ID FROM geography
-- INTERSECT
-- SELECT GEOGRAPHY_ID FROM store_information;


-- https://www.yiibai.com/mysql/sql-union-mysql.html
-- INNER JOIN + DISTINCT = INTERSECT 查詢交集結果
SELECT DISTINCT G.GEOGRAPHY_ID
FROM geography G, store_information S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- MySQL不支援MINUS
-- 1,2,3
-- SELECT GEOGRAPHY_ID FROM geography
-- MINUS
-- 1,2,NULL
-- SELECT GEOGRAPHY_ID FROM store_information;

-- https://www.yiibai.com/mysql/minus.html
-- LEFT JOIN + table2.id IS NULL = MINUS

SELECT G.GEOGRAPHY_ID
FROM geography G LEFT JOIN store_information S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;




