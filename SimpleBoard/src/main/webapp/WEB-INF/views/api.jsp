<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="java.util.*" %>
<% LinkedList<String> movienamelist = (LinkedList<String>)request.getAttribute("moviename");	%>
<% LinkedList<String> movieaudilist = (LinkedList<String>)request.getAttribute("movieaudi");	%>
<% LinkedList<String> coronadeathlist = (LinkedList<String>)request.getAttribute("coronadeath");	%>
<% LinkedList<String> coronadatelist = (LinkedList<String>)request.getAttribute("coronadate");	%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
<title>SimpleBoardPortFolio</title>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <!-- Jquery 동적인 움직임을 위해 필요함? -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!--  chart.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
</head>

	<body>
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">SimpleBoard</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="/home/api">API사용</a></li>
            <li><a href="/home/list">게시판</a></li>
          	<li><a href="/home/main">ReadMe</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <c:if test="${member != null}">
				<li>${member.userId}님 안녕하세요.</li>
				<li><a href="/home/logout">로그아웃</a></li>
			</c:if>
			<c:if test="${member == null}">
				<li><a href="/home/login">로그인</a></li>
			</c:if>
			<c:if test="${member != null}">
				<li class="active"><a href="/home/memberUpdateView">마이페이지</a></li>
			</c:if>
			<c:if test="${member == null}">
				 <li class="active"><a href="/home/register">회원가입</a></li>
			</c:if>
          </ul>
        </div><!--/.nav-collapse -->
       <div>
       </div>

      <!-- 박스 소개글 -->
	      <div>
	      	<p style="position:relative; left:25px">영화 OpenApi(JSON)방식 </p>
	        <p style="position:relative; left:25px">지난주 기준</p>
	           	<div style="width:1200px">
	        		<canvas id="barChart"></canvas>
				</div>
	      </div>
	      <div style="position:relative; top:25px">
	        <p style="position:relative; left:25px">코로나 OpenApi(XML)방식 </p>
	        <p style="position:relative; left:25px">최근 일주일 기준</p> 
		       <div style="width:1200px">
		        	<canvas id="lineChart"></canvas>
		       </div>
	      </div>
         
      </div>
</body>
	<script>
		// 우선 컨텍스트를 가져옵니다. 
		var ctx = document.getElementById("barChart").getContext('2d');
		/*
		- Chart를 생성하면서, 
		- ctx를 첫번째 argument로 넘겨주고, 
		- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
		*/
		var myChart = new Chart(ctx, {
		    type: 'bar',
		    data: {
		        labels: ["<%=movienamelist.get(0)%>", "<%=movienamelist.get(1)%>", "<%=movienamelist.get(2)%>", "<%=movienamelist.get(3)%>", "<%=movienamelist.get(4)%>", "<%=movienamelist.get(5)%>"],
		        datasets: [{
		            label: '누적관객수',
		            data: [<%=movieaudilist.get(0)%>, <%=movieaudilist.get(1)%>, <%=movieaudilist.get(2)%>, <%=movieaudilist.get(3)%>, <%=movieaudilist.get(4)%>, <%=movieaudilist.get(5)%>],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255,99,132,1)',
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)',
		                'rgba(153, 102, 255, 1)',
		                'rgba(255, 159, 64, 1)'
		            ],
		            borderWidth: 1
		        }]
		    },
		    options: {
		        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero:true
		                }
		            }]
		        }
		    }
		});
		
				
		var ctx = document.getElementById('lineChart').getContext('2d'); var chart = new Chart(ctx, {
			// 챠트 종류를 선택 
			type: 'line', 
			// 챠트를 그릴 데이타 
			data: { 
				labels: ['<%=coronadatelist.get(6)%>', '<%=coronadatelist.get(5)%>', '<%=coronadatelist.get(4)%>', '<%=coronadatelist.get(3)%>', '<%=coronadatelist.get(2)%>', '<%=coronadatelist.get(1)%>', '<%=coronadatelist.get(0)%>'], 
				datasets: [{ 
					label: '코로나 사망자수', 
					backgroundColor: 'transparent', 
					borderColor: 'orange', 
					data: [<%=coronadeathlist.get(6)%>, <%=coronadeathlist.get(5)%>, <%=coronadeathlist.get(4)%>, <%=coronadeathlist.get(3)%>, <%=coronadeathlist.get(2)%>, <%=coronadeathlist.get(1)%>, <%=coronadeathlist.get(0)%>] }] }, // 옵션 
					options: {} 
			});

			
		
	</script>

</html>