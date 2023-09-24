-- 1264.Page Recommendations

-- Table: Friendship
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user1_id      | int     |
-- | user2_id      | int     |
-- +---------------+---------+
-- (user1_id, user2_id) is the primary key for this table.
-- Each row of this table indicates that there is a friendship relation between user1_id and user2_id.
-- 該表的每一行表示user1_id 和user2_id 為朋友，其中(user1_id，user2_id)是此表的主鍵

-- Table: Likes
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | user_id     | int     |
-- | page_id     | int     |
-- +-------------+---------+
-- (user_id, page_id) is the primary key for this table.
-- Each row of this table indicates that user_id likes page_id.
-- 該表的每一行表示 user_id 喜歡 page_id

-- Write an SQL query to recommend pages to the user with user_id = 1 using the pages that your friends liked.
-- It should not recommend pages you already liked.
-- 查詢 user_id:1 的朋友推薦的頁面。它不應該推薦 user_id:1 已經喜歡的頁面

-- Return result table in any order without duplicates.
-- 以任意順序返回結果表，不重複

-- The query result format is in the following example:
-- Friendship table:
-- +----------+----------+
-- | user1_id | user2_id |
-- +----------+----------+
-- | 1        | 2        |
-- | 1        | 3        |
-- | 1        | 4        |
-- | 2        | 3        |
-- | 2        | 4        |
-- | 2        | 5        |
-- | 6        | 1        |
-- +----------+----------+

 
-- Likes table:
-- +---------+---------+
-- | user_id | page_id |
-- +---------+---------+
-- | 1       | 88      |
-- | 2       | 23      |
-- | 3       | 24      |
-- | 4       | 56      |
-- | 5       | 11      |
-- | 6       | 33      |
-- | 2       | 77      |
-- | 3       | 77      |
-- | 6       | 88      |
-- +---------+---------+

-- Result table:
-- +------------------+
-- | recommended_page |
-- +------------------+
-- | 23               |
-- | 24               |
-- | 56               |
-- | 33               |
-- | 77               |
-- +------------------+
-- User one is friend with users 2, 3, 4 and 6.
-- Suggested pages are 23 from user 2, 24 from user 3, 56 from user 3 and 33 from user 6.
-- Page 77 is suggested from both user 2 and user 3.
-- Page 88 is not suggested because user 1 already likes it.
-- 用戶 1 是用戶 2、3、4 和 6 的朋友
-- 建議的頁面是用戶 2 的 23、用戶 3 的 24、用戶 3 的 56 和用戶 6 的 33
-- 用戶 2 和用戶 3 都建議使用第 77 頁
-- 不建議使用第 88 頁，因為用戶 1 已經喜歡它


-- Solution
-- 找出 user1_id:1 的朋友所推薦的 page_id(去重覆)
SELECT DISTINCT PAGE_ID AS RECOMMENDED_PAGE
FROM LIKES
WHERE USER_ID IN (
  -- 找出 user1_id:1 的所有朋友
  SELECT USER2_ID FROM FRIENDSHIP WHERE USER1_ID = 1
  UNION
  SELECT USER1_ID FROM FRIENDSHIP WHERE USER2_ID = 1
)
MINUS
-- 排除 user1_id:1 自身喜歡的 page_id
SELECT PAGE_ID FROM LIKES WHERE USER_ID = 1;

