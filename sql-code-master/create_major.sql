CREATE TABLE major(
    s_major VARCHAR2(50),
    total_credit number,
    total_major_credit number,
    CONSTRAINT major_pk PRIMARY KEY(s_major)
);
INSERT INTO major VALUES ('컴퓨터과학전공', 130, 60);
INSERT INTO major VALUES ('응용물리전공', 130, 74);
INSERT INTO major VALUES ('소프트웨어융합전공', 130, 72);