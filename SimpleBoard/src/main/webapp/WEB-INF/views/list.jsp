<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	
	 	<title>게시판</title>
	 	
	 	<!-- 부트스트랩 CSS -->
	 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	 	<!--  부트스트랩 테마 -->
	 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	<!--  JQUERY 설정 -->
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	
	 	<!--  css 일부 설정  -->
	 	<style type ="text/css">
	 		li {list-style: none; float: left; }
	 	</style>
	 	
	 	<script type="text/javascript">
	 	$(document).ready(function(){
					   
	 	  $('#searchBtn').click(function() {
		    		self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
		   });  // 제이쿼리 안에 자바스크립트 사용했는데 가능  이 부분은 검색버튼과 연관되어 있음 
		   
		  $('#writeBtn').click(function(){
			        var tmp = $('#log').text(); 
			        if(tmp=='로그아웃'){
			        	location.href="/home/writeView" 
			        }else{
			        	alert("로그인하셔야 합니다");
			        }
			      			  		
		  });
		          
		});
 
	    </script>
	</head>
	
	
	<body>
		<div class="container">
			<div class="navbar-header">
	          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
	            <span class="sr-only">Toggle navigation</span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	          </button>
       		   <a class="navbar-brand" href="#">SimpleBoard</a>
	        </div>
	        <div id="navbar" class="navbar-collapse collapse">
	          <ul class="nav navbar-nav">
	            <li><a href="/home/api">API사용</a></li>
           		<li><a href="/home/list">게시판</a></li>
          	    <li><a href="/home/main">ReadMe</a></li>
	          </ul>
	          <ul class="nav navbar-nav navbar-right">
	            <c:if test="${member != null}"> <!-- member는 세션에 있는것을 가져오는듯함 !! -->
				<li>${member.userId}님 안녕하세요.</li>
				<li><a href="/home/logout" id="log">로그아웃</a></li>
				</c:if>
				<c:if test="${member == null}">
					<li><a href="/home/login" id="log">로그인</a></li>
				</c:if>
				<c:if test="${member != null}">
					<li class="active"><a href="/home/memberUpdateView">마이페이지</a></li>
				</c:if>
				<c:if test="${member == null}">
					 <li class="active"><a href="/home/register">회원가입</a></li>
				</c:if>
	          </ul>
	        </div><!--/.nav-collapse -->
			
			<div style="position:relative; left:15px" >
				<button id="writeBtn" type="button" class="btn">글작성</button>
			</div>
			   <div style="position:relative; top:10px">			
				
				<form role="form" method="get" >
					<table class="table table-hover">
						<tr><th>번호</th><th>제목</th><th>작성자</th><th>등록일</th>
						
						</tr>
						<!-- 홈 컨트롤러에서 보내줌   -->
						<c:forEach items="${list}" var = "list"> <!--  -->
							<tr>
								<td><c:out value="${list.bno}" /></td>
								<td>
									<a href="/home/readView?bno=${list.bno}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}">
									<c:out value="${list.title}" />          <!--scri넘겨준것에서 list안의 데이터를 꺼내서 씀 페이지부분-->
									</a>
								</td>
								<td><c:out value="${list.writer}" /></td>
								<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
					</table>
				
				<!-- 검색부분  -->
					<div class="search row">
					    <div class="col-xs-2 col-sm-2">
					    <select name="searchType" class="form-control">
					      <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
					      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
					      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
					      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
					      <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
					    </select>                           <!--  selected는 미리 선택되는것  value에서의 값이 scri의 searchType에 -->                            
						</div>
					   <div class="col-xs-10 col-sm-10">
					    	<div class="input=group">
					    		<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
								<span class="input-group-btn">
					 				<button id="searchBtn" type="button" class="btn bttn-default">검색</button>
					    		</span>
					    	</div>
					    </div>
				   </div>
					
				<!-- 단순히 데이터를 띄우는것과 다름  -->
				<!-- 페이징버튼 부분  -->
				<h3></h3>
				<div class="col-md-offset-3">
				  <ul class="pagination">   
				    <c:if test="${pageMaker.prev}">  <!--  pageMaker.prev 가 true냐 false냐에 따라 생김 -->	
				    	<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
				    </c:if>	 <!-- pageMaker의 makeSearch()라는 함수를 이용해서 이전 버튼을 만듦 -->
																				      
				    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">  <!-- var 부분은 뭘까? -->
				    	<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : '' }"/> >
				    	<!--  pageMaker.cri.page의 값이 idx와 같다면 li안에 class=info라는 것을 넣어줘서 디자인 꾸며주는듯함 -->
				    	<a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
				    </c:forEach>
				
				    <c:if test="${pageMaker.next && pageMaker.endPage > 0}"> <!-- 페이지메이커 클래스에서 next가 있고 페이지메이커에서 endPage가 0보다 크면 -->
				    	<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
				    </c:if> 
				  </ul>
				</div>
				</form>
				
			<hr/>
			</div>
		</div>
	</body>
</html>