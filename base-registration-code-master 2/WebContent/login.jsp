<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 시스템 로그인</title>
<style>
	body{text-align:center;}
	h2{color:#0D2D84;}
	tr{
		height:40px;
	}
</style>
</head>
<body>
	<%@include file="top.jsp" %>
	<h2>로그인</h2>
	<br>
	<table width="50%" align="center" bgcolor="#008fca" >
		<tr><td><div align="center" style="color:#ffffff;">아이디와 패스워드를 입력하세요</div></td></tr>
	</table>
	<table width="50%" align="center"  >
		<form method="post" action="login_verify.jsp">
		
		<tr>
		<td><div align="center">아이디</div></td>
		<td><div align="center"><input type="text" name="userID"></div></td>
		</tr>
		
		<tr>
		<td><div align="center">패스워드</div></td>
		<td><div align="center"><input type="password" name="userPassword"></div></td>
		</tr>
		
		<tr>
		<td colspan=2><div align="center">
		<input type="submit" name="Submit" value="로그인">
		<input type="reset" value="취소"></div></td>
		</tr>
		</form>
	</table>
</body>
</html>