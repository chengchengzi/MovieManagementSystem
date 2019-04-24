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
	<!-- 选座css -->
	 <link rel="stylesheet" type="text/css" href=".././css/seat_color.css">
	 
	 <link rel="stylesheet" type="text/css" href=".././css/input_button.css">
</head>

<body>    
<div id="container">

	<!-- Nav导航条 -->
	<jsp:include page="../public/public_nav.jsp"></jsp:include>
	
	<div id="content">	
		<div id="left_mes" style="width:230px;height:500px;border-right:solid #DCDCDC 1px;position: relative;top:20px;left:5px;">
			<h2 style="font-family: KaiTi;">${film_hall_id}号影厅排座</h2>
			<table>
				<tr>
					<td>行数：</td>
					<td><input type="text" name="x" id="x" class="xyInput"></td>
				</tr>
				<tr>
					<td>列数：</td>
					<td><input type="text" name="y" id="y" class="xyInput"></td>
				</tr>
			</table>
			<input type="button" value="确定" onclick="registSeat()" id="sortSubmit">
			<p><button id="saveSort" onclick="saveSeat()" >保存</button></p>
			<div class="booking-details">
      			<ul id="selected-seats"></ul>      
      			<div id="legend"></div>
			</div>
		</div>
		<div id="right_show" style="width:1050px;height:500px;position:relative;top:-500px;left:240px;">	  
             <div class="front">屏幕</div>     					
			 <div id="seat-maps">					
                </div>
			 </div>
		</div>
    	
	<!-- foot -->
	<jsp:include page="../public/public_foot.jsp"></jsp:include>
</div>	
<!--排座 -->
 <script src="http://www.jq22.com/jquery/1.9.1/jquery.min.js"></script>
 <script type="text/javascript" src="${APP_PATH}/static/js/jquery.seat-charts.min.js"></script>
 <script type="text/javascript">
 	$(document).ready(function() {
    registSeat();
    /* $("#save").on('click',function(){
        $.get("${pageContext.request.contextPath}/Seat/saveSeat?str="+map).success(function(data){
            console.log(data);
        });
    }); */
	});
var map = new Array();
function registSeat(){
    var x = parseInt($("#x").val());
    var y = parseInt($("#y").val());
    map = [];
    for(var i=0;i<x;i++){
        map[i]="";
        for(var j=0;j<y;j++){
            map[i]+="e";
        }
    }
    $('#seat-maps').empty();
    $("#legend").empty();
    var sc = $('#seat-maps').seatCharts({
                    map: map,
                    naming: {
                        top: false, //不显示顶部横坐标（行） 
                        left:true,
                        getLabel: function(character, row, column) { //返回座位信息 
                            return column;
                        }
                    },
                    legend: {
                        node: $('#legend'),
                        items: [
                            [ 'e', 'available',   '位置' ],
                            [ 'e', 'none', '过道']
                        ]
                    },
                    click: function() {
                         if (this.status() == 'available') { //若为可选座状态，添加座位
                            map[this.settings.row]=map[this.settings.row].substring(0,this.settings.column)+"_"+map[this.settings.row].substring(this.settings.column+1);
                            return 'none';
                         }else {
                            map[this.settings.row]=map[this.settings.row].substring(0,this.settings.column)+"e"+map[this.settings.row].substring(this.settings.column+1);
                            return "available";
                        }
                    }
    });

        // sc.get(['1_1', '2_1']).status('none');
}   

function saveSeat(){
	window.location.href="${pageContext.request.contextPath}/FilmHall/saveSeat?film_hall_id=${film_hall_id}&str=" + map;
}    
</script>
 <!-- start:根据后台传回的值，处理座位保存的结果 -->
 <%
	if((String)session.getAttribute("data") == "update_success"){
 %>
 	<script type="text/javascript">
 		alert("保存成功！返回设置影厅页面...");
 	</script>
 <%session.removeAttribute("data");%>
 <!-- 延迟1秒后，跳转回film_hall页面 -->
  	<script type="text/javascript">
 		var myDelay = setTimeout(function(){
 			window.location.href="${pageContext.request.contextPath}/FilmHall/showFilmHall";
 		},1000);
 	</script>
 <%} %>
 <!--end:根据后台传回的值，处理座位保存的结果 -->   
</body>
</html>
