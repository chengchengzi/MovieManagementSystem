<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ page isELIgnored="false" %>

<html>
<head>
	<title>橘子影城</title>
	<%  
    pageContext.setAttribute("APP_PATH",request.getContextPath());  
	%>  
<!-- web路径：  
            不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出现问题  
            以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3366);需要加上项目名  
                http://localhost:3366/crud  
 -->  	
	<link rel="stylesheet" type="text/css" href=".././css/film_info.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<link rel="stylesheet" type="text/css" href=".././css/show_film_hall_tabletype.css">
	<!-- 表单验证 -->
	<script type="text/javascript" src=".././static/js/film_info_form.js"></script>
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	<!-- 引入bookstrap -->
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	
	<!-- 时间日期 -->
    <link type="text/css" rel="stylesheet" href=".././css/jedate.css">
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src=".././static/js/jquery.jedate.js"></script>
     <script type="text/javascript" src=".././static/js/jedate-test.js"></script>
	
	<link rel="stylesheet" type="text/css" href=".././css/input_button.css">
	
</head>

<body onload="showShowPlanMes()">    
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">	
		<div>
			<h2 class="title" >修改放映计划</h2>
			<hr class="line_hr">
		</div>
		
		<div id="show_plan_add_form">
		<form action="${pageContext.request.contextPath}/ShowPlan/editShowPlan" method="get" onsubmit="return check()">
		<table class="edit_table">
 			<tr>
  				<td class="tr_title">放映计划编号 </td>
  				<td><input  class="inputBox" type="text" name="show_plan_id" id="show_plan_id" onclick="checkshow_plan_id()" readonly="readonly"></td>
 			</tr>
 
 			<tr>
  				<td class="tr_title">影片名称 </td>
 			 	<td><select  class="inputBox" id="film_id" name="film_id">
  						<option>请选择</option>
  						<c:forEach items="${listFilmInfo}" var="listFilmInfo" varStatus="status">
  							<option value="${listFilmInfo.film_id}">${listFilmInfo.film_name}</option>
  						</c:forEach>
  					</select>
  				</td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">影厅编号 </td>
 			 	<td><select  class="inputBox" id="film_hall_id" name="film_hall_id">
  						<option>请选择</option>
  						<c:forEach items="${listFilmHallInfo}" var="listFilmHallInfo" varStatus="status">
  							<option  value="${listFilmHallInfo.film_hall_id}">${listFilmHallInfo.film_hall_id}</option>
  						</c:forEach>
  					</select></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">放映时间 </td>
 			 	<td><input class="inputBox" type="text" class="jeinput" name="film_show_time" id="film_show_time" placeholder="YYYY-MM-DD hh:mm:ss" onchange="checkfilm_show_time()"></td>
 			</tr>
 			<tr>
  				<td class="tr_title"> 单价 </td>
 			 	<td><input class="inputBox" type="text" name="film_price" id="film_price"></td>
 			</tr>
 			<tr>
  				<td colspan="2" align="center">
   				<input class="editSubmit" type="submit" value="修改" onclick="return confirm('确认修改？')"/>
   				<button class="editSubmit" onclick="rebackShowPlan()">返回</button>
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
 	//接受并显示show_plan页面传过来的影片信息
 	function showShowPlanMes(){
 	 	var show_plan_id = localStorage.getItem('show_plan_id');
 	 	var show_plan_film_id = localStorage.getItem('show_plan_film_id');
 	 	var show_plan_film_hall_id = localStorage.getItem('show_plan_film_hall_id');
 	 	var show_time = localStorage.getItem('show_time');
 	 	var film_price = localStorage.getItem('film_price');
 	 	
 	 	document.getElementById("show_plan_id").value= show_plan_id;
 	 	document.getElementById("film_show_time").value= show_time;
 	 	document.getElementById("film_price").value= film_price;
 	 	
 	 	var selFilmId = document.getElementById("film_id");
 	 	var opSelFilmIds = selFilmId.options;
 	 	for(var i = 0; i < opSelFilmIds.length;i++){
 	 		var tempValue = opSelFilmIds[i].value;
 	 		if(tempValue == show_plan_film_id){
 	 			opSelFilmIds[i].selected = true;
 	 		}
 	 	}
 	 	
 	 	var selFilmHallId = document.getElementById("film_hall_id");
 	 	var opSelFilmHallIds = selFilmHallId.options;
 	 	for(var i = 0; i < opSelFilmHallIds.length;i++){
 	 		var tempValue = opSelFilmHallIds[i].value;
 	 		if(tempValue == show_plan_film_hall_id){
 	 			opSelFilmHallIds[i].selected = true;
 	 		}
 	 	}
 	}
 	 	
 	//返回film_info_management页面
 	function rebackShowPlan(){
 		window.location.href="${pageContext.request.contextPath}/ShowPlan/showShowPlan";
 	}
 </script>
 
<!-- start:根据后台传回的值，处理film_info_edit结果 -->
 <%
	if((String)session.getAttribute("result") == "success"){
 %>
 	<script type="text/javascript">
 		alert("修改成功！");
 	</script>
 <%session.removeAttribute("result");%>
 <!-- 延迟1秒后，跳转回页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/ShowPlan/showShowPlan";
 		},1000);
 	</script>
 <%	
	}else if((String)session.getAttribute("result") == "fail"){
 %>
	<script type="text/javascript">
 		alert("修改失败！发生未知错误");
 	</script>
 	<%session.removeAttribute("result");%>
 <!-- 延迟1秒后，跳转回film_hall页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/ShowPlan/showShowPlan";
 		},1000);
 	</script>
 <%
    }
 %>
 <!--end:处理film_info_edit结果  -->

</body>
</html>
