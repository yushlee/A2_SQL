-- SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY 
SELECT STORE_NAME, SUM(SALES)
FROM store_information
WHERE GEOGRAPHY_ID = 2
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 200
ORDER BY SUM(SALES) ASC;
