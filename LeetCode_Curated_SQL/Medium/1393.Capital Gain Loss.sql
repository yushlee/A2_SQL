-- 1393.Capital Gain/Loss

-- Table: Stocks
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | stock_name    | varchar |
-- | operation     | enum    |
-- | operation_day | int     |
-- | price         | int     |
-- +---------------+---------+
-- (stock_name, operation_day) is the primary key for this table.
-- The operation column is an ENUM of type ('Sell', 'Buy')
-- Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
-- It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day.
-- 操作列是ENUM類型('出售'，'購買')
-- 該表的每一行指示具有stock_name 的股票在operation_day 進行了一次操作
-- 可以保證股票的每個“賣出”操作在前一天都有一個對應的“買入”操作


-- Write an SQL query to report the Capital gain/loss for each stock.
-- 查詢每隻股票的資本收益/損失

-- The capital gain/loss of a stock is total gain or loss after buying and selling the stock one or many times.
-- 股票的資本收益/損失是在一次或多次買賣股票後的總收益或損失

-- Return the result table in any order.

-- Stocks table:
-- +---------------+-----------+---------------+--------+
-- | stock_name    | operation | operation_day | price  |
-- +---------------+-----------+---------------+--------+
-- | Leetcode      | Buy       | 1             | 1000   |
-- | Corona Masks  | Buy       | 2             | 10     |
-- | Leetcode      | Sell      | 5             | 9000   |
-- | Handbags      | Buy       | 17            | 30000  |
-- | Corona Masks  | Sell      | 3             | 1010   |
-- | Corona Masks  | Buy       | 4             | 1000   |
-- | Corona Masks  | Sell      | 5             | 500    |
-- | Corona Masks  | Buy       | 6             | 1000   |
-- | Handbags      | Sell      | 29            | 7000   |
-- | Corona Masks  | Sell      | 10            | 10000  |
-- +---------------+-----------+---------------+--------+

-- The query result format is in the following example:
-- Result table:
-- +---------------+-------------------+
-- | stock_name    | capital_gain_loss |
-- +---------------+-------------------+
-- | Corona Masks  | 9500              |
-- | Leetcode      | 8000              |
-- | Handbags      | -23000            |
-- +---------------+-------------------+
-- Leetcode stock was bought at day 1 for 1000$ and was sold at day 5 for 9000$. Capital gain = 9000 - 1000 = 8000$.
-- Handbags stock was bought at day 17 for 30000$ and was sold at day 29 for 7000$. Capital loss = 7000 - 30000 = -23000$.
-- Corona Masks stock was bought at day 1 for 10$ and was sold at day 3 for 1010$. It was bought again at day 4 for 1000$ and was sold at day 5 for 500$. 
-- At last, it was bought at day 6 for 1000$ and was sold at day 10 for 10000$. 
-- Capital gain/loss is the sum of capital gains/losses for each ('Buy' --> 'Sell') 
-- operation = (1010 - 10) + (500 - 1000) + (10000 - 1000) = 1000 - 500 + 9000 = 9500$.

-- Leetcode 股票：在第1天以 1000$ 的價格購買，並在第5天以 9000$ 的價格出售。資本收益 = 9000 - 1000 = 8000$
-- Handbags 股票：在第17天以 30000$ 的價格購買，在第29天以 7000$ 的價格出售。資本損失 = 7000 - 30000 = -23000$
-- Corona Masks 股票：在第1天以10$的價格購買，第3天以1010$的價格出售；
-- 在第4天再次以1000$的價格購買，並在第5天以500$的價格出售；
-- 最後，在第6天以1000$的價格購買，並在第10天以10000$的價格出售。
-- 資本損益是每個('購買'->'賣出')操作的
-- 資本損益之和 = (1010-10)+(500-1000)+(10000-1000) = 1000 - 500 + 9000 = 9500$


-- Solution
-- 賣出總金額 - 買入總金額 = 資本損益
SELECT STOCK_NAME, (ONE-TWO) AS CAPITAL_GAIN_LOSS
FROM(
  (
    -- 計算各股票各別賣出總金額
    SELECT STOCK_NAME, SUM(PRICE) AS ONE
    FROM STOCKS
    WHERE OPERATION = 'Sell'
    GROUP BY STOCK_NAME
  ) B LEFT JOIN  
  (
    -- 計算各股票各別買入總金額
    SELECT STOCK_NAME AS NAME, SUM(PRICE) AS TWO
    FROM STOCKS
    WHERE OPERATION = 'Buy'
    GROUP BY STOCK_NAME
  ) C
  ON B.STOCK_NAME = C.NAME
)
ORDER BY CAPITAL_GAIN_LOSS DESC;
