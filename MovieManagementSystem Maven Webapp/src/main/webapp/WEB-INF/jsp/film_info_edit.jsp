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
	<link rel="stylesheet" type="text/css" href=".././css/film_info.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<script type="text/javascript" src=".././static/js/film_info_form.js"></script>
	<!-- 时间日期选择器 -->
    <link type="text/css" rel="stylesheet" href=".././css/jedate.css">
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src=".././static/js/jquery.jedate.js"></script>
     <script type="text/javascript" src=".././static/js/jedate-test.js"></script>

	<link rel="stylesheet" type="text/css" href=".././css/input_button.css">
	
</head>
<body onload="showFilmInfoMes()">
<div id="container">
	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">
		<div>
			<h2 class="title" >修改影片信息</h2>
			<hr class="line_hr">
		</div>		
	<div id="film_info_add_form">
		<form action="${pageContext.request.contextPath}/FilmInfo/editFilmInfo" method="post" onsubmit="return check()" enctype="multipart/form-data">
		<table class="edit_table">
 			<tr>
  				<td class="tr_title">影片编号</td>
  				<td><input class="inputBox" type="text" name="film_id" id="film_id" readonly="readonly"/></td>
 			</tr>
 
 			<tr>
  				<td class="tr_title">影片名称</td>
 			 	<td><input class="inputBox" type="text" name="film_name" id="film_name" onchange="checkfilm_name()"></td>
 			</tr>
 	
 			<tr>
  				<td class="tr_title">导演</td>
 			 	<td><input class="inputBox" type="text" name="film_dirctor" id="film_dirctor" onchange="checkfilm_dirctor()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">主演</td>
 			 	<td><input class="inputBox" type="text" name="film_major" id="film_major" onchange="checkfilm_major()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">影片类型</td>
 			 	<td><input class="inputBox" type="text" name="film_type" id="film_type"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">上映时间</td>
 			 	<td><input class="inputBox" type="text" class="jeinput" name="film_show_time" id="film_show_time" placeholder="YYYY-MM-DD hh:mm:ss" onchange="checkfilm_show_time()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">影片时长</td>
 			 	<td><input class="inputBox" type="text" name="film_duration" id="film_duration" onchange="checkfilm_duration()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">影片简介</td>
 			 	<td><input class="inputBox" type="text" name="film_brife" id="film_brife"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">宣传海报</td>
 			 	<td>
 			 		<input class="inputBox" type="file" name="file" id="film_pic">
 			 	</td>
 			</tr>
 			
 			<tr>
  				<td colspan="2" align="center">
   			    <input class="editSubmit" type="submit" value="修改" onclick="return confirm('确认修改？')"/>
   				<button class="editSubmit" type="button" onclick="rebackFilmInfo()">返回</button>
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
 	//接受并显示film_info_management页面传过来的影片信息
 	function showFilmInfoMes(){
 	 	var film_id = localStorage.getItem('film_id');
 	 	var film_name = localStorage.getItem('film_name');
 	 	var film_dirctor = localStorage.getItem('film_dirctor');
 	 	var film_major = localStorage.getItem('film_major');
 	 	var film_type = localStorage.getItem('film_type');
 	 	var film_show_time = localStorage.getItem('film_show_time');
 	 	var film_duration = localStorage.getItem('film_duration');
 	 	var film_brife = localStorage.getItem('film_brife');
 	 	var film_pic = localStorage.getItem('film_pic');
 	 	document.getElementById("film_id").value= film_id;
 	 	document.getElementById("film_name").value= film_name;
 	 	document.getElementById("film_dirctor").value= film_dirctor;
 	 	document.getElementById("film_major").value= film_major;
 	 	document.getElementById("film_type").value= film_type;
 	 	document.getElementById("film_show_time").value= film_show_time;
 	 	document.getElementById("film_duration").value= film_duration;
 	 	document.getElementById("film_brife").value= film_brife;
 	 	document.getElementById("film_pic").value= film_pic;
 	}
 	 	
 	//返回film_info_management页面
 	function rebackFilmInfo(){
 		window.location.href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo";
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
 			window.location.href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo";
 		},1000);
 	</script>
 <%	
	}else if((String)session.getAttribute("result") == "fail"){
 %>
	<script type="text/javascript">
 		alert("保存失败！发生未知错误");
 	</script>
 	<%session.removeAttribute("result");%>
 <!-- 延迟1秒后，跳转回film_hall页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo";
 		},1000);
 	</script>
 <%
    }
 %>
 <!--end:处理film_info_edit结果  -->
</body>
</html>
