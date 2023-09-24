-- 571.Find Median Given Frequency of Numbers

-- The Numbers table keeps the value of number and its frequency.
-- 下表記錄了每個數字及其出現的頻率
-- +----------+-------------+
-- |  Number  |  Frequency  |
-- +----------+-------------|
-- |  0       |  7          |
-- |  1       |  1          |
-- |  2       |  3          |
-- |  3       |  1          |
-- +----------+-------------+

-- In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.
-- 在此表中，數字為 0, 0, 0, 0, 0, "0", "0", 1, 2, 2, 2, 3，所以中位數是 (0 + 0) / 2 = 0
-- PS:左邊與右邊的數字個數各為5個，所以中間兩個數相加除2
-- +--------+
-- | median |
-- +--------|
-- | 0.0000 |
-- +--------+
-- Write a query to find the median of all numbers and name the result as median.
-- 編寫一個查詢來查找所有數字的中位數


-- Solution
WITH T1 AS(
  SELECT "NUMBER", FREQUENCY,
  -- 數字頻率 "累計鏓計"
  SUM(FREQUENCY) OVER(ORDER BY "NUMBER") AS CUM_SUM,
  -- 數字頻率 "中間數"
  (SUM(FREQUENCY) OVER()) / 2 AS MIDDLE
  FROM NUMBERS
)
--SELECT "NUMBER", FREQUENCY, (CUM_SUM - FREQUENCY), CUM_SUM, MIDDLE
SELECT AVG("NUMBER") AS MEDIAN
FROM T1
-- (CUM_SUM - FREQUENCY)計算每個數字所出現的起始位置
WHERE MIDDLE BETWEEN (CUM_SUM - FREQUENCY) AND CUM_SUM;
