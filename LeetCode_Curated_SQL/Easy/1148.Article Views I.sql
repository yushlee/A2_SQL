-- 1148.Article Views I 文章瀏覽

-- Table: Views
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | article_id    | int     |
-- | author_id     | int     |
-- | viewer_id     | int     |
-- | view_date     | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may have duplicate rows.
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
-- 表格的每一行表示某位觀看者在某個日期觀看了某位作者撰寫的文章
-- Note that equal author_id and viewer_id indicate the same person.
-- 請注意，相同的author_id 和viewer_id 表示同一個人。

-- Write an SQL query to find all the authors that viewed at least one of their own articles,
-- 查找所有查看過至少一篇自己的文章的作者
-- sorted in ascending order by their id.
-- 作者編號升幕排序
-- The query result format is in the following example:

-- Views table:
-- +------------+-----------+-----------+------------+
-- | article_id | author_id | viewer_id | view_date  |
-- +------------+-----------+-----------+------------+
-- | 1          | 3         | 5         | 2019-08-01 |
-- | 1          | 3         | 6         | 2019-08-02 |
-- | 2          | 7         | 7         | 2019-08-01 |
-- | 2          | 7         | 6         | 2019-08-02 |
-- | 4          | 7         | 1         | 2019-07-22 |
-- | 3          | 4         | 4         | 2019-07-21 |
-- | 3          | 4         | 4         | 2019-07-21 |
-- +------------+-----------+-----------+------------+

-- Result table:
-- +------+
-- | id   |
-- +------+
-- | 4    |
-- | 7    |
-- +------+


-- Solution
-- 所有查看過至少一篇自己的文章的作者，同一人的 author_id 與 viewer_id 相同
SELECT DISTINCT AUTHOR_ID AS ID
FROM VIEWS
WHERE AUTHOR_ID = VIEWER_ID
ORDER BY AUTHOR_ID;
