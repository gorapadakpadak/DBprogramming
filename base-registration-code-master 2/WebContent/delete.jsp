<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%><%@page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 삭제</title>
<style>
	table{border: 1px solid #D5D5D5; border-collapse: collapse;}
	th,td{border: 1px solid #D5D5D5;}
	tr{height:40px;}
	#delete_btn a{color:#8C8C8C; text-decoration:none;}
	#delete_btn a:hover{color:#0D2D84; font-weight:bold;}
	#table_head{background-color:#008fca; color:#ffffff;}
</style>
</head>
<body>
	<%@include file="top.jsp" %>
	<% if (session.getAttribute("user")==null){%>
		<script>
			alert("로그인 한 후 사용하세요.");
			location.href="login.jsp";
		</script>
	<%} %>
	<br><br>
	<table width="75%" align="center" border>
		<tr id="table_head"><th>과목번호</th><th>분반</th><th>과목명</th><th>교수명</th><th>강의시간</th><th>장소</th><th>학점</th><th>취소</th></tr>
	<%
	Calendar cal = Calendar.getInstance();
	int nyear = cal.get(Calendar.YEAR);
    int nmonth = cal.get(Calendar.MONTH)+1; 
    String semester;
    if(nmonth>=1 && nmonth<=4){
    	semester = "1학기";
    }else if(nmonth>=5 && nmonth<=10){
    	semester = "2학기";
    }else{
    	nyear++;
    	semester = "1학기";
    }
	
	Connection myConn = null;
	Statement stmt = null;
	
	String mySQL = null;
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "c##jaeeun";
	String passwd = "jaeeun";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	String c_id = null;
	String c_id_no = null;
	String c_name = null;
	String p_name = null;
	String t_time = null;
	String t_place = null;
	int c_unit = 0;
	
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
	}catch(SQLException e) {
		System.err.println("SQLException: "+e.getMessage());
	}
	mySQL = "select c_id, c_id_no, c_name, p_name, t_time, t_place, c_unit from senroll where s_id='"+session_id+"' and e_year='"+nyear+"' and e_semester='"+semester+"'";
	ResultSet rs = stmt.executeQuery(mySQL);
	if(rs!=null){
		while (rs.next()) {
			c_id = rs.getString("c_id");
			c_id_no = rs.getString("c_id_no");
			c_name = rs.getString("c_name");
			p_name = rs.getString("p_name");
			t_time = rs.getString("t_time");
			t_place = rs.getString("t_place");
			c_unit = rs.getInt("c_unit");%>
			<tr>
			<td align="center"><%= c_id %></td> <td align="center"><%= c_id_no %></td>
			<td align="center"><%= c_name %></td> <td align="center"><%= p_name %></td>
			<td align="center"><%= t_time %></td> <td align="center"><%= t_place %></td>
			<td align="center"><%= c_unit %></td>
			<td id="delete_btn" align="center"><a href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no%>">취소</a></td>
			</tr>
		<%}
	}
	stmt.close(); 
	myConn.close();
	%>
	</table>
</body>
</html>