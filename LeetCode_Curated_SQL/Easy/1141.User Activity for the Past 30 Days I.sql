-- 1141.User Activity for the Past 30 Days I
-- 使用者過去30天的活動紀錄

-- Table: Activity
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | session_id    | int     |
-- | activity_date | date    |
-- | activity_type | enum    |
-- +---------------+---------+
-- There is no primary key for this table, it may have duplicate rows.
-- The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
-- The table shows the user activities for a social media website.
-- 使用者在網路社交媒體上的活動資料
-- Note that each session belongs to exactly one user.
-- 請注意，每個會話只屬於一個使用者

-- Write an SQL query to find the daily active user count for a period of 30 days ending '2019-07-27' inclusively.
-- 查詢截至2019年7月27日（含）的30天期間的每日活躍用戶數
-- A user was active on some day if he/she made at least one activity on that day.

-- The query result format is in the following example:

-- Activity table:
-- +---------+------------+---------------+---------------+
-- | user_id | session_id | activity_date | activity_type |
-- +---------+------------+---------------+---------------+
-- | 1       | 1          | 2019-07-20    | open_session  |
-- | 1       | 1          | 2019-07-20    | scroll_down   |
-- | 1       | 1          | 2019-07-20    | end_session   |
-- | 2       | 4          | 2019-07-20    | open_session  |
-- | 2       | 4          | 2019-07-21    | send_message  |
-- | 2       | 4          | 2019-07-21    | end_session   |
-- | 3       | 2          | 2019-07-21    | open_session  |
-- | 3       | 2          | 2019-07-21    | send_message  |
-- | 3       | 2          | 2019-07-21    | end_session   |
-- | 4       | 3          | 2019-06-25    | open_session  |
-- | 4       | 3          | 2019-06-25    | end_session   |
-- +---------+------------+---------------+---------------+

-- Result table:
-- +------------+--------------+ 
-- | day        | active_users |
-- +------------+--------------+ 
-- | 2019-07-20 | 2            |
-- | 2019-07-21 | 2            |
-- +------------+--------------+ 
-- Note that we do not care about days with zero active users.


-- MySQL
SELECT DATE_SUB('2018-12-31', INTERVAL 1 DAY);
-- Solution
-- 查詢條件ACTIVITY_DATE介於'2019-07-27'(包含)30日內，將ACTIVITY_DATE做資料分群
-- 透過COUNT搭配DISTINCT取得去重複的使用者編號數量
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS
FROM ACTIVITY
WHERE ACTIVITY_DATE BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY ACTIVITY_DATE;

/*
在 MySQL 中，處理日期加減的函數有 DATE_ADD() 和 DATE_SUB()
DATE_SUB() 語法 (Syntax)
DATE_SUB(datetime, INTERVAL expr UNIT)
expr 用來指定你要減去的時間間隔，UNIT 是 expr 的單位。
長用的 unit 單位有：MINUTE、HOUR、DAY、WEEK、MONTH、QUARTER、YEAR
*/