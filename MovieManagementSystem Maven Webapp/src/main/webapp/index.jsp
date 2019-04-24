<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>橘子影城</title>
	<%  
    pageContext.setAttribute("APP_PATH",request.getContextPath());  
	%>  
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- 登录验证表单 -->
	<script type="text/javascript" src="./static/js/login_form.js"></script>
	
	<link rel="stylesheet" type="text/css" href="./css/login.css">
</head>
<body>
<div id="container">

	<!-- <div id="Nav_bg" style="witdth:100%;height:90px;background-color: #F8F8FF;border-top: 5px solid #f27f02;border-bottom: 1px solid #f27f02">
		<div id="image" style="position: relative;top:5px;left:20px">
		
			<img src="./image/orange.jpg" width="77px" height="77x">
			
			<div  style="position: relative;top:-75px;left:85px">
				<h1 style="font-family:KaiTi;">橘子影城</h1>
			</div>
		</div>
	</div> -->
	
<%-- 	<div id="index_content" style="height:530px;background-color: #F8F8FF;position: relative;top: -10px;">
		<div id="welcome" style="position: relative;top: 80px;">
			<h1 align="center" style="font-family:KaiTi;">欢迎您来到橘子影城售票系统</h1>
		</div>
		<br>
		 <div  align="center" style="position: relative;top: 80px;">
			<form action="${pageContext.request.contextPath}/Login/showLogin" method="post" onsubmit="return check()">
				<input type="text" name="name" id="name" placeholder="用户名" onchange="checkName()"
				style="height:30px;width:170px;width: 170px;
						margin: 0px;padding:0px;
						border:1px solid #a5b6c8;
						font-size: 16px;color: #c1c1c1;text-indent: 25px;
						outline: none;
						background: url(./image/login/input_username.png) no-repeat 2px ;"><br><br>
				<input type="password" name="password" id="password" placeholder="密码" onchange="checkPassword()"
				style="height:30px;width:170px;
					   margin: 0px;padding:0px;
						border:1px solid #a5b6c8;
						font-size: 16px;color: #c1c1c1;text-indent: 25px;
						outline: none;
					   background: url(./image/login/input_password.png) no-repeat 2px ;"><br><br>
				<input  type="submit" value="登录" 
				style="width: 170px;
					height: 30px;
					background: #3b7ae3;
					border:none;
					font-size: 16px;
					color: #fff;">
			</form> 			 
		</div>  
	</div> --%>
	
	<div id="bodyAll">
		<div id="logo">
			<img src="./image/orange.jpg" width="77px" height="77x">
			<h1 id="logo_title">橘子影城</h1>
		</div>
		<div id="login">
			<div id="login_title">
				账号登录
			</div>
			<hr>
			<form action="${pageContext.request.contextPath}/Login/showLogin" method="post" onsubmit="return check()">
				<input class="input_username" type="text" name="name" id="name" placeholder="用户名" onchange="checkName()"><br><br>
				<input class="input_passwrod" type="password" name="password" id="password" placeholder="密码" onchange="checkPassword()"><br><br>
				<input class="login_submit"  type="submit" value="登录" >
			</form> 			
		</div>
		
	</div>
	
</div>
</body>
</html>
