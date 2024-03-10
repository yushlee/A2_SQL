SELECT S.*, G.* 
FROM store_information S, geography G 
WHERE S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- 內部連接
-- INNER JOIN...ON
SELECT S.*, G.* 
FROM store_information S INNER JOIN geography G 
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;


SELECT G.*, S.*  
FROM geography G  LEFT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

SELECT G.*, S.*  
FROM geography G  RIGHT OUTER JOIN store_information S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- MySQL 不支援FULL OUTER JOIN
-- SELECT G.*, S.*  
-- FROM geography G  FULL OUTER JOIN store_information S 
-- ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- cross join
SELECT S.*, G.* 
FROM store_information S, geography G;