<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Home</title>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
 	<!-- jquery -->
 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>  	
  	
  	<style>
	div.container {
		position:absolute;
		top:25%;
		left:40%;
	}
	</style>
	  	
	<script type="text/javascript">
		$(document).ready(function(){
			
			$("#logoutBtn").on("click", function(){
				location.href="/home/logout";
			})
			
			$("#cancleBtn").on("click", function(){
				location.href="/home/api";
			})
			
			$("#memberUpdateBtn").on("click", function(){
				location.href="/home/memberUpdateView";
			})
		})
	</script>  	
  	
</head>



<body>
	<div class="container">
		<form name='homeForm' method="post" action="/home/login" id="regForm">
			<c:if test="${member == null}">
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">아이디</label></br>
					<input type="text" id="userId" name="userId" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass">패스워드</label></br> 
					<input type="password" id="userPass" name="userPass" />
				</div>
				<div class="form-group has-feedback">
					<button type="submit" class="btn btn-success">로그인</button>
					<button id="cancleBtn" class="btn btn-danger" type="button">취소</button>
				</div>
			</c:if>
		     
			<c:if test="${msg == false}">
				<div>
				<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
				</div>
			</c:if>
		</form>
	</div> 	
</body>
</html>