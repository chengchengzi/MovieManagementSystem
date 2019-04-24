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
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	<!-- 引入bookstrap -->
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href=".././css/input_button.css">
</head>

<body>    
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">	
	<div id="all">
	<div id="sreachFilmHallById" style="position: relative;top:105px;left:220px">
		<form action="${pageContext.request.contextPath}/ShowPlan/searchShowPlan">
		输入影片编号：<input type="text" name="searchShowPlanFId" id="searchShowPlanFId" class="searchBox">
		<input type="submit" value="查询" onclick="searchById()" class="searchSubmit">
		</form>
	</div>
	
	<div id="add$deleteFilmHall" style="position: relative;top:65px;left:830px;">
		<a href="${pageContext.request.contextPath}/ShowPlan/JumpAddShowPlan" class="add_a_link">
			&nbsp;新增放映计划&nbsp;
		</a>  
		&nbsp;
		<button type="button" onclick="checkAllDelete()" class="batch_del_btn">
			批量删除
		</button>
	</div> 
	
	<div id="mytable" align="center" style="position: relative;top:80px;">
		<table class="hovertable">
			<tr>
				<th style="width: 50px;"><input type="checkbox" id="checkitem" name="checkitem" onclick="checkItem(checkitem)">			
				</th>
				<th>放映计划编号   </th>
				<th>影片编号   </th>
				<th>影片名称   </th>
				<th>影厅编号   </th>
				<th>放映时间  </th>
				<th>散场时间  </th>
				<th>单价  </th>
				<th>管理</th>
			</tr>
			<c:forEach items="${listShowPlan}" var="listShowPlan" varStatus="status">
				<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
					<td style="width: 50px;" align ="center">
					<input type="checkbox" id='${listShowPlan.show_plan_id}' name='show_plan_id_info' value= '${listShowPlan.show_plan_id}' />
					</td>
					<td>${listShowPlan.show_plan_id}</td>
					<td>${listShowPlan.film_id}</td>
					<td>${listShowPlan.filmInfo.film_name}</td>
					<td>${listShowPlan.film_hall_id}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${listShowPlan.show_time}"/></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${listShowPlan.end_time}"/></td>
					<td>${listShowPlan.film_price}</td>
					<td>
					<!-- 按钮 -->
						<button class="management_btn" id="${listShowPlan.show_plan_id}" type="button" onclick="editById(this,this.id)">编辑</button>
						<button class="management_btn" id="${listShowPlan.show_plan_id}" type="button" onclick="delById(this,this.id)">删除</button>	
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<!-- 分页功能 start -->  
    <div align="center" style="position: relative;top:10px;">  
        <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第  
            ${page.pageNow} 页</font> <a href="${pageContext.request.contextPath}/ShowPlan/showShowPlan?pageNow=1">首页</a>  
        <c:choose>  
            <c:when test="${page.pageNow - 1 > 0}">  
                <a href="${pageContext.request.contextPath}/ShowPlan/showShowPlan?pageNow=${page.pageNow - 1}">上一页</a>  
            </c:when>  
            <c:when test="${page.pageNow - 1 <= 0}">  
                <a href="${pageContext.request.contextPath}/ShowPlan/showShowPlan?pageNow=1">上一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="${pageContext.request.contextPath}/ShowPlan/showShowPlan?pageNow=${page.pageNow}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 < page.totalPageCount}">  
                <a href="${pageContext.request.contextPath}/ShowPlan/showShowPlan?pageNow=${page.pageNow + 1}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 >= page.totalPageCount}">  
                <a href="${pageContext.request.contextPath}/ShowPlan/showShowPlan?pageNow=${page.totalPageCount}">下一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="${pageContext.request.contextPath}/ShowPlan/showShowPlan?pageNow=${page.pageNow}">尾页</a>  
            </c:when>  
            <c:otherwise>  
                <a href="${pageContext.request.contextPath}/ShowPlan/showShowPlan?pageNow=${page.totalPageCount}">尾页</a>  
            </c:otherwise>  
        </c:choose>  
    </div>  
    <!-- 分页功能 End -->	
	</div>
	</div>
	</div>	
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>
	<script type="text/javascript">
	// start：删除影厅
	//单个删除
	function delById(obj,id){
		var td_content = $(obj).parents("tr").children("td"); //获取当前行中的所有td值
		var content_show_plan_id = td_content.eq(1).text(); //获取当前行第1个td的值
		//1、弹出确认删除对话框
		if(confirm("确认删除【" + content_show_plan_id  + "】号放映计划么?")) {
			//确认，发送 Ajax
			$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/ShowPlan/delShowPlan",
				data:{'show_plan_id':content_show_plan_id},				
				success: function(res) {
					alert("删除成功");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/ShowPlan/showShowPlan";
				}
			});
		}
	}
	
	//完成全选全不选批量删除
	function checkItem(checkitem){    
            arr = document.getElementsByName('show_plan_id_info' );   
            if (checkitem.checked == true) {   
                for(i=0;i<arr.length;i++){     
                    arr[i].checked = true;   
                }  
             }else{  
                 for(i=0;i<arr.length;i++){   
                      if((arr[i]).checked==false){  
                           arr[i].checked = true;  
                       }else  
                       {arr[i].checked = false; }  
                 }  
             }  
    } 
    
    //批量删除
    function checkAllDelete(){
		var show_plan_del_ids = "";
		$("input[name='show_plan_id_info']").each(function(){
			if(this.checked){
				show_plan_del_ids += this.value + ",";
			}
		});
		if(show_plan_del_ids == ""){
			alert("未选中任何项");
		}else{
			 if(confirm("确认删除所选项么？")){
    		//确认删除，发送Ajax
    		$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/ShowPlan/delBatchShowPlan",
				data:{'show_plan_del_ids':show_plan_del_ids},				
				success: function(res) {
					alert("删除成功！");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/ShowPlan/showShowPlan";
				}
			});
			}
		}
	}
	// end：删除影厅 
	
	//start:编辑放映计划
	function editById(obj,id){
		//1、获取选择的影厅信息
		var show_plan_content = $(obj).parents("tr").children("td"); //获取当前行中的所有td值
		var content_show_plan_id = show_plan_content.eq(1).text(); //获取当前行放映计划编号
		var content_film_id = show_plan_content.eq(2).text(); //获取当前行影片编号
		var content_film_hall_id = show_plan_content.eq(4).text(); //获取当前行影片类型
		var content_show_time = show_plan_content.eq(5).text(); //获取当前行时间
		var content_film_price = show_plan_content.eq(7).text(); //获取当前行单价
		//2、传值到编辑页面
		localStorage.setItem("show_plan_id",content_show_plan_id);
		localStorage.setItem("show_plan_film_id",content_film_id);
		localStorage.setItem("show_plan_film_hall_id",content_film_hall_id);
		localStorage.setItem("show_time",content_show_time);
		localStorage.setItem("film_price",content_film_price);
		window.location.href="${pageContext.request.contextPath}/ShowPlan/JumpEditShowPlan";
	}
	
	//分页查询的查询id
	function searchById(){
		var show_plan_search_film_id = document.getElementById("searchShowPlanFId").value;
		localStorage.setItem("show_plan_search_film_id",show_plan_search_film_id);
	}
</script>

<!-- 分页查询 -->
<%
	String name = request.getParameter("searchUserInfoName");
	session.setAttribute("param",name); 
%>

</body>
</html>
