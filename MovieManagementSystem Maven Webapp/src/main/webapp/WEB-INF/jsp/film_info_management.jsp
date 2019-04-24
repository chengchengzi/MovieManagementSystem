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
  
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	%> 
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
		<div id="sreachFilmHallByName" style="position: relative;top:105px;left:220px">
		<form action="${pageContext.request.contextPath}/FilmInfo/searchFilmInfo">
		输入影片名称：<input type="text" name="searchFilmName" id="searchFilmName" class="searchBox">
		<input type="submit" value="查询" onclick="fuzzySelect()" class="searchSubmit" >
		</form>
		</div>
	
	<div id="add$deleteFilmInfo" style="position: relative;top:65px;left:830px;">
		<a href="${pageContext.request.contextPath}/FilmInfo/JumpAddFilmInfo" class="add_a_link">
			&nbsp;新增影片&nbsp;
		</a>  
		&nbsp;
		<button type="button" onclick="checkAllDelete()" class="batch_del_btn">
			批量删除
		</button>
	</div> 
	
	<div id="mytable" align="center" style="position: relative;top:80px;">
		<table class="hovertable">
			<tr>
				<th style="width: 35px;"><input type="checkbox" id="checkitem" name="checkitem" onclick="checkItem(checkitem)">			
				</th>
				<th>影片编号   </th>
				<th>影片名称   </th>
				<th>导演   </th>
				<th>主演  </th>
				<th>影片类型</th>
				<th>上映时间</th>
				<th>影片时长</th>
				<th>影片简介</th>
				<th>宣传海报</th>
				<th>管理</th>
			</tr>
			<c:forEach items="${listFilmInfo}" var="listFilmInfo" varStatus="status">
				<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
					<td style="width: 50px;" align ="center">
					<input type="checkbox" id='${listFilmInfo.film_id}' name='film_id_info' value= '${listFilmInfo.film_id}' />
					</td>
					<td>${listFilmInfo.film_id}</td>
					<td>${listFilmInfo.film_name}</td>
					<td>${listFilmInfo.film_dirctor}</td>
					<td>${listFilmInfo.film_major}</td>
					<td>${listFilmInfo.film_type}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${listFilmInfo.film_show_time}"/></td>
					<td>${listFilmInfo.film_duration}</td>
					<td>${listFilmInfo.film_brife}</td>
					<td>
						<c:if test="${listFilmInfo.film_pic!=null}">
						<img id="iamges" alt="" src="${basePath}${listFilmInfo.film_pic}" style="width:50px;heigth:80px;">
						</c:if>
					</td>
					<td>
					<!-- 按钮 -->
						<button class="management_btn" id="${listFilmInfo.film_id}" type="button" onclick="editById(this,this.id)">编辑</button>
						<button class="management_btn" id="${listFilmInfo.film_id}" type="button" onclick="delById(this,this.id)">删除</button>	
					</td>
				</tr>
			</c:forEach>
		</table>
		
    <!-- 分页功能 start -->  
    <div align="center" style="position: relative;top:10px;">  
        <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第  
            ${page.pageNow} 页</font> <a href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo?pageNow=1">首页</a>  
        <c:choose>  
            <c:when test="${page.pageNow - 1 > 0}">  
                <a href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo?pageNow=${page.pageNow - 1}">上一页</a>  
            </c:when>  
            <c:when test="${page.pageNow - 1 <= 0}">  
                <a href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo?pageNow=1">上一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo?pageNow=${page.pageNow}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 < page.totalPageCount}">  
                <a href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo?pageNow=${page.pageNow + 1}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 >= page.totalPageCount}">  
                <a href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo?pageNow=${page.totalPageCount}">下一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo?pageNow=${page.pageNow}">尾页</a>  
            </c:when>  
            <c:otherwise>  
                <a href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo?pageNow=${page.totalPageCount}">尾页</a>  
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
		var content_film_info_id = td_content.eq(1).text(); //获取当前行第1个td的值
		//1、弹出确认删除对话框
		if(confirm("确认删除【" + content_film_info_id  + "】号影片么?")) {
			//确认，发送 Ajax
			$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/FilmInfo/delFilmInfo",
				data:{'film_id':content_film_info_id},				
				success: function(res) {
					alert("删除成功");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo";
				}
			});
		}
	}
	//完成全选全不选批量删除
	function checkItem(checkitem){    
            arr = document.getElementsByName('film_id_info' );   
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
		var film_info_del_ids = "";
		$("input[name='film_id_info']").each(function(){
			if(this.checked){
				film_info_del_ids += this.value + ",";
			}
		});
		if(film_info_del_ids == ""){
			alert("未选中任何项");
		}else{
			 if(confirm("确认删除所选项么？")){
    		//确认删除，发送Ajax
    		$.ajax({
				type:"post",
				url: "${pageContext.request.contextPath}/FilmInfo/delBatchFilmInfo",
				data:{'film_info_del_ids':film_info_del_ids},				
				success: function(res) {
					alert("删除成功！");
					//回到本页
					window.location.href="${pageContext.request.contextPath}/FilmInfo/showFilmInfo";
				}
			});
			}
		}
	}
	//模糊查询员工信息
	function fuzzySelect(){
		var film_search_name = document.getElementById("searchFilmName").value;
		localStorage.setItem("film_search_name",film_search_name);
	}
	
	//start:编辑影片信息
	function editById(obj,id){
		//1、获取选择的影厅信息
		var film_content = $(obj).parents("tr").children("td"); //获取当前行中的所有td值
		var content_film_id = film_content.eq(1).text(); //获取当前行影片编号
		var content_film_name = film_content.eq(2).text(); //获取当前行影片名称
		var content_film_dirctor = film_content.eq(3).text(); //获取当前行导演
		var content_film_major = film_content.eq(4).text(); //获取当前行主演
		var content_film_type = film_content.eq(5).text(); //电影类型
		var content_film_show_time = film_content.eq(6).text();//上映时间
		var content_film_duration = film_content.eq(7).text();//影片时长
		var content_film_brife = film_content.eq(8).text();//影片简介
		var content_film_pic = film_content.eq(9).text();//宣传海报
		
		//2、传值到编辑页面
		localStorage.setItem("film_id",content_film_id);
		localStorage.setItem("film_name",content_film_name);
		localStorage.setItem("film_dirctor",content_film_dirctor);
		localStorage.setItem("film_major",content_film_major);
		localStorage.setItem("film_type",content_film_type);
		localStorage.setItem("film_show_time",content_film_show_time);
		localStorage.setItem("film_duration",content_film_duration);
		localStorage.setItem("film_brife",content_film_brife);
		localStorage.setItem("film_pic",content_film_pic);
		
		window.location.href="${pageContext.request.contextPath}/FilmInfo/JumpEditFilmInfo";
	}
</script>

<%
	String name = request.getParameter("searchFilmName");
	session.setAttribute("param",name); 
%>
</body>
</html>
