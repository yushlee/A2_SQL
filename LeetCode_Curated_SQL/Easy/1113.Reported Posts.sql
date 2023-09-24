-- 1113.Reported Posts

-- Table: Actions

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | post_id       | int     |
-- | action_date   | date    | 
-- | action        | enum    |
-- | extra         | varchar |
-- +---------------+---------+
-- There is no primary key for this table, it may have duplicate rows.
-- The action column is an ENUM type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
-- The extra column has optional information about the action such as a reason for report or a type of reaction.
-- 下表中沒有主鍵，因此可能有重複行。action 列可能的值為(查看、喜歡、反應、評論、報告、分享)
-- extra 列不是必須的，包含有關操作的可選信息，例如報告原因或反應類型。
 
-- Write an SQL query that "reports" the number of posts reported 'yesterday' for each report reason. Assume today is '2019-07-05'.
-- 查詢每種報告理由在昨天的報告數量，需要篩除重複 'post_id' 的重複報告

-- The query result format is in the following example:

-- Actions table:
-- +---------+---------+-------------+--------+--------+
-- | user_id | post_id | action_date | action | extra  |
-- +---------+---------+-------------+--------+--------+
-- | 1       | 1       | 2019-07-01  | view   | null   |
-- | 1       | 1       | 2019-07-01  | like   | null   |
-- | 1       | 1       | 2019-07-01  | share  | null   |
-- | 2       | 4       | 2019-07-04  | view   | null   |
-- | 2       | 4       | 2019-07-04  | report | spam   |
-- | 3       | 4       | 2019-07-04  | view   | null   |
-- | 3       | 4       | 2019-07-04  | report | spam   |
-- | 4       | 3       | 2019-07-02  | view   | null   |
-- | 4       | 3       | 2019-07-02  | report | spam   |
-- | 5       | 2       | 2019-07-04  | view   | null   |
-- | 5       | 2       | 2019-07-04  | report | racism |
-- | 5       | 5       | 2019-07-04  | view   | null   |
-- | 5       | 5       | 2019-07-04  | report | racism |
-- +---------+---------+-------------+--------+--------+

-- spam 垃圾郵件
-- racism 種族主義
-- Result table:
-- +---------------+--------------+
-- | report_reason | report_count |
-- +---------------+--------------+
-- | spam          | 1            |
-- | racism        | 2            |
-- +---------------+--------------+ 
-- Note that we only care about report reasons with non zero number of reports.
-- 我們只關心報告數量不為零的報告原因


-- Solution
-- Oracle
SELECT EXTRA "REPORT_REASON", COUNT(DISTINCT POST_ID) "REPORT_COUNT"
FROM ACTIONS
WHERE ACTION = 'report'
AND ACTION_DATE = (TO_DATE('2019-07-05','YYYY-MM-DD') - 1)
GROUP BY EXTRA;

-- MySQL
SELECT EXTRA AS REPORT_REASON, COUNT(DISTINCT POST_ID) AS REPORT_COUNT
FROM ACTIONS
WHERE ACTION_DATE = DATE_SUB("2019-07-5", INTERVAL 1 DAY)
AND ACTION = 'report'
GROUP BY EXTRA;