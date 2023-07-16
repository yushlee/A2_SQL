/*

Looker Studio報表URL
https://lookerstudio.google.com/u/1/navigation/reporting

GCP付費
https://console.cloud.google.com/billing

*/

-- DELETE FROM momo-search.store.STORE_INFORMATION;
-- DELETE FROM momo-search.store.GEOGRAPHY;

INSERT INTO momo-search.store.GEOGRAPHY (GEOGRAPHY_ID,REGION_NAME) VALUES (1,'East');
INSERT INTO momo-search.store.GEOGRAPHY (GEOGRAPHY_ID,REGION_NAME) VALUES (2,'West');
INSERT INTO momo-search.store.GEOGRAPHY (GEOGRAPHY_ID,REGION_NAME) VALUES (3,'North');

INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (1,'Boston',2200,'2018-03-09 00:00:00',1);
INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (2,'Los Angeles',1400,'2018-04-05 00:00:00',2);
INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (3,'San Diego',250,'2018-01-07 00:00:00',2);
INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (4,'Los Angeles',300,'2018-02-07 00:00:00',2);
INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (5,'Albany, Crossgates',2500,'2018-05-15 00:00:00',2);
INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (6,'Buffalo, Walden Galleria',3000,'2018-06-10 00:00:00',NULL);
INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (7,'San Diego',500,'2018-02-15 00:00:00',2);
INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (8,'Los Angeles',1600,'2018-02-07 00:00:00',2);
INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (9,'Boston',1500,'2018-03-09 00:00:00',1);
INSERT INTO momo-search.store.STORE_INFORMATION (STORE_ID,STORE_NAME,SALES,STORE_DATE,GEOGRAPHY_ID) VALUES (10,'Apple Inc',2600,'2023-03-09 00:00:00',3);

SELECT G.REGION_NAME, IFNULL(SUM(S.SALES), 0) SUM_SALES
FROM momo-search.store.GEOGRAPHY G 
LEFT JOIN momo-search.store.STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY SUM(S.SALES) DESC;