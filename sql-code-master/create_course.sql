CREATE TABLE course(
	c_id varchar2(20),
	c_id_no varchar2(10),
	c_name varchar2(40),
	c_unit NUMBER(10),
	CONSTRAINT course_pk PRIMARY KEY (c_id, c_id_no),
CONSTRAINT course_ck CHECK(c_unit>=0)
);
INSERT INTO COURSE VALUES ('C001', '01', '데이터베이스프로그래밍',3);
INSERT INTO COURSE VALUES ('C001', '02', '데이터베이스프로그래밍', 3);
INSERT INTO COURSE VALUES ('C002', '01', '소프트웨어의이해', 3);
INSERT INTO COURSE VALUES ('C003', '01', '운영체제', 3);
INSERT INTO COURSE VALUES ('C003', '02', '운영체제', 3);
INSERT INTO COURSE VALUES ('C004', '01', '자료구조', 3);
INSERT INTO COURSE VALUES ('C004', '02', '자료구조', 3);
INSERT INTO COURSE VALUES ('C005', '01', '컴파일러', 3);

INSERT INTO COURSE VALUES ('P002', '01', '기초물리학', 3);
INSERT INTO COURSE VALUES ('P003', '01', '일반물리실험', 3);
INSERT INTO COURSE VALUES ('P003', '02', '첨단소재및소자', 3);
INSERT INTO COURSE VALUES ('P004', '01', '반도체소자', 3);

INSERT INTO COURSE VALUES ('S001', '01', '경영정보시스템', 3);
INSERT INTO COURSE VALUES ('S001', '02', '경영정보시스템', 3);
INSERT INTO COURSE VALUES ('S001', '01', '데이터통계입문', 3);
INSERT INTO COURSE VALUES ('S002', '01', '데이터사이언스개론', 3);
INSERT INTO COURSE VALUES ('S002', '02', '데이터사이언스개론', 3);
INSERT INTO COURSE VALUES ('S003', '01', '인터넷기술융합', 3);
