--이미 여석 신청된 정보가 있으면 여석 신청 안된다는 알림 띄우기
--여석 신청 가능하다면 spare table 업데이트(받아온 s_id, s_id, s_id_no 넣기)

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
	DBMS_OUTPUT.PUT_LINE(sStudentId||'님이 과목번호 '||sCourseId||', 분반'||TO_CHAR(nCourseIdNo)||'의 여석알림 서비스 등록을 요청하였습니다.');

	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);
	
	/*에러 처리1 : 이미 여석 신청을 요청한 경우*/
	SELECT COUNT(*)
	INTO nCnt
	FROM Spare
	WHERE s_id=sStudentId and c_id = sCourseId and c_id_no = nCourseIdNo;
	
	IF (nCnt > 0) 
	THEN
		RAISE already_enroll_spare_check;
	END IF;
	
	/*에러 처리2 : 아직 수강신청이 가능하다면(여석이 남아있다면) 여석 신청하지 못하도록*/
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
	
	/*여석 알림 서비스 등록*/
	INSERT INTO spare(c_id, c_id_no, s_id, e_year, e_semester) VALUES (sCourseId, nCourseIdNo, sStudentId, nYear, nSemester);

	COMMIT;
	result := '여석 알림 신청이 완료되었습니다.';
	
	EXCEPTION
  		WHEN already_enroll_spare_check THEN    
			result := '이미 해당 수업에 대한 여석 알림이 신청되어 있습니다.';
		WHEN still_have_spare_seat THEN    
			result := '이미 해당 수업은 여석이 존재합니다.';
		WHEN OTHERS THEN
        	ROLLBACK;
        	result := SQLCODE;	
END;
/