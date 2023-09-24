-- 1341.Movie Rating

-- Table: Movies
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | movie_id      | int     |
-- | title         | varchar |
-- +---------------+---------+
-- movie_id is the primary key for this table.
-- title is the name of the movie.

-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | name          | varchar |
-- +---------------+---------+
-- user_id is the primary key for this table.



-- Table: Movie_Rating
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | movie_id      | int     |
-- | user_id       | int     |
-- | rating        | int     |
-- | created_at    | date    |
-- +---------------+---------+
-- (movie_id, user_id) is the primary key for this table.
-- (movie_id，user_id)是此表的主鍵
-- This table contains the rating of a movie by a user in their review.
-- 該表包含用戶在其評論中對電影的評分
-- created_at is the user's review date. 
-- created_at是用戶評分日期

-- Write the following SQL query:
-- Find the name of the user who has rated the greatest number of the movies.
-- In case of a tie, return lexicographically smaller user name.
-- 查找評論電影數量最多的用戶名。如果數量相同，則按用戶名升序排序
  

-- Find the movie name with the highest average rating in February 2020.
-- In case of a tie, return lexicographically smaller movie name.
-- 查找"2020年2月"平均評分最高的電影名稱，如果評分相同，則按電影名升序排序

-- Movies table:
-- +-------------+--------------+
-- | movie_id    |  title       |
-- +-------------+--------------+
-- | 1           | Avengers     |
-- | 2           | Frozen 2     |
-- | 3           | Joker        |
-- +-------------+--------------+


-- Users table:
-- +-------------+--------------+
-- | user_id     |  name        |
-- +-------------+--------------+
-- | 1           | Daniel       |
-- | 2           | Monica       |
-- | 3           | Maria        |
-- | 4           | James        |
-- +-------------+--------------+


-- Movie_Rating table:
-- +-------------+--------------+--------------+-------------+
-- | movie_id    | user_id      | rating       | created_at  |
-- +-------------+--------------+--------------+-------------+
-- | 1           | 1            | 3            | 2020-01-12  |
-- | 1           | 2            | 4            | 2020-02-11  |
-- | 1           | 3            | 2            | 2020-02-12  |
-- | 1           | 4            | 1            | 2020-01-01  |
-- | 2           | 1            | 5            | 2020-02-17  | 
-- | 2           | 2            | 2            | 2020-02-01  | 
-- | 2           | 3            | 2            | 2020-03-01  |
-- | 3           | 1            | 3            | 2020-02-22  | 
-- | 3           | 2            | 4            | 2020-02-25  | 
-- +-------------+--------------+--------------+-------------+
 
-- Query is returned in 2 rows, the query result format is in the folowing example:
-- Result table:
-- +--------------+
-- | results      |
-- +--------------+
-- | Daniel       |
-- | Frozen 2     |
-- +--------------+

-- Daniel and Maria have rated 3 movies ("Avengers", "Frozen 2" and "Joker") but Daniel is smaller lexicographically.
-- 丹尼爾(Daniel)和莫妮卡(Monica)都對3部電影進行了評分（"復仇者聯盟"，"冰雪奇緣2"和"小丑"），但丹尼爾在詞典上順序靠前
-- Frozen 2 and Joker have a rating average of 3.5 in February but Frozen 2 is smaller lexicographically.
-- 《冰雪奇緣2》和《小丑》在2月的平均評分為3.5，但《冰雪奇緣2》在字典上順序靠前


-- Solution
-- Oracle
(
  SELECT NAME RESULTS FROM (
    -- 查找評論電影數量最多的"用戶名"。如果數量相同，則按用戶名升序排序
    SELECT U.USER_ID, U.NAME,
          COUNT(U.USER_ID),
          ROW_NUMBER()OVER(ORDER BY COUNT(U.USER_ID) DESC, U.NAME) ROWNO
    FROM MOVIE_RATING MR JOIN USERS U
    ON MR.USER_ID = U.USER_ID  
    GROUP BY U.USER_ID, U.NAME
    ORDER BY COUNT(U.USER_ID) DESC, U.NAME
  ) WHERE ROWNO = 1 
)
UNION 
(
  SELECT TITLE RESULTS FROM (
    -- 查找"2020年2月"平均評分最高的"電影名稱"。如果評分相同，則按電影名升序排序
    SELECT MR.MOVIE_ID, M.TITLE,
          AVG(RATING),
          ROW_NUMBER()OVER(ORDER BY AVG(MR.RATING) DESC, M.TITLE) ROWNO
    FROM MOVIE_RATING MR JOIN MOVIES M
    ON MR.MOVIE_ID = M.MOVIE_ID
    AND MR.CREATED_AT LIKE '2020-02%'
    GROUP BY MR.MOVIE_ID, M.TITLE
    ORDER BY AVG(MR.RATING) DESC, M.TITLE
  ) WHERE ROWNO = 1  
)

-- MySQL
SELECT NAME AS RESULTS
FROM(
  (
    SELECT A.NAME FROM(    
      SELECT NAME, COUNT(*),
      RANK() OVER(ORDER BY COUNT(*) DESC) AS RK
      FROM MOVIE_RATING M
      JOIN USERS U 
      ON M.USER_ID = U.USER_ID
      GROUP BY NAME, M.USER_ID
      ORDER BY RK, NAME
    ) A LIMIT 1    
  )
  UNION
  (
    SELECT TITLE FROM(    
      SELECT TITLE, ROUND(AVG(RATING),1) AS RND
      FROM MOVIE_RATING M
      JOIN MOVIES U
      ON M.MOVIE_ID = U.MOVIE_ID
      WHERE MONTH(CREATED_AT) = 2
      GROUP BY TITLE
      ORDER BY RND DESC, TITLE
      ) B LIMIT 1      
  )
) AS D;

