<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");

Connection myConn = null;
Statement stmt = null;

String mySQL = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "c##jaeeun";
String passwd = "jaeeun";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();

try{
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();
}catch(SQLException e) {
	System.err.println("SQLException: "+e.getMessage());
}
mySQL = "select s_id from students where s_id='"+userID+"'and s_pwd='"+userPassword+"'";
ResultSet myResultSet = stmt.executeQuery(mySQL);
if(myResultSet!=null){
	if(myResultSet.next()){
		String id = myResultSet.getString("s_id");
		session.setAttribute("user", id);
		response.sendRedirect("main.jsp");
	}
	else{%>
		<script>
			alert("사용자 아이디 혹은 암호가 틀렸습니다.");
			location.href="login.jsp";
		</script>
<%	}
}
else{
	response.sendRedirect("login.jsp");
}
stmt.close();
myConn.close();
%>