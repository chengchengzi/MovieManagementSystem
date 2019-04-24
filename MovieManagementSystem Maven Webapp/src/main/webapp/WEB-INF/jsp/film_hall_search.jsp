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
<!-- web路径：  
            不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出现问题  
            以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3366);需要加上项目名  
                http://localhost:3366/crud  
 -->  	
	<link rel="stylesheet" type="text/css" href=".././css/film_hall.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<link rel="stylesheet" type="text/css" href=".././css/show_film_hall_tabletype.css">
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	<!-- 引入bookstrap -->
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>    
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">	
	
	<div id="sreachFilmHallById" style="position: relative;top:105px;left:220px">
		<form action="${pageContext.request.contextPath}/FilmHall/searchFilmHall">
		输入影厅编号：<input type="text" name="searchFimlHallId" id="searchFimlHallId">
		<input type="submit" value="查询">
		</form>
	</div>
	
	<div id="add$deleteFilmHall" style="position: relative;top:65px;left:830px;">
		<a href="${pageContext.request.contextPath}/FilmHall/JumpAddFilmHall" style="border:1px solid #BDB76B;font-family:KaiTi;font-size: 20px;text-decoration: none;background-color:#F0FFFF">
			&nbsp;新增影厅&nbsp;
		</a>  
		&nbsp;
		<button type="button" onclick="checkAllDelete()" style="border:1px solid #BDB76B;font-family:KaiTi;font-size: 18px;text-decoration: none;background-color:#F0FFFF">
			批量删除
		</button>
	</div> 
	
	<div id="mytable" align="center" style="position: relative;top:80px;">
		<table class="hovertable">
			<tr>
				<th style="width: 50px;"><input type="checkbox" id="checkitem" name="checkitem" onclick="checkItem(checkitem)">			
				</th>
				<th>影厅编号   </th>
				<th>影厅位置   </th>
				<th>影厅类型   </th>
				<th>影厅总座位数  </th>
				<th>管理</th>
			</tr>
				<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
					<td style="width: 50px;" align ="center">
					<input type="checkbox" id='${listFilmHall.film_hall_id}' name='film_hall_id_info' value= '${listFilmHall.film_hall_id}' />
					</td>
					<td>${listFilmHall.film_hall_id}</td>
					<td>${listFilmHall.film_hall_location}</td>
					<td>${listFilmHall.film_hall_type}</td>
					<td>${listFilmHall.film_hall_numbers}</td>
					<td>
					<!-- 按钮 -->
						<button>排座</button>
						<button class="edit_btn" id="${listFilmHall.film_hall_id}" type="button" onclick="editById(this,this.id)">编辑</button>
						<button class="delete_btn" id="${listFilmHall.film_hall_id}" type="button" onclick="delById(this,this.id)">删除</button>	
					</td>
				</tr>
		</table>
		
	
	</div>
	</div>	
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>
	<script type="text/javascript">
	// start：删除影厅
	//单个删除
	function delById(obj,id){
		//1、弹出确认删除对话框
		var td_content = $(obj).parents("tr").children("td"); //获取当前行中的所有td值
		var content_film_hall_id = td_content.eq(1).text(); //获取当前行第1个td的值
		if(confirm("确认删除【" + content_film_hall_id  + "】号影厅么?")) {
			//确认，发送 Ajax
			$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/FilmHall/delFilmHall",
				data:{'film_hall_id':content_film_hall_id},				
				success: function(res) {
					alert("删除成功");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/FilmHall/showFilmHall";
				}
			});
		}
	}
	
	//完成全选全不选批量删除
	function checkItem(checkitem){    
            arr = document.getElementsByName('film_hall_id_info' );   
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
		var film_hall__del_ids = "";
		$("input[name='film_hall_id_info']").each(function(){
			if(this.checked){
				film_hall__del_ids += this.value + ",";
			}
		});
		if(film_hall__del_ids == ""){
			alert("未选中任何项");
		}else{
			 if(confirm("确认删除所选项么？")){
    		//确认删除，发送Ajax
    		$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/FilmHall/delBatchFilmHall",
				data:{'film_hall_del_ids':film_hall__del_ids},				
				success: function(res) {
					alert("删除成功！");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/FilmHall/showFilmHall";
				}
			});
			}
		}
	}
	// end：删除影厅 
	
	//start:编辑影厅
	function editById(obj,id){
		//1、获取选择的影厅信息
		var film_content = $(obj).parents("tr").children("td"); //获取当前行中的所有td值
		var content_film_hall_id = film_content.eq(1).text(); //获取当前行影厅编号
		var content_film_hall_location = film_content.eq(2).text(); //获取当前行影厅位置
		var content_film_hall_type = film_content.eq(3).text(); //获取当前行影厅类型
		var content_film_hall_numbers = film_content.eq(4).text(); //获取当前行影厅总座位数
		//2、传值到编辑页面
		localStorage.setItem("film_hall_id",content_film_hall_id);
		localStorage.setItem("film_hall_location",content_film_hall_location);
		localStorage.setItem("film_hall_type",content_film_hall_type);
		localStorage.setItem("film_hall_numbers",content_film_hall_numbers);
		window.location.href="${pageContext.request.contextPath}/FilmHall/JumpEditFilmHall";
	}
		
	</script>

<!-- 处理search的结果 -->
 <%
	if((String)session.getAttribute("data") == "search_success"){
 %>
 	<script type="text/javascript">
 		alert("查询成功");
 	</script>
 <%
 	session.removeAttribute("data");
	}else if((String)session.getAttribute("data") == "search_fail"){
 %>
	<script type="text/javascript">
 		alert("影厅不存在");
 		 //延迟1秒后，跳转回film_hall页面
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/FilmHall/showFilmHall";
 		},1000);
 	</script>
  <%
  	session.removeAttribute("data");
  	}else if((String)session.getAttribute("data") == "search_empty"){
 %>
	<script type="text/javascript">
 		alert("请输入影厅编号");
 		 //延迟1秒后，跳转回film_hall页面
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/FilmHall/showFilmHall";
 		},1000);
 	</script>
 <%session.removeAttribute("data"); %>
 <%
    }
 %>
</body>
</html>
