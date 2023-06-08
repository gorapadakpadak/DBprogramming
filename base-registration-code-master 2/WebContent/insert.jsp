<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%><%@page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 입력</title>
<style>
	table{border: 1px solid #D5D5D5; border-collapse: collapse;}
	th,td{border: 1px solid #D5D5D5;}
	tr{height:40px;}
	#insert_btn a{color:#8C8C8C; text-decoration:none;}
	#insert_btn a:hover{color:#0D2D84; font-weight:bold;}
	#table_head{background-color:#008fca; color:#ffffff;}
	
	table{
	border: 2px solid #d2d2d2;
	border-collapse: collapse;
	font-size: 0.9em;
}
th, td{
	border: 1px solid #d2d2d2;
	border-collapse: collapse;
}
th{
	height: 5px;
}
td {
	height: 60px;
}

  .container {
    text-align: center;
  }

  .container select {
    margin-right: auto;
  }
	

</style>
</head>
<body>
	<%@ include file="top.jsp" %>
	<% if (session.getAttribute("user")==null){%>
		<script>
			alert("로그인 한 후 사용하세요.");
			location.href="login.jsp";
		</script>
	<%} %>
	<div class="container">
    <select id="majorDropdown" onchange="selectMajor()">
      <option value="">전체 보기</option>
      <option value="C">컴퓨터과학전공</option>
      <option value="P">응용물리전공</option>
      <option value="S">소프트웨어융합전공</option>
    </select>
	
	<table width="80%" align="center">
	<br><br>
	<tr id="table_head"><th>과목번호</th><th>분반</th><th>과목명</th><th>교수명</th><th>강의시간</th><th>장소</th><th>학점</th><th>수강인원</th><th>수강신청</th><th>여석 알림 신청</th></tr>
	<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver"; 
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe"; 
	String user = "c##jaeeun";
	String passwd = "jaeeun";
	Connection myConn = null;
	
	Class.forName(dbdriver);
	myConn=DriverManager.getConnection(dburl, user, passwd);
	
	Statement stmt = null;
	String mySQL = null;
	ResultSet rs = null;
	
	String c_id = null;
	String c_id_no = null;
	String c_name = null;
	String p_name = null;
	String t_time = null;
	String t_place = null;
	int c_unit = 0;
	int tmax = 0;
	int e_count = 0;
	
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
	
	stmt = myConn.createStatement();
	mySQL = "select i.c_id, i.c_id_no, i.c_name, i.p_name, i.t_time, i.t_place, i.c_unit, i.tmax, NVL(ec.count,0) count from enroll_count ec, insertview i where i.c_id=ec.c_id(+) and i.c_id_no=ec.c_id_no(+) and i.c_id not in (select c_id from enroll where s_id='"+session.getAttribute("user")+"' and e_year='"+nyear+"' and e_semester='"+semester+"') order by i.c_id";
	//mySQL = "select c_id, c_id_no, c_name, c_unit from course where c_id not in (select c_id from enroll where s_id='" + session_id + "')";
	
	rs = stmt.executeQuery(mySQL);
	
	if (rs != null) {
		while (rs.next()) {
			c_id = rs.getString("c_id");
			c_id_no = rs.getString("c_id_no");
			c_name = rs.getString("c_name");
			p_name = rs.getString("p_name");
			t_time = rs.getString("t_time");
			t_place = rs.getString("t_place");
			c_unit = rs.getInt("c_unit");
			tmax = rs.getInt("tmax");
			e_count = rs.getInt("count");%>
			<tr>
			<td align="center"><%= c_id %></td> <td align="center"><%= c_id_no %></td>
			<td align="center"><%= c_name %></td> <td align="center"><%= p_name %></td>
			<td align="center"><%= t_time %></td> <td align="center"><%= t_place %></td>
			<td align="center"><%= c_unit %></td><td align="center"><%=e_count%>/<%= tmax %></td>
			<td id="insert_btn" align="center"><a href="insert_verify.jsp?c_id=<%= c_id %>&c_id_no=<%=c_id_no %>">신청</a></td>
			<td id="insert_btn" align="center"><a href="spare_verify.jsp?c_id=<%= c_id %>&c_id_no=<%=c_id_no %>">알림 신청</a></td>
			</tr>
			
		<%}
	}
	stmt.close(); 
	myConn.close();
	%>
	</table>
	</div>
	<script>
	    function selectMajor() {
	        var dropdown = document.getElementById("majorDropdown");
	        var selectedMajor = dropdown.value;
	
	        var tableRows = document.getElementsByTagName("tr");
	
	        for (var i = 1; i < tableRows.length; i++) {
	            var tableData = tableRows[i].getElementsByTagName("td");
	            var c_id = tableData[0].innerText;
	
	            if (c_id.substring(0, 1) === selectedMajor || selectedMajor === "") {
	                tableRows[i].style.display = "";
	            } else {
	                tableRows[i].style.display = "none";
	            }
	        }
	    }
	</script>

</body>
</html>