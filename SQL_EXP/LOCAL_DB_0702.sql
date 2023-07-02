SELECT STORE_NAME FROM STORE_INFORMATION;

SELECT STORE_ID,STORE_NAME,SALES FROM STORE_INFORMATION;

SELECT STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID FROM STORE_INFORMATION;

SELECT * FROM STORE_INFORMATION;

-- DISTINCT
-- 找出表格內的不同資料值的情況
-- 1.以整列資料列為去重覆為依據
-- 2.DISTINCT只能一次
-- 3.DISTINCT只能下在欄位的最前面
SELECT DISTINCT STORE_NAME FROM STORE_INFORMATION;

SELECT DISTINCT STORE_ID, STORE_NAME FROM STORE_INFORMATION;

SELECT * FROM STORE_INFORMATION WHERE SALES > 1000;

-- AND 嚴謹(資料限縮)
-- OR 寬鬆(資料擴展)
SELECT * FROM STORE_INFORMATION
WHERE SALES > 1000
OR (SALES > 270 AND SALES < 500);

SELECT * 
FROM STORE_INFORMATION
WHERE GEOGRAPHY_ID = 2
AND SALES >= 300;

SELECT * 
FROM STORE_INFORMATION
WHERE STORE_ID = 1
OR STORE_ID = 2
OR STORE_ID = 3;

SELECT * 
FROM STORE_INFORMATION
WHERE STORE_ID IN (1,2,3);

SELECT * 
FROM STORE_INFORMATION
WHERE STORE_NAME IN ('Boston', 'Los Angeles');

SELECT * 
FROM STORE_INFORMATION
WHERE SALES >= 300 AND SALES <= 2500;

-- BETWEEN 則是讓我們可以運用一個範圍 (range) 內 抓出資料庫中的值
SELECT * 
FROM STORE_INFORMATION
WHERE SALES BETWEEN 300 AND 2500;

SELECT * 
FROM STORE_INFORMATION
WHERE STORE_DATE BETWEEN '2018-02-01' AND '2018-05-30';


SELECT * 
FROM STORE_INFORMATION
WHERE STORE_NAME LIKE 'B%';

SELECT * 
FROM STORE_INFORMATION
WHERE STORE_NAME LIKE '%s';

SELECT * 
FROM STORE_INFORMATION
WHERE STORE_NAME LIKE '%An%';

SELECT * 
FROM STORE_INFORMATION
WHERE STORE_NAME LIKE 'L%s';

/*
1.「且」找出屬於西區的商店
2.「且」營業額大於300(包含300)
3.「且」商店名稱"L"開頭
4.「或」營業日介於2018年3月至4月
*/
SELECT * 
FROM STORE_INFORMATION
WHERE GEOGRAPHY_ID = 2
AND SALES >= 300
AND STORE_NAME LIKE 'L%'
OR STORE_DATE BETWEEN '2018-03-01' AND '2018-04-30';


SELECT STORE_ID, STORE_NAME, SALES, STORE_DATE,
	DATE_FORMAT(STORE_DATE, '%Y-%m')
FROM STORE_INFORMATION
WHERE DATE_FORMAT(STORE_DATE, '%Y-%m') BETWEEN '2018-03' AND '2018-05';


-- ASC(預設)
-- 小往大 (ascending) 
SELECT * 
FROM STORE_INFORMATION
ORDER BY SALES ASC;

-- DESC
-- 由大往小(descending)
SELECT * 
FROM STORE_INFORMATION
ORDER BY SALES DESC;

-- ASC(預設)
SELECT * 
FROM STORE_INFORMATION
ORDER BY SALES;

-- 主排序欄位:SALES(營業額)
-- 次排序欄位:STORE_DATE(營業日)
SELECT * 
FROM STORE_INFORMATION
ORDER BY SALES DESC, STORE_DATE DESC;


-- SQL Aggregate Functions 聚合函數
SELECT SUM(SALES), COUNT(STORE_ID), AVG(SALES),
	MIN(SALES), MAX(SALES)
FROM STORE_INFORMATION;

-- NULL:空值
-- 找出空值的筆數
SELECT COUNT(STORE_ID) 
FROM STORE_INFORMATION
WHERE GEOGRAPHY_ID IS NULL;

-- 找出非空值的筆數
SELECT COUNT(STORE_ID) 
FROM STORE_INFORMATION
WHERE GEOGRAPHY_ID IS NOT NULL;


-- COUNT 和 DISTINCT 經常被合起來使用，目的是找
-- 出表格中有多少筆不同的資料(EX:非重覆商店名稱個數)

SELECT COUNT(DISTINCT STORE_NAME)
FROM STORE_INFORMATION;


SELECT * FROM STORE_INFORMATION
ORDER BY STORE_NAME, SALES;

-- 各別商店(以商店名稱分群)的加總營業額、平均業額額、商店個數
-- PS:其它非群組的欄位必須指定聚合的方式(否則無法執行)
SELECT STORE_NAME, SUM(SALES), AVG(SALES), COUNT(STORE_ID),
	MIN(SALES), MAX(SALES)
FROM STORE_INFORMATION
GROUP BY STORE_NAME;

-- 以多個欄位做資料分群
SELECT STORE_ID, STORE_NAME
FROM STORE_INFORMATION
GROUP BY STORE_ID, STORE_NAME;

-- MySQL(GROUP_CONCAT)
-- 群組資料清單
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID),
	GROUP_CONCAT(SALES ORDER BY SALES DESC SEPARATOR '/')
FROM STORE_INFORMATION
GROUP BY STORE_NAME;

-- Oracle(LISTAGG)
-- 群組資料清單
/*
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID),
	LISTAGG(SALES, ',') WITHIN GROUP (ORDER BY SALES DESC)
FROM STORE_INFORMATION
GROUP BY STORE_NAME;
*/

-- MS SQL(STRING_AGG)
-- 群組資料清單
/*
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID),
	STRING_AGG(SALES, ',') WITHIN GROUP (ORDER BY SALES DESC)
FROM STORE_INFORMATION
GROUP BY STORE_NAME;
*/


-- HAVING:對函數產生的值來設定條件查尋
-- SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY
SELECT STORE_NAME, SUM(SALES)
FROM STORE_INFORMATION
WHERE SALES > 0
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 3000
ORDER BY SUM(SALES) ASC;

-- alias (別名)
-- 欄位別名及表格別名
-- 1.別名使用雙引號括起來
-- 2.AS可以省略不寫
-- 3.雙引號可以省略(別名不可以有空白)
SELECT STORE_NAME, 
	SUM(SALES) SUM_SALES, 
	COUNT(STORE_ID) "COUNT_STORE",
	GROUP_CONCAT(SALES ORDER BY SALES DESC SEPARATOR '/') AS "GROUP_SALES_LIST"
FROM STORE_INFORMATION
GROUP BY STORE_NAME;

-- 表格別名.表格欄位
SELECT S.STORE_ID, S.STORE_NAME, S.SALES
FROM STORE_INFORMATION S;


