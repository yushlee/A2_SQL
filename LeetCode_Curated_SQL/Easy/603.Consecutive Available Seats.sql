-- 603.Consecutive Available Seats
-- 連續空餘座位

-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- 在電影院售票處幾個朋友想訂個"連續的可用座位"。
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
-- 使用以下 CINEMA TABLE 通過 seat_id 查詢所有"連續可用"的電影院座位順序？


-- Table: Cinema
-- | seat_id | free |
-- |---------|------|
-- | 1       | 1    |
-- | 2       | 0    |
-- | 3       | 1    |
-- | 4       | 1    |
-- | 5       | 1    | 

-- Your query should return the following result for the sample case above.

-- | seat_id |
-- |---------|
-- | 3       |
-- | 4       |
-- | 5       |

-- Note:
-- The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
-- SEAT_ID 是一個自動增量 int 和 free 是 boolean ('1'釋放,'0'佔據)
-- Consecutive available seats are more than 2(inclusive) seats consecutively available.
-- 連續可用座位數連續超過2個(含)座位。


-- Solution
-- 運用LAG查尋上一個FREE、LEAD查尋下一個FREE
-- 最後在查詢每個座位資料本身FREE為1的值，且"上一個PREV FREE " 或 "下一個NEXT FREE" 為1的值
-- 即為查詢連續的可用座位

WITH T_CINEMA AS (
	SELECT SEAT_ID, FREE,
	-- 返迴上一列的值
	-- ORDER BY SEAT_ID 為取上一個、下一個值的排序依據
	LAG(FREE) OVER (ORDER BY SEAT_ID) AS PREV,
	-- 返迴下一列的值
	LEAD(FREE) OVER (ORDER BY SEAT_ID) AS NEXT  
	FROM CINEMA
)
SELECT SEAT_ID
FROM T_CINEMA
WHERE FREE = 1
AND (PREV = 1 OR NEXT = 1)
ORDER BY SEAT_ID;

