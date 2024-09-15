-- 1294.Weather Type in Each Country 不同國家的天氣類型

-- Table: Countries
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | country_id    | int     |
-- | country_name  | varchar |
-- +---------------+---------+
-- country_id is the primary key for this table.
-- Each row of this table contains the ID and the name of one country.
-- 表格的每一行包含一個國家的 ID 和名稱。

-- Table: Weather
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | country_id    | int     |
-- | weather_state | varchar |
-- | day           | date    |
-- +---------------+---------+
-- (country_id, day) is the primary key for this table.
-- Each row of this table indicates the weather state in a country for one day.
-- 此表的每一行表示一個國家一天的天氣狀況 

-- Write an SQL query to find the type of weather in each country for November 2019.
-- 查找每個國家在2019年11月的天氣類型

-- The type of weather is Cold if the "average" 'weather_state' is less than or equal 15,
-- 如果平均 weather_state 小於或等於 15，則天氣類型為 'Cold'
-- Hot if the average weather_state is greater than or equal 25 and Warm otherwise.
-- 如果平均 weather_state 大於或等於 25，則天氣類型為 'Hot'
-- Return result table in any order.

-- The query result format is in the following example:

-- Countries table:
-- +------------+--------------+
-- | country_id | country_name |
-- +------------+--------------+
-- | 2          | USA          |
-- | 3          | Australia    |
-- | 7          | Peru         |
-- | 5          | China        |
-- | 8          | Morocco      |
-- | 9          | Spain        |
-- +------------+--------------+

-- Weather table:
-- +------------+---------------+------------+
-- | country_id | weather_state | day        |
-- +------------+---------------+------------+
-- | 2          | 15            | 2019-11-01 |
-- | 2          | 12            | 2019-10-28 |
-- | 2          | 12            | 2019-10-27 |
-- | 3          | -2            | 2019-11-10 |
-- | 3          | 0             | 2019-11-11 |
-- | 3          | 3             | 2019-11-12 |
-- | 5          | 16            | 2019-11-07 |
-- | 5          | 18            | 2019-11-09 |
-- | 5          | 21            | 2019-11-23 |
-- | 7          | 25            | 2019-11-28 |
-- | 7          | 22            | 2019-12-01 |
-- | 7          | 20            | 2019-12-02 |
-- | 8          | 25            | 2019-11-05 |
-- | 8          | 27            | 2019-11-15 |
-- | 8          | 31            | 2019-11-25 |
-- | 9          | 7             | 2019-10-23 |
-- | 9          | 3             | 2019-12-23 |
-- +------------+---------------+------------+

-- Result table:
-- +--------------+--------------+
-- | country_name | weather_type |
-- +--------------+--------------+
-- | USA          | Cold         |
-- | Austraila    | Cold         |
-- | Peru         | Hot          |
-- | China        | Warm         |
-- | Morocco      | Hot          |
-- +--------------+--------------+

-- Average weather_state in USA in November is (15) / 1 = 15 so weather type is 'Cold'.
-- 美國11月的平均天氣狀態為（15）/ 1 = 15，因此天氣類型為'Cold'
-- Average weather_state in Austraila in November is (-2 + 0 + 3) / 3 = 0.333 so weather type is 'Cold'.
-- 11月在澳大利亞的平均天氣狀態為（-2 + 0 + 3）/ 3 = 0.333，因此天氣類型為'Cold'
-- Average weather_state in Peru in November is (25) / 1 = 25 so weather type is 'Hot'.
-- 秘魯在11月的平均weather_state為（25）/ 1 = 25，因此天氣類型為'Hot'
-- Average weather_state in China in November is (16 + 18 + 21) / 3 = 18.333 so weather type is 'Warm'.
-- 11月中國的平均天氣狀態為（16 + 18 + 21）/ 3 = 18.333，因此天氣類型為'Warm'
-- Average weather_state in Morocco in November is (25 + 27 + 31) / 3 = 27.667 so weather type is 'Hot'.
-- 摩洛哥11月的平均weather_state為（25 + 27 + 31）/ 3 = 27.667，因此天氣類型為'Hot'
-- We know nothing about average weather_state in Spain in November
-- 我們對11月份西班牙的平均天氣狀況一無所知
-- so we don't include it in the result table. 
-- 因此我們不將其包括在結果表中。


-- Solution
-- 先將WEATHER天氣資料表與COUNTRIES國家資料表透過COUNTRY_ID國家編號關聯連接
-- 查詢條件DATE_FORMAT(W.DAY, ' %Y-%m')只取天氣月份並且為2019-11資料篩選
-- 透過COUNTRY_NAME國家名稱做為資料分群
-- 透過AVG(W.WEATHER_STATE)計算各別國家的天氣狀態平均值
-- 判斷天氣狀態，其中溫度小於等於15，為'Cold'，溫度大於等於25，為'Hot'，其他溫度區間為'Warm'
-- MySQL
SELECT C.COUNTRY_NAME, 
CASE WHEN AVG(W.WEATHER_STATE) <= 15 THEN 'Cold'
     WHEN AVG(W.WEATHER_STATE) >= 25 THEN 'Hot'
     ELSE 'Warm'
     END AS WEATHER_TYPE,
     AVG(W.WEATHER_STATE)
FROM WEATHER W JOIN COUNTRIES C
ON W.COUNTRY_ID = C.COUNTRY_ID
WHERE DATE_FORMAT(W.DAY, '%Y-%m') = '2019-11'
GROUP BY C.COUNTRY_NAME;



-- Oracle
SELECT C.COUNTRY_NAME,
CASE WHEN AVG(W.WEATHER_STATE) <= 15 THEN 'Cold'
     WHEN AVG(W.WEATHER_STATE) >= 25 THEN 'Hot'
     ELSE 'Warm'
     END AS WEATHER_TYPE,
     TRUNC(W.DAY, 'MONTH') "November 2019"
FROM WEATHER W JOIN COUNTRIES C
ON W.COUNTRY_ID = C.COUNTRY_ID
WHERE TRUNC(W.DAY, 'MONTH') = '2019-11-01' -- MONTH(月捨去)
GROUP BY C.COUNTRY_NAME, TRUNC(W.DAY, 'MONTH');