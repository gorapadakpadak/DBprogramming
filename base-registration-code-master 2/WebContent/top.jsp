<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% String session_id = (String)session.getAttribute("user");
String log;
if(session_id ==null)
log="<a href=login.jsp>�α���</a>";
else log="<a href=logout.jsp>�α׾ƿ�</a>";%>
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
		<a href="main.jsp"><h2>������û������</h2></a>
	</div>
	<ul>
	<li><b><%=log%></b></li>
	<li><b><a href="update.jsp">����� ���� ����</a></b></li>
	<li><b><a href="insert.jsp">������û �Է�</a></b></li>
	<li><b><a href="delete.jsp">������û ����</a></b></li>		
	<li><b><a href="select.jsp">������û ��ȸ</a></b></li>
	</ul>
</body>