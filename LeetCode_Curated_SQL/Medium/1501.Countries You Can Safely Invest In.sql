-- 1501.Countries You Can Safely Invest In

-- Table Person:
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | name           | varchar |
-- | phone_number   | varchar |
-- +----------------+---------+
-- id is the primary key for this table.
-- Each row of this table contains the name of a person and their phone number.
-- Phone number will be in the form 'xxx-yyyyyyy' where xxx is the country code (3 characters) and yyyyyyy is the 
-- phone number (7 characters) where x and y are digits. Both can contain leading zeros.
-- 該表的每一行均包含一個人的姓名及其電話號碼。
-- 電話號碼的格式為'xxx-yyyyyyy'，其中xxx是國家/地區代碼（3個字符），
-- 而yyyyyyy是電話號碼（7個字符），其中x和y是數字。兩者都可以以0開頭。

-- Table Country:
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | name           | varchar |
-- | country_code   | varchar |
-- +----------------+---------+
-- country_code is the primary key for this table.
-- Each row of this table contains the country name and its code. country_code will be in the form 'xxx' where x is digits.
-- 該表的每一行均包含國家名稱及其代碼。country_code 的格式為'xxx'，其中x為數字
 

-- Table Calls:
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | caller_id   | int  |
-- | callee_id   | int  |
-- | duration    | int  |
-- +-------------+------+
-- There is no primary key for this table, it may contain duplicates.
-- Each row of this table contains the caller id, callee id and the duration of the call in minutes. caller_id != callee_id
-- 該表的每一行均包含呼叫者ID，被呼叫者ID和通話時間（以分鐘為單位），其中呼叫者和被呼叫者不能是同一個人。


-- A telecommunications company wants to invest in new countries.
-- The country intends to invest in the countries where the average call duration 
-- of the calls in this country is strictly greater than the global average call duration.
-- Write an SQL query to find the countries where this company can invest.
-- 一家電信公司想在新的國家投資。公司擬投資於該國平均通話時長大於全球平均通話時長的國家
-- 查找可以投資的國家/地區

-- Return the result table in any order.

-- Person table:
-- +----+----------+--------------+
-- | id | name     | phone_number |
-- +----+----------+--------------+
-- | 3  | Jonathan | 051-1234567  |
-- | 12 | Elvis    | 051-7654321  |
-- | 1  | Moncef   | 212-1234567  |
-- | 2  | Maroua   | 212-6523651  |
-- | 7  | Meir     | 972-1234567  |
-- | 9  | Rachel   | 972-0011100  |
-- +----+----------+--------------+

-- Country table:
-- +----------+--------------+
-- | name     | country_code |
-- +----------+--------------+
-- | Peru     | 051          |
-- | Israel   | 972          |
-- | Morocco  | 212          |
-- | Germany  | 049          |
-- | Ethiopia | 251          |
-- +----------+--------------+

-- Calls table:
-- +-----------+-----------+----------+
-- | caller_id | callee_id | duration |
-- +-----------+-----------+----------+
-- | 1         | 9         | 33       |
-- | 2         | 9         | 4        |
-- | 1         | 2         | 59       |
-- | 3         | 12        | 102      |
-- | 3         | 12        | 330      |
-- | 12        | 3         | 5        |
-- | 7         | 9         | 13       |
-- | 7         | 1         | 3        |
-- | 9         | 7         | 1        |
-- | 1         | 7         | 7        |
-- +-----------+-----------+----------+


-- The query result format is in the following example.
-- Result table:
-- +----------+
-- | country  |
-- +----------+
-- | Peru     |
-- +----------+
-- The average call duration for Peru is (102 + 102 + 330 + 330 + 5 + 5) / 6 = 145.666667
-- The average call duration for Israel is (33 + 4 + 13 + 13 + 3 + 1 + 1 + 7) / 8 = 9.37500
-- The average call duration for Morocco is (33 + 4 + 59 + 59 + 3 + 7) / 6 = 27.5000 
-- Global call duration average = (2 * (33 + 3 + 59 + 102 + 330 + 5 + 13 + 3 + 1 + 7)) / 20 = 55.70000
-- Since Peru is the only country where average call duration is greater than the global average, it's the only recommended country.
-- 秘魯的平均通話時間為（102 + 102 + 330 + 330 + 5 + 5）/ 6 = 145.666667
-- 以色列的平均通話時間為（33 + 4 + 13 + 13 + 3 +1 +1 + 7）/ 8 = 9.37500
-- 摩洛哥的平均通話時間為（33 + 4 + 59 + 59 + 3 + 7）/ 6 = 27.5000
-- 全球通話總時間平均值=（2 *（33 + 4 + 59 + 102 + 330 + 5 + 13 + 3 +1 + 7））/ 20 = 55.70000
-- 由於秘魯是唯一一個平均通話時長大於全球平均通話時間的國家，因此它是唯一推薦的國家


-- Solution One
-- Oracle
WITH CALL_TIME AS (
  -- 查詢所有 CALLER、CALLEE 所有的通話時間
  SELECT CALLER_ID CALL_ID, DURATION
  FROM CALLS
  UNION ALL
  SELECT CALLEE_ID CALL_ID, DURATION
  FROM CALLS
),
PERSON_COUNTRY AS (
  -- 查詢 PERSON 所在的 COUNTRY 資料
  SELECT P.ID, C.COUNTRY_CODE, C.NAME COUNTRY_NAME
  FROM (
    SELECT ID, SUBSTR(PHONE_NUMBER,0,3) PRE_CODE
    FROM PERSON P
  ) P JOIN COUNTRY C
  ON P.PRE_CODE = C.COUNTRY_CODE
)
SELECT COUNTRY_NAME COUNTRY FROM (
  -- 查詢每個PERSON在每個國家，於每個國家計算平均通話時間，全球平均通話時間
  SELECT DISTINCT P.COUNTRY_NAME,
    AVG(C.DURATION) OVER (PARTITION BY P.COUNTRY_CODE) COUNTRY_AVG,
    AVG(C.DURATION) OVER() AS GLOBAL_AVG
  FROM CALL_TIME C JOIN PERSON_COUNTRY P
  ON C.CALL_ID = P.ID
) WHERE COUNTRY_AVG > GLOBAL_AVG;

-- MySQL
WITH T1 AS(
  SELECT CALLER_ID AS ID, DURATION AS TOTAL
  FROM (
    SELECT CALLER_ID, DURATION
    FROM CALLS
    UNION ALL
    SELECT CALLEE_ID, DURATION
    FROM CALLS
  ) A
)
SELECT NAME AS COUNTRY 
FROM (
  SELECT DISTINCT AVG(TOTAL) OVER(PARTITION BY CODE) AS AVG_CALL, AVG(TOTAL) OVER() AS GLOBAL_AVG, C.NAME
  FROM (
    (
      SELECT *, COALESCE(TOTAL,0) AS DURATION, SUBSTRING(PHONE_NUMBER FROM 1 FOR 3) AS CODE
      FROM PERSON RIGHT JOIN T1
      USING (ID)
    ) B JOIN COUNTRY C    
    ON C.COUNTRY_CODE = B.CODE
  )
) D
WHERE AVG_CALL > GLOBAL_AVG;
