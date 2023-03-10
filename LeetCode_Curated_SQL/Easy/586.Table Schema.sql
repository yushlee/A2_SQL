DROP TABLE ORDERS;

CREATE TABLE ORDERS
(
  ORDER_NUMBER INT NOT NULL 
, CUSTOMER_NUMBER INT 
, ORDER_DATE DATE 
, REQUIRED_DATE DATE 
, SHIPPED_DATE DATE 
, STATUS CHAR(15) 
, CONSTRAINT TABLE1_PK PRIMARY KEY (ORDER_NUMBER)
);

INSERT INTO ORDERS (ORDER_NUMBER,CUSTOMER_NUMBER,ORDER_DATE,REQUIRED_DATE,SHIPPED_DATE,STATUS) VALUES (1,1,'2017-04-09','2017-04-13','2017-04-12','Closed');
INSERT INTO ORDERS (ORDER_NUMBER,CUSTOMER_NUMBER,ORDER_DATE,REQUIRED_DATE,SHIPPED_DATE,STATUS) VALUES (2,2,'2017-04-15','2017-04-20','2017-04-18','Closed');
INSERT INTO ORDERS (ORDER_NUMBER,CUSTOMER_NUMBER,ORDER_DATE,REQUIRED_DATE,SHIPPED_DATE,STATUS) VALUES (3,3,'2017-04-16','2017-04-25','2017-04-20','Closed');
INSERT INTO ORDERS (ORDER_NUMBER,CUSTOMER_NUMBER,ORDER_DATE,REQUIRED_DATE,SHIPPED_DATE,STATUS) VALUES (4,3,'2017-04-18','2017-04-28','2017-04-25','Closed');

COMMIT;