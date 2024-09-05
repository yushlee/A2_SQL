-- 1132.Reported Posts II

--  Table: Actions
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | user_id       | int     |
--  | post_id       | int     |
--  | action_date   | date    |
--  | action        | enum    |
--  | extra         | varchar |
--  +---------------+---------+
--  There is no primary key for this table, it may have duplicate rows.
--  The action column is an ENUM type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
--  The extra column has optional information about the action such as a reason for report or a type of reaction. 
--  下表中沒有主鍵，因此可能有重複行。
--  action 列可能的值為(查看、喜歡、反應、評論、報告、分享)
--  extra 列不是必須的，包含有關操作的可選信息，例如報告原因或反應類型(spam 垃圾郵件、racism 種族主義)


--  Table: Removals
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | post_id       | int     |
--  | remove_date   | date    | 
--  +---------------+---------+
--  post_id is the primary key of this table.
--  Each row in this table indicates that some post was removed as a result of being reported or as a result of an admin review.
--  此表中的每一行都表示某些文章因被舉報或管理員審核而被刪除

--  Write an SQL query to find the average for daily percentage 
--  of posts that got removed after being "reported as spam", rounded to 2 decimal places.
--  查找被報告為垃圾郵件之中，被刪除文章的每日百分比平均值，四捨五入到小數點後兩位。

--  The query result format is in the following example:
--  
--  Table: Actions
--  spam 垃圾郵件、racism 種族主義
--  +---------+---------+-------------+--------+--------+
--  | user_id | post_id | action_date | action | extra  |
--  +---------+---------+-------------+--------+--------+
--  | 1       | 1       | 2019-07-01  | view   | null   |
--  | 1       | 1       | 2019-07-01  | like   | null   |
--  | 1       | 1       | 2019-07-01  | share  | null   |
--  | 2       | 2       | 2019-07-04  | view   | null   |
--  | 2       | 2       | 2019-07-04  | report | spam   |
--  | 3       | 4       | 2019-07-04  | view   | null   |
--  | 3       | 4       | 2019-07-04  | report | spam   |
--  | 4       | 3       | 2019-07-02  | view   | null   |
--  | 4       | 3       | 2019-07-02  | report | spam   |
--  | 5       | 2       | 2019-07-03  | view   | null   |
--  | 5       | 2       | 2019-07-03  | report | racism |
--  | 5       | 5       | 2019-07-03  | view   | null   |
--  | 5       | 5       | 2019-07-03  | report | racism |
--  +---------+---------+-------------+--------+--------+

--  Removals table:
--  +---------+-------------+
--  | post_id | remove_date |
--  +---------+-------------+
--  | 2       | 2019-07-20  |
--  | 3       | 2019-07-18  |
--  +---------+-------------+
  
--  Result table:
--  +-----------------------+
--  | average_daily_percent |
--  +-----------------------+
--  | 75.00                 |
--  +-----------------------+
--  The percentage for 2019-07-04 is 50% because only one post of two spam reported posts was removed.
--  2019-07-04 的百分比為 50%，因為在兩個垃圾郵件報告文章中只有一個文章被刪除。
--  The percentage for 2019-07-02 is 100% because one post was reported as spam and it was removed.
--  2019-07-02 的百分比是 100%，因為一個文章被報告為垃圾郵件並被刪除。
--  The other days had no spam reports so the average is (50 + 100) / 2 = 75%
--  其他日子沒有垃圾郵件，所以平均值是 (50% + 100%) / 2日 = 75%
--  Note that the output is only one number and that we do not care about the remove dates.
--  請注意，輸出只是一個數字，我們不關心刪除日期。


-- Solution
-- 以ACTIONS活動資料表為主左外部連接REMOVALS管理員審核資料表透過POST_ID活動編號關聯
-- 篩選活動為報告'report'、額外類型爲垃圾郵件'spam'
-- 將資料依照ACTION_DATE活動日期為資料分群
-- 分別計算每日被審核刪除的垃圾郵件次數，與每日全部的垃圾郵件次數，兩者互除得每日刪除佔比
-- 最後將全部的每日被刪除垃圾郵件佔比計算最終平均
WITH T AS (
	SELECT COUNT(DISTINCT R.POST_ID) / COUNT(DISTINCT A.POST_ID) AVERAGE_DAILY
	FROM ACTIONS A
	LEFT JOIN REMOVALS R ON A.POST_ID = R.POST_ID 
	WHERE A.ACTION = 'report' AND A.EXTRA = 'spam'
	GROUP BY A.ACTION_DATE
)
SELECT ROUND(AVG(AVERAGE_DAILY) * 100, 2) AS AVERAGE_DAILY_PERCENT 
FROM T;



SELECT A.USER_ID, A.POST_ID, A.ACTION_DATE, A.ACTION, A.EXTRA,
	R.POST_ID, R.REMOVE_DATE
FROM ACTIONS A
LEFT JOIN REMOVALS R ON A.POST_ID = R.POST_ID 
WHERE A.ACTION = 'report' AND A.EXTRA = 'spam'


SELECT A.ACTION_DATE, COUNT(DISTINCT R.POST_ID), COUNT(DISTINCT A.POST_ID)
FROM ACTIONS A
LEFT JOIN REMOVALS R ON A.POST_ID = R.POST_ID 
WHERE A.ACTION = 'report' AND A.EXTRA = 'spam'
GROUP BY A.ACTION_DATE


