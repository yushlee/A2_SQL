SELECT S.*, G.* 
FROM store_information S, geography G 
WHERE S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- 內部連接
-- INNER JOIN...ON
SELECT G.*, S.*  
FROM geography G INNER JOIN store_information S  
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


SELECT G.*, S.*  
FROM geography G  LEFT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

SELECT G.*, S.*  
FROM geography G  RIGHT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- MySQL 不支援FULL OUTER JOIN
-- SELECT G.*, S.*  
-- FROM geography G  FULL OUTER JOIN store_information S 
-- ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- cross join
SELECT S.*, G.* 
FROM store_information S, geography G;

SELECT G.*, S.*  
FROM geography G  LEFT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;

SELECT G.*, S.*  
FROM geography G  RIGHT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE G.GEOGRAPHY_ID IS NULL;

-- SELECT G.*, S.*  
-- FROM geography G  FULL OUTER JOIN store_information S 
-- ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
-- WHERE G.GEOGRAPHY_ID IS NULL OR S.GEOGRAPHY_ID IS NULL;

-- SQL 練習題(三)
-- 查詢各區域的營業額總計
-- 資料結果依營業額總計由大到小排序
-- (不論該區域底下是否有所屬商店)
SELECT G.REGION_NAME, IFNULL(SUM(S.SALES), 0) REGION_SUM_SALES
FROM geography G  LEFT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY REGION_SUM_SALES DESC;

-- 查詢各區域的商店個數
-- 資料結果依區域的商店個數由大至小排序
-- (依據商店名稱,不包含重覆的商店)
-- (不論該區域底下是否有所屬商店)
SELECT G.REGION_NAME, COUNT(DISTINCT S.STORE_NAME) REGION_COUNT
FROM geography G  LEFT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY REGION_COUNT DESC;


SELECT CONCAT(STORE_ID, '_', STORE_NAME, '_$', SALES)
FROM store_information;


SELECT STORE_NAME, SUBSTR(STORE_NAME, 3), SUBSTR(STORE_NAME, 1, 3) 
FROM store_information;


SELECT STORE_NAME, LTRIM(STORE_NAME),  RTRIM(STORE_NAME), TRIM(STORE_NAME)
FROM store_information;
