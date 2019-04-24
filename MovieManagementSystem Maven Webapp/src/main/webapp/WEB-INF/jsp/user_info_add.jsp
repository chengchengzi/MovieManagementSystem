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
	<script type="text/javascript" src=".././static/js/user_info_add_form.js"></script>
	
	<link rel="stylesheet" type="text/css" href=".././css/input_button.css">
	
</head>

<body>
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">	
		<div>
			<h2 class="title" >新增员工</h2>
			<hr class="line_hr">
		</div>
		
		<div id="user_info_add_form">
		<form action="${pageContext.request.contextPath}/UserInfo/addUserInfo" method="get" onsubmit="return check()">
		<table class="edit_table">
		<!-- onblur 事件处理程序:当元素或窗口失去焦点时触发该事件 -->
 		<!-- onchange事件处理程序:当表单元素获取焦点，并且内容发生改变时，触发该事件 -->
 		<!-- 以下同理 -->
 			<tr>
  				<td class="tr_title">员工编号</td>
  				<td><input class="inputBox" type="text" name="user_info_id" id="user_info_id" onchange="checkuser_info_id()" /></td>
 			</tr>
 
 			<tr>
  				<td class="tr_title">员工姓名</td>
 			 	<td><input class="inputBox" type="text" name="user_info_name" id="user_info_name" onchange="checkuser_info_name()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">员工初始密码</td>
 			 	<td><input class="inputBox" type="text" name="user_info_password" id="user_info_password" onchange="checkuser_info_password()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">员工等级</td>
 			 	<td><input class="inputBox" type="text" name="user_info_grade" id="user_info_grade" onchange="checkuser_info_grade()"></td>
 			</tr>
 			<tr>
  				<td colspan="2" align="center">
   				<input class="editSubmit"  type="submit" name="submit" value="保存"/>
   				<input class="editSubmit" type="submit" type="reset" name="reset" value="重置"/>
  				</td>
 			</tr>
		</table>
		</form> 
		</div>
	</div>
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>
<!-- start:根据后台传回的值，处理user_info_add结果 -->
 <%
	if((String)session.getAttribute("data") == "success"){
 %>
 	<script type="text/javascript">
 		alert("保存成功！返回员工管理页面...");
 	</script>
 <%session.removeAttribute("data");%>
 <!-- 延迟1秒后，跳转回film_hall页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/UserInfo/showUserInfo";
 		},1000);
 	</script>
 <%
	}else if((String)session.getAttribute("data") == "repeat"){
 %>
	<script type="text/javascript">
 		alert("员工编号已存在！返回员工管理页面...");
 	</script>
 	<%session.removeAttribute("data");%>
 <!-- 延迟1秒后，跳转回film_hall页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/UserInfo/showUserInfo";
 		},1000);
 	</script>
 <%	
	}else if((String)session.getAttribute("data") == "fail"){
 %>
	<script type="text/javascript">
 		alert("保存失败！返回员工管理页面...");
 	</script>
 	<%session.removeAttribute("data");%>
 <!-- 延迟1秒后，跳转回film_hall页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/UserInfo/showUserInfo";
 		},1000);
 	</script>
 <%
    }
 %>
 <!--end:处理film_hall_add结果  -->

</body>
</html>
