SELECT STORE_NAME FROM STORE_INFORMATION;

SELECT STORE_ID, STORE_NAME FROM STORE_INFORMATION;

SELECT STORE_ID, SALES, STORE_NAME FROM STORE_INFORMATION;

SELECT * FROM STORE_INFORMATION;

-- 欄位資料去重覆
SELECT DISTINCT STORE_NAME FROM STORE_INFORMATION;

-- 1.以整列資料為去重覆的依據
-- 2.DISTINCT位置只能在欄位的最前面
-- 3.DISTINCT只能下一次
SELECT DISTINCT STORE_NAME FROM STORE_INFORMATION;
SELECT DISTINCT STORE_ID, STORE_NAME FROM STORE_INFORMATION;

SELECT * FROM STORE_INFORMATION 
WHERE SALES > 1000;

SELECT * FROM STORE_INFORMATION 
WHERE SALES >= 1500;

-- AND(且):條件同時成立
-- OR(或):條件單一成立
SELECT * FROM STORE_INFORMATION
WHERE SALES > 250 AND STORE_DATE > '2018-04-01';

SELECT * FROM STORE_INFORMATION
WHERE SALES <= 300 OR SALES >= 2500;


SELECT * FROM STORE_INFORMATION
WHERE STORE_ID = 1
OR STORE_ID = 2
OR STORE_ID = 3;

SELECT * FROM STORE_INFORMATION
WHERE STORE_ID IN (1,2,3);

SELECT * FROM STORE_INFORMATION
WHERE STORE_NAME IN ('Los Angeles', 'Boston');


SELECT * FROM STORE_INFORMATION
WHERE SALES >= 300 AND SALES <= 2500;

-- BETWEEN ... AND
SELECT * FROM STORE_INFORMATION
WHERE SALES BETWEEN 300 AND 2500;

SELECT * FROM STORE_INFORMATION
WHERE STORE_DATE BETWEEN '2018-02-01' AND '2018-05-30';


SELECT STORE_ID, STORE_NAME, STORE_DATE, DATE_FORMAT(STORE_DATE, '%Y-%m')
FROM STORE_INFORMATION
WHERE DATE_FORMAT(STORE_DATE, '%Y-%m') BETWEEN '2018-02' AND '2018-05';


SELECT * FROM STORE_INFORMATION
WHERE STORE_NAME LIKE 'B%';

SELECT * FROM STORE_INFORMATION
WHERE STORE_NAME LIKE '%s';

SELECT * FROM STORE_INFORMATION
WHERE STORE_NAME LIKE '%os%';

SELECT * FROM STORE_INFORMATION
WHERE STORE_NAME LIKE 'L%s';

-- BINARY可指定區分大小寫
SELECT * FROM STORE_INFORMATION
WHERE BINARY STORE_NAME LIKE  'l%s';


SELECT * FROM geography;

-- SQL 練習題(一)
SELECT * FROM STORE_INFORMATION
-- 1.「且」找出屬於西區的商店
WHERE GEOGRAPHY_ID = 2
-- 2.「且」營業額大於300(包含300)
AND SALES >= 300
-- 3.「且」商店名稱'L'開頭
AND STORE_NAME LIKE 'L%'
-- 4.「或」營業日介於2018年3月至4月
OR STORE_DATE BETWEEN '2018-03-01' AND '2018-04-30';

-- ASC:預設是升幕排序
-- DESC:降幕排序
SELECT * FROM STORE_INFORMATION
ORDER BY SALES ASC;

SELECT * FROM STORE_INFORMATION
ORDER BY SALES DESC, STORE_DATE DESC;

-- Aggregate Functions 聚合函數
SELECT SUM(SALES), AVG(SALES), COUNT(STORE_ID),
	MAX(SALES), MIN(SALES)
FROM STORE_INFORMATION;

-- 是IS NULL空值的資料筆數
SELECT COUNT(STORE_ID) 
FROM STORE_INFORMATION
WHERE GEOGRAPHY_ID IS NULL;

-- 是IS NOT NULL非空值的資料筆數
SELECT COUNT(STORE_ID) 
FROM STORE_INFORMATION
WHERE GEOGRAPHY_ID IS NOT NULL;

-- 去重覆資料個數 COUNT+ DISTINCT
SELECT COUNT(DISTINCT STORE_NAME) FROM STORE_INFORMATION;

-- 各別商店的加總營業額
-- 分群:GROUP BY、合併聚合函數(其它非群組):SUM,AVG,COUNT,MAX,MIN
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID), AVG(SALES),
	MAX(SALES), MIN(SALES)
FROM STORE_INFORMATION
GROUP BY STORE_NAME;

-- 非群組欄位必須指定聚合函數合併的方式
-- SELECT list is not in GROUP BY clause and contains nonaggregated column 'local.STORE_INFORMATION.SALES' which is not functionally dependent on columns in GROUP BY clause
SELECT STORE_NAME, SALES
FROM STORE_INFORMATION
GROUP BY STORE_NAME;

-- MySQL 群組清單GROUP_CONCAT
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID), 
	GROUP_CONCAT(SALES ORDER BY SALES DESC SEPARATOR '/')
FROM STORE_INFORMATION
GROUP BY STORE_NAME;

-- Oracle 群組清單:LISTAGG
/*
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID), 
	LISTAGG(SALES, '/') WITHIN GROUP (ORDER BY SALES DESC)
FROM STORE_INFORMATION
GROUP BY STORE_NAME;
*/

-- MS SQL Server群組清單:STRING_AGG
/*
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID), 
	STRING_AGG(SALES, '/') WITHIN GROUP (ORDER BY SALES DESC)
FROM STORE_INFORMATION
GROUP BY STORE_NAME;
*/

-- HAVING
-- 對函數產生的值來設定條件查尋
-- 各別商店加總營業額大於3000的商店
-- SQL語法順序
-- SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY
SELECT STORE_NAME, SUM(SALES)
FROM STORE_INFORMATION
-- WHERE SALES > 1000 
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 3000
ORDER BY SUM(SALES) ASC;


-- Alias(別名)
-- 欄位別名及表格別名
-- 1.欄位須用"雙引號"包起來
-- 2.AS可省略
-- 3."雙引號"可省略(別名中間不能有空白)
SELECT STORE_NAME "STORE NAME", 
	SUM(SALES) 加總營業額, 
    COUNT(STORE_ID) "商店個數", 
	GROUP_CONCAT(SALES ORDER BY SALES DESC SEPARATOR '/') AS "GROUP_LIST_SALES"
FROM STORE_INFORMATION
GROUP BY STORE_NAME;

-- 表格別名.欄位
-- 表格別名不需要雙引號
SELECT STORE.STORE_ID, STORE.STORE_NAME
FROM STORE_INFORMATION STORE;

-- Oracle 不支援HAVING搭配別名條件
SELECT STORE_NAME, SUM(SALES) "SUM_SALES"
FROM STORE_INFORMATION
-- WHERE SALES > 1000 
GROUP BY STORE_NAME
HAVING SUM_SALES >= 3000
ORDER BY SUM_SALES ASC;


SELECT * FROM GEOGRAPHY;

SELECT * FROM STORE_INFORMATION
ORDER BY GEOGRAPHY_ID;

-- 表格連結JOIN
SELECT G.*, S.* 
FROM GEOGRAPHY G, STORE_INFORMATION S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 若未下WHERE JOIN 欄位關聯查詢，將會產生所有的資料排列組合的結果
-- 區域:3
-- 商店:9
SELECT G.*, S.* 
FROM GEOGRAPHY G, STORE_INFORMATION S;




