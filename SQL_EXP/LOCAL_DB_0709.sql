SELECT STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID FROM store_information;

-- 將兩張資料表連接在一起,透過WHERE子句欄位做關聯查詢
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G, STORE_INFORMATION S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 交叉連接(cross join)
-- 交叉連接為兩個資料表間的笛卡兒乘積 (Cartesian product)，兩個資料表在結合時，
-- 不指定任何條件，即將兩個資料表中所有的可能排列組合出來
-- GEOGRAPHY * 3
-- STORE_INFORMATION * 9
-- CROSS JOIN 3 * 9 = 27
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G, STORE_INFORMATION S;

-- 內部連接 (INNER JOIN...ON)
-- INNER 可省略不寫
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G INNER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- 左外部連接(LEFT JOIN or LEFT OUTER JOIN)
-- 查詢的 SQL 敘述句 LEFT JOIN 左側資料表的所有記錄都會加入到查詢結果中，即使右側資料表中的連接欄位沒有符合的值也一樣。
-- OUTER 可省略不寫
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G LEFT OUTER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 右外部連接 (RIGHT JOIN or RIGHT OUTER JOIN)
-- 查詢的 SQL 敘述句 RIGHT JOIN 右側資料表的所有記錄都會加入到查詢結果中，即使左側資料表中的連接欄位沒有符合的值也一樣。
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G RIGHT OUTER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 全外部連接 (FULL JOIN or FULL OUTER JOIN)
-- 查詢的 SQL 敘述句 FULL JOIN 左側資料表及右側資料表的所有記錄都會加入到查詢結果中。
-- MySQL不支援 FULL OUTER JOIN
/*
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G FULL OUTER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;
*/

-- LEFT JOIN - INNER JOIN
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;

-- RIGHT JOIN - INNER JOIN
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G RIGHT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE G.GEOGRAPHY_ID IS NULL;

-- FULL JOIN - INNER JOIN
/*
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G FULL OUTER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE G.GEOGRAPHY_ID IS NULL 
OR S.GEOGRAPHY_ID IS NULL;
*/

/*
SQL 練習題(二)
計算和統計「個別商店」的以下三項資料：
「總合營業額」、「商店資料個數」、「平均營業額」
搜尋或排除條件如下：
排除「平均營業額」1000(含)以下的商店資料
排除「商店資料個數」1(含)個以下的商店資料
依照「平均營業額」由大至小排序
PS:使用別名語法簡化「表格名稱」及查詢結果「欄位名稱」
*/
SELECT  S.STORE_NAME, SUM(S.SALES) "SUM_SALES", 
	COUNT(S.STORE_ID) "COUNT_STORE", FLOOR(AVG(S.SALES)) "AVG_SALES"
FROM STORE_INFORMATION S
GROUP BY S.STORE_NAME
HAVING FLOOR(AVG(S.SALES)) > 1000
AND COUNT(S.STORE_ID) > 1
ORDER BY FLOOR(AVG(S.SALES)) DESC;

/*
SQL 練習題(3-1)
查詢各區域的營業額總計
資料結果依營業額總計由大到小排序
(不論該區域底下是否有所屬商店)
*/
SELECT G.REGION_NAME, IFNULL(SUM(S.SALES),0) "REGION_SUM"
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY REGION_SUM DESC;

/*
SQL 練習題(3-2)
查詢各區域的商店個數
資料結果依區域的商店個數由大至小排序
(依據商店名稱,不包含重覆的商店)
(不論該區域底下是否有所屬商店)
*/
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

