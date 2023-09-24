-- 1517.Find Users With Valid E-Mails

--  Table: Users
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | user_id       | int     |
--  | name          | varchar |
--  | mail          | varchar |
--  +---------------+---------+
--  user_id is the primary key for this table.
--  This table contains information of the users signed up in a website. Some e-mails are invalid.
-- 此表包含在網站上註冊的用戶的信息。一些電子郵件無效。

--  Write an SQL query to find the users who have valid emails.
-- 查找擁有有效電子郵件的用戶
  
-- A valid e-mail has a "prefix name" and a "domain" where:
-- The prefix name is a string that may contain letters (upper or lower case), digits, 
-- 前綴名稱是一個"字符串"，可能包含字母（大寫或小寫）、數字、
-- underscore '_', period '.' and/ or dash '-'. The prefix name must start with a letter.
-- 下劃線'_'、句點'.'和/ 或 破折號'-'。前綴名稱必須以字母開頭
-- The domain is '@leetcode.com'.
-- 網域是 '@leetcode.com'

-- Return the result table in any order.
 
--  The query result format is in the following example.
--  Users
--  +---------+-----------+-------------------------+
--  | user_id | name      | mail                    |
--  +---------+-----------+-------------------------+
--  | 1       | Winston   | winston@leetcode.com    |
--  | 2       | Jonathan  | jonathanisgreat         |
--  | 3       | Annabelle | bella-@leetcode.com     |
--  | 4       | Sally     | sally.come@leetcode.com |
--  | 5       | Marwan    | quarz#2020@leetcode.com |
--  | 6       | David     | david69@gmail.com       |
--  | 7       | Shapiro   | .shapo@leetcode.com     |
--  +---------+-----------+-------------------------+


--  Result table:
--  +---------+-----------+-------------------------+
--  | user_id | name      | mail                    |
--  +---------+-----------+-------------------------+
--  | 1       | Winston   | winston@leetcode.com    |
--  | 3       | Annabelle | bella-@leetcode.com     |
--  | 4       | Sally     | sally.come@leetcode.com |
--  +---------+-----------+-------------------------+

-- The mail of user 2 doesn't have a domain.
-- 用戶2的郵件沒有網域
-- The mail of user 5 has # sign which is not allowed.
-- 用戶5的郵件帶有＃號，這是不允許的
-- The mail of user 6 doesn't have leetcode domain.
-- 用戶6的郵件沒有 leetcode 網域
-- The mail of user 7 starts with a period.
-- 用戶7的郵件以句點開頭


-- Solution
-- Oracle
-- 語法規則：https://docs.oracle.com/cd/B19306_01/B14251_01/adfns_regexp.htm
SELECT * FROM USERS
WHERE REGEXP_LIKE(MAIL, '^[A-Za-z]+[A-Za-z0-9_./-]*@leetcode.com$');

-- MySQL
-- 語法規則：https://www.runoob.com/mysql/mysql-regexp.html
--  ^ 表示開頭
--  + 符合一個或多個,不包括空值
--  * 符合零個或多個
--  [] 表示集合裡的任意一個
--  \\ 用於轉譯特殊字符
--  a{m,n} 符合 m 到 n 個 a，左側不寫為0，右側不寫為任意
--  $ 表示以什麼為結尾
SELECT * FROM USERS
WHERE MAIL REGEXP '^[a-zA-Z]+[a-zA-Z0-9_\\./\\-]{0,}@leetcode\\.com$';
