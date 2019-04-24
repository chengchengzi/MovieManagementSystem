 <%@ page language="java" contentType="text/html; charset=UTF-8"  
 pageEncoding="UTF-8"%>
 
	<div id="Nav_bg" style="witdth:100%;height:90px;background-color: #F8F8FF;border-top: 5px solid #f27f02;border-bottom: 1px solid #f27f02">
		<div id="image" style="position: relative;top:5px;left:20px">
		
			<img src=".././image/orange.jpg" width="77px" height="77x">
			
			<div  style="position: relative;top:-75px;left:85px">
				<h1 style="font-family:KaiTi;">橘子影城</h1>
			</div>
			<div class="nav">
				<nav>
       				<ul>
            			<li><a href="${pageContext.request.contextPath}/TicketSeller/showFilmInfo">影城主页</a></li>
            			<li><a href="${pageContext.request.contextPath}/TicketSellerSaleInfo/showSaleInfo">票务管理</a></li>
            			<li><a href="${pageContext.request.contextPath}/UserInfo/JumpTicketSellerEditPassword">修改密码</a></li>
        			</ul>
				</nav>
			</div>
		</div>
	</div> 
	<div id="welcome">
		<h5>>>>>>欢迎售票员:${name}&nbsp;<a href=".././index.jsp">退出/切换账号</a></h5>
	</div>
	