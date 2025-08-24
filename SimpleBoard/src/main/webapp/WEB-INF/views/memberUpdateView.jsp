<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<!--  css update -->
		<link href="resources/css/update.css?after" rel="stylesheet" type="text/css">
		<link href="resources/css/loginjoin.css?after" rel="stylesheet" type="text/css">
		
		<title>SimpleBoardPortFolio</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			
			// 폼선택자 관련 변수 설정 
			//var formObj = $("form[name='updateform']");
						
			/*$("#delete").on("click", function(){
				
				formObj.attr("method", "get");	
				location.href = "/home/memberDeleteView";
				
			});
			*/
			
			// 취소
			$("#cancel").on("click", function(){
				
				location.href = "/home/main";
						    
			});
			
			
			
			// 회원탈퇴버튼
			$("#leave").on("click", function(){
				if($("#userPass").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPass").focus();
					return false;
				}	
				$.ajax({
					url : "/home/passChk",
					type : "POST",
					dataType : "json",
					data : $("#formdata").serializeArray(),
					
					success: function(data){
						
						if(data.result == 0){
							alert("패스워드가 틀렸습니다.");
							return;
						}else{
							if(confirm("회원탈퇴하시겠습니까?")){
							$("#formdata").attr("action","/home/memberDelete");
							$("#formdata").submit();
								
							}
							
						}
					}
				})
					
			 });
			
			
			$("#submit").on("click", function(){
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
			
				
			
		});
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
				
		<div class=bodyupdate>
			<div class="updateform1">
			<form action="/home/memberUpdate" method="post" class ="updateform2" name="updateform" id="formdata">
				<div class="updatemember">
					<label for="userId">아이디</label>
					<input type="text" id="userId" name="userId" class="input3" value="${member.userId}" readonly="readonly"/>
				</div>
				<div class="updatemember">
					<label for="userPass">패스워드</label>
					<input type="password" id="userPass" class="input3" name="userPass" />
				</div>
				<div class="updatemember">
					<label for="userName">성명</label>
					<input type="text" id="userName" class="input3" name="userName" value="${member.userName}"/>
				</div>
			
					<button type="submit" id="update" class="button1">회원정보수정</button>
					<button type="button" id="cancel" class="button2">취소</button>
					<button type="button" id="leave" class="button3" >회원탈퇴</button>
				
			</form>
		    </div>
		</div>
	</body>
	
</html>