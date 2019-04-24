<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>橘子影城</title>
	<link rel="stylesheet" type="text/css" href=".././css/ticket_seller_main.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<!-- 显示图片 -->
 	<link rel="stylesheet" href=".././css/admin_main_pic.css" type="text/css" />
</head>

<body>
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav_sale.jsp"></jsp:include>
	
	<div id="content">
	              <div>
                   <c:forEach items="${listFilmInfo}" var="listFilmInfo" varStatus="status">    
                       <div class="img" style="position: relative;left: 80px;">
                            <a href="${pageContext.request.contextPath}/TicketSeller/selectShowPlan?film_id=${listFilmInfo.film_id}">
                                <c:if test="${listFilmInfo.film_pic!=null}">
									<img alt="" src="${basePath}${listFilmInfo.film_pic}" alt="图片文本描述" >
								</c:if>
                            </a>
                            <div class="desc">${listFilmInfo.film_name}</div>
                        </div>
					</c:forEach>
                 
                    </div>
 	</div>
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>

</body>
</html>