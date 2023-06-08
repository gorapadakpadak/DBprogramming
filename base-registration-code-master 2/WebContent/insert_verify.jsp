<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������û �Է�</title>
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
    
    // �α��� �� ������� s_major ��ȸ
    PreparedStatement majorStmt = myConn.prepareStatement("SELECT s_major FROM students WHERE s_id = ?");
    majorStmt.setString(1, s_id);
    ResultSet majorRs = majorStmt.executeQuery();
    
    String majorflag = ""; // majorflag ���� ����
    
    if (majorRs.next()) {
      String s_major = majorRs.getString("s_major");
      
      // s_major�� ���� majorflag ����
      if (s_major.equals("��ǻ�Ͱ�������")) {
        majorflag = "C";
      } else if (s_major.equals("���빰������")) {
        majorflag = "P";
      } else if (s_major.equals("����Ʈ������������")) {
        majorflag = "S";
      }
      
      cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?,?)}");
      cstmt.setString(1, s_id);
      cstmt.setString(2, c_id);
      cstmt.setString(3, c_id_no);
      cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
      
      cstmt.execute();
      result = cstmt.getString(4);
      
      // ���� ó�� �߰�
      if (result.equals("������û ����� �Ϸ�Ǿ����ϴ�.")) {
        // ������ ������ ���� ��ȸ
        PreparedStatement ps = myConn.prepareStatement("SELECT c_unit FROM course WHERE c_id = ? AND c_id_no = ?");
        ps.setString(1, c_id);
        ps.setString(2, c_id_no);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
          int nCourseUnit = rs.getInt("c_unit");
          
          // �л��� ���� sum_credit, sum_major���� ��ȸ
          PreparedStatement ps2 = myConn.prepareStatement("SELECT sum_credit, sum_major FROM students WHERE s_id = ?");
          ps2.setString(1, s_id);
          ResultSet rs2 = ps2.executeQuery();
          
          if (rs2.next()) {
            int nSumCredit = rs2.getInt("sum_credit");
            int nSumMajor = rs2.getInt("sum_major");
            
            // ������ ������ ������ ���� sum_credit�� ����
            nSumCredit += nCourseUnit;
            
            // sum_credit ���� ����
            PreparedStatement ps3 = myConn.prepareStatement("UPDATE students SET sum_credit = ? WHERE s_id = ?");
            ps3.setInt(1, nSumCredit);
            ps3.setString(2, s_id);
            ps3.executeUpdate();
            
            // ��ȸ�� c_id�� ù ���ڿ� s_major�� ��ġ�ϴ� ��� sum_major ���� ����
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
        // ó�� �ڵ�
      }
    }
  }
%>
</body>
</html>