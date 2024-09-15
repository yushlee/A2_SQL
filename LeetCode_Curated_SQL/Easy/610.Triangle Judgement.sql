-- 610.Triangle Judgement

-- A pupil Tim gets homework to identify whether three line segments could possibly form a triangle.
-- 小學生蒂姆(Tim)進行作業，以確定三個線段是否可能形成三角形

-- However, this assignment is very heavy because there are hundreds of records to calculate.
-- 但是，此任務非常繁重，因為有數百條記錄需要計算

-- Could you help Tim by writing a query to judge whether these three sides can form a triangle, 
-- assuming table triangle holds the length of the three sides x, y and z.
-- 通過編寫查詢來判斷這三個邊是否可以形成三角形
-- 假設表格三角形包含x，y和z的三個邊的長度

-- Table: Triangle
-- | x  | y  | z  |
-- |----|----|----|
-- | 13 | 15 | 30 |
-- | 10 | 20 | 15 |

-- For the sample data above, your query should return the follow result:
-- | x  | y  | z  | triangle |
-- |----|----|----|----------|
-- | 13 | 15 | 30 | No       |
-- | 10 | 20 | 15 | Yes      |


-- Solution
-- 應用三角形成立的條件，兩邊之和大於第三邊。
SELECT X, Y, Z,
CASE 
  WHEN X+Y > Z AND X+Z > Y AND Y+Z > X THEN 'Yes'
  ELSE 'No'
END AS TRIANGLE
FROM TRIANGLE;
