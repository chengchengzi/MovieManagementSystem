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
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	 %>
	<link rel="stylesheet" type="text/css" href=".././css/admin_main.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<link rel="stylesheet" type="text/css" href=".././css/show_film_hall_tabletype.css">
	<!-- 选座 -->
	 <link rel="stylesheet" type="text/css" href=".././css/seat_color.css">
 	<script src="http://www.jq22.com/jquery/1.9.1/jquery.min.js">
 	</script>
 	<script type="text/javascript" src="${APP_PATH}/static/js/jquery.seat-charts.min.js"></script>
</head>

<body>
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav_sale.jsp"></jsp:include>
	
	<div id="content">
		<h2 class="title" style="position:relative;left:20px;top:10px;font-family: KaiTi">选座</h2>
		<hr style="height:1px;border:none;border-top:1px groove #E0EEEE;">
            <div class="demo clearfix">
                <!---左边座位列表----->
                <div class="front" style="position: relative;left:50px;">
                    	屏幕
                    	 <div id="legend" style="position: relative;top:20px;left:150px;"></div>
                    </div>
                <div id="seat_area" style="position: relative;left:290px;top:40px;">
                </div>
                <!---右边选座信息----->
                <div class="booking_area" style="position: relative;top:-80px;">
                	<span>
                		<c:if test="${filmInfo.film_pic!=null}">
								<img alt="" src="${basePath}${filmInfo.film_pic}" alt="图片文本描述" >
						</c:if>
                	</span>
                    <p>电影：<span>${filmInfo.film_name}</span></p>
                    <p>时间：<span><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${showPlan.show_time}"/></span></p>
                    <p>影厅：<span>${showPlan.film_hall_id}号厅</span></p>
                    <p>座位：</p>
                    <ul id="seats_chose"></ul>
                    <p>票数：<span id="tickects_num">0</span></p>
                    <p>总价：<b>￥<span id="total_price">0</span></b></p>
                    <input type="button" class="btn" value="确定购买" onclick="save()"/>
                </div>
                <!-- 传参 -->
                <!-- 电影票价 -->
                    <input id="price" type="hidden" value="${showPlan.film_price}">
                 <!-- 电影编号 -->
                 <input id="film_id" type="hidden" value="${filmInfo.film_id}">
                 <!-- 放映计划编号 -->
                 	<input id="show_plan_id" type="hidden" value="${showPlan.show_plan_id}">
                <!-- 接收可选座位字符串 -->
                	<input id="seatInit" type="hidden" value="${seatInit}">
                <!-- 接收已售座位字符串-->
                	<input id="seatOut" type="hidden" value="${seatOut}">
            </div>
    </div>
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>
<!-- 显示座位信息 -->
<script type="text/javascript" src="${APP_PATH}/static/js/seat-select.js"></script>
<script type="text/javascript">
	//保存座位信息
    function save(){
       window.location.href="${pageContext.request.contextPath}/TicketSeller/saveSeat?seat_selected=" 
            + seat_selected + "&seat_removeSelected=" + seat_removeSelected + "&show_plan_id=" + show_plan_id;
    }
</script>
 <!-- 处理购票结果 -->
 <%
	if((String)session.getAttribute("sale_result") == "success"){
 %>
 	<script type="text/javascript">
 		alert("购票成功");
 	</script>
 <%session.removeAttribute("sale_result");%>
 <!-- 延迟1秒后，跳转 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/TicketSeller/showFilmInfo";
 		},1000);
 	</script>
 <%
	}else if((String)session.getAttribute("sale_result") == "fail"){
 %>
	<script type="text/javascript">
 		alert("座位锁定失败！请重新选座");
 	</script>
 	<%session.removeAttribute("sale_result");%>
  	<script type="text/javascript">
  		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/TicketSeller/showFilmInfo";
 		},1000);
 	</script>  
 <%} %>     
</body>
</html>
