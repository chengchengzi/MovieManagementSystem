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
	<link rel="stylesheet" type="text/css" href=".././css/ticket_sale.css">
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
			<form action="${pageContext.request.contextPath}/SaleInfo/searchSaleInfo">
			输入电影票编号：<input type="text" name="searchSaleInfoById" id="searchSaleInfoById" class="searchBox">
			<input type="submit" value="查询" class="searchSubmit">
			</form>
	   </div>
	
		<div id="add$deleteSaleInfo" style="position: relative;top:65px;left:830px;">
			<button type="button" onclick="checkAllDelete()" class="batch_del_btn">
			批量操作
			</button>
		</div> 
	
		<div id="mytable" align="center" style="position: relative;top:80px;">
			<table class="hovertable">
				<tr>
					<th style="width: 50px;"><input type="checkbox" id="checkitem" name="checkitem" onclick="checkItem(checkitem)">			
					</th>
					<th>电影票编号   </th>
					<th>售票时间   </th>
					<th>影片编号 </th>
					<th>影厅编号 </th>
					<th>座位号 </th>
					<th>放映时间 </th>
					<th>电影票类型 </th>
					<th>电影票单价 </th>
					<th>管理</th>
				</tr>
				<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
					<td style="width: 50px;" align ="center">
					<input type="checkbox" id='${listSale.sale_info_id}' name='sale_info_id' value='${listSale.sale_info_id}' />
					</td>
					<td>${listSale.sale_info_id}</td>
					<td><fmt:formatDate type="both" value="${listSale.sale_info_showtime}"/></td>
					<td>${listSale.film_id}</td>
					<td>${listSale.film_hall_id}</td>
					<td>${listSale.sale_info_location}</td>
					<td><fmt:formatDate type="both" value="${listSale.sale_info_showtime}"/></td>
					<td>${listSale.sale_info_type}</td>
					<td>${listSale.sale_info_price}</td>
					<td>
					<!-- 按钮 -->
						<button class="management_btn" id="${listSale.sale_info_id}" type="button" onclick="delSaleInfoById(this,this.id)">退票</button>	
					</td>
				</tr>
		</table>
	</div>	
	</div>
	</div>
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>

<script type="text/javascript">
	//单个删除
	function delSaleInfoById(obj,id){
		var td_content = $(obj).parents("tr").children("td"); //获取当前行中的所有td值
		var content_sale_info_id = td_content.eq(1).text(); //获取当前行第1个td的值
		//1、弹出确认删除对话框
		if(confirm("确认退票【" + content_sale_info_id   + "】号电影票么?")) {
			//确认，发送 Ajax
			$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/SaleInfo/delSaleInfo",
				data:{'sale_info_id':content_sale_info_id},				
				success: function(res) {
					alert("删除成功");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/SaleInfo/showSaleInfo";
				}
			});
		}
	}

	//完成全选全不选批量删除
	function checkItem(checkitem){    
            arr = document.getElementsByName('sale_info_id' );   
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
		var sale_info_del_ids = "";
		$("input[name='sale_info_id']").each(function(){
			if(this.checked){
				sale_info_del_ids += this.value + ",";
			}
		});
		if(sale_info_del_ids == ""){
			alert("未选中任何项");
		}else{
			 if(confirm("确认删除所选项么？")){
    		//确认删除，发送Ajax
    		$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/SaleInfo/delBatchSaleInfo",
				data:{'sale_info_del_ids':sale_info_del_ids},				
				success: function(res) {
					alert("删除成功！");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/SaleInfo/showSaleInfo";
				}
			});
			}
		}
	} 
</script>
<!-- 处理search的结果 -->
 <%
 if((String)session.getAttribute("data") == "search_fail"){
 %>
	<script type="text/javascript">
 		alert("电影票不存在！");
 		 //延迟1秒后，跳转回film_hall页面
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/SaleInfo/showSaleInfo";
 		},1000);
 	</script>
  <%
  	session.removeAttribute("data");
  	}else if((String)session.getAttribute("data") == "search_empty"){
 %>
	<script type="text/javascript">
 		alert("请输入电影票编号！");
 		 //延迟1秒后，跳转回film_hall页面
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/SaleInfo/showSaleInfo";
 		},1000);
 	</script>
 <%session.removeAttribute("data"); %>
 <%
    }
 %>
</body>
</html>
