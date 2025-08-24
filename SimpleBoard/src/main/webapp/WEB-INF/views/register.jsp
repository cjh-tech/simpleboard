<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	<!-- jquery -->
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	
	 	<!--  css update -->
		<link href="resources/css/update.css?after" rel="stylesheet" type="text/css">
		<link href="resources/css/loginjoin.css?after" rel="stylesheet" type="text/css">
	 	
		<title>SimpleBoardPortFolio</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			// 취소
			$(".cancel").on("click", function(){
				
				location.href = "/home/api";
						    
			})
		
			$("#submit").on("click", function(){
				if($("#userId").val()==""){
					alert("아이디를 입력해주세요.");
					$("#userId").focus();
					return false;
				}
				if($("#userPass").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPass").focus();
					return false;
				}
				if($("#userName").val()==""){
					alert("성명을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
			});
		})
		
		// ajax 관련
		function fn_idChk(){
			$.ajax({
				url : "/home/idChk",
				type : "post",
				dataType : "json",
				data : {"userId" : $("#userId").val()},
				success : function(data){
					if(data == 1){
						alert("중복된 아이디입니다.");
					}else if(data == 0){
						$("#idChk").attr("value", "Y");
						alert("사용가능한 아이디입니다.");
					}
				}
			})
		}
	</script>
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
		
	 <div class="bodyjoin">
		<div class="joinform1">
			<form action="/home/register" method="post" class="joinform2" id="regForm"  >
				<div class="joinid">
				<h2>Sign up</h2>
				</div>
				<div class ="joinid">
					<label for="userid">아이디</label><br>
					<input type="text" id="userId" name="userId" class="input2">
					<button class="idChk" type="button" id="idChk" onclick="fn_idChk();" value="N">중복확인</button>
				</div>
				<div class ="joinid">
					<label for="userPass">패스워드</label><br/>
					<input type="password" id="userPass" name="userPass" class="input2"/>
				</div>
				<div class ="joinid">
					<label for="userName">성명</label><br/>
					<input type="text" id="userName" name="userName" class="input2"/>
				</div>
				<div>
					<button type="submit" id="submit">회원가입</button>
					<button class="cancel btn btn-danger" type="button">취소</button>
				</div>
			</form>
		</div>
	 </div>	
	</body>
	
</html>