<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% String session_id = (String)session.getAttribute("user");
String log;
if(session_id ==null)
log="<a href=login.jsp>로그인</a>";
else log="<a href=logout.jsp>로그아웃</a>";%>
<style>
	body{margin:0; padding:0;}
	.title{text-align:center;}
	img{width:139px; height:45px; vertical-align:middle;}
	h2{color:#008fca; text-align:center; display:inline-block; vertical-align:middle;}
	ul{
	    list-style: none;
	    line-height:1;
		width: 100%;
	    background-color: #008fca;
	    text-align: center;
	}
	ul li{
	    display: inline-block;
	    margin: 0;
	}
	ul a{
		color:#ffffff; 
		text-decoration:none; 
		padding: 15px 25px;
	    margin: 0;
		display:block; 
		height:100%;
	}
	ul a:hover{color:#008fca; background-color:#ffffff;}
</style>
<body>
	<div class="title">
		<img src="aclogo.jpg"/>
		<a href="main.jsp"><h2>수강신청페이지</h2></a>
	</div>
	<ul>
	<li><b><%=log%></b></li>
	<li><b><a href="update.jsp">사용자 정보 수정</a></b></li>
	<li><b><a href="insert.jsp">수강신청 입력</a></b></li>
	<li><b><a href="delete.jsp">수강신청 삭제</a></b></li>		
	<li><b><a href="select.jsp">수강신청 조회</a></b></li>
	</ul>
</body>