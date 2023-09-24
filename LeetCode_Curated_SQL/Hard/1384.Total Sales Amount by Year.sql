-- 1384.Total Sales Amount by Year

-- Table: Product

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | product_name  | varchar |
-- +---------------+---------+
-- product_id is the primary key for this table.
-- product_name is the name of the product.
 

-- Table: Sales
-- +---------------------+---------+
-- | Column Name         | Type    |
-- +---------------------+---------+
-- | product_id          | int     |
-- | period_start        | varchar |
-- | period_end          | date    |
-- | average_daily_sales | int     |
-- +---------------------+---------+
-- product_id is the primary key for this table. 
-- period_start and period_end indicates the start and end date for sales period, both dates are inclusive.
-- period_start 和period_end 是銷售開始和結束日期
-- The average_daily_sales column holds the average daily sales amount of the items for the period.
-- average_daily_sales 是該期間物料的平均每日銷售額

-- Write an SQL query to report the Total sales amount of each item for each 
-- year, with corresponding product name, product_id, product_name and report_year.
-- 查詢每個項目每年(2018~2020)的總銷售額(total_amount)，以及相應的產品編號(product_id)，產品名稱(product_name)和年份(report_year)。


-- Dates of the sales years are between 2018 to 2020. Return the result table ordered by product_id and report_year.
-- 銷售年份的日期在2018到2020之間，查詢結果按product_id和report_year升序排列。

-- Product table:
-- +------------+--------------+
-- | product_id | product_name |
-- +------------+--------------+
-- | 1          | LC Phone     |
-- | 2          | LC T-Shirt   |
-- | 3          | LC Keychain  |
-- +------------+--------------+

-- Sales table:
-- +------------+--------------+-------------+---------------------+
-- | product_id | period_start | period_end  | average_daily_sales |
-- +------------+--------------+-------------+---------------------+
-- | 1          | 2019-01-25   | 2019-02-28  | 100                 |
-- | 2          | 2018-12-01   | 2020-01-01  | 10                  |
-- | 3          | 2019-12-01   | 2020-01-31  | 1                   |
-- +------------+--------------+-------------+---------------------+

-- Result table:
-- +------------+--------------+-------------+--------------+
-- | product_id | product_name | report_year | total_amount |
-- +------------+--------------+-------------+--------------+
-- | 1          | LC Phone     |    2019     | 3500         |
-- | 2          | LC T-Shirt   |    2018     | 310          |
-- | 2          | LC T-Shirt   |    2019     | 3650         |
-- | 2          | LC T-Shirt   |    2020     | 10           |
-- | 3          | LC Keychain  |    2019     | 31           |
-- | 3          | LC Keychain  |    2020     | 31           |
-- +------------+--------------+-------------+--------------+
-- LC Phone was sold for the period of 2019-01-25 to 2019-02-28, and there are 35 days for this period. Total amount 35*100 = 3500. 
-- LC T-shirt was sold for the period of 2018-12-01 to 2020-01-01, and there are 31, 365, 1 days for years 2018, 2019 and 2020 respectively.
-- LC Keychain was sold for the period of 2019-12-01 to 2020-01-31, and there are 31, 31 days for years 2019 and 2020 respectively.
-- LC Phone 銷售時間為2019-01-25至2019-02-28，此期間為35天。總金額35*100 = 3500。
-- LCT T-Shirt 銷售時間為2018-12-01至2020-01-01，2018年、2019年、2020年分別為31天、365天、1天。
-- LC Keychain 銷售時間為2019-12-01至2020-01-31，2019年和2020年分別為31天、31天。


