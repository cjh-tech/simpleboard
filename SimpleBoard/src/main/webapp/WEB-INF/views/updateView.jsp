<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 부트스트랩 css 설정 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부트스트랩 테마 설정 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			// 저장 
			$(".update_btn").on("click", function(){
				
				if(fn_valiChk()){
					return false;
				}
				
				formObj.attr("action", "/home/update");
				formObj.attr("method", "post");
				formObj.submit();				
			})
			
			//취소
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/home/readView?bno=${update.bno}"
					   + "&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}";
			})
		})
		
		
		function fn_valiChk(){
			var updateForm = $("form[name='updateForm'] .chk").length;
			for(var i = 0; i<updateForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
	
	</script>
	<body>
	
		<div class="container">
			<header>
				<h1> 게시판</h1>
			</header>
			<hr />
			 
			<section id="container">
				<form name="updateForm" role="form" >
					<input type="hidden" name="bno" value="${update.bno}" readonly="readonly"/>
					<div class="form-group">							
						<label for="title" class="col-sm-2 control-label">제목</label>
						<input type="text" id="title" name="title" value="${update.title}" class="chk" " title="제목을 입력하세요."/>
					</div>	
					<div class="form-group">							
						<label for="content" class="col-sm-2 control-label">내용</label>
						<textarea id="content" name="content" class="chk" title="내용을 입력하세요."><c:out value="${update.content}" /></textarea>
					</div>	
					<div class="form-group">							
						<label for="writer" class="col-sm-2 control-label">작성자</label>
						<input type="text" id="writer" name="writer" value="${update.writer}" readonly="readonly"/>
					</div>	
					<div class="form-group">							
						<label for="regdate" class="col-sm-2 control-label">작성날짜</label>
						<fmt:formatDate value="${update.regdate}" pattern="yyyy-MM-dd"/>	
					</div>				
					<div>
						<button type="submit" class="update_btn btn btn-warning">저장</button>
						<button type="submit" class="cancel_btn btn btn-danger">취소</button>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>