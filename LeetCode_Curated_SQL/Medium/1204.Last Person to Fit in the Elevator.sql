-- 1204.Last Person to Fit in the Elevator 最後一個進入電梯的人

-- Table: Queue
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | person_id   | int     |
-- | person_name | varchar |
-- | weight      | int     |
-- | turn        | int     |
-- +-------------+---------+
-- person_id is the primary key column for this table.
-- This table has the information about all people waiting for an elevator.
-- The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
-- 這張表包含所有等待電梯的人的信息
-- person_id 和 turn 列將包含從 1 到 n 的所有數字，其中 n 是表中的行數

-- The maximum weight the elevator can hold is 1000.
-- 電梯可容納的最大重量為1000

-- Write an SQL query to find the person_name of the last person who will fit in the elevator without exceeding the weight limit. 
-- It is guaranteed that the person who is first in the queue can fit in the elevator.
-- 查詢"最後一位"能在不超過重量限制的情況下進入電梯的人的 person_name。保證排在第一位的人能坐進電梯。

-- The query result format is in the following example:
-- Queue table
-- +-----------+-------------------+--------+------+
-- | person_id | person_name       | weight | turn |
-- +-----------+-------------------+--------+------+
-- | 5         | George Washington | 250    | 1    |
-- | 3         | John Adams        | 350    | 2    |
-- | 6         | Thomas Jefferson  | 400    | 3    |
-- | 2         | Will Johnliams    | 200    | 4    |
-- | 4         | Thomas Jefferson  | 175    | 5    |
-- | 1         | James Elephant    | 500    | 6    |
-- +-----------+-------------------+--------+------+

-- Result table
-- +-------------------+
-- | person_name       |
-- +-------------------+
-- | Thomas Jefferson  |
-- +-------------------+

-- Queue table is ordered by turn in the example for simplicity.
-- In the example George Washington(id 5), John Adams(id 3) and Thomas Jefferson(id 6) will enter the elevator as their weight sum is 250 + 350 + 400 = 1000.
-- Thomas Jefferson(id 6) is the last person to fit in the elevator because he has the last turn in these three people.

-- 為簡單起見，示例中的隊列表是按順序排列的。
-- 在示例 George Washington(id 5) 中，John Adams(id 3) 和 Thomas Jefferson(id 6) 將進入電梯
-- 因為他們的總重量為 250 + 350 + 400 = 1000。
-- Thomas Jefferson(id 6) 是最後一個人進電梯


-- Solution
-- 透過SUM OVER函數計算累積 ORDER BY TURN 總和 WEIGHT 體重
-- 最後找出隊列中最後一個小於等於1000累積總和體重的TURN(隊列號碼)
-- 再查詢PERSON_NAME乘員名稱
WITH T AS (  
  SELECT PERSON_ID, PERSON_NAME, TURN, WEIGHT,
	SUM(WEIGHT) OVER (ORDER BY TURN) AS SUM_WEIGHT
  FROM QUEUE
  ORDER BY TURN
)
SELECT T.PERSON_NAME
FROM T
WHERE TURN = (  
  SELECT MAX(TURN) FROM T WHERE SUM_WEIGHT <= 1000
);
