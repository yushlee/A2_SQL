-- 1421.NPV Queries

-- Table: NPV
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | year          | int     |
-- | npv           | int     |
-- +---------------+---------+
-- (id, year) is the primary key of this table.
-- The table has information about the id and the year of each inventory and the corresponding net present value.
-- 該表包含有關每個庫存的編號和年份以及相應的淨現值(npv)的信息


-- Table: Queries
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | year          | int     |
-- +---------------+---------+
-- (id, year) is the primary key of this table.
-- The table has information about the id and the year of each inventory query.
-- 該表包含有關每個庫存查詢的 ID 和年份的信息

-- Write an SQL query to find the npv of all each query of queries table.
-- 查詢queries表中每一條記錄的npv值，以任何順序返回結果表

-- Return the result table in any order.

-- NPV table:
-- +------+--------+--------+
-- | id   | year   | npv    |
-- +------+--------+--------+
-- | 1    | 2018   | 100    |
-- | 7    | 2020   | 30     |
-- | 13   | 2019   | 40     |
-- | 1    | 2019   | 113    |
-- | 2    | 2008   | 121    |
-- | 3    | 2009   | 12     |
-- | 11   | 2020   | 99     |
-- | 7    | 2019   | 0      |
-- +------+--------+--------+

-- Queries table:
-- +------+--------+
-- | id   | year   |
-- +------+--------+
-- | 1    | 2019   |
-- | 2    | 2008   |
-- | 3    | 2009   |
-- | 7    | 2018   |
-- | 7    | 2019   |
-- | 7    | 2020   |
-- | 13   | 2019   |
-- +------+--------+

-- The query result format is in the following example:
-- Result table:
-- +------+--------+--------+
-- | id   | year   | npv    |
-- +------+--------+--------+
-- | 1    | 2019   | 113    |
-- | 2    | 2008   | 121    |
-- | 3    | 2009   | 12     |
-- | 7    | 2018   | 0      |
-- | 7    | 2019   | 0      |
-- | 7    | 2020   | 30     |
-- | 13   | 2019   | 40     |
-- +------+--------+--------+
-- The npv value of (7, 2018) is not present in the NPV table, we consider it 0.
-- The npv values of all other queries can be found in the NPV table.
-- NPV 表中沒有 (7, 2018) 的 npv 值，我們將其視為 0
-- 所有其他查詢的 npv 值都可以在 NPV 表中找到



-- Solution
-- 以QUERIES庫存查詢資料表為主左外側連接NPV淨現值資料表
-- 透過ID查詢編號、YEAR查詢年份兩個欄位關聯
-- 因為在QUERIES資料表中的資料可能不存於於NPV淨現值資料表
-- 所以NPV使用IFNULL函數處理資料為NULL時預設值為0
SELECT Q.ID, Q.YEAR, IFNULL(N.NPV, 0) NPV
FROM QUERIES Q
LEFT JOIN NPV N
ON Q.ID = N.ID AND Q.YEAR = N.YEAR
ORDER BY Q.ID, NPV;
