<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>橘子影城</title>
	<link rel="stylesheet" type="text/css" href=".././css/ticket_seller_worker_info.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href=".././css/input_button.css">
	
</head>

<body>
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav_sale.jsp"></jsp:include>
	
	<div id="content">
		<div>
			<h2 class="title" >修改密码</h2>
			<hr class="line_hr">
		</div>
		<div class="edit_table">
			<div style="position: relative;left:70px;">
				<h4>员工编号：${uid}</h4>
        		<h4>员工姓名：${name}</h4>
        	</div>
        	<table>
        	<tr>
        		<td class="tr_title">请输入原始密码</td>
        		<td><input class="inputBox" type="password" id="user_password" name="user_password" value=""></td>
        	</tr>
        	<tr>
        		<td class="tr_title">修改密码</td>
        		<td><input class="inputBox" type="password" id="user_edit_password" name="user_edit_password" value=""></td>
        	</tr>
             <tr>
  				<td colspan="2" align="center">
   				<button class="editSubmit" type="button" onclick="editPassword()">提交</button>
  				</td>
 			</tr>                       
    	   </table>
    	</div> 
    </div>
  	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
    
    <div>
    	<input type="hidden" id="user_id" name="user_id" value="${uid}">
    </div>
</div>
<script type="text/javascript">
	function editPassword(){
		var user_id = document.getElementById("user_id").value;
		var user_password = document.getElementById("user_password").value;
		var user_edit_password = document.getElementById("user_edit_password").value;
		window.location.href="${pageContext.request.contextPath}/UserInfo/TicketSellerEditPassword?user_id=" + user_id + 
		"&user_password=" + user_password + "&user_edit_password=" + user_edit_password;
	}
</script>
 <!-- start:根据后台传回的值，处理结果 -->
 <%
	if((String)session.getAttribute("result") == "success"){
 %>
 	<script type="text/javascript">
 		alert("修改成功！");
 	</script>
 <%session.removeAttribute("result");%>
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/TicketSeller/showFilmInfo";
 		},1000);
 	</script>
 <%	
	}else if((String)session.getAttribute("result") == "notSame"){
 %>
	<script type="text/javascript">
 		alert("原始密码输入有误");
 	</script>
 	<%session.removeAttribute("result");%>
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/UserInfo/JumpTicketSellerEditPassword";
 		},1000);
 	</script>
 <%
    }
 %>
 <!--end:处理结果  -->

</body>
</html>