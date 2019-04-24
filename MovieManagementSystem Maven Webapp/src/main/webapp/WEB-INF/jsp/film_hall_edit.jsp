<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page isELIgnored="false" %>

<html>
<head>
	<title>橘子影城</title>	
	<link rel="stylesheet" type="text/css" href=".././css/film_hall.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<link rel="stylesheet" type="text/css" href=".././css/add_film_hall_form.css">
	<script type="text/javascript" src=".././static/js/film_hall_form.js"></script>
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	<!-- 引入bookstrap -->
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href=".././css/input_button.css">
</head>
<body onload="showFilmHallMes()">    
<div id="container">

<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">	
		<div>
			<h2 class="title" >修改影厅信息</h2>
			<hr class="line_hr">
		</div>
		
		<div id="film_hall_add_form">
		<form action="${pageContext.request.contextPath}/FilmHall/editFilmHall">
		<table class="edit_table">
		<!-- onblur 事件处理程序:当元素或窗口失去焦点时触发该事件 -->
 		<!-- onchange事件处理程序:当表单元素获取焦点，并且内容发生改变时，触发该事件 -->
 		<!-- 以下同理 -->
 			<tr>
  				<td class="tr_title">影厅编号</td>
  				<td><input class="inputBox" type="text" value="" name="film_hall_id" id="film_hall_id" readonly="readonly"/></td>
 			</tr>
 
 			<tr>
  				<td class="tr_title">影厅位置</td>
 			 	<td><input class="inputBox" type="text" value="" name="film_hall_location" id="film_hall_location" onchange="checkfilm_hall_location()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">影厅类型</td>
 			 	<td><input class="inputBox" type="text" value="" name="film_hall_type" id="film_hall_type"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">影厅总座位数</td>
 			 	<td><input class="inputBox" type="text" value="" name="film_hall_numbers" id="film_hall_numbers" onchange="checkfilm_hall_numbers()"></td>
 			</tr>
 			<tr>
  				<td colspan="2" align="center">
   				<input class="editSubmit" type="submit" value="修改" onclick="return confirm('确认修改？')"/>
   				<button class="editSubmit" type="button" onclick="rebackFilmHall()">返回</button>
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
 	function showFilmHallMes(){
 	 	var film_hall_id = localStorage.getItem('film_hall_id');
 	 	var film_hall_location = localStorage.getItem('film_hall_location');
 	 	var film_hall_type = localStorage.getItem('film_hall_type');
 	 	var film_hall_numbers = localStorage.getItem('film_hall_numbers');
 	 	document.getElementById("film_hall_id").value= film_hall_id;
 	 	document.getElementById("film_hall_location").value= film_hall_location;
 	 	document.getElementById("film_hall_type").value= film_hall_type;
 	 	document.getElementById("film_hall_numbers").value= film_hall_numbers;
 	}
 	 	
 	//返回film_hall页面
 	function rebackFilmHall(){
 		window.location.href="${pageContext.request.contextPath}/FilmHall/showFilmHall";
 	}
 </script>
 
 <!-- start:根据后台传回的值，处理film_hall_edit结果 -->
 <%
	if((String)session.getAttribute("data") == "update_success"){
 %>
 	<script type="text/javascript">
 		alert("修改成功！返回设置影厅页面...");
 	</script>
 <%session.removeAttribute("data");%>
 <!-- 延迟1秒后，跳转回film_hall页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/FilmHall/showFilmHall";
 		},1000);
 	</script>
 <%} %>
 <!--end:处理film_hall_edit结果  -->
 
</body>
</html>
