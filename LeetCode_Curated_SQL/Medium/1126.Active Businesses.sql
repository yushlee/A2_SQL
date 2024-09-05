-- 1126.Active Businesses

--  Table: Events
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | business_id   | int     |
--  | event_type    | varchar |
--  | occurences    | int     | 
--  +---------------+---------+
--  (business_id, event_type) is the primary key of this table.
--  Each row in the table logs the info that an event of some type occured at some business for a number of times.
--  表中的每一行都記錄了某種商業類型的事件(event_type)在商家多次發生的頻率(occurance)

--  Write an SQL query to find all active businesses.
--  查詢以查找所有活躍的商業
--  An active business is a business that has more than one event type 
--  活躍的商業是指超過一個事件類型
--  with occurences greater than the average occurences of that event type among all businesses.
--  其發生次數大於所有商業中該事件類型的平均發生次數

--  The query result format is in the following example:
--  Events table:
--  +-------------+------------+------------+
--  | business_id | event_type | occurences |
--  +-------------+------------+------------+
--  | 1           | reviews    | 7          |
--  | 3           | reviews    | 3          |
--  | 1           | ads        | 11         |
--  | 2           | ads        | 7          |
--  | 3           | ads        | 6          |
--  | 1           | page views | 3          |
--  | 2           | page views | 12         |
--  +-------------+------------+------------+

--  Result table:
--  +-------------+
--  | business_id |
--  +-------------+
--  | 1           |
--  +-------------+ 
--  Average for 'reviews','ads'and'page views'are 
--  (7+3)/2=5, (11+7+6)/3=8, (3+12)/2=7.5 respectively.
--  Business with id 1 has 7 'reviews' events (more than 5)
--  and 11 'ads' events (more than 8) so it is an active business.


-- Solution
-- 使用AVG OVER函數計算OCCURENCES平均事件次數
-- 並用EVENT_TYPE事件類型為資料劃分平均欄位
-- 篩選事件頻率大於發生"平均頻率" OCCURENCES > AVG_OCCURENCES
-- GROUP BY BUSINESS_ID 透過商業編號資料分群
-- 篩選次數大於一次以上的事件類型 HAVING COUNT(BUSINESS_ID) > 1
WITH T AS (
	SELECT BUSINESS_ID, EVENT_TYPE, OCCURENCES,
		AVG(OCCURENCES) OVER (PARTITION BY EVENT_TYPE) AVG_OCCURENCES
	FROM EVENTS
)
SELECT BUSINESS_ID
FROM T
WHERE OCCURENCES > AVG_OCCURENCES
GROUP BY BUSINESS_ID
HAVING COUNT(BUSINESS_ID) > 1;
