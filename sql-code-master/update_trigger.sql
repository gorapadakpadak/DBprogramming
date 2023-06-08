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
	
	/*추가기능 - 이메일 변경 체크*/
	SELECT COUNT(*) 
	INTO nCnt
	FROM dual
	WHERE :new.s_email LIKE '%@%.%';
	
	IF(nCnt < 1) THEN
		RAISE pattern_do_not_match;
	END IF;
	
EXCEPTION
	WHEN underflow_length THEN
		RAISE_APPLICATION_ERROR(-20002, '암호는 4자리 이상이어야 합니다');
	WHEN invalid_value THEN
		RAISE_APPLICATION_ERROR(-20003, '암호에 공란은 입력되지 않습니다');
	WHEN pattern_do_not_match THEN
		RAISE_APPLICATION_ERROR(-20004, '이메일에 어긋나는 문자 형식입니다.');
END;
/
