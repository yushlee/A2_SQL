-- 1341.Movie Rating 電影分級

-- Table: Movies
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | movie_id      | int     |
-- | title         | varchar |
-- +---------------+---------+
-- movie_id is the primary key for this table.
-- title is the name of the movie.
-- title 是電影的名稱

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
-- (movie_id 電影編號，user_id 使用者編號)是此表的主鍵
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


-- MovieRating table:
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
-- 丹尼爾(Daniel)和莫妮卡(Monica)都對3部電影進行了評分（"Avengers復仇者聯盟"，"Frozen 2冰雪奇緣2"和"Joker小丑"），但丹尼爾在詞典上順序靠前
-- Frozen 2 and Joker have a rating average of 3.5 in February but Frozen 2 is smaller lexicographically.
-- 《冰雪奇緣2》和《小丑》在2月的平均評分為3.5，但《冰雪奇緣2》在字典上順序靠前


-- Solution
-- USERS使用者資料表與MovieRating電影評分資料表透過USER_ID使用者編號關聯
-- 將資料依照U.USER_ID使用者編號、U.NAME使用者名稱將資料分群
-- 並將資料依照COUNT(MR.MOVIE_ID)評論數量降幕排序、U.NAME使用者名稱升幕排序
-- LIMIT 1只取第一筆獲取評論數量最多的用戶
-- MOVIES電影資料表與MovieRating電影評分資料表透過MOVIE_ID電影編號關聯
-- 將資料依照M.MOVIE_ID電影編號、M.TITLE電影名稱將資料分群
-- 並將資料依照AVG(MR.RATING)平均評分降幕排序、M.TITLE電影名稱升幕排序
-- LIMIT 1只取第一筆獲取2020年2月平均評分最高的電影
(
	SELECT NAME AS RESULTS
	FROM USERS U
	JOIN MOVIERATING MR ON U.USER_ID = MR.USER_ID
	GROUP BY U.USER_ID, U.NAME
	ORDER BY COUNT(MR.MOVIE_ID) DESC, U.NAME ASC
	LIMIT 1
)
UNION ALL
(
	SELECT TITLE AS RESULTS
	FROM MOVIES M
	JOIN MOVIERATING MR ON M.MOVIE_ID = MR.MOVIE_ID
	WHERE DATE_FORMAT(MR.CREATED_AT,'%Y-%m') = '2020-02'
	GROUP BY M.MOVIE_ID, M.TITLE
	ORDER BY AVG(MR.RATING) DESC, M.TITLE ASC
	LIMIT 1
 );


SELECT U.USER_ID, U.NAME, COUNT(MR.MOVIE_ID)
FROM USERS U
JOIN MOVIERATING MR ON U.USER_ID = MR.USER_ID
GROUP BY U.USER_ID, U.NAME
ORDER BY COUNT(MR.MOVIE_ID) DESC, U.NAME ASC;


SELECT M.MOVIE_ID, M.TITLE, AVG(MR.RATING)
FROM MOVIES M
JOIN MOVIERATING MR ON M.MOVIE_ID = MR.MOVIE_ID
WHERE DATE_FORMAT(MR.CREATED_AT,'%Y-%m') = '2020-02'
GROUP BY M.MOVIE_ID, M.TITLE
ORDER BY AVG(MR.RATING) DESC, M.TITLE ASC;