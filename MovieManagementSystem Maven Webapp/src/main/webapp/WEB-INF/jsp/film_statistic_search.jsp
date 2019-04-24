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
	<link rel="stylesheet" type="text/css" href=".././css/film_statistic.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<link rel="stylesheet" type="text/css" href=".././css/show_film_hall_tabletype.css">
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	<!-- 时间日期 -->
    <link type="text/css" rel="stylesheet" href=".././css/jedate.css">
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src=".././static/js/jquery.jedate.js"></script>
     <script type="text/javascript" src=".././static/js/jedate-test.js"></script>
     
     <link rel="stylesheet" type="text/css" href=".././css/input_button.css">
</head>

<body onload="showMesOfFilmId()">
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	
	
	<div id="content">
		<div id="sreach" style="position: relative;top:45px;left:220px">
			请输入影片编号：<input type="text" id="film_id" name="film_id" class="searchBox">
			<div id="btns">
			<button type="button" onclick="queryByOnTime()" id="searchSubmitDay">
				查询当日
			</button>
			<button type="button" onclick="queryByWeek()" id="searchSubmitDay">
				查询本周
			</button>
			<button type="button" onclick="queryByMonth()" id="searchSubmitDay">
			查询本月
			</button>
			</div>
			<div>
		<div style="position: relative;top:-5px;">
		<input class="searchBox" type="text" class="jeinput" name="from_time" id="from_time" placeholder="YYYY-MM-DD hh:mm">
		至
		<input class="searchBox" type="text" class="jeinput" name="to_time" id="to_time" placeholder="YYYY-MM-DD hh:mm">
		<button class="searchSubmit" type="button" onclick="queryByRange()">
			查询
		</button>
		</div>
		</div>
		</div>
	
		<div id="mytable" align="center" style="position: relative;top:60px;">
		<table class="hovertable">
			<tr>
				<th>统计时间   </th>
				<th>影片编号   </th>
				<th>影片名称  </th>
				<th>售票数量  </th>
				<th>总票房   </th>
			</tr>
				<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${listTicketOffice.ticket_office_time}"/></td>
					<td>${listTicketOffice.film_id}</td>
					<td>${listTicketOffice.filmInfo.film_name}</td>
					<td>${listTicketOffice.ticket_office_numbers}</td>
					<td>${listTicketOffice.ticket_office_totalprice}</td>
				</tr>
		</table>
    </div>
	</div>
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>
<script type="text/javascript">
	//实时查询
	function queryByOnTime(){
		var film_id = document.getElementById("film_id").value;
		if(film_id == ""){
			alert("请输入影片编号");
		} else{
			localStorage.setItem("ticket_ontime_search_film_id",film_id);
			window.location.href="${pageContext.request.contextPath}/TicketOffice/QueryByOnTime?film_id=" + film_id;
		}
		
	}
	
	//查询本周
	function queryByWeek(){
		var film_id = document.getElementById("film_id").value;
		if(film_id == ""){
			alert("请输入影片编号");
		} else{
			localStorage.setItem("ticket_ontime_search_film_id",film_id);
			window.location.href="${pageContext.request.contextPath}/TicketOffice/QueryByWeek?film_id=" + film_id;
		}
	}
	
	//查询本月
	function queryByMonth(){
		var film_id = document.getElementById("film_id").value;
		if(film_id == ""){
			alert("请输入影片编号");
		} else{
			localStorage.setItem("ticket_ontime_search_film_id",film_id);
			window.location.href="${pageContext.request.contextPath}/TicketOffice/QueryByMonth?film_id=" + film_id;
		}
	}
	
	//区域查询
	function queryByRange(){
		var film_id = document.getElementById("film_id").value;
		var from_time = document.getElementById("from_time").value;
		var to_time = document.getElementById("to_time").value;
		if(film_id == ""){
			alert("请输入影片编号");
		}else if(from_time == "" || to_time == ""){
			alert("请选择日期");
		}else{
			localStorage.setItem("ticket_ontime_search_film_id",film_id);
			localStorage.setItem("ticket_search_from_time",from_time);
			localStorage.setItem("ticket_search_to_time",to_time);
			window.location.href="${pageContext.request.contextPath}/TicketOffice/QueryByRange?film_id=" + film_id + "&from_time=" + from_time + "&to_time=" + to_time;
		}
	}
	
	
	function showMesOfFilmId(){
		var film_id = localStorage.getItem("ticket_ontime_search_film_id");
		var from_time = localStorage.getItem("ticket_search_from_time");
		var to_time = localStorage.getItem("ticket_search_to_time");
 	 	document.getElementById("film_id").value = film_id;
 	 	document.getElementById("from_time").value = from_time;
 	 	document.getElementById("to_time").value = to_time;
	}
	
	//接受模糊查询的 参数
 	function showFilmInfoNameMes(){
 	 	var flim_info_search_name = localStorage.getItem("film_search_name");
 	 	document.getElementById("searchFilmName").value= flim_info_search_name;
 	} 	
</script>

</body>
</html>
