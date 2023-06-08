CREATE TABLE course(
	c_id varchar2(20),
	c_id_no varchar2(10),
	c_name varchar2(40),
	c_unit NUMBER(10),
	CONSTRAINT course_pk PRIMARY KEY (c_id, c_id_no),
CONSTRAINT course_ck CHECK(c_unit>=0)
);
INSERT INTO COURSE VALUES ('C001', '01', '�����ͺ��̽����α׷���',3);
INSERT INTO COURSE VALUES ('C001', '02', '�����ͺ��̽����α׷���', 3);
INSERT INTO COURSE VALUES ('C002', '01', '����Ʈ����������', 3);
INSERT INTO COURSE VALUES ('C003', '01', '�ü��', 3);
INSERT INTO COURSE VALUES ('C003', '02', '�ü��', 3);
INSERT INTO COURSE VALUES ('C004', '01', '�ڷᱸ��', 3);
INSERT INTO COURSE VALUES ('C004', '02', '�ڷᱸ��', 3);
INSERT INTO COURSE VALUES ('C005', '01', '�����Ϸ�', 3);

INSERT INTO COURSE VALUES ('P002', '01', '���ʹ�����', 3);
INSERT INTO COURSE VALUES ('P003', '01', '�Ϲݹ�������', 3);
INSERT INTO COURSE VALUES ('P003', '02', '÷�ܼ���׼���', 3);
INSERT INTO COURSE VALUES ('P004', '01', '�ݵ�ü����', 3);

INSERT INTO COURSE VALUES ('S001', '01', '�濵�����ý���', 3);
INSERT INTO COURSE VALUES ('S001', '02', '�濵�����ý���', 3);
INSERT INTO COURSE VALUES ('S001', '01', '����������Թ�', 3);
INSERT INTO COURSE VALUES ('S002', '01', '�����ͻ��̾𽺰���', 3);
INSERT INTO COURSE VALUES ('S002', '02', '�����ͻ��̾𽺰���', 3);
INSERT INTO COURSE VALUES ('S003', '01', '���ͳݱ������', 3);
