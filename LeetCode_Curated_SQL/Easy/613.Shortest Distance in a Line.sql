-- 613.Shortest Distance in a Line

-- Table point holds the x coordinate of some points on x-axis in a plane, which are all integers.
-- 表格點保存平面中x軸上某些點的x坐標，它們都是整數。 

-- Write a query to find the shortest distance between two points in these points.
-- 編寫查詢以查找這些點中兩個點之間的最短距離

-- | x   |
-- |-----|
-- | -1  |
-- | 0   |
-- | 2   |
 

-- The shortest distance is '1' obviously, which is from point '-1' to '0'. So the output is as below:
-- 最短距離顯然是'1'，它是從點 '-1' 到 '0' 的距離。所以輸出如下：

-- | shortest|
-- |---------|
-- | 1       |
 

-- Note: Every point is unique, which means there is no duplicates in table point
-- 每個點都是唯一的，這意味著表點中沒有重複

-- Solution
SELECT MIN(NEXT_CLOSEST - X) SHORTEST
FROM (
  -- 先查詢出每一個點與下一個點的位置
  SELECT X,
  LEAD(X) OVER (ORDER BY X) AS NEXT_CLOSEST
  FROM POINT
) A;
