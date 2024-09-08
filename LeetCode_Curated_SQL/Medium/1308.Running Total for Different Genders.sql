-- 1308.Running Total for Different Genders 不同性別的運行總計

-- Table: Scores
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | player_name   | varchar |
-- | gender        | varchar |
-- | day           | date    |
-- | score_points  | int     |
-- +---------------+---------+
-- (gender, day) is the primary key for this table.
-- A competition is held between females team and males team.
-- Each row of this table indicates that a player_name and with gender has scored score_point in someday.
-- Gender is 'F' if the player is in females team and 'M' if the player is in males team.
-- (gender性別,day日期)是此表的主鍵
-- 女子團體與男子團體之間進行比賽
-- 表格的每一行表示某玩家姓名和性別在某一天獲得的分數
-- 如果球員在女子隊伍中，則性別為'F'，如果球員在男子隊伍中，則性別為'M'

-- Write an SQL query to find the total score for each gender at each day.
-- 查詢每天每種性別的 "累計總分"，查詢結果按性別和日期升序排序

-- Order the result table by gender and day

-- The query result format is in the following example:

-- Scores table:
-- +-------------+--------+------------+--------------+
-- | player_name | gender | day        | score_points |
-- +-------------+--------+------------+--------------+
-- | Aron        | F      | 2020-01-01 | 17           |
-- | Alice       | F      | 2020-01-07 | 23           |
-- | Bajrang     | M      | 2020-01-07 | 7            |
-- | Khali       | M      | 2019-12-25 | 11           |
-- | Slaman      | M      | 2019-12-30 | 13           |
-- | Joe         | M      | 2019-12-31 | 3            |
-- | Jose        | M      | 2019-12-18 | 2            |
-- | Priya       | F      | 2019-12-31 | 23           |
-- | Priyanka    | F      | 2019-12-30 | 17           |
-- +-------------+--------+------------+--------------+


-- Result table:
-- +--------+------------+-------+
-- | gender | day        | total |
-- +--------+------------+-------+
-- | F      | 2019-12-30 | 17    |
-- | F      | 2019-12-31 | 40    |
-- | F      | 2020-01-01 | 57    |
-- | F      | 2020-01-07 | 80    |
-- | M      | 2019-12-18 | 2     |
-- | M      | 2019-12-25 | 13    |
-- | M      | 2019-12-30 | 26    |
-- | M      | 2019-12-31 | 29    |
-- | M      | 2020-01-07 | 36    |
-- +--------+------------+-------+
-- For females team:
-- First day is 2019-12-30, Priyanka scored 17 points and the total score for the team is 17.
-- Second day is 2019-12-31, Priya scored 23 points and the total score for the team is 40.
-- Third day is 2020-01-01, Aron scored 17 points and the total score for the team is 57.
-- Fourth day is 2020-01-07, Alice scored 23 points and the total score for the team is 80.
-- For males team:
-- First day is 2019-12-18, Jose scored 2 points and the total score for the team is 2.
-- Second day is 2019-12-25, Khali scored 11 points and the total score for the team is 13.
-- Third day is 2019-12-30, Slaman scored 13 points and the total score for the team is 26.
-- Fourth day is 2019-12-31, Joe scored 3 points and the total score for the team is 29.
-- Fifth day is 2020-01-07, Bajrang scored 7 points and the total score for the team is 36.

-- 對於女隊：
-- 第一天是2019-12-30，普里揚卡獲得17分，該團隊的總得分是17
-- 第二天是2019-12-31，Priya獲得23分，該團隊的總得分為40
-- 第三天是2020-1-1，阿隆得到17分，球隊總得分為57分
-- 第四天是2020-1-7，愛麗絲得到23分，團隊總得分80

-- 對於男隊：
-- 第一天是2019-12-18，何塞得到2分，球隊總得分是2
-- 第二天是2019-12-25，Khali得到11分，該團隊的總得分是13
-- 第三天是2019-12-30，斯拉曼獲得13分，團隊總得分為26
-- 第四天是2019-12-31，喬獲得3分，該團隊的總得分為29
-- 第五天是2020-1-7，巴傑朗得到7分，該團隊的總得分為36


-- Solution
-- 使用SUM OVER函數累計總合SCORE_POINTS得分
-- PARTITION BY GENDER 透過依性別資料劃分(F、M 資料分群)
-- ORDER BY DAY 達成按照日期排序累計總合
SELECT GENDER, DAY,
  SUM(SCORE_POINTS) OVER(PARTITION BY GENDER ORDER BY DAY) AS TOTAL
FROM SCORES;

