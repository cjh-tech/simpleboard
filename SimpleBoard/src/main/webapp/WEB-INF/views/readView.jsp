<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 부트스트랩 css 설정 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부트스트랩 테마 설정 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<!-- JQUERY 설정 -->
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		
		<!--  css update -->
		<link href="resources/css/update.css?after" rel="stylesheet" type="text/css">
		<link href="resources/css/loginjoin.css?after" rel="stylesheet" type="text/css">
		<link href="resources/css/readview.css?after" rel="stylesheet" type="text/css">
	 	<title>SimpleBoardPortFolio</title>
	</head>
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			
			var formObj = $("form[name='readForm']");
			// 제이쿼리 선택자    name값이 readForm인 form태그 객체를 담음 
			
			// 게시글 수정 
			$("#update_btn").on("click", function(){
				var userid1 = $("#userid").text();
				var userid2 = $("#writer").val();
				
				if(userid1 == userid2){
					formObj.attr("action", "/home/updateView");
					formObj.attr("method", "get"); //.attr("속성 " , "대체하는 속성값")
					formObj.submit();	// form태그의 버튼 submit 태그처럼 서버전송 하는듯함
				}else{
					alert("아이디가 동일한 사람만 가능합니다");
				}
							
			});
			
			// 게시글 삭제
			$("#delete_btn").on("click", function(){
				var userid1 = $("#userid").text();
				var userid2 = $("#writer").val();
				
				if(userid1 == userid2){
					var check = confirm("글을 삭제하시겠습니까?")
					if(check == true){
						formObj.attr("action", "/home/delete");
						formObj.attr("method", "post");
						formObj.submit();
					}
					
				}else{
					alert("아이디가 동일한 사람만 가능합니다");
				}
			});
			
			
			// 취소 목록 
			$("#list_btn").on("click", function(){
				
				location.href = "/home/list";
			});
		
			
			// 목록
			$("#list_btn").on("click", function(){
				
				location.href = "/home/list?page=${scri.page}"
				+"&perPageNum=${scri.perPageNum}"
				+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
			});
						
			//댓글 수정 버튼
			/*$("#replyUpdateBtn").on("click", function(){
				
				var userid1 = $("#userid").text();
				var userid2 = $("#replyWriter").text();
								
				
				if(userid1 == userid2){
 					location.href = "/home/replyUpdateView?bno=${read.bno}"
						+ "&page=${scri.page}"
						+ "&perPageNum=${scri.perPageNum}"
						+ "&searchType=${scri.searchType}"
						+ "&keyword=${scri.keyword}"
						+ "&rno="+$(this).attr("data-rno");
 				}else {
 					alert("작성자만 수정하실 수 있습니다");
 				}
				
			});*/
					
			//댓글 수정 버튼
			$("#replyUpdateBtn").on("click", function(){
				
				var userid1 = $("#userid").text();
				var userid2 = $("#replyWriter").text();
												
				if(userid1 == userid2){
 					alert("수정 하시겠습니까?")
 				}else {
 					alert("작성자만 수정하실 수 있습니다");
 					return false;
 				}
				
			});
			
						
			//댓글 삭제 버튼
			$("#replyDeleteBtn").on("click", function(){
				
			    var form = $("#replyform");
			    form.attr("action", "/home/replyDelete");
			    
				var userid1 = $("#userid").text();
				var userid2 = $("#replyWriter").text();
				 
								
				if(userid1 == userid2){
					alert("삭제 하시겠습니까?")
					form.submit();
				}else{
					alert("작성자만 삭제하실 수 있습니다");	
					return false;
				}
					
			});
			
			
			// 새댓글 작성
			$("#replyWriteBtn").on("click", function(){
				  var userid =  $("#replywriter").val();
				 
				  if(userid != "로그인시 작성가능"){
					  var formObj = $("form[name='replyForm']");
					  formObj.attr("action", "/home/replyWrite");
					  formObj.submit();
				  }else{
					  alert("로그인시 작성가능합니다");
				  }
							  
			});
		
		});
		
		
	</script>
	
	<body>
	   <div class="container">
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
			
		<!-- 작성된 게시글 -->			
		
			<form name="readForm" role="form" method="post">
				<p id="userid" style="display:none">${userid}</p>
				<input type="hidden" id="bno" name="bno" value="${read.bno}" />
				<input type="hidden" id="page" name="page" value="${scri.page}"> 
			    <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
			    <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
			    <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
		    </form>
			<div class="readbody1">
				<h1 class="boardtext">Board</h1><hr/>
			</div>
			<div class="readbody2">							
				<label for="title" class="titlename">제목</label>
				<input type="text" id="title" name="title"  class ="title1" value="${read.title}" readonly="readonly" />
			</div>			
			<div class="readbody3">
				<textarea id="content" name="content" class="contentarea" readonly="readonly"><c:out value="${read.content}" /></textarea>
			</div>			
			<div class="readbody4">
				<label for="writer" class="writername">작성자</label>
				<input type="text" id="writer" name="writer" class="writer" value="${read.writer}"  readonly="readonly"/>
			</div>		
			<div class="readbody5">
				<label class="regdate" >작성날짜</label>
				<span><fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd"/></span>		
			</div>			
				
			<div class="readbody6">
				<button type="submit" id="update_btn" class="update_btn btn btn-warning">수정</button>
				<button type="submit" id="delete_btn" class="delete_btn btn btn-danger">삭제</button>
				<button type="submit" id="list_btn" class="list_btn btn-primary">목록</button>	
			</div>
			
				
				
			<!-- 댓글 -->
			
			
			
			<div id="reply"  class="replybody1">
			  
			    <c:forEach items="${replyList}" var="replyList">
			     <form action="/home/replyUpdate" id="replyform" method="post" >
			      <ol class="replyList">
			      <li>
			        <p><span> 작성자 :</span>  <span id="replyWriter" class="writer">${replyList.writer}</span></p>
			        <p>작성 날짜 :  <fmt:formatDate  value="${replyList.regdate}" pattern="yyyy-MM-dd" /> </p>
			        			
			        <p><input type="text" id="getcontent" name="getcontent" class ="inputcontent" value="${replyList.content}"/></p>
			           <input type="hidden" id="getrno" name="rno" value="${replyList.rno}">
			           <input type="hidden" id="getbno" name="bno" value="${read.bno}">
			           
			        <div>
					  <button type="submit" id="replyUpdateBtn" class="replyUpdateBtn btn btn-warning" data-rno="${replyList.rno}">수정</button>
					  <button type="submit" id="replyDeleteBtn" class="replyDeleteBtn btn btn-danger" data-rno="${replyList.rno}">삭제</button>
					</div>
			      </li>
			      </ol>
			     </form>
			   </c:forEach>   
			  
			</div>
				
			<!-- 댓글 작성칸 -->	
		  <div class= "replybody2">		
			<form name="replyForm" method="post" class="form-horizontal">
			  <input type="hidden" id="bno" name="bno" value="${read.bno}" />
			  <input type="hidden" id="page" name="page" value="${scri.page}"> 
			  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
			  <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
			  <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
			  
			  <div class="form-group" style="position:relative; left:30px">
			      	<div>
			    		<label for="writer" >댓글 작성자</label>
			    		<c:if test="${userid != null}">
			    			<input type="text" id="replywriter" name="writer" value="${userid}" readonly="readonly" />
			    		</c:if>
			    		<c:if test="${userid == null}">
			    			<input type="text" id="replywriter" name="writer" value="로그인시 작성가능" readonly="readonly" />
			    		</c:if>
			    		
			   		</div>
			  </div>
			  
			  <div class="form-group" style="position:relative; left:30px">
			  	 <div>	
			  	 	<label for="content">댓글 내용</label>
			  	 		<c:if test="${userid != null}">
			    			<input type="text" id="replycontent" name="content"/>
			    		</c:if>
			    		<c:if test="${userid == null}">
			    			<input type="text" id="replycontent" name="content" value="로그인시 작성가능" readonly="readonly"/>
			    		</c:if>
			   	 </div>
			  </div>
			  
			   
			  <div class="form-group" >
			 	 <div class="col-sm-offset-2 col-sm-10">
			 	 	<button type="button" id ="replyWriteBtn" class="replyWriteBtn btn btn-success">댓글 작성</button>
			     </div>		
			  </div>
			</form>
		   </div>
		</div>
	</body>
</html>