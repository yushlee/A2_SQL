DROP TABLE Failed;
CREATE TABLE Failed(
 fail_date DATE,
 PRIMARY KEY (fail_date)
);
DROP TABLE Succeeded;
CREATE TABLE Succeeded(
 success_date DATE,
 PRIMARY KEY (success_date)
);
INSERT INTO FAILED VALUES ('2018-12-28');
INSERT INTO FAILED VALUES ('2018-12-29');
INSERT INTO FAILED VALUES ('2019-01-04');
INSERT INTO FAILED VALUES ('2019-01-05');
INSERT INTO SUCCEEDED VALUES ('2018-12-30');
INSERT INTO SUCCEEDED VALUES ('2018-12-31');
INSERT INTO SUCCEEDED VALUES ('2019-01-01');
INSERT INTO SUCCEEDED VALUES ('2019-01-02');
INSERT INTO SUCCEEDED VALUES ('2019-01-03');
INSERT INTO SUCCEEDED VALUES ('2019-01-06');
COMMIT;