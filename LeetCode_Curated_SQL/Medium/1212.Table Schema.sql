DROP TABLE TEAMS;
CREATE TABLE TEAMS(
 TEAM_ID INT,
 TEAM_NAME VARCHAR(30),
 PRIMARY KEY (TEAM_ID)
); 
DROP TABLE MATCHES;
CREATE TABLE MATCHES(
 MATCH_ID INT,
 HOST_TEAM INT,
 GUEST_TEAM INT,
 HOST_GOALS INT,
 GUEST_GOALS INT,
 PRIMARY KEY (MATCH_ID)
);
INSERT INTO TEAMS VALUES (10, 'Leetcode FC');
INSERT INTO TEAMS VALUES (20, 'NewYork FC');
INSERT INTO TEAMS VALUES (30, 'Atlanta FC');
INSERT INTO TEAMS VALUES (40, 'Chicago FC');
INSERT INTO TEAMS VALUES (50, 'Toronto FC');
INSERT INTO MATCHES VALUES (1, 10, 20, 3, 0);
INSERT INTO MATCHES VALUES (2, 30, 10, 2, 2);
INSERT INTO MATCHES VALUES (3, 10, 50, 5, 1);
INSERT INTO MATCHES VALUES (4, 20, 30, 1, 0);
INSERT INTO MATCHES VALUES (5, 50, 30, 1, 0);
COMMIT;