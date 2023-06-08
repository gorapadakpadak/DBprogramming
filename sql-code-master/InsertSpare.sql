--�̹� ���� ��û�� ������ ������ ���� ��û �ȵȴٴ� �˸� ����
--���� ��û �����ϴٸ� spare table ������Ʈ(�޾ƿ� s_id, s_id, s_id_no �ֱ�)

CREATE OR REPLACE PROCEDURE InsertSpare
(sStudentId IN VARCHAR2, 
sCourseId IN  VARCHAR2,
nCourseIdNo IN VARCHAR2,
result OUT VARCHAR2)
IS
already_enroll_spare_check EXCEPTION;
still_have_spare_seat EXCEPTION;
nCnt NUMBER;
nYear VARCHAR2(10);
nSemester VARCHAR2(10);
nTeachMax NUMBER;
BEGIN
	result := '';
	DBMS_OUTPUT.PUT_LINE('#');
	DBMS_OUTPUT.PUT_LINE(sStudentId||'���� �����ȣ '||sCourseId||', �й�'||TO_CHAR(nCourseIdNo)||'�� �����˸� ���� ����� ��û�Ͽ����ϴ�.');

	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);
	
	/*���� ó��1 : �̹� ���� ��û�� ��û�� ���*/
	SELECT COUNT(*)
	INTO nCnt
	FROM Spare
	WHERE s_id=sStudentId and c_id = sCourseId and c_id_no = nCourseIdNo;
	
	IF (nCnt > 0) 
	THEN
		RAISE already_enroll_spare_check;
	END IF;
	
	/*���� ó��2 : ���� ������û�� �����ϴٸ�(������ �����ִٸ�) ���� ��û���� ���ϵ���*/
	SELECT tmax
	INTO nTeachMax
	FROM teach
	WHERE t_year = nYear and t_semester = nSemester
	and c_id = sCourseId and c_id_no = nCourseIdNo;
	
	SELECT COUNT(*)
	INTO nCnt
	FROM enroll
	WHERE e_year = nYear and e_semester = nSemester
	and c_id = sCourseId and c_id_no = nCourseIdNo;
	
	IF (nCnt<nTeachMax)
	THEN
		RAISE still_have_spare_seat;
	END IF;
	
	/*���� �˸� ���� ���*/
	INSERT INTO spare(c_id, c_id_no, s_id, e_year, e_semester) VALUES (sCourseId, nCourseIdNo, sStudentId, nYear, nSemester);

	COMMIT;
	result := '���� �˸� ��û�� �Ϸ�Ǿ����ϴ�.';
	
	EXCEPTION
  		WHEN already_enroll_spare_check THEN    
			result := '�̹� �ش� ������ ���� ���� �˸��� ��û�Ǿ� �ֽ��ϴ�.';
		WHEN still_have_spare_seat THEN    
			result := '�̹� �ش� ������ ������ �����մϴ�.';
		WHEN OTHERS THEN
        	ROLLBACK;
        	result := SQLCODE;	
END;
/