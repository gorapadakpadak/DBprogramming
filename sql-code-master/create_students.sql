CREATE TABLE STUDENTS(
	s_id VARCHAR2(10),
	s_pwd VARCHAR2(30),
	s_name VARCHAR2(20),
	s_major VARCHAR2(30),
	s_adress VARCHAR2(200),
	s_email VARCHAR2(100), --���� ���� ��û
	sum_credit number, --�������� �˸�
	sum_major number, --�������� �˸�
	CONSTRAINT students_pk PRIMARY KEY(s_id),
	CONSTRAINT students_fk FOREIGN KEY(s_major) REFERENCES major(s_major) ON DELETE CASCADE --�������� �˸�
);

INSERT INTO STUDENTS VALUES ('2010799', 'abcde', '������', '��ǻ�Ͱ�������', '����� ������ XX��� XXX-XXXX', 'pjcson8@naver.com', 0, 0);
INSERT INTO STUDENTS VALUES ('2110798', 'abcdef', '�����', '����Ʈ������������', '����� ���ı� XX��� XXX-XXXX', 'pjcson8@sookmyung.ac.kr', 0, 0);
INSERT INTO STUDENTS VALUES ('1913100', 'abcde', '������', '���빰������', '����� ��걸 XX��� XXX-XXXX', 'conoria@naver.com', 0, 0);
