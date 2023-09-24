-- 1495.Friendly Movies Streamed Last Month 上個月播放的兒童電影

-- Table: TVProgram
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | program_date  | date    |
-- | content_id    | int     |
-- | channel       | varchar |
-- +---------------+---------+
-- (program_date, content_id) is the primary key for this table.
-- This table contains information of the programs on the TV.
-- content_id is the id of the program on some channels on the TV.


-- Table: Content
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | content_id    | int     |
-- | title         | varchar |
-- | Kids_content  | enum    |
-- | content_type  | varchar |
-- +---------------+---------+
-- content_id is the primary key for this table.
-- Kids_content is an enum that takes one of the values ('Y', 'N') 
-- where:'Y' means is content for kids otherwise 'N' is not content for kids.
-- 'Y'表示內容適合小孩，'N'表示內容不適合小孩
-- content_type is the category of the content as movies, series, etc.
-- content_type 是內容的類別，例如電影，連續劇等


-- Write an SQL query to report the "distinct titles" of the 'kid-friendly' movies streamed in 'June 2020'.
-- 查詢以2020年6月播放的兒童電影的不同標題

-- Return the result table in any order.

-- TVProgram table:
-- +--------------------+--------------+-------------+
-- | program_date       | content_id   | channel     |
-- +--------------------+--------------+-------------+
-- | 2020-06-10 08:00   | 1            | LC-Channel  |
-- | 2020-05-11 12:00   | 2            | LC-Channel  |
-- | 2020-05-12 12:00   | 3            | LC-Channel  |
-- | 2020-05-13 14:00   | 4            | Disney Ch   |
-- | 2020-06-18 14:00   | 4            | Disney Ch   |
-- | 2020-07-15 16:00   | 5            | Disney Ch   |
-- +--------------------+--------------+-------------+


-- Content table:
-- Series(系列)
-- +------------+----------------+---------------+---------------+
-- | content_id | title          | Kids_content  | content_type  |
-- +------------+----------------+---------------+---------------+
-- | 1          | Leetcode Movie | N             | Movies        |
-- | 2          | Alg. for Kids  | Y             | Series        |
-- | 3          | Database Sols  | N             | Series        |
-- | 4          | Aladdin        | Y             | Movies        |
-- | 5          | Cinderella     | Y             | Movies        |
-- +------------+----------------+---------------+---------------+

-- The query result format is in the following example. 
-- Result table:
-- +--------------+
-- | title        |
-- +--------------+
-- | Aladdin      |
-- +--------------+
-- "Leetcode Movie" is not a content for kids.
-- "Leetcode Movie" 不是兒童內容
-- "Alg. for Kids" is not a movie.
-- "Alg. for Kids" 不是電影。
-- "Database Sols" is not a movie
-- "Database Sols" 不是電影
-- "Alladin" is a movie, content for kids and was streamed in June 2020.
-- "阿拉丁" 是一部兒童的電影，於 2020 年 6 月播出
-- "Cinderella" was not streamed in June 2020.
-- "灰姑娘" 於 2020 年 6 月未播出。


-- Solution
-- Oracle
SELECT DISTINCT C.TITLE, TRUNC(PROGRAM_DATE, 'MONTH') TRUNC_MONTH
FROM CONTENT C JOIN TVPROGRAM T
ON C.CONTENT_ID = T.CONTENT_ID
WHERE KIDS_CONTENT = 'Y' AND CONTENT_TYPE = 'Movies'
AND TRUNC(PROGRAM_DATE, 'MONTH') = '2020-06-01';

-- MySQL
SELECT DISTINCT C.TITLE  , MONTH(T.PROGRAM_DATE) PROGRAM_DATE_MONTH
FROM CONTENT C JOIN TVPROGRAM T
ON C.CONTENT_ID = T.CONTENT_ID
WHERE C.KIDS_CONTENT = 'Y' AND C.CONTENT_TYPE = 'Movies'
AND MONTH(T.PROGRAM_DATE) = 6;
