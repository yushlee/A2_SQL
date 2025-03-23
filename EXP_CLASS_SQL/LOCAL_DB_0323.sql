
-- alias (別名) 在 SQL 上的用處。最常用到的別名有兩種： 欄位別名及表格別名
-- 欄位別名
-- 1.AS別名語句可省略不寫
-- 2.AS別名雙引號可省略不寫(PS:別名不可以包含空白)
-- 3.AS別名使用雙引號(PS:別名可以包含空白)
SELECT STORE_NAME, SUM(SALES) "SUM SALSE", COUNT(STORE_ID) "STORE_COUNT", 
	GROUP_CONCAT(SALES ORDER BY SALES SEPARATOR '/') AS "SALES_LIST"
FROM store_information
GROUP BY STORE_NAME;


-- 表格別名
-- 1.表格別名不須加 AS(PS:習慣上不加AS)
-- 2.表格別名不須加雙引號
SELECT S.STORE_ID, S.STORE_NAME, S.SALES
FROM store_information S;


-- 透過WHERE將欄位資料關聯達到表單連結
SELECT S.*, G.*
FROM store_information S, geography G
WHERE S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- 內部連接 (INNER JOIN)
-- INNER JOIN ... ON (PS:INNER可省略)
SELECT S.*, G.*
FROM store_information S INNER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- 左外部連接
-- LEFT OUTER JOIN ... ON (PS:OUTER可省略)
SELECT S.*, G.*
FROM store_information S LEFT OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;


-- 右外部連接
-- RITGHT OUTER JOIN ... ON (PS:OUTER可省略)
SELECT S.*, G.*
FROM store_information S RIGHT OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- MySQL不支援FULL JOIN
-- SELECT S.*, G.*
-- FROM store_information S FULL JOIN geography G
-- ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- 交叉連接(cross join)
-- 商店9筆、區域3筆:27
SELECT S.*, G.*
FROM store_information S, geography G;



SELECT S.*, G.*
FROM store_information S LEFT OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
WHERE  G.GEOGRAPHY_ID IS NULL;


SELECT S.*, G.*
FROM store_information S RIGHT OUTER JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;


-- SELECT S.*, G.*
-- FROM store_information S FULL JOIN geography G
-- ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
-- WHERE S.GEOGRAPHY_ID IS NULL 
-- OR G.GEOGRAPHY_ID IS NULL;


-- SQL 練習題(三)
-- 查詢各區域的營業額總計
-- 資料結果依營業額總計由大到小排序
-- (不論該區域底下是否有所屬商店)
-- My NULL 函數 IFNULL()
-- MS SQL NULL 函數 ISNULL
SELECT G.REGION_NAME, IFNULL(SUM(S.SALES), 0) "SUM_SALES"
FROM geography G LEFT JOIN store_information S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY SUM_SALES DESC;

-- 查詢各區域的商店個數
-- 資料結果依區域的商店個數由大至小排序
-- (依據商店名稱,不包含重覆的商店)
-- (不論該區域底下是否有所屬商店)
SELECT G.REGION_NAME, COUNT(DISTINCT S.STORE_NAME) "COUNT_STORE"
FROM geography G LEFT JOIN store_information S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY COUNT_STORE DESC;

SELECT * FROM store_information;

-- 資料新增
INSERT INTO store_information (STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID, OPEN_STATUS) VALUES(10, 'Apple store', 3600, '2018-07-07', 3, 1);

INSERT INTO store_information_2 (STORE_ID, STORE_NAME)
SELECT STORE_ID, STORE_NAME FROM store_information;


-- 資料修改
UPDATE store_information SET STORE_NAME = 'Apple Inc', SALES = 3700 WHERE STORE_ID = 10;

-- 資料刪除
DELETE FROM store_information WHERE STORE_ID = 10;

-- 交易提交
COMMIT;
-- 交易取消(回滾)
ROLLBACK;


SELECT CONCAT(STORE_ID, '_', STORE_NAME, '_', GEOGRAPHY_ID) "STORE_DATE" FROM store_information;


