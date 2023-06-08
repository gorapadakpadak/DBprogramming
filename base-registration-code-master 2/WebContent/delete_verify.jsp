<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="java.io.UnsupportedEncodingException" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 삭제</title>
</head>
<body>
<%
    String s_id = (String)session.getAttribute("user");
    String c_id = request.getParameter("c_id");
    String c_id_no = request.getParameter("c_id_no");
    
    Connection myConn = null;
    Statement stmt = null;
    
    String mySQL = null;
    String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
    String user = "c##jaeeun";
    String passwd = "jaeeun";    // Oracle password 
    String dbdriver = "oracle.jdbc.driver.OracleDriver";
    try {
        Class.forName(dbdriver);
        myConn = DriverManager.getConnection(dburl, user, passwd);
        stmt = myConn.createStatement();
        
        // 로그인 한 사용자의 s_major 조회
        PreparedStatement majorStmt = myConn.prepareStatement("SELECT s_major FROM students WHERE s_id = ?");
        majorStmt.setString(1, s_id);
        ResultSet majorRs = majorStmt.executeQuery();
        
        String majorflag = ""; // majorflag 변수 선언
        if (majorRs.next()) {
          String s_major = majorRs.getString("s_major");
          // s_major에 따라 majorflag 설정
          if (s_major.equals("컴퓨터과학전공")) {
            majorflag = "C";
          } else if (s_major.equals("응용물리전공")) {
            majorflag = "P";
          } else if (s_major.equals("소프트웨어융합전공")) {
            majorflag = "S";
          }
        }
        majorRs.close();
        majorStmt.close();
        
     // enroll 테이블에서 c_id와 c_id_no 조회
        mySQL = "SELECT * FROM enroll WHERE s_id=? AND c_id=?";
        PreparedStatement pstmt0 = myConn.prepareStatement(mySQL);
        pstmt0.setString(1, s_id);
        pstmt0.setString(2, c_id);
        ResultSet enrollRs = pstmt0.executeQuery();
        if (enrollRs.next()) {
            // enroll 테이블에서 c_id와 c_id_no 값을 임시 변수에 저장
            String enrolledCid = enrollRs.getString("c_id");
            String enrolledCidNo = enrollRs.getString("c_id_no");
        
        pstmt0.close();

        mySQL = "delete from enroll where s_id=? and c_id=?";
        PreparedStatement pstmt = myConn.prepareStatement(mySQL);
        pstmt.setString(1, s_id);
        pstmt.setString(2, c_id);
        
        int res = pstmt.executeUpdate();
        if (res == 1) {
			// 수강 취소로 인한 여석 발생했는지 검사 => 여석 발생 시 email 보내주기.
            // spare table에 해당 c_id, c_id_no를 가진 s_id 있는지 검사
            mySQL = "select s_email from students where s_id=(select s_id from spare where c_id=? and c_id_no=?)";
            pstmt = myConn.prepareStatement(mySQL);
            pstmt.setString(1, c_id);
            pstmt.setString(2, c_id_no);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) { // 있으면
                String s_email = rs.getString("s_email");
                
                // 이메일 전송을 위한 SMTP 서버 정보 설정
                String host = "smtp.gmail.com";
                String port = "587"; // naver port
                final String senderEmail = "pjcson8@sookmyung.ac.kr";
                final String senderPassword = "#";
                
                // 이메일 수신자 정보
                String recipientEmail = s_email; // 받아온 정보로 수정
                
                // 이메일 내용
                String subject = "수강신청 여석 알림";
                String body = c_id+"/"+c_id_no+"분반 수강신청 여석이 발생했습니다.";
                
                // SMTP 서버 설정
                Properties props = new Properties();
                props.put("mail.smtp.host", host);
                props.put("mail.smtp.port", port);
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.ssl.trust", host);
                props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
                
                // SMTP 인증 정보
                Authenticator auth = new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(senderEmail, senderPassword);
                    }
                };
                
                // 이메일 전송
                try {
                    // 메일 세션 생성
                    Session mailsession = Session.getInstance(props, auth);
                    MimeMessage message = new MimeMessage(mailsession);
                    // 발신자 설정
                    message.setFrom(new InternetAddress(senderEmail));
                    // 수신자 설정
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
                    // 제목 설정
                    message.setSubject(subject);
                    // 내용 설정
                    message.setText(body);
                    // 이메일 전송
                    Transport.send(message);
                    out.println("이메일 알림이 성공적으로 전송되었습니다.");   
                } catch (Exception e) {
                    out.println("이메일 알림 전송 중 오류가 발생했습니다: " + e.getMessage());
                }
             	// spare table에서 여석 신청 정보 삭제
                mySQL = "delete from spare where c_id=? and c_id_no=?";
                pstmt = myConn.prepareStatement(mySQL);
                pstmt.setString(1, c_id);
                pstmt.setString(2, c_id_no);
                res = pstmt.executeUpdate();
            } 
            rs.close();
            %>
            <script>
            	alert('수강 취소되었습니다.');
            	location.href='delete.jsp';
            </script>
            <%
        	
        	//연지추가 - 누적학점 subtract부분
        	// course 테이블에서 학점 조회
            PreparedStatement ps = myConn.prepareStatement("SELECT c_unit FROM course WHERE c_id = ? AND c_id_no = ?");
            ps.setString(1, enrolledCid);
            ps.setString(2, enrolledCidNo);
            ResultSet courseRs = ps.executeQuery();

            if (courseRs.next()) {
                int nCourseUnit = courseRs.getInt("c_unit");

                // 학생의 현재 sum_credit, sum_major 값을 조회
                PreparedStatement ps2 = myConn.prepareStatement("SELECT sum_credit, sum_major FROM students WHERE s_id = ?");
                ps2.setString(1, s_id);
                ResultSet studentRs = ps2.executeQuery();

                if (studentRs.next()) {
                    int nSumCredit = studentRs.getInt("sum_credit");
                    int nSumMajor = studentRs.getInt("sum_major");

                    // 취소한 학점을 현재 sum_credit에서 빼기
                    nSumCredit -= nCourseUnit;

                    // sum_credit 값을 갱신
                    PreparedStatement ps3 = myConn.prepareStatement("UPDATE students SET sum_credit = ? WHERE s_id = ?");
                    ps3.setInt(1, nSumCredit);
                    ps3.setString(2, s_id);
                    ps3.executeUpdate();

                    // 조회한 c_id의 첫 글자와 s_major가 일치하는 경우 sum_major 값도 갱신
                    if (enrolledCid.substring(0, 1).equals(majorflag)) {
                        nSumMajor -= nCourseUnit;
                        PreparedStatement ps4 = myConn.prepareStatement("UPDATE students SET sum_major = ? WHERE s_id = ?");
                        ps4.setInt(1, nSumMajor);
                        ps4.setString(2, s_id);
                        ps4.executeUpdate();
                        ps4.close();
                    }
                }

                studentRs.close();
                ps2.close();
            }

            courseRs.close();
            ps.close();
        }
        enrollRs.close();
        
        pstmt.close();
        stmt.close();
        myConn.close();
        }
        %>
        <script>
        	alert('수강 취소되었습니다.');
        	location.href='delete.jsp';
        </script>
        <%
        
        
    } catch (SQLException e) {
        System.err.println("SQLException: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        System.err.println("ClassNotFoundException: " + e.getMessage());
    }
%>
</body>
</html>