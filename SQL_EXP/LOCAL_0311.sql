-- 利用WHERE的方式JOIN
SELECT G.*, S.* 
FROM GEOGRAPHY G, STORE_INFORMATION S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 內部連接 (INNER JOIN)
-- INNER JOIN TABLE ON COLUMN
-- INNER可省略不寫
SELECT G.*, S.* 
FROM GEOGRAPHY G INNER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- 左外部連接(LEFT JOIN or LEFT OUTER JOIN)
-- OUTER可省略不寫
SELECT G.*, S.* 
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- 右外部連接 (RIGHT JOIN or RIGHT OUTER JOIN)
SELECT G.*, S.* 
FROM GEOGRAPHY G RIGHT OUTER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 全外部連接 (FULL JOIN or FULL OUTER JOIN)
-- MySQL不支援FULL JOIN
/*
SELECT G.*, S.* 
FROM GEOGRAPHY G FULL JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;
*/

-- LEFT JOIN - INNER JOIN
SELECT G.*, S.* 
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;


-- RIGHT JOIN - INNER JOIN
SELECT G.*, S.* 
FROM GEOGRAPHY G RIGHT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE G.GEOGRAPHY_ID IS NULL;


-- FULL JOIN - INNER JOIN
/*
SELECT G.*, S.* 
FROM GEOGRAPHY G FULL JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE G.GEOGRAPHY_ID IS NULL
OR S.GEOGRAPHY_ID IS NULL;
*/

-- 由不同欄位獲得的資料串連在一起
SELECT CONCAT(STORE_ID, '-', STORE_NAME, '-', SALES)
FROM STORE_INFORMATION;

-- SUBSTRING 子字串
-- substring函數是用來抓出一個欄位資料中的其中一部分
SELECT STORE_NAME, SUBSTRING(STORE_NAME, 2), SUBSTRING(STORE_NAME, 2, 3)
FROM STORE_INFORMATION;


SELECT STORE_ID, STORE_NAME, LTRIM(STORE_NAME), RTRIM(STORE_NAME)
FROM STORE_INFORMATION;


-- TRIM([[位置] [要移除的字串] FROM ] 字串)
-- [位置] 的可能值為 LEADING (起頭), TRAILING (結尾), or BOTH (起頭及結尾)
SELECT STORE_ID, STORE_NAME,
    TRIM(LEADING 'Bos' FROM STORE_NAME),
    TRIM(TRAILING 's' FROM STORE_NAME),
    TRIM(BOTH 'L' FROM STORE_NAME)
FROM STORE_INFORMATION;

-- SQL 練習題(二)
-- 計算和統計「個別商店」的以下三項資料：
-- 「總合營業額」、「商店資料個數」、「平均營業額」
-- 搜尋或排除條件如下：
-- 排除「平均營業額」1000(含)以下的商店資料
-- 排除「商店資料個數」1(含)個以下的商店資料
-- 依照「平均營業額」由大至小排序
-- PS:使用別名語法簡化「表格名稱」及查詢結果「欄位名稱」
SELECT STORE_NAME, SUM(SALES) "SUM_SALES", 
	COUNT(STORE_ID) "COUNT_STORE", AVG(SALES) "AVG_SALES"
FROM STORE_INFORMATION
GROUP BY STORE_NAME
HAVING AVG(SALES) > 1000
AND COUNT(STORE_ID) > 1
ORDER BY AVG(SALES) DESC;


-- SQL 練習題(3-1)
-- 查詢各區域的營業額總計
-- 資料結果依營業額總計由大到小排序
-- (不論該區域底下是否有所屬商店)
-- FROM GEOGRAPHY G FULL JOIN STORE_INFORMATION S
SELECT G.REGION_NAME, IFNULL(SUM(S.SALES), 0)
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY SUM(S.SALES) DESC;

-- Oracle NVL
-- MS SQL ISNULL
-- MySQL
SELECT IFNULL(NULL, 'VALUE');

-- SQL 練習題(3-2)
-- 查詢各區域的商店個數
-- 資料結果依區域的商店個數由大至小排序
-- (依據商店名稱,不包含重覆的商店)
-- (不論該區域底下是否有所屬商店)
SELECT G.REGION_NAME, COUNT(DISTINCT S.STORE_NAME) "STORE_COUNT"
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY COUNT(DISTINCT S.STORE_NAME) DESC;

/*
NUMBER( P, S )
P：表示數字總共的位數
S：表示小數的位數

NUMBER(5, 2)
表示數值共5位數(包含固定最多2位小數、故整數位最多只能為3碼數字)
小數點第3位自動進位至第2位
123.455 → 123.46

NUMBER( 5, -2)
表示數值共5位「整數」-2表示數值自動進位至百位數
12355 → 12400
*/

/*
1.主鍵 (Primary Key) 中的每一筆資料都是表格中的唯一值。
2.主鍵可以包含一或多個欄位。當主鍵包含多個欄位時，稱為組合鍵 (Composite Key)。
3.Primary Key不允許NULL、UNIQUE允許NULL
*/
/*
外來鍵(Foreign Key)是一個(或數個)指向另外一個表格主鍵的欄位。
外來鍵的目的是確定資料的參考完整性(referential integrity)
*/

