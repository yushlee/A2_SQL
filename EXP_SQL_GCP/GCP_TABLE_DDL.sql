/*

GCP BigQuery
https://console.cloud.google.com/bigquery

*/
CREATE TABLE momo-search.store.GEOGRAPHY (
	GEOGRAPHY_ID NUMERIC,
	REGION_NAME  STRING
);

CREATE TABLE momo-search.store.STORE_INFORMATION(
	STORE_ID   NUMERIC,
	STORE_NAME STRING,
	SALES      NUMERIC,
	STORE_DATE date,
 	GEOGRAPHY_ID NUMERIC
);