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
	<link rel="stylesheet" type="text/css" href=".././css/film_statistic.css">
	<link rel="stylesheet" type="text/css" href=".././css/content.css">
	<link rel="stylesheet" type="text/css" href=".././css/show_film_hall_tabletype.css">
	<!-- 引入jquery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
	<!-- 时间日期 -->
    <link type="text/css" rel="stylesheet" href=".././css/jedate.css">
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src=".././static/js/jquery.jedate.js"></script>
     <script type="text/javascript" src=".././static/js/jedate-test.js"></script>
     
     <link rel="stylesheet" type="text/css" href=".././css/input_button.css">
</head>

<body>
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	
	
	<div id="content">
	<div id="all">
	<div id="sreach" style="position: relative;top:105px;left:180px">
		请输入影片编号：<input type="text" id="film_id" name="film_id" class="searchBox"><br>
		<div id="btns">
		<button type="button" onclick="queryByOnTime()" id="searchSubmitDay">
			查询当日
		</button>
		<button type="button" onclick="queryByWeek()" id="searchSubmitWeek">
			查询本周
		</button>
		<button type="button" onclick="queryByMonth()" id="searchSubmitMonth">
			查询本月
		</button>
		</div>
		<br>
		<div id="searchRange">
		<input class="searchBox" type="text" class="jeinput" name="from_time" id="from_time" placeholder="YYYY-MM-DD">
		至
		<input class="searchBox" type="text" class="jeinput" name="to_time" id="to_time" placeholder="YYYY-MM-DD">
		<button class="searchSubmit" type="button" onclick="queryByRange()">
			查询
		</button>
		</div>
	</div>
		<div style="position: relative;top:58px;left:1030px;">
			<button type="button" onclick="checkAllDelete()" class="batch_del_btn">
			批量删除
		</button>
		</div>
	
		<div id="mytable" align="center" style="position: relative;top:70px;">
		<table class="hovertable">
			<tr>
				<th style="width: 50px;"><input type="checkbox" id="checkitem" name="checkitem" onclick="checkItem(checkitem)">			
				</th>
				<th>票房统计编号   </th>
				<th>统计时间   </th>
				<th>影片编号   </th>
				<th>影片名称  </th>
				<th>售票数量  </th>
				<th>总票房   </th>
				<th>管理</th>
			</tr>
			<c:forEach items="${listTicketOffice}" var="listTicketOffice" varStatus="status">
				<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
					<td style="width: 50px;" align ="center">
					<input type="checkbox" id='${listTicketOffice.ticket_office_id}' name='ticket_office_id_info' value= '${listTicketOffice.ticket_office_id}' />
					</td>
					<td>${listTicketOffice.ticket_office_id}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${listTicketOffice.ticket_office_time}"/></td>
					<td>${listTicketOffice.film_id}</td>
					<td>${listTicketOffice.filmInfo.film_name}</td>
					<td>${listTicketOffice.ticket_office_numbers}</td>
					<td>${listTicketOffice.ticket_office_totalprice}</td>
					<td>
						<button class="management_btn" id="${listTicketOffice.ticket_office_id}" type="button" onclick="delById(this,this.id)">删除</button>	
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 分页功能 start -->  
    <div align="center" style="position: relative;top:10px;">  
        <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第  
            ${page.pageNow} 页</font> <a href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice?pageNow=1">首页</a>  
        <c:choose>  
            <c:when test="${page.pageNow - 1 > 0}">  
                <a href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice?pageNow=${page.pageNow - 1}">上一页</a>  
            </c:when>  
            <c:when test="${page.pageNow - 1 <= 0}">  
                <a href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice?pageNow=1">上一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice?pageNow=${page.pageNow}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 < page.totalPageCount}">  
                <a href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice?pageNow=${page.pageNow + 1}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 >= page.totalPageCount}">  
                <a href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice?pageNow=${page.totalPageCount}">下一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice?pageNow=${page.pageNow}">尾页</a>  
            </c:when>  
            <c:otherwise>  
                <a href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice?pageNow=${page.totalPageCount}">尾页</a>  
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
	function delById(obj,id){
		var td_content = $(obj).parents("tr").children("td"); //获取当前行中的所有td值
		var content_ticket_office_id = td_content.eq(1).text(); //获取当前行第1个td的值
		//1、弹出确认删除对话框
		if(confirm("确认删除【" + content_ticket_office_id  + "】号统计数据么?")) {
			//确认，发送 Ajax
			$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/TicketOffice/delTicketOffice",
				data:{'ticket_office_id':content_ticket_office_id},				
				success: function(res) {
					alert("删除成功");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice";
				}
			});
		}
	}
	
	//完成全选全不选批量删除
	function checkItem(checkitem){    
            arr = document.getElementsByName('ticket_office_id_info' );   
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
		var ticket_office_del_ids = "";
		$("input[name='ticket_office_id_info']").each(function(){
			if(this.checked){
				ticket_office_del_ids += this.value + ",";
			}
		});
		if(ticket_office_del_ids == ""){
			alert("未选中任何项");
		}else{
			 if(confirm("确认删除所选项么？")){
    		//确认删除，发送Ajax
    		$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/TicketOffice/delBatchTicketOffice",
				data:{'ticket_office_del_ids':ticket_office_del_ids},				
				success: function(res) {
					alert("删除成功！");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/TicketOffice/showTicketOffice";
				}
			});
			}
		}
	}
	
	//实时查询
	function queryByOnTime(){
		var film_id = document.getElementById("film_id").value;
		if(film_id == ""){
			alert("请输入影片编号");
		} else{
			localStorage.setItem("ticket_ontime_search_film_id",film_id);
			window.location.href="${pageContext.request.contextPath}/TicketOffice/QueryByOnTime?film_id=" + film_id;
		}
		
	}
	
	//查询本周
	function queryByWeek(){
		var film_id = document.getElementById("film_id").value;
		if(film_id == ""){
			alert("请输入影片编号");
		} else{
			localStorage.setItem("ticket_ontime_search_film_id",film_id);
			window.location.href="${pageContext.request.contextPath}/TicketOffice/QueryByWeek?film_id=" + film_id;
		}
	}
	
	//查询本月
	function queryByMonth(){
		var film_id = document.getElementById("film_id").value;
		if(film_id == ""){
			alert("请输入影片编号");
		} else{
			localStorage.setItem("ticket_ontime_search_film_id",film_id);
			window.location.href="${pageContext.request.contextPath}/TicketOffice/QueryByMonth?film_id=" + film_id;
		}
	}
	
	//区域查询
	function queryByRange(){
		var film_id = document.getElementById("film_id").value;
		var from_time = document.getElementById("from_time").value;
		var to_time = document.getElementById("to_time").value;
		if(film_id == ""){
			alert("请输入影片编号");
		}else if(from_time == "" || to_time == ""){
			alert("请选择日期");
		}else{
			localStorage.setItem("ticket_ontime_search_film_id",film_id);
			localStorage.setItem("ticket_search_from_time",from_time);
			localStorage.setItem("ticket_search_to_time",to_time);
			window.location.href="${pageContext.request.contextPath}/TicketOffice/QueryByRange?film_id=" + film_id + "&from_time=" + from_time + "&to_time=" + to_time;
		}
	}
	
</script>

</body>
</html>
