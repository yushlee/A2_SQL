-- 1149.Article Views II

--  Table: Views
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | article_id    | int     |
--  | author_id     | int     |
--  | viewer_id     | int     |
--  | view_date     | date    |
--  +---------------+---------+
--  There is no primary key for this table, it may have duplicate rows.
--  Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
--  Note that equal author_id and viewer_id indicate the same person.
-- 此表的每一行都表示某些查看者在某個日期查看了一篇文章(由某個作者撰寫)
-- 請注意，相等的 author_id 和 viewer_id 表示同一個人

--  Write an SQL query to find all the people who viewed more than one article on the same date, sorted in ascending order by their id.
-- 查找在同一日期查看過一篇以上文章的所有人，並按他們的 id 升序排序

--  The query result format is in the following example:
--  Views table:
--  +------------+-----------+-----------+------------+
--  | article_id | author_id | viewer_id | view_date  |
--  +------------+-----------+-----------+------------+
--  | 1          | 3         | 5         | 2019-08-01 |
--  | 3          | 4         | 5         | 2019-08-01 |
--  | 1          | 3         | 6         | 2019-08-02 |
--  | 2          | 7         | 7         | 2019-08-01 |
--  | 2          | 7         | 6         | 2019-08-02 |
--  | 4          | 7         | 1         | 2019-07-22 |
--  | 3          | 4         | 4         | 2019-07-21 |
--  | 3          | 4         | 4         | 2019-07-21 |
--  +------------+-----------+-----------+------------+

--  Result table:
--  +------+
--  | id   |
--  +------+
--  | 5    |
--  | 6    |
--  +------+


-- Solution
SELECT VIEWER_ID ID 
FROM　VIEWS
GROUP BY VIEW_DATE, VIEWER_ID
-- VIEWER_ID:4 同一日資料重復須加 DISTINCT
HAVING COUNT(DISTINCT ARTICLE_ID) > 1
ORDER BY VIEWER_ID;
