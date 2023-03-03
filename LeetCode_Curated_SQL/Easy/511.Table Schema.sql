DROP TABLE ACTIVITY;

CREATE TABLE ACTIVITY 
(
  PLAYER_ID INT NOT NULL 
, DEVICE_ID INT 
, EVENT_DATE DATE NOT NULL 
, GAMES_PLAYED INT 
, CONSTRAINT ACTIVITY_PK PRIMARY KEY (PLAYER_ID , EVENT_DATE)
);

INSERT INTO ACTIVITY VALUES (1, 2, '2016-03-01', 5);
INSERT INTO ACTIVITY VALUES (1, 2, '2016-05-02', 6);
INSERT INTO ACTIVITY VALUES (2, 3, '2017-06-25', 1);
INSERT INTO ACTIVITY VALUES (3, 1, '2016-03-02', 0);
INSERT INTO ACTIVITY VALUES (3, 4, '2018-07-03', 5);
COMMIT;