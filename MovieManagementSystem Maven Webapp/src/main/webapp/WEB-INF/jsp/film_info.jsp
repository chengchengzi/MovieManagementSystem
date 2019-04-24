<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>橘子影城</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href=".././css/film_info.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
</head>

<body>
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	<div id="content">
		<div id="film_info_image" style="position: relative;top:150px;left:250px;">
			<a href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo"><img style="width:300px;height:300px;" src=".././image/filmInfo.jpg"></a>
		</div>
		<div id="film_show_image" style="position: relative;top:-150px;left:620px;">
			<a href="${pageContext.request.contextPath}/ShowPlan/showShowPlan"><img style="width:320px;height:320px;" src=".././image/filmShow.jpg"></a>
		</div>
	</div>
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>

</body>
</html>
