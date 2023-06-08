CREATE OR REPLACE TRIGGER BeforeUpdateStudent
BEFORE
UPDATE ON students
FOR EACH ROW

DECLARE
	underflow_length EXCEPTION;
	invalid_value EXCEPTION;
	pattern_do_not_match EXCEPTION;
	nLength NUMBER;
	nBlank NUMBER;
	nCnt NUMBER;

BEGIN
	SELECT LENGTH(:new.s_pwd)
	INTO nLength
	FROM dual;
	
	SELECT  INSTR(:new.s_pwd, ' ', 1, 1)
	INTO nBlank
	FROM dual;
	
	IF (nLength < 4) THEN
		RAISE underflow_length;
	ELSIF (nBlank != 0) THEN
		RAISE invalid_value;
	END IF;
	
	/*�߰���� - �̸��� ���� üũ*/
	SELECT COUNT(*) 
	INTO nCnt
	FROM dual
	WHERE :new.s_email LIKE '%@%.%';
	
	IF(nCnt < 1) THEN
		RAISE pattern_do_not_match;
	END IF;
	
EXCEPTION
	WHEN underflow_length THEN
		RAISE_APPLICATION_ERROR(-20002, '��ȣ�� 4�ڸ� �̻��̾�� �մϴ�');
	WHEN invalid_value THEN
		RAISE_APPLICATION_ERROR(-20003, '��ȣ�� ������ �Էµ��� �ʽ��ϴ�');
	WHEN pattern_do_not_match THEN
		RAISE_APPLICATION_ERROR(-20004, '�̸��Ͽ� ��߳��� ���� �����Դϴ�.');
END;
/
