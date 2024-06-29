-- Alias (別名) 在 SQL 上的用處。最常用到的別名有兩種： "欄位別名"及表格別名

-- "欄位別名"
-- 1.使用"雙引號"
-- 2.可省略"雙引號"但是別名中間不可以有白空
-- 3.AS可省略
SELECT STORE_NAME, SUM(SALES) "營業額加總", 
	COUNT(STORE_ID) AS COUNT_STORE,
	GROUP_CONCAT(SALES ORDER BY SALES DESC SEPARATOR '/') AS "GROUP_SALES_LIST"
FROM store_information
GROUP BY STORE_NAME;

-- 表格別名
-- 表格別名.表格欄位 AS "欄位別名"
SELECT S.STORE_ID, S.STORE_NAME AS "商店名稱"
FROM store_information S;

-- 透過WHERE的方式將兩張資料表欄位關聯(JOIN連接)在一起
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S, geography G
WHERE S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S, geography G;


-- 內部連接 (INNER JOIN...ON)
-- INNER 可省略不寫
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S INNER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- 左外部連接(LEFT JOIN or LEFT OUTER JOIN)
-- OUTER 可省略不寫
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S LEFT OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- 右外部連接 (RIGHT JOIN or RIGHT OUTER JOIN)
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, 
	G.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S RIGHT OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- FULL OUTER JOIN (MySQL支援)
/*
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, 
	G.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S FULL OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;
*/

-- 只取"左半邊未交集"的資料結果
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, 
	G.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S LEFT OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
WHERE G.GEOGRAPHY_ID IS NULL;

-- 只取"右半邊未交集"的資料結果
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, 
	G.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S RIGHT OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;

-- 只取"左右半邊未交集"的資料結果
/*
SELECT S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, 
	G.GEOGRAPHY_ID, G.REGION_NAME
FROM store_information S FULL OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL
OR G.GEOGRAPHY_ID IS NULL;
*/
