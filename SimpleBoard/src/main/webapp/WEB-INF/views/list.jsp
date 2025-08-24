<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	
	 	<title>SimpleBoardPortFolio</title>
	 	
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
	 	
	 	<!--  css update -->
		<link href="resources/css/update.css" rel="stylesheet" type="text/css">
	 	
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
		
	   <div style="position:relative; top:100px; width: 50%; margin: 0 auto;">			
		
		  <form role="form" method="get" >
			 <table class="table table-hover">
				<tr>
					<th>번호</th><th>제목</th><th>작성자</th><th>등록일</th>
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
				<div>
				    <div >
				    <select name="searchType"  class="searchOption">
				      <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>---</option>
				      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
				      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
				      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
				      <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
				    </select><!--  selected는 미리 선택되는것  value에서의 값이 scri의 searchType에 -->  
				      <input type="text" name="keyword" class="input" id="keywordInput" value="${scri.keyword}" /> 
				      <button id="searchBtn" type="button" class="search">검색</button>                                                    
					  <button id="writeBtn" type="button" class="write">글작성</button> 	
					</div>
				   
			    </div>
				
				<!-- 단순히 데이터를 띄우는것과 다름  -->
				<!-- 페이징버튼 부분  -->
				<div class="pagebutton">
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
	       </div>
		
	</body>
</html>