-- Solution
-- Oracle
WITH T AS (
  SELECT
      B.PRODUCT_ID,
      A.PRODUCT_NAME,
      A.YR REPORT_YEAR,
--      TO_CHAR(B.PERIOD_START, 'YYYY') PERIOD_START,
--      TO_CHAR(B.PERIOD_END, 'YYYY') PERIOD_END,
--      CASE 
--           WHEN TO_CHAR(B.PERIOD_START,'YYYY') = TO_CHAR(B.PERIOD_END,'YYYY') AND A.YR = TO_CHAR(B.PERIOD_START,'YYYY')
--              THEN '報表年份、開始日、結束日(同一年)'
--           WHEN A.YR = TO_CHAR(B.PERIOD_START,'YYYY')
--              THEN '報表年份與開始日(同一年)'
--           WHEN A.YR = TO_CHAR(B.PERIOD_END,'YYYY')
--              THEN '報表年份與結束日(同一年)'
--           WHEN A.YR BETWEEN TO_CHAR(B.PERIOD_START,'YYYY') AND TO_CHAR(B.PERIOD_END,'YYYY') 
--              THEN '報表年份介於開始日、結束日之間'
--           ELSE '報表年份未在開始日、結束日範圍內'
--      END REPORT_TYPE,
      CASE 
           -- 報表年份、開始日、結束日(同一年)
           WHEN A.YR = TO_CHAR(B.PERIOD_START,'YYYY') AND TO_CHAR(B.PERIOD_START,'YYYY') = TO_CHAR(B.PERIOD_END,'YYYY')
              -- 間隔天數 = 開始日-結束日+1
              THEN B.PERIOD_END - B.PERIOD_START + 1
           -- 報表年份與開始日(同一年)
           WHEN A.YR = TO_CHAR(B.PERIOD_START,'YYYY')
              -- 間隔天數 = 開始日的年底(12/31)-開始日+1
              THEN TO_DATE(TO_CHAR(B.PERIOD_START, 'YYYY')||'-12-31', 'YYYY-mm-DD') - B.PERIOD_START + 1
           -- 報表年份與結束日(同一年)
           WHEN A.YR = TO_CHAR(B.PERIOD_END,'YYYY')
              -- 間隔天數 = 結束日是報表年的第幾天(Day of year)
              THEN TO_NUMBER(TO_CHAR(B.PERIOD_END,'DDD'))
           --  報表年份介於開始日、結束日之間
           WHEN A.YR BETWEEN TO_CHAR(B.PERIOD_START,'YYYY') AND TO_CHAR(B.PERIOD_END,'YYYY') 
              -- 間隔天數 = 整年度365天
              THEN 365
           -- 報表年份未在開始日、結束日範圍內
           ELSE 0
      END * AVERAGE_DAILY_SALES AS TOTAL_AMOUNT
  FROM (
    -- 建立三個報表年份的產品REPORT_YEAR
    SELECT PRODUCT_ID,PRODUCT_NAME,'2018' YR FROM PRODUCT
    UNION
    SELECT PRODUCT_ID,PRODUCT_NAME,'2019' YR FROM PRODUCT
    UNION
    SELECT PRODUCT_ID,PRODUCT_NAME,'2020' YR FROM PRODUCT
  ) A JOIN SALES B    
  ON A.PRODUCT_ID = B.PRODUCT_ID  
  ORDER BY B.PRODUCT_ID, A.YR
)
SELECT * FROM T
WHERE TOTAL_AMOUNT > 0;


--MySQL
SELECT
    B.PRODUCT_ID,
    A.PRODUCT_NAME,
    A.YR AS REPORT_YEAR,
    CASE 
        WHEN YEAR(B.PERIOD_START) = YEAR(B.PERIOD_END) AND A.YR = YEAR(B.PERIOD_START) THEN DATEDIFF(B.PERIOD_END,B.PERIOD_START)+1
        WHEN A.YR = YEAR(B.PERIOD_START) THEN DATEDIFF(DATE_FORMAT(B.PERIOD_START,'%Y-12-31'),B.PERIOD_START)+1
        WHEN A.YR = YEAR(B.PERIOD_END) THEN DAYOFYEAR(B.PERIOD_END) 
        WHEN A.YR > YEAR(B.PERIOD_START) AND A.YR < YEAR(B.PERIOD_END) THEN 365
        ELSE 0
    END * AVERAGE_DAILY_SALES AS TOTAL_AMOUNT
FROM (
  SELECT PRODUCT_ID,PRODUCT_NAME,'2018' AS YR FROM PRODUCT
  UNION
  SELECT PRODUCT_ID,PRODUCT_NAME,'2019' AS YR FROM PRODUCT
  UNION
  SELECT PRODUCT_ID,PRODUCT_NAME,'2020' AS YR FROM PRODUCT
) A JOIN SALES B    
ON A.PRODUCT_ID=B.PRODUCT_ID  
HAVING TOTAL_AMOUNT > 0
ORDER BY B.PRODUCT_ID, A.YR;