-- One to One 一對一關係
-- A資料表中的單筆資料記錄同時只能對應到B資料表的一筆記錄
-- 政府官員州長
CREATE TABLE Gov(
    GID NUMERIC(3) PRIMARY KEY,
    Name VARCHAR(25),
    Address VARCHAR(30),
    TermBegin date,
    TermEnd date
);

-- 州
-- REFERENCES(參照)、CONSTRAINT(限制)、UNIQUE(唯一)
CREATE TABLE State(
    SID NUMERIC(3) PRIMARY KEY,
    StateName VARCHAR(15),
    Population NUMERIC(10),
    SGID NUMERIC(4),
    CONSTRAINT CONSTRAINT_SGID_UNIQUE UNIQUE (SGID),
	CONSTRAINT CONSTRAINT_FK_GOV_GID FOREIGN KEY (SGID) REFERENCES Gov(GID)
);

INSERT INTO Gov (GID, Name, Address, TermBegin, TERMEND) VALUES (110, 'Bob', '123 Any St', '2009-01-01', '2011-12-31');

INSERT INTO State (SID, StateName, Population, SGID) VALUES (111, 'Virginia', 2000000, 110);

-- One to Many 一對多關係
-- A資料表中的單筆資料記錄同時可以對應到B資料表的多筆記錄
-- 供應商
CREATE TABLE Vendor(
    VendorNUMERIC NUMERIC(4) PRIMARY KEY,
    Name VARCHAR(20),
    Address VARCHAR(200),
    City VARCHAR(15),
    Street VARCHAR(200),
    ZipCode VARCHAR(10),
    PhoneNUMERIC VARCHAR(12),
    Status VARCHAR(50)
);

-- 商品清單
CREATE TABLE Inventory(
    Item VARCHAR(50) PRIMARY KEY,
    Description VARCHAR(300),
    CurrentQuantity NUMERIC(4) NOT NULL,
    VendorNUMERIC NUMERIC(4),
	CONSTRAINT CONSTRAINT_VENDOR_FK FOREIGN KEY (VendorNUMERIC) REFERENCES Vendor(VendorNUMERIC)
);

INSERT INTO Vendor (VENDORNUMERIC, NAME, ADDRESS, CITY, STREET, ZIPCODE, PHONENUMERIC, STATUS) VALUES ('1', 'Apple Inc', '大同區承德路一段1號1樓', '台北市', '承德路', '10351', '02 7743 8068', '營運中');
INSERT INTO Inventory (ITEM, DESCRIPTION, CURRENTQUANTITY, VENDORNUMERIC) VALUES ('iPhone 7 Plus', 'iPhone 7 Plus 5.5吋手機 32GB(原廠包裝盒+原廠配件)', '10', '1');

-- Many to Many 多對多關係(雙向一對多)
-- A資料表中的多筆資料記錄同時可以對應到B資料表的多筆記錄
-- 例如一位學生可以選擇多門課，一門課也可以同時被多位學生選擇

-- 課程科目
CREATE TABLE Class(
    ClassID VARCHAR(20) PRIMARY KEY,
    ClassName VARCHAR(300),
    Instructor VARCHAR(100)
);

-- 學生
CREATE TABLE Student(
    StudentID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Major VARCHAR(100),
    ClassYear VARCHAR(50)
);

--
-- UNIQUE (StudentID, ClassID)
-- 表示一位學生只能選擇同樣的課程一次不得重覆
CREATE TABLE ClassStudent_Relation(
    StudentID VARCHAR(20) NOT NULL,
    ClassID VARCHAR(20) NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    UNIQUE (StudentID, ClassID)
);

INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('1', '國文', '朱媽');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('2', '數學', '凡清');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('3', '英文', '高國華');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('4', '理化', '阿飛');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('5', '物理', '簡杰');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('6', '歷史', '呂杰');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('7', '地理', '王剛');

INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('1', '馬小九', '資訊管理', '大二');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('2', '輸真慘', '資訊工程', '大一');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('3', '菜英蚊', '企業管理', '大三');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('4', '豬利輪', '財務金融', '大二');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('5', '韓國魚', '應用外語', '碩二');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('6', '賣臺銘', '國際貿易', '大一');

INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('1', '1');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('1', '3');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('2', '1');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('3', '1');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('3', '2');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('3', '5');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('5', '6');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('6', '6');

-- 資料操作語言 DML (Data Manipulation Language)
-- 1.INSERT 新增資料到資料表中
INSERT INTO store_information (STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID)
	VALUES(10, 'AppleInc', 5600, '2023-03-11 00:00:00', 3);

-- 2.UPDATE 更改資料表中的資料
UPDATE store_information SET STORE_NAME ='HTC', SALES=1600 WHERE STORE_ID = 10;

-- 3.DELETE 刪除資料表中的資料
DELETE FROM store_information WHERE STORE_ID = 10;

