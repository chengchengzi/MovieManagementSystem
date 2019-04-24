<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page isELIgnored="false" %>
	
<html>
<head>
	<title>橘子影城</title>
	<%  
    pageContext.setAttribute("APP_PATH",request.getContextPath());  
	%>  
	<link rel="stylesheet" type="text/css" href=".././css/user_info.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<link rel="stylesheet" type="text/css" href=".././css/show_film_hall_tabletype.css">
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	<!-- 引入bookstrap -->
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href=".././css/input_button.css">
	
</head>

<body onload="showUserInfoMes()">
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">
		<div>
			<h2 class="title" >修改信息</h2>
			<hr class="line_hr">
		</div>
	
		<div id="user_info_edit_form">
		<form action="${pageContext.request.contextPath}/UserInfo/editUserInfo">
		<table class="edit_table">
		<!-- onblur 事件处理程序:当元素或窗口失去焦点时触发该事件 -->
 		<!-- onchange事件处理程序:当表单元素获取焦点，并且内容发生改变时，触发该事件 -->
 		<!-- 以下同理 -->
 			<tr>
  				<td class="tr_title">员工编号 </td> 
  				<td><input class="inputBox" type="text" name="user_info_id" id="user_info_id" value="" onchange="checkuser_info_id()" readonly="readonly"/></td>
 			</tr>
 
 			<tr>
  				<td class="tr_title">员工姓名</td>
 			 	<td><input class="inputBox" type="text" name="user_info_name" id="user_info_name" value="" onchange="checkuser_info_name()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">员工初始密码</td>
 			 	<td><input class="inputBox" type="text" name="user_info_password" id="user_info_password" value="" onchange="checkuser_info_password()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">员工等级</td>
 			 	<td><input class="inputBox" type="text" name="user_info_grade" id="user_info_grade" value="" onchange="checkuser_info_grade()"></td>
 			</tr>
 			<tr>
  				<td colspan="2" align="center">
   				<input class="editSubmit" type="submit" value="修改" onclick="return confirm('确认修改？')"/>
   				<button class="editSubmit" onclick="rebackUserInfo()">返回</button>
  				</td>
 			</tr>
		</table>
		</form> 
		</div>
	</div>
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>
<script type="text/javascript">
 	//接受并显示film_hall页面传过来的影厅信息
 	function showUserInfoMes(){
 	 	var user_info_id = localStorage.getItem('user_info_id');
 	 	var user_info_name = localStorage.getItem('user_info_name');
 	 	var user_info_password = localStorage.getItem('user_info_password');
 	 	var user_info_grade = localStorage.getItem('user_info_grade');
 	 	document.getElementById("user_info_id").value= user_info_id;
 	 	document.getElementById("user_info_name").value= user_info_name;
 	 	document.getElementById("user_info_password").value= user_info_password;
 	 	document.getElementById("user_info_grade").value= user_info_grade;
 	}
 	 	
 	//返回film_hall页面
 	function rebackUserInfo(){
 		window.location.href="${pageContext.request.contextPath}/UserInfo/showUserInfo";
 	}
 </script>
 
 <!-- start:根据后台传回的值，处理结果 -->
 <%
	if((String)session.getAttribute("data") == "update_success"){
 %>
 	<script type="text/javascript">
 		alert("修改成功！返回员工管理页面...");
 	</script>
 <%session.removeAttribute("data");%>
 <!-- 延迟1秒后，跳转回film_hall页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/UserInfo/showUserInfo";
 		},1000);
 	</script>
 <%} %>
 <!--end:处理结果  -->

</body>
</html>
