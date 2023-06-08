<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 시스템</title>
</head>
<body>
	<%@include file="top.jsp" %>
	<table width="75%" align="center" height="100%">
		<%if(session_id != null){ %>
		<br><br>
		<tr><td align="center"><%=session_id%>님 방문을 환영합니다.</td></tr>
		<%} else{ %>
		<br><br>
		<tr><td align="center">로그인한 후 사용하세요.</td></tr>
		<%} %>
	</table>
</body>
</html>