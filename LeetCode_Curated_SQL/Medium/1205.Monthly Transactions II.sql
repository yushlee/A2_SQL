-- 1205.Monthly Transactions II 每月交易

-- Table: Transactions
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | country        | varchar |
-- | state          | enum    |
-- | amount         | int     |
-- | trans_date     | date    |
-- +----------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- 該表包含有關傳入交易的資訊
-- The state column is an enum of type ["approved", "declined"].
-- 下表包含一些交易信息，id是此表的主鍵。state狀態可能的值為["approved批准"、"declined拒絕"]

-- Table: Chargebacks 退款
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | trans_id       | int     |
-- | trans_date    | date    |
-- +----------------+---------+
-- Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
-- trans_id is a foreign key to the id column of Transactions table.
-- Each chargeback corresponds to a transaction made previously even if they were not approved.
-- Chargebacks 包含有關來自放置在 Transactions 表中的某些交易退款的信息
-- trans_id 是 Transactions 表的 id 列的外鍵
-- 每個退款都對應於先前進行的交易，即使它們未獲批准

-- Write an SQL query to find for each month and country, the number of approved transactions and their total amount,
-- the number of chargebacks and their total amount.
-- 查詢 "每個月" 和 "國家" 的 '批准' "交易數量" 及其 "總金額"、'退款' "數量"及其"總金額"

-- Note:In your query, given the month and country, ignore rows with all zeros.
-- Note:在查詢中，給定月份和國家，請忽略全零的資料行

-- The query result format is in the following example:
-- Transactions table:
-- +------+---------+----------+--------+------------+
-- | id   | country | state    | amount | trans_date |
-- +------+---------+----------+--------+------------+
-- | 101  | US      | approved | 1000   | 2019-05-18 |
-- | 102  | US      | declined | 2000   | 2019-05-19 |
-- | 103  | US      | approved | 3000   | 2019-06-10 |
-- | 104  | US      | approved | 4000   | 2019-06-13 |
-- | 105  | US      | approved | 5000   | 2019-06-15 |
-- +------+---------+----------+--------+------------+

-- Chargebacks table:
-- +------------+------------+
-- | trans_id   | trans_date |
-- +------------+------------+
-- | 102        | 2019-05-29 |
-- | 101        | 2019-06-30 |
-- | 105        | 2019-09-18 |
-- +------------+------------+


-- Result table:
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
-- | 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
-- | 2019-09  | US      | 0              | 0               | 1                 | 5000               |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+


-- Solution
-- 這一題的解題關鍵在於建立一張「退款紀綠資料表」在與原先的「交易紀錄資料表」合併聯集
-- 退款紀綠資料表
-- CHARGEBACKS退款資料表與TRANSACTIONS交易資料表，透過TRANS_ID退款交易編號、ID交易編號關聯
-- 特別建立固定值'chargeback'欄位STATE交易類型，代表紀錄為退款，與使用C.TRANS_DATE的退款交易日
-- 透過UNION在與原先的TRANSACTIONS交易資料表，將兩張資料表合併聯集儲存於暫存表T
-- 暫存表T透過TRANS_DATE交易日年月、COUNTRY國家兩個欄位做資料分群
-- 透過SUM函數搭配IF判斷STATE交易類型值為'approved'為1否則為0，計算批准加總數量
-- 透過SUM函數搭配IF判斷STATE交易類型值為'approved'為AMOUNT交易金額否則為0，計算批准加總交易金額
-- 透過SUM函數搭配IF判斷STATE交易類型值為'chargeback'為1否則為0，計算退款加總數量
-- 透過SUM函數搭配IF判斷STATE交易類型值為'chargeback'為AMOUNT交易金額否則為0，計算退款加總交易金額
WITH T AS (
	SELECT ID, COUNTRY, STATE, AMOUNT, TRANS_DATE FROM TRANSACTIONS
	UNION
	SELECT C.TRANS_ID, T.COUNTRY, 'chargeback' STATE, T.AMOUNT, C.TRANS_DATE 
	FROM CHARGEBACKS C
	JOIN TRANSACTIONS T ON C.TRANS_ID = T.ID
)
SELECT DATE_FORMAT(TRANS_DATE,'%Y-%m') MONTH,
	COUNTRY,
	SUM(IF(STATE = 'approved',1 , 0)) APPROVED_COUNT, 
    SUM(IF(STATE = 'approved', AMOUNT, 0)) APPROVED_AMOUNT,
	SUM(IF(STATE = 'chargeback',1 , 0)) CHARGEBACK_COUNT, 
    SUM(IF(STATE = 'chargeback', AMOUNT, 0)) CHARGEBACK_AMOUNT
FROM T
GROUP BY MONTH, COUNTRY;
