
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


-- JOIN ... ON
SELECT S.*, G.*
FROM store_information S JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;


SELECT S.*, G.*
FROM store_information S LEFT JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;


SELECT S.*, G.*
FROM store_information S RIGHT JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- MySQL不支援FULL JOIN
-- SELECT S.*, G.*
-- FROM store_information S FULL JOIN geography G
-- ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- 商店9筆、區域3筆:27
SELECT S.*, G.*
FROM store_information S, geography G;






