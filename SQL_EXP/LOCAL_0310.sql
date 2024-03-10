SELECT S.*, G.* 
FROM store_information S, geography G 
WHERE S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

SELECT S.*, G.* 
FROM store_information S JOIN geography G 
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

-- cross join
SELECT S.*, G.* 
FROM store_information S, geography G;