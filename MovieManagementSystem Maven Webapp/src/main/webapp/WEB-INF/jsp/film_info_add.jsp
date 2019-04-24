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
    request.setCharacterEncoding("UTF-8");
	%>  
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href=".././css/film_info.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<script type="text/javascript" src=".././static/js/film_info_form.js"></script>
	<!-- 时间日期 -->
    <link type="text/css" rel="stylesheet" href=".././css/jedate.css">
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src=".././static/js/jquery.jedate.js"></script>
     <script type="text/javascript" src=".././static/js/jedate-test.js"></script>

	<link rel="stylesheet" type="text/css" href=".././css/input_button.css">
	
</head>
<body>
<div id="container">
	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">
		<div>
			<h2 class="title" >新增影片</h2>
			<hr class="line_hr">
		</div>		
	<div id="film_info_add_form">
		<form action="${pageContext.request.contextPath}/FilmInfo/addFilmInfo" method="post" onsubmit="return check()" enctype="multipart/form-data">
		<table class="edit_table">
 			<tr>
  				<td class="tr_title">影片编号 </td>
  				<td><input class="inputBox" type="text" name="film_id" id="film_id" onchange="checkfilm_id()" /></td>
 			</tr>
 
 			<tr>
  				<td class="tr_title">影片名称 </td>
 			 	<td><input class="inputBox" type="text" name="film_name" id="film_name" onchange="checkfilm_name()"></td>
 			</tr>
 	
 			<tr>
  				<td class="tr_title">导演 </td>
 			 	<td><input class="inputBox" type="text" name="film_dirctor" id="film_dirctor" onchange="checkfilm_dirctor()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">主演 </td>
 			 	<td><input class="inputBox" type="text" name="film_major" id="film_major" onchange="checkfilm_major()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">影片类型 </td>
 			 	<td><input class="inputBox" type="text" name="film_type" id="film_type"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">上映时间 </td>
 			 	<td><input class="inputBox" type="text" class="jeinput" name="film_show_time" id="film_show_time" placeholder="YYYY-MM-DD hh:mm" onchange="checkfilm_show_time()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">影片时长 </td>
 			 	<td><input class="inputBox" type="text" name="film_duration" id="film_duration" onchange="checkfilm_duration()"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">影片简介 </td>
 			 	<td><input class="inputBox" type="text" name="film_brife" id="film_brife"></td>
 			</tr>
 			
 			<tr>
  				<td class="tr_title">宣传海报 </td>
 			 	<td>
 			 		<input class="inputBox" type="file" name="file" id="film_pic">
 			 	</td>
 			</tr>
 			
 			<tr>
  				<td colspan="2" align="center">
   			    <input class="editSubmit" type="submit" name="submit" value="新增"/> 
   				<input class="editSubmit" type="reset" name="reset" value="重置"/>
  				</td>
 			</tr>
		</table>  
	</form> 
		
	</div>
	</div>
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>
<!-- start:处理后台返回film_info_add的结果 -->
 <%
	if((String)session.getAttribute("result") == "success"){
 %>
 	<script type="text/javascript">
 		alert("新增成功！");
 	</script>
 <%session.removeAttribute("result");%>
 <!--延时1秒后返回film_info页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo";
 		},1000);
 	</script>
 <%
	}else if((String)session.getAttribute("result") == "repeat"){
 %>
	<script type="text/javascript">
 		alert("影片名重复！");
 	</script>
 	<%session.removeAttribute("result");%>
 <!-- 延时1秒后返回film_info页面-->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo";
 		},1000);
 	</script>
 <%	
	}else if((String)session.getAttribute("result") == "fail"){
 %>
	<script type="text/javascript">
 		alert("新增失败！");
 	</script>
 	<%session.removeAttribute("result");%>
 <!--延时1秒后返回film_info页面  -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo";
 		},1000);
 	</script>
 <%
    }
 %>
 <!--end:处理后台返回film_info_add的结果  -->
</body>
</html>
