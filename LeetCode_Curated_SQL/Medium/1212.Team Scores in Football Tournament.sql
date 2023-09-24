-- 1212.Team Scores in Football Tournament

-- Table: Teams
-- +---------------+----------+
-- | Column Name   | Type     |
-- +---------------+----------+
-- | team_id       | int      |
-- | team_name     | varchar  |
-- +---------------+----------+
-- team_id is the primary key of this table.
-- Each row of this table represents a single football team.
-- team_id是此表的主鍵。該表的每一行代表一個足球隊

-- Table: Matches
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | host_team     | int     |
-- | guest_team    | int     | 
-- | host_goals    | int     |
-- | guest_goals   | int     |
-- +---------------+---------+
-- match_id is the primary key of this table.
-- Each row is a record of a finished match between two different teams. 
-- Teams host_team and guest_team are represented by their IDs in the teams table (team_id) and they scored host_goals and guest_goals goals respectively.
-- match_id 是此表的主鍵。每一行都是兩個不同團隊之間的比賽記錄
-- 團隊 host_team 和 guest_team 在團隊表(team_id)中以其ID表示
-- 他們各自的得分情況分別記錄在 host_goals 和 guest_goals 裡

-- You would like to compute the scores of all teams after all matches. Points are awarded as follows:
-- A team receives three points if they win a match (Score strictly more goals than the opponent team).
-- A team receives one point if they draw a match (Same number of goals as the opponent team).
-- A team receives no points if they lose a match (Score less goals than the opponent team).
-- Write an SQL query that selects the team_id, team_name and num_points of each team in the tournament after all described matches. Result table should be ordered by num_points (decreasing order). In case of a tie, order the records by team_id (increasing order).

-- 您想計算所有比賽後所有球隊的得分。積分獎勵如下：
-- 如果球隊贏得一場比賽，他們將獲得3分(進球數多於對手隊)
-- 如果球隊進行一場比賽(與對手球隊進球數相同)，則該隊獲得1分
-- 如果球隊輸掉比賽，則該隊將不獲任何積分（進球數少於對手隊）
-- 在描述所有匹配之後，選擇錦標賽中每個團隊的 team_id，team_name 和 num_points
-- 結果表應按 num_points 降序排列。如果是平局，請按team_id 對記錄進行升序排序


-- The query result format is in the following example:
-- Teams table:
-- +-----------+--------------+
-- | team_id   | team_name    |
-- +-----------+--------------+
-- | 10        | Leetcode FC  |
-- | 20        | NewYork FC   |
-- | 30        | Atlanta FC   |
-- | 40        | Chicago FC   |
-- | 50        | Toronto FC   |
-- +-----------+--------------+
  

-- Matches table:
-- +------------+--------------+---------------+-------------+--------------+
-- | match_id   | host_team    | guest_team    | host_goals  | guest_goals  |
-- +------------+--------------+---------------+-------------+--------------+
-- | 1          | 10           | 20            | 3           | 0            |
-- | 2          | 30           | 10            | 2           | 2            |
-- | 3          | 10           | 50            | 5           | 1            |
-- | 4          | 20           | 30            | 1           | 0            |
-- | 5          | 50           | 30            | 1           | 0            |
-- +------------+--------------+---------------+-------------+--------------+


-- Result table:
-- +------------+--------------+---------------+
-- | team_id    | team_name    | num_points    |
-- +------------+--------------+---------------+
-- | 10         | Leetcode FC  | 7             |
-- | 20         | NewYork FC   | 3             |
-- | 50         | Toronto FC   | 3             |
-- | 30         | Atlanta FC   | 1             |
-- | 40         | Chicago FC   | 0             |
-- +------------+--------------+---------------+


-- Solution
WITH T1 AS (
  -- 計算主隊積分(勝3分、負0分、平局1分)
  SELECT T.TEAM_ID, M.HOST_GOALS, M.GUEST_GOALS,
  CASE WHEN M.HOST_GOALS > M.GUEST_GOALS THEN 3
        WHEN M.HOST_GOALS < M.GUEST_GOALS THEN 0
       ELSE 1 END POINTS
  FROM TEAMS T JOIN MATCHES M
  ON T.TEAM_ID = M.HOST_TEAM
  ORDER BY T.TEAM_ID
),
T2 AS (
  -- 計算客隊積分(勝3分、負0分、平局1分)
  SELECT T.TEAM_ID, M.GUEST_GOALS, M.HOST_GOALS, 
  CASE WHEN M.GUEST_GOALS > M.HOST_GOALS THEN 3
       WHEN M.GUEST_GOALS < M.HOST_GOALS  THEN 0
       ELSE 1 END POINTS
  FROM TEAMS T JOIN MATCHES M
  ON T.TEAM_ID = M.GUEST_TEAM
  ORDER BY T.TEAM_ID
),
T3 AS (
  -- 主隊、客隊總積分
  SELECT TEAM_ID, SUM(POINTS) SUM_POINTS
  FROM (
    SELECT T1.TEAM_ID, T1.POINTS FROM T1
    UNION ALL
    SELECT T2.TEAM_ID, T2.POINTS FROM T2
  ) GROUP BY TEAM_ID ORDER BY TEAM_ID
)
SELECT T.TEAM_ID, T.TEAM_NAME, NVL(T3.SUM_POINTS, 0) NUM_POINTS
FROM Teams T LEFT JOIN T3
ON T.TEAM_ID = T3.TEAM_ID
ORDER BY NUM_POINTS DESC, T.TEAM_ID;