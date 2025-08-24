<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<!-- 부트스트랩 css 설정 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부트스트랩 테마 설정 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<!--  css update -->
		<link href="resources/css/update.css?after" rel="stylesheet" type="text/css">
	 	<link href="resources/css/writeview.css?after" rel="stylesheet" type="text/css">
	 	
	 	<title>SimpleBoardPortFolio</title>
	</head>
	<script type="text/javascript">
	
	/*
	function fn_valiChk(){
			var updateForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<updateForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
	*/
	
	function fn_valChk(event){
			var titlecontent = $("#title").val();
			var textcontent	 = $("#content").val();
					
			if(titlecontent == null || titlecontent == "" || textcontent == null || textcontent == ""){
				event.preventDefault();
				alert("제목 내용 확인");
			}
			
	}
	</script>
	
	<body>
	
		<div>
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
            <c:if test="${member != null}"> 
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
			<div class="writebody1">
				<h1 class="boardtext">Board</h1><hr/>
			</div>			
			<div class="writebody2">
				<form role="form" name="writeForm" method="post" action="/home/insert">
					<div class="writebody3">							
						<label for="title" >제목</label>
						<input type="text" id="title" name="title"/>
					</div>		
					<div class="writebody4">							
						<textarea id="content" name="content" class="textcontents"></textarea>
					</div>		
					<div class="writebody5">							
						<label for="writer" >작성자</label>
						<input type="text" id="writer" name="writer" value="${userid}" readonly="readonly" />
					</div>						
						<button type="submit" class="write_btn btn btn-success" onclick="fn_valChk(event)">작성</button>
						<button type="button" class="btn-primary" onclick="history.back(-1);">뒤로가기</button>
				 </form>
			</div>
			
		</div>
	</body>
</html>