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
	<link rel="stylesheet" type="text/css" href=".././css/admin_main.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<link rel="stylesheet" type="text/css" href=".././css/show_film_hall_tabletype.css">
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	<!-- 引入bookstrap -->
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<!-- 美团css -->
	<link rel="stylesheet" type="text/css" href=".././css/meituan_select_show_plan.css">
	
	<link rel="stylesheet" type="text/css" href=".././css/sale_select_show_plan_a.css">
	
</head>

<body>
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">
		<div class="show-list active" data-index="0">
        	<div class="movie-info">
  				<div>
    				<h2 class="movie-name">${listFilmInfo.film_name}</h2>
  				</div>

  			<div class="movie-desc">
    			<div>
      				<span class="key">时长 :</span>
      				<span class="value">${listFilmInfo.film_duration}</span>
    			</div>
   				 <div>
      				<span class="key">类型 :</span>
      				<span class="value"> ${listFilmInfo.film_type} </span>
   				 </div>
   				  <div>
      				<span class="key">导演 :</span>
      				<span class="value"> ${listFilmInfo.film_dirctor}</span>
    			</div>
   				 <div>
      				<span class="key">主演 :</span>
      				<span class="value"> ${listFilmInfo.film_major}</span>
    			</div>
    			<br>
    			<div style="width: 800px;">
      				<span class="key">影片简介 :</span>
      				<span class="value"> ${listFilmInfo.film_brife}</span>
    			</div>
  			</div>
		</div>

		<div class="show-date">
  			<span>观影时间 :</span>
  			<c:forEach items="${listShowPlanFilmTime}" var="listShowPlanFilmTime" varStatus="status">
   			<a  
   			href="${pageContext.request.contextPath}/AdminMain/selectShowPlanByA?film_id=${listFilmInfo.film_id}&date=${listShowPlanFilmTime.show_time}"
   			>  			
   			<fmt:formatDate pattern="E yyyy-MM-dd" value="${listShowPlanFilmTime.show_time}"/>&nbsp;&nbsp;&nbsp;
   			</a>
            
            </c:forEach>
		</div>

  		<div class="plist-container active">
      
			<table class="plist">
  				<thead>
   		 		<tr>
      				<th>放映时间 </th>
     		 		<th>放映厅</th>
     		 		<th>类型</th>
      				<th>售价（元）</th>
      				<th>选座购票</th>
    			</tr>
  				</thead>

 				<tbody>
    			<c:forEach items="${listShowPlanInfo}" var="listShowPlanInfo" varStatus="status">
    			<tr class="">
      				<td>
        				<span class="begin-time">
        					<fmt:formatDate pattern="HH:mm" value="${listShowPlanInfo.show_time}"/>
        				</span>
       				 	<br />
        				<span class="end-time">
        					<fmt:formatDate pattern="HH:mm" value="${listShowPlanInfo.end_time}"/>散场
        				</span>
      				</td>
      				<td>
        				<span class="hall">${listShowPlanInfo.film_hall_id}号厅</span>
      				</td>
      				<td>
        				<span class="hall_type">${listShowPlanInfo.filmHallInfo.film_hall_type}</span>
      				</td>
      				<td>
        				<span class="sell-price"><span class="stonefont">${listShowPlanInfo.film_price}</span></span>
      				</td>
      				<td>
        				<a href="${pageContext.request.contextPath}/AdminMain/selectSeat?film_id=${listFilmInfo.film_id}&show_plan_id=${listShowPlanInfo.show_plan_id}" 
          				class="buy-btn normal"
        				>选座购票</a>
     				 </td>
      			</tr>
      		</c:forEach>
      		</tbody>
      </table>
    
		
		</div>
	  </div>
	</div>	
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>

</body>
</html>
