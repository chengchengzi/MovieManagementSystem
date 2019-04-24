<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>橘子影城</title>	
	<!-- 登录验证表单 -->
	<script type="text/javascript" src=".././static/js/login_form.js"></script>
	<link rel="stylesheet" type="text/css" href=".././css/login.css">
</head>
<body>
<div id="container">

		<div id="bodyAll">
		<div id="logo">
			<img src=".././image/orange.jpg" width="77px" height="77x">
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
			<div id="message" align="center">
			${failure_message}
		</div> 
		</div>
		
		</div>
</div>
</html>
