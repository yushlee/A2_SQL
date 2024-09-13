-- 571.Find Median Given Frequency of Numbers 給定數字的頻率查詢中位數

-- Table: NUMBERS
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
-- 在此表中，數字為 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3，所以中位數是 (0 + 0) / 2 = 0
-- PS:左邊與右邊的數字個數各5個，所以中間兩個數相加除2
-- +--------+
-- | median |
-- +--------|
-- | 0.0000 |
-- +--------+
-- Write a query to find the median of all numbers and name the result as median.
-- 編寫一個查詢來查找所有數字的中位數


-- Solution
-- 透過數字出現次數累計加總，得出每個數字的「結束位置」FREQUENCY_TOTAL
-- 計算數字出現次數「中間數」MIDDLE
-- FREQUENCY_TOTAL - FREQUENCY 計算每個數字出現的「起始位置」
-- 篩選「中間數」MIDDLE介於「起始位置」和「結束位置」FREQUENCY_TOTAL之間，找出中間數的數字NUMBER
-- 最後將NUMBER平均AVG計算中位數
WITH T AS(
  SELECT NUMBER, FREQUENCY,
	  SUM(FREQUENCY)OVER(ORDER BY NUMBER) FREQUENCY_TOTAL,	  
	  SUM(FREQUENCY)OVER() / 2 AS MIDDLE
  FROM NUMBERS
)
SELECT AVG(NUMBER) AS MEDIAN
FROM T
WHERE MIDDLE BETWEEN (FREQUENCY_TOTAL - FREQUENCY) AND FREQUENCY_TOTAL;


WITH T AS(
  SELECT NUMBER, FREQUENCY,
	  SUM(FREQUENCY)OVER(ORDER BY NUMBER) FREQUENCY_TOTAL,	  
	  SUM(FREQUENCY)OVER() / 2 AS MIDDLE
  FROM NUMBERS
)
SELECT NUMBER, FREQUENCY, MIDDLE, (FREQUENCY_TOTAL - FREQUENCY), FREQUENCY_TOTAL
FROM T;
