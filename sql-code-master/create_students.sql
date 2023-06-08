CREATE TABLE STUDENTS(
	s_id VARCHAR2(10),
	s_pwd VARCHAR2(30),
	s_name VARCHAR2(20),
	s_major VARCHAR2(30),
	s_adress VARCHAR2(200),
	s_email VARCHAR2(100), --수강 여석 신청
	sum_credit number, --졸업학점 알림
	sum_major number, --졸업학점 알림
	CONSTRAINT students_pk PRIMARY KEY(s_id),
	CONSTRAINT students_fk FOREIGN KEY(s_major) REFERENCES major(s_major) ON DELETE CASCADE --졸업학점 알림
);

INSERT INTO STUDENTS VALUES ('2010799', 'abcde', '박재은', '컴퓨터과학전공', '서울시 강남구 XX대로 XXX-XXXX', 'pjcson8@naver.com', 0, 0);
INSERT INTO STUDENTS VALUES ('2110798', 'abcdef', '박재원', '소프트웨어융합전공', '서울시 송파구 XX대로 XXX-XXXX', 'pjcson8@sookmyung.ac.kr', 0, 0);
INSERT INTO STUDENTS VALUES ('1913100', 'abcde', '류현진', '응용물리전공', '서울시 용산구 XX대로 XXX-XXXX', 'conoria@naver.com', 0, 0);
