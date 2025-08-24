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
		<title>회원탈퇴</title>
		<script type="text/javascript">
		$(document).ready(function(){
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
					data : $("#delForm").serializeArray(),
					
					success: function(data){
						
						if(data.result == 0){
							alert("패스워드가 틀렸습니다.");
							return;
						}else{
							if(confirm("회원탈퇴하시겠습니까?")){
							$("#delForm").submit();
								
							}
							
						}
					}
				})
					
			 });
			
		 })
		</script>
	
	</head>
	
	<body>
		<div>
			<form method="post" id="delForm" action="/home/memberDelete" >
				<div>
					<label for="userId">아이디</label>
					<input type="text" id="userId" name="userId" value="${member.userId}" readonly="readonly"/>
				</div>
				<div>
					<label for="userPass">패스워드</label>
					<input type="password" id="userPass" name="userPass" />
				</div>
				<div>
					<label for="userName">성명</label>
					<input type="text" id="userName" name="userName" value="${member.userName}" readonly="readonly"/>
				</div>
				<div>
					<button type="submit" id="leave">회원탈퇴</button>
					<button type="button" id="cancel" >취소</button>
				</div>
			</form>
			<div>
				<c:if test="${msg == false}">
					<p>비밀번호가 맞지 않습니다.</p>
				</c:if>
			</div>
		</div>
		
	</body>
	
</html>