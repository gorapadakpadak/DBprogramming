CREATE TABLE professor (
p_id varchar2(20),
p_name varchar2(10),
p_major varchar2(30),
CONSTRAINT professor_pk PRIMARY KEY(p_id)
);
INSERT INTO PROFESSOR VALUES ('201', '이현자', '컴퓨터과학전공');
INSERT INTO PROFESSOR VALUES ('202', '김주균', '컴퓨터과학전공');
INSERT INTO PROFESSOR VALUES ('203', '유석종', '컴퓨터과학전공');
INSERT INTO PROFESSOR VALUES ('204', '문봉희', '컴퓨터과학전공');
INSERT INTO PROFESSOR VALUES ('205', '박영훈', '컴퓨터과학전공');

INSERT INTO PROFESSOR VALUES ('206', '정홍', '응용물리전공');
INSERT INTO PROFESSOR VALUES ('207', '김재성', '응용물리전공');
INSERT INTO PROFESSOR VALUES ('208', '주민규', '응용물리전공');
INSERT INTO PROFESSOR VALUES ('209', '고창현', '응용물리전공');

INSERT INTO PROFESSOR VALUES ('210', '서보밀', '소프트웨어융합전공');
INSERT INTO PROFESSOR VALUES ('211', '정영주', '소프트웨어융합전공');
INSERT INTO PROFESSOR VALUES ('212', '이기용', '소프트웨어융합전공');
INSERT INTO PROFESSOR VALUES ('213', '최영우', '소프트웨어융합전공');
INSERT INTO PROFESSOR VALUES ('214', '최종원', '소프트웨어융합전공');