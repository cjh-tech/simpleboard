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
	 	<title>게시판</title>
	</head>
	<script type="text/javascript">
	
	
	function fn_valiChk(){
			var updateForm = $("form[name='writeForm'] .chk").length;
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
			
					
			<section id="container">
				<form role="form" name="writeForm" method="post" action="/home/insert">
					<div class="form-group">							
						<label for="title" class="col-sm-2 control-label" >제목</label>
						<input type="text" id="title" name="title" class="chk" title="제목을 입력하세요." />
					</div>		
					<div class="form-group">							
						<label for="content" class="col-sm-2 control-label" >내용</label>
						<textarea id="content" name="content" class="chk" title="내용을 입력하세요."></textarea>
					</div>		
					<div class="form-group">							
						<label for="writer" class="col-sm-2 control-label" >작성자</label>
						<input type="text" id="writer" name="writer" class="chk" value="${userid}" readonly="readonly" />
					</div>						
						<button class="write_btn btn btn-success" type="submit" >작성</button>
						<input type="button" value="뒤로가기"  class="list_btn btn-primary" onclick="history.back(-1);">
				 </form>
				 		
			</section>
			
		</div>
	</body>
</html>