<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page isELIgnored="false" %>
	
<html>
<head>
	<title>橘子影城</title>
	<%  
    pageContext.setAttribute("APP_PATH",request.getContextPath());  
	%>  
	<link rel="stylesheet" type="text/css" href=".././css/user_info.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<link rel="stylesheet" type="text/css" href=".././css/show_film_hall_tabletype.css">
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	<!-- 引入bookstrap -->
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href=".././css/input_button.css">
</head>

<body onload="showUserInfoNameMes()">
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	<div id="content">
	<div id="all">
		<div id="sreachFilmHallById" style="position: relative;top:105px;left:220px">
		<form action="${pageContext.request.contextPath}/UserInfo/searchUserInfo">
		输入员工姓名：<input type="text" name="searchUserInfoName" id="searchUserInfoName" class="searchBox">
		<input type="submit" value="查询" onclick="fuzzySelect()" class="searchSubmit">
		</form>
	</div>
	
	<div id="add$deleteFilmHall" style="position: relative;top:65px;left:830px;">
		<a href="${pageContext.request.contextPath}/UserInfo/JumpAddUserInfo" class="add_a_link">
			&nbsp;新增员工&nbsp;
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
				<th>员工编号   </th>
				<th>员工姓名   </th>
				<th>密码   </th>
				<th>级别  </th>
				<th>管理</th>
			</tr>
			
				<c:forEach items="${listUserInfo}" var="listUser" varStatus="status">
				<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
					<td style="width: 50px;" align ="center">
					<input type="checkbox" id='${listUser.user_id}' name='user_info_id' value='${listUser.user_id}' />
					</td>
					<td>${listUser.user_id}</td>
					<td>${listUser.user_name}</td>
					<td>${listUser.user_password}</td>
					<td>${listUser.user_grade}</td>
					<td>
					<!-- 按钮 -->
						<button class="management_btn" id="${listUser.user_id}" type="button" onclick="editUserInfoById(this,this.id)">修改</button>
						<button class="management_btn" id="${listUser.user_id}" type="button" onclick="delUserInfoById(this,this.id)">删除</button>	
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<!-- 分页功能 start -->  
    <div align="center" style="position: relative;top:10px;">  
        <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第  
            ${page.pageNow} 页</font> <a href="${pageContext.request.contextPath}/UserInfo/searchUserInfo?pageNow=1">首页</a>  
        <c:choose>  
            <c:when test="${page.pageNow - 1 > 0}">  
                <a href="${pageContext.request.contextPath}/UserInfo/searchUserInfo?pageNow=${page.pageNow - 1}">上一页</a>  
            </c:when>  
            <c:when test="${page.pageNow - 1 <= 0}">  
                <a href="${pageContext.request.contextPath}/UserInfo/searchUserInfo?pageNow=1">上一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="${pageContext.request.contextPath}/UserInfo/searchUserInfo?pageNow=${page.pageNow}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 < page.totalPageCount}">  
                <a href="${pageContext.request.contextPath}/UserInfo/searchUserInfo?pageNow=${page.pageNow + 1}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 >= page.totalPageCount}">  
                <a href="${pageContext.request.contextPath}/UserInfo/searchUserInfo?pageNow=${page.totalPageCount}">下一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="${pageContext.request.contextPath}/UserInfo/searchUserInfo?pageNow=${page.pageNow}">尾页</a>  
            </c:when>  
            <c:otherwise>  
                <a href="${pageContext.request.contextPath}/UserInfo/searchUserInfo?pageNow=${page.totalPageCount}">尾页</a>  
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
	//单个删除
	function delUserInfoById(obj,id){
		var td_content = $(obj).parents("tr").children("td"); //获取当前行中的所有td值
		var content_user_info_id = td_content.eq(1).text(); //获取当前行第1个td的值
		//1、弹出确认删除对话框
		if(confirm("确认删除【" + content_user_info_id  + "】号员工信息?")) {
			//确认，发送 Ajax
			$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/UserInfo/delUserInfo",
				data:{'content_user_info_id':content_user_info_id},				
				success: function(res) {
					alert("删除成功");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/UserInfo/showUserInfo";
				}
			});
		}
	}
	
	//完成全选全不选批量删除
	function checkItem(checkitem){    
            arr = document.getElementsByName('user_info_id');   
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
		var user_info_del_ids = "";
		$("input[name='user_info_id']").each(function(){
			if(this.checked){
				user_info_del_ids += this.value + ",";
			}
		});
		if(user_info_del_ids == ""){
			alert("未选中任何项");
		}else{
			 if(confirm("确认删除所选项么？")){
    		//确认删除，发送Ajax
    		$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/UserInfo/delBatchUserInfo",
				data:{'user_info_del_ids':user_info_del_ids},				
				success: function(res) {
					alert("删除成功！");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/UserInfo/showUserInfo";
				}
			});
			}
		}
	}
	
	//start:修改员工信息
	function editUserInfoById(obj,id){
		//1、获取选择的影厅信息
		var user_content = $(obj).parents("tr").children("td"); //获取当前行中的所有td值
		var content_user_info_id = user_content.eq(1).text(); //获取当前行影厅编号
		var content_user_info_name = user_content.eq(2).text(); //获取当前行影厅位置
		var content_user_info_password = user_content.eq(3).text(); //获取当前行影厅类型
		var content_user_info_grade = user_content.eq(4).text(); //获取当前行影厅总座位数
		//2、传值到编辑页面
		localStorage.setItem("user_info_id",content_user_info_id);
		localStorage.setItem("user_info_name",content_user_info_name);
		localStorage.setItem("user_info_password",content_user_info_password);
		localStorage.setItem("user_info_grade",content_user_info_grade);
		//3、跳转到修改员工信息页面
		window.location.href="${pageContext.request.contextPath}/UserInfo/JumpEditUserInfo";
	}
	
	//接受并显示模糊查询的员工姓名
 	function showUserInfoNameMes(){
 	 	var user_info_search_name = localStorage.getItem("user_search_name");
 	 	document.getElementById("searchUserInfoName").value= user_info_search_name;
 	} 
 	
 	//模糊查询员工信息
	function fuzzySelect(){
		var user_search_name = document.getElementById("searchUserInfoName").value;
		localStorage.setItem("user_search_name",user_search_name);
	}
</script>


<!-- 分页查询：放入查询参数 -->
<%
	String name = request.getParameter("searchUserInfoName");
	session.setAttribute("param",name); 
%>
</body>
</html>
