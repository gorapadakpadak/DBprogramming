<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
String userPassword = request.getParameter("userPassword");
String userEmail = request.getParameter("userEmail");
String session_id = (String)session.getAttribute("user");

Connection myConn = null;
Statement stmt = null;

String mySQL = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "c##jaeeun";
String passwd = "jaeeun";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

if(userEmail.length()==0 && userPassword.length()!=0){
	mySQL = "update students set s_pwd='"+userPassword+"' where s_id='"+session_id+"'";
}
else if(userEmail.length()!=0 && userPassword.length()==0){
	mySQL = "update students set s_email='"+userEmail+"' where s_id='"+session_id+"'";
}
else if(userEmail.length()!=0 && userPassword.length()!=0){
	mySQL = "update students set s_pwd='"+userPassword+"', s_email='"+userEmail+"' where s_id='"+session_id+"'";
}


try{
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
	}catch(SQLException e) {
		System.err.println("SQLException: "+e.getMessage());
	}
	int n = stmt.executeUpdate(mySQL);%>
	<script>
		alert("정상적으로 수정되었습니다.");
		location.href="update.jsp";
	</script>
<%}catch(SQLException ex){
	String sMessage;
	if(ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다.";
	else if(ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
	else if(ex.getErrorCode() == 20004) sMessage="이메일에 어긋나는 문자 형식입니다.";
	else sMessage="잠시 후 다시 시도하십시오";%>
	<script>
		alert("<%=sMessage%>");
		location.href="update.jsp";
	</script>
<%}
stmt.close();
myConn.close();
%>