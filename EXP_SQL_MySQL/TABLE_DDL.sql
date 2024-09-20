DROP TABLE STORE_INFORMATION;
DROP TABLE GEOGRAPHY;


CREATE TABLE GEOGRAPHY (  
	GEOGRAPHY_ID NUMERIC (10,0) PRIMARY KEY,
	REGION_NAME  VARCHAR(255)
);

CREATE TABLE STORE_INFORMATION(
	STORE_ID   NUMERIC (10,0) PRIMARY KEY,
	STORE_NAME VARCHAR(255),
	SALES      NUMERIC (10,0) CHECK (SALES > 0),
	STORE_DATE datetime,
-- 	GEOGRAPHY_ID NUMERIC(10,0) REFERENCES GEOGRAPHY(GEOGRAPHY_ID)
 	GEOGRAPHY_ID NUMERIC (10,0),
 	CONSTRAINT CONSTRAINT_GEOGRAPHY_ID FOREIGN KEY (GEOGRAPHY_ID) REFERENCES GEOGRAPHY (GEOGRAPHY_ID),
	OPEN_STATUS CHAR(1)
);