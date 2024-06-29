-- Alias (別名) 在 SQL 上的用處。最常用到的別名有兩種： "欄位別名"及表格別名
-- 1.使用"雙引號"
-- 2.可省略"雙引號"但是別名中間不可以有白空
-- 3.AS可省略
SELECT STORE_NAME, SUM(SALES) "營業額加總", 
	COUNT(STORE_ID) AS COUNT_STORE,
	GROUP_CONCAT(SALES ORDER BY SALES DESC SEPARATOR '/') AS "GROUP_SALES_LIST"
FROM store_information
GROUP BY STORE_NAME;