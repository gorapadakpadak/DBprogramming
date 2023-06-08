<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 입력</title>
</head>
<body>
<%
  String s_id = (String) session.getAttribute("user");
  String c_id = request.getParameter("c_id");
  String c_id_no = request.getParameter("c_id_no");
  String result = null;
  
  Connection myConn = null;
  CallableStatement cstmt = null;
  
  String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
  String user = "c##jaeeun";
  String passwd = "jaeeun";    // Oracle password 
  String dbdriver = "oracle.jdbc.driver.OracleDriver";
  
  try {
    Class.forName(dbdriver);
    myConn = DriverManager.getConnection(dburl, user, passwd);
    
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
      
      cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?,?)}");
      cstmt.setString(1, s_id);
      cstmt.setString(2, c_id);
      cstmt.setString(3, c_id_no);
      cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
      
      cstmt.execute();
      result = cstmt.getString(4);
      
      // 학점 처리 추가
      if (result.equals("수강신청 등록이 완료되었습니다.")) {
        // 수강한 과목의 학점 조회
        PreparedStatement ps = myConn.prepareStatement("SELECT c_unit FROM course WHERE c_id = ? AND c_id_no = ?");
        ps.setString(1, c_id);
        ps.setString(2, c_id_no);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
          int nCourseUnit = rs.getInt("c_unit");
          
          // 학생의 현재 sum_credit, sum_major값을 조회
          PreparedStatement ps2 = myConn.prepareStatement("SELECT sum_credit, sum_major FROM students WHERE s_id = ?");
          ps2.setString(1, s_id);
          ResultSet rs2 = ps2.executeQuery();
          
          if (rs2.next()) {
            int nSumCredit = rs2.getInt("sum_credit");
            int nSumMajor = rs2.getInt("sum_major");
            
            // 수강한 과목의 학점을 현재 sum_credit에 더함
            nSumCredit += nCourseUnit;
            
            // sum_credit 값을 갱신
            PreparedStatement ps3 = myConn.prepareStatement("UPDATE students SET sum_credit = ? WHERE s_id = ?");
            ps3.setInt(1, nSumCredit);
            ps3.setString(2, s_id);
            ps3.executeUpdate();
            
            // 조회한 c_id의 첫 글자와 s_major가 일치하는 경우 sum_major 값도 갱신
            if (c_id.substring(0, 1).equals(majorflag)) {
              nSumMajor += nCourseUnit;
              PreparedStatement ps4 = myConn.prepareStatement("UPDATE students SET sum_major = ? WHERE s_id = ?");
              ps4.setInt(1, nSumMajor);
              ps4.setString(2, s_id);
              ps4.executeUpdate();
              ps4.close();
            }
          }
          
          rs2.close();
          ps2.close();
        }
        
        rs.close();
        ps.close();
      }
    }
    
    majorRs.close();
    majorStmt.close();
    
    %>
    <script>
      alert("<%= result%>");
      location.href = "insert.jsp";
    </script>
    <%
  } catch (SQLException ex) {
    System.err.println("SQLException: " + ex.getMessage());
  } finally {
    if (cstmt != null) {
      try {
        myConn.commit();
        cstmt.close();
        myConn.close();
      } catch (SQLException ex) {
        // 처리 코드
      }
    }
  }
%>
</body>
</html>