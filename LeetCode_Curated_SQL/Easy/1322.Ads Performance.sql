-- 1322.Ads Performance 廣告成效統計

-- Table: Ads
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | ad_id         | int     |
-- | user_id       | int     |
-- | action        | enum    |
-- +---------------+---------+
-- (ad_id, user_id) is the primary key for this table.
-- Each row of this table contains the ID of an Ad, the ID of a user and the action taken by this user regarding this Ad.
-- 每一行都包含一個廣告的ID，一個用戶的ID以及該用戶對該廣告所採取的操作
-- The action column is an ENUM type of ('Clicked', 'Viewed', 'Ignored').
-- 操作列是ENUM類型（'單擊','查看','忽略'）

-- A company is running Ads and wants to calculate the performance of each Ad.
-- 一家公司正在投放廣告，並希望計算每個廣告的效果

-- Performance of the Ad is measured using Click-Through Rate (CTR) where:
-- 使用則（CTR）衡量廣告的效果，其中
-- CTR = (Ad total clicks / Ad total clicks + Ad total views) * 100

-- Write an SQL query to find the ctr of each Ad.
-- 編寫SQL查詢以找到每個廣告的點擊率

-- Round ctr to 2 decimal points.
-- 將ctr捨入到2個小數點
-- Order the result table by ctr in descending order and by ad_id in ascending order in case of a tie.
-- 按照 "ctr 降序" 對結果進行排序，在點擊率相同的情況下，則按 "ad_id按升序" 對結果表進行排序

-- The query result format is in the following example:

-- Ads table:
-- +-------+---------+---------+
-- | ad_id | user_id | action  |
-- +-------+---------+---------+
-- | 1     | 1       | Clicked |
-- | 2     | 2       | Clicked |
-- | 3     | 3       | Viewed  |
-- | 5     | 5       | Ignored |
-- | 1     | 7       | Ignored |
-- | 2     | 7       | Viewed  |
-- | 3     | 5       | Clicked |
-- | 1     | 4       | Viewed  |
-- | 2     | 11      | Viewed  |
-- | 1     | 2       | Clicked |
-- +-------+---------+---------+

-- Result table:
-- +-------+-------+
-- | ad_id | ctr   |
-- +-------+-------+
-- | 1     | 66.67 |
-- | 3     | 50.00 |
-- | 2     | 33.33 |
-- | 5     | 0.00  |
-- +-------+-------+

-- for ad_id = 1, ctr = (2/(2+1)) * 100 = 66.67
-- for ad_id = 2, ctr = (1/(1+2)) * 100 = 33.33
-- for ad_id = 3, ctr = (1/(1+1)) * 100 = 50.00
-- for ad_id = 5, ctr = 0.00, Note that ad_id = 5 has no clicks or views.
-- 請注意 ad_id = 5 沒有點擊或觀看次數。
-- Note that we don't care about Ignored Ads.
-- Result table is ordered by the ctr. in case of a tie we order them by ad_id


-- Solution
-- MySQL
-- 子查詢T1廣告點數擊：透過AD_ID廣告編號資料分群，透過CASE WHEN判斷式若值為'Clicked'值為1否則為0，再透過SUM函數將點擊數加總
-- 子查詢T2廣告點數擊查看數：透過AD_ID廣告編號資料分群，透過CASE WHEN判斷式若值為'Clicked'、'Viewed'值為1否則為0，再透過SUM函數將點擊數與查看數加總
-- 最後將T1子查詢與T2子查詢透過AD_ID廣告編號欄位關聯，T1點擊數加總除以T2點擊數與查詢數加總，百分比後取小數點後兩位
WITH T1 AS(
  SELECT AD_ID, 
	SUM(CASE WHEN ACTION = 'Clicked' THEN 1 ELSE 0 END) AS CLICKED
  FROM ADS
  GROUP BY AD_ID
),
T2 AS (
  SELECT AD_ID,
	SUM(CASE WHEN ACTION IN ('Clicked','Viewed') THEN 1 ELSE 0 END) AS TOTAL
  FROM ADS
  GROUP BY AD_ID
)
SELECT T1.AD_ID, 
	IFNULL(ROUND(T1.CLICKED / NULLIF(T2.TOTAL, 0) * 100, 2), 0) AS CTR
FROM T1 JOIN T2
ON T1.AD_ID = T2.AD_ID
ORDER BY CTR DESC, AD_ID;


-- Oracle
WITH T1 AS(
  -- 計算每一個AD的"點擊數"加總
  SELECT AD_ID, 
	SUM(CASE WHEN ACTION IN ('Clicked') THEN 1 ELSE 0 END) AS CLICKED
  FROM ADS
  GROUP BY AD_ID
),
T2 AS (
  -- 計算每一個AD的"點擊數"及"查看"的加總
  SELECT AD_ID,
	SUM(CASE WHEN ACTION IN ('Clicked','Viewed') THEN 1 ELSE 0 END) AS TOTAL
  FROM ADS
  GROUP BY AD_ID
)
SELECT T1.AD_ID, 
	NVL(ROUND(CLICKED / NULLIF(TOTAL, 0) * 100, 2), 0) AS CTR
FROM T1 JOIN T2
ON T1.AD_ID = T2.AD_ID
ORDER BY CTR DESC, AD_ID;

-- 語法為「NULLIF ( expression-1 , expression-2 )」
-- 當 expression-1 的值與 expression-2 的值相同時，便會回傳 NULL，其他的就會如實的回傳 expression-1