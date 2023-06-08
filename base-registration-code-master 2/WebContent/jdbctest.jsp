<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>


<%
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "c##jaeeun";
String password = "jaeeun";    // Oracle password 
String driver = "oracle.jdbc.driver.OracleDriver";
try {
	Class.forName(driver);
	out.println("jdbc driver loading success.");
	DriverManager.getConnection(url, user, password);
	out.println("oracle conn success.");
} catch(ClassNotFoundException e) {
	System.out.println("driver loading failed.");
}catch(SQLException e) {
	System.out.println("oracle conn failed.");
}
%>

</body>
</html>