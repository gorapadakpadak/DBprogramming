<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 입력</title>
</head>
<body>
<%	String s_id = (String)session.getAttribute("user");
	String c_id = request.getParameter("c_id");
	String c_id_no = request.getParameter("c_id_no");%>
<%	Connection myConn = null;
	String result = null;
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "c##jaeeun"; 
	String passwd = "jaeeun";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user,passwd);
	}catch(SQLException ex){
		System.err.println("SQLException: " + ex.getMessage());
	}
	
	
	//InsertSpare 이라는 함수 만들어서 수행.
	CallableStatement cstmt = myConn.prepareCall("{call InsertSpare(?,?,?,?)}");
	cstmt.setString(1, s_id);
	cstmt.setString(2, c_id);
	cstmt.setString(3, c_id_no);
	cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
	try{
		cstmt.execute();
		result = cstmt.getString(4); %>
		<script>
			alert("<%= result%>");
			location.href="insert.jsp";
		</script>
	<%}catch(SQLException ex){
		System.err.println("SQLException: "+ ex.getMessage());
	}
	finally{
		if(cstmt != null)
			try{
				myConn.commit();
				cstmt.close();
				myConn.close();
			}catch(SQLException ex){}
	}
%>
	
</body>
</html>