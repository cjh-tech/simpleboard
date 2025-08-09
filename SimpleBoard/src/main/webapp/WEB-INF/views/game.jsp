<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
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
          	<li><a href="/home/game">게임</a></li>
          	<li><a href="/home/main">ReadMe</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <c:if test="${member != null}"> <!-- 세션에 있는것 씀 -->
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
	    <div class="jumbotron">
	        <h1>Read Me</h1>
	        <canvas id="canvas"></canvas>   
	         
        </div>
            <script src="resources/js/main.js"></script>
            
      </div>
</body>
</html>