SELECT STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID FROM store_information;

-- 將兩張資料表連接在一起,透過WHERE子句欄位做關聯查詢
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.STORE_DATE, S.GEOGRAPHY_ID
FROM GEOGRAPHY G, STORE_INFORMATION S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


