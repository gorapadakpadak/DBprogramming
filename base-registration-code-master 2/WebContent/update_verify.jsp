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
		alert("���������� �����Ǿ����ϴ�.");
		location.href="update.jsp";
	</script>
<%}catch(SQLException ex){
	String sMessage;
	if(ex.getErrorCode() == 20002) sMessage="��ȣ�� 4�ڸ� �̻��̾�� �մϴ�.";
	else if(ex.getErrorCode() == 20003) sMessage="��ȣ�� ������ �Էµ��� �ʽ��ϴ�.";
	else if(ex.getErrorCode() == 20004) sMessage="�̸��Ͽ� ��߳��� ���� �����Դϴ�.";
	else sMessage="��� �� �ٽ� �õ��Ͻʽÿ�";%>
	<script>
		alert("<%=sMessage%>");
		location.href="update.jsp";
	</script>
<%}
stmt.close();
myConn.close();
%>