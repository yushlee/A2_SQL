-- 1194.Tournament Winners 錦標賽優勝者

-- Table: Players
-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | player_id   | int   |
-- | group_id    | int   |
-- +-------------+-------+
-- player_id is the primary key of this table.
-- Each row of this table indicates the group of each player.
-- 該表的每一行表示每個玩家所在的組

-- Table: Matches
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | first_player  | int     |
-- | second_player | int     | 
-- | first_score   | int     |
-- | second_score  | int     |
-- +---------------+---------+
-- match_id is the primary key of this table.
-- Each row is a record of a match, first_player and second_player contain the player_id of each match.
-- 每行是一場比賽的記錄，first_player 和 second_player 包含每場比賽的 player_id。
-- first_score and second_score contain the number of points of the first_player and second_player respectively.
-- first_score 和 second_score 分別包含 first_player 和 second_player 的點數。
-- You may assume that, in each match, players belongs to the same group.
-- 您可以假設，在每場比賽中，玩家都屬於同一組。 


-- The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, 
-- the lowest player_id wins.
-- Write an SQL query to find the winner in each group.
-- 每個組中的獲勝者是得分最高的人。如果是平局，則player_id 編號小的獲勝。查詢每個組中的獲勝者。


-- Players table:
-- +-----------+------------+
-- | player_id | group_id   |
-- +-----------+------------+
-- | 15        | 1          |
-- | 25        | 1          |
-- | 30        | 1          |
-- | 45        | 1          |
-- | 10        | 2          |
-- | 35        | 2          |
-- | 50        | 2          |
-- | 20        | 3          |
-- | 40        | 3          |
-- +-----------+------------+


-- Matches table:
-- +------------+--------------+---------------+-------------+--------------+
-- | match_id   | first_player | second_player | first_score | second_score |
-- +------------+--------------+---------------+-------------+--------------+
-- | 1          | 15           | 45            | 3           | 0            |
-- | 2          | 30           | 25            | 1           | 2            |
-- | 3          | 30           | 15            | 2           | 0            |
-- | 4          | 40           | 20            | 5           | 2            |
-- | 5          | 35           | 50            | 1           | 1            |
-- +------------+--------------+---------------+-------------+--------------+

-- The query result format is in the following example:
-- Result table:
-- +-----------+------------+
-- | group_id  | player_id  |
-- +-----------+------------+ 
-- | 1         | 15         |
-- | 2         | 35         |
-- | 3         | 40         |
-- +-----------+------------+


-- Solution
WITH T1 AS (
  SELECT P.GROUP_ID, P.PLAYER_ID, M.FIRST_SCORE SCORE
  FROM　PLAYERS P JOIN MATCHES M 
  ON P.PLAYER_ID = M.FIRST_PLAYER
  UNION ALL
  SELECT P.GROUP_ID, P.PLAYER_ID, M.SECOND_SCORE SCORE
  FROM　PLAYERS P JOIN MATCHES M 
  ON P.PLAYER_ID = M.SECOND_PLAYER
),
T2 AS (
  SELECT GROUP_ID, PLAYER_ID, SUM(SCORE) SUM_SCORE,
  ROW_NUMBER() OVER (PARTITION BY GROUP_ID ORDER BY SUM(SCORE) DESC, PLAYER_ID) RANK
  FROM T1
  GROUP BY GROUP_ID, PLAYER_ID
  ORDER BY GROUP_ID, SUM_SCORE DESC, PLAYER_ID
)
SELECT GROUP_ID, PLAYER_ID FROM T2 WHERE T2.RANK = 1;
