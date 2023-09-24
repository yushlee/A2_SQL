-- 1369.Get the Second Most Recent Activity

--  Table: UserActivity
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | username      | varchar |
--  | activity      | varchar |
--  | startDate     | Date    |
--  | endDate       | Date    |
--  +---------------+---------+
--  This table does not contain primary key.
--  This table contain information about the activity performed of each user in a period of time.
--  A person with username performed a activity from startDate to endDate.
--  該表包含每個用戶在活動期間的信息
--  名稱為username 的用戶從startDate 到endDate 參與了名稱為activity 的活動

--  Write an SQL query to show the second most recent activity of each user.
--  If the user only has one activity, return that one. 
--  查詢以顯示每個用戶的"第二個:最近活動。如果用戶"只有一項"活動則返回該活動。

--  A user can't perform more than one activity at the same time. Return the result table in any order.
-- 一個用戶"不能同時執行多個活動"。以任意順序返回結果

--  UserActivity table:
--  +------------+--------------+-------------+-------------+
--  | username   | activity     | startDate   | endDate     |
--  +------------+--------------+-------------+-------------+
--  | Alice      | Travel       | 2020-02-12  | 2020-02-20  |
--  | Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
--  | Alice      | Travel       | 2020-02-24  | 2020-02-28  |
--  | Bob        | Travel       | 2020-02-11  | 2020-02-18  |
--  +------------+--------------+-------------+-------------+

--  Result table:
--  +------------+--------------+-------------+-------------+
--  | username   | activity     | startDate   | endDate     |
--  +------------+--------------+-------------+-------------+
--  | Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
--  | Bob        | Travel       | 2020-02-11  | 2020-02-18  |
--  +------------+--------------+-------------+-------------+
--  The most recent activity of Alice is Travel from 2020-02-24 to 2020-02-28, 
--  before that she was dancing from 2020-02-21 to 2020-02-23.
--  Bob only has one record, we just take that one.
--  Alice 最近的活動是從 2020-02-24 到 2020-02-28 的旅行，之前她從 2020-02-21 到 2020-02-23 跳舞。
--  Bob只有一個記錄，只取一個。


-- Solution
SELECT USERNAME, ACTIVITY, STARTDATE, ENDDATE 
FROM (
    SELECT USERNAME, ACTIVITY, STARTDATE, ENDDATE,
      -- 依照各別USERNAME資料劃分，再依STARTDATE 降序排列取名次(只取第二名)
      RANK() OVER (PARTITION BY USERNAME ORDER BY STARTDATE DESC) RANK,
      -- 依照各別USERNAME資料劃分，COUNT使用者的數量(只取資料為一個的個數)
      COUNT(USERNAME) OVER (PARTITION BY USERNAME) CNT
    FROM USERACTIVITY
) WHERE RANK = 2 OR CNT = 1;
