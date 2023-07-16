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
-- SQL EXISTS 存在式關聯查詢
-- SQL CASE WHEN 條件查詢
