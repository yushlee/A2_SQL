-- 1440.Evaluate Boolean Expression
-- 計算布林表達式的值

-- Table Variables:
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | name          | varchar |
-- | value         | int     |
-- +---------------+---------+
-- name is the primary key for this table.
-- This table contains the stored variables and their values.
-- 該表包含存儲的變量及其值

-- Table Expressions:
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | left_operand  | varchar |
-- | operator      | enum    |
-- | right_operand | varchar |
-- +---------------+---------+
-- (left_operand, operator, right_operand) is the primary key for this table.
-- This table contains a boolean expression that should be evaluated.
-- operator is an enum that takes one of the values ('<', '>', '=')
-- The values of left_operand and right_operand are guaranteed to be in the Variables table.
-- 此表包含應評估的布爾表達式
-- operator 是一個列舉，它採用以下值之一 ('<', '>', '=')
-- left_operand 和 right_operand 的值保證在 Variables 表中

-- Write an SQL query to evaluate the boolean expressions in Expressions table.
-- 查詢以評估Expressions表中的布林表達式

-- Variables table:
-- +------+-------+
-- | name | value |
-- +------+-------+
-- | x    | 66    |
-- | y    | 77    |
-- +------+-------+

-- Return the result table in any order.
-- Expressions table:
-- +--------------+----------+---------------+
-- | left_operand | operator | right_operand |
-- +--------------+----------+---------------+
-- | x            | >        | y             |
-- | x            | <        | y             |
-- | x            | =        | y             |
-- | y            | >        | x             |
-- | y            | <        | x             |
-- | x            | =        | x             |
-- +--------------+----------+---------------+


-- The query result format is in the following example.
-- Result table:
-- +--------------+----------+---------------+-------+
-- | left_operand | operator | right_operand | value |
-- +--------------+----------+---------------+-------+
-- | x            | >        | y             | false |
-- | x            | <        | y             | true  |
-- | x            | =        | y             | false |
-- | y            | >        | x             | true  |
-- | y            | <        | x             | false |
-- | x            | =        | x             | true  |
-- +--------------+----------+---------------+-------+
-- As shown, you need find the value of each boolean exprssion in the table using the variables table.


-- Solution
SELECT E.*, --VL.*, VR.*
CASE WHEN (E.OPERATOR = '>' AND VL.VALUE > VR.VALUE) THEN 'true'
     WHEN (E.OPERATOR = '<' AND VL.VALUE < VR.VALUE) THEN 'true'
     WHEN (E.OPERATOR = '=' AND VL.VALUE = VR.VALUE) THEN 'true'
     ELSE 'false' END VALUE
FROM EXPRESSIONS E
-- JOIN VARIABLES 取得LEFT_OPERAND左側的值
JOIN VARIABLES VL ON E.LEFT_OPERAND = VL.NAME 
-- JOIN VARIABLES 取得RIGHT_OPERAND右側的值
JOIN VARIABLES VR ON E.RIGHT_OPERAND = VR.NAME;
