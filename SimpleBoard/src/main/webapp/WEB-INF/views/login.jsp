<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>SimpleBoardPortFolio</title>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
 	<!-- jquery -->
 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>  	
  
	<!--  css update -->
	<link href="resources/css/update.css?after" rel="stylesheet" type="text/css">
	<link href="resources/css/loginjoin.css?after" rel="stylesheet" type="text/css">
	  	
	<script type="text/javascript">
		$(document).ready(function(){
			
			$("#logoutBtn").on("click", function(){
				location.href="/home/logout";
			})
			
			$("#cancelBtn").on("click", function(){
				location.href="/home/api";
			})
			
			$("#memberUpdateBtn").on("click", function(){
				location.href="/home/memberUpdateView";
			})
		})
	</script>  	
  	
</head>

<body>
  	   <div class ="fixed">
         <div>
          <a class="title" href="#">SimpleBoard</a>
        
          <ul class="navigation1">
            <li class="menu"><a href="/home/api">API사용</a></li>
            <li class="menu"><a href="/home/list">게시판</a></li>
          	<li class="menu"><a href="/home/main">ReadMe</a></li>
          </ul>
          
          <ul class="lognavigation">
          	<c:if test="${member != null}">	
          		<li class="menu">${member.userId}님</li>
          	</c:if>
          </ul>
          <ul class="navigation2">
            <c:if test="${member != null}"> <!-- 세션에 있는것 씀  -->
				<li class="menu"><a href="/home/logout" id="log">로그아웃</a></li>
			</c:if> 
			<c:if test="${member == null}">
				<li class="menu"><a href="/home/login" id="log">로그인</a></li>
			</c:if>
			<c:if test="${member != null}">
				<li class="menu"><a href="/home/memberUpdateView">마이페이지</a></li>
			</c:if>
			<c:if test="${member == null}">
				 <li class="menu"><a href="/home/register">회원가입</a></li>
			</c:if>
          </ul>
          </div>
		 </div>

	   <div class="bodylogin">
		<div class="loginform1">
			<form name='homeForm' method="post" action="/home/login" class="loginform2" id="regForm">
				<c:if test="${member == null}">
					<div class="loginid">
					<h2>Login</h2>
					</div>
					<div class="loginid">
						<label for="userId">아이디</label></br>
						<input type="text" id="userId" name="userId" class="input3" placeholder = "아이디" /></br>
					</div>
					<div class="loginid">
						<label for="userPass"  >패스워드</label></br> 
						<input type="password" id="userPass" name="userPass" class="input3" placeholder = "패스워드"/></br>
					</div>
					<div class="loginid"> 
						<button type="submit" >로그인</button>
						<button id="cancelBtn" type="button">취소</button>
					</div>
				</c:if>
			     
				<c:if test="${msg == false}">
					<div>
					<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
					</div>
				</c:if>
			</form>
		 </div> 
		</div> 	
</body>
</html>