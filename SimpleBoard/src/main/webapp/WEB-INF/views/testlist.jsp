<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1> 테스트</h1>			
		
		<table>
			<tr>
			  <td>111</td><td>222</td><td>333</td>
			</tr>
				
			<!-- var=test를 명칭으로 하위에서  list값에 담긴것 만큼 위에서부터 차례대로 뿌려줌-->
			<c:forEach var="test" items="${list}">
					<!--  c:out value 로 써줘야 더좋음  보다 그냥 이거쓰셈 -->
					<td><c:out value="${test}"/></td>
				    
			</c:forEach>
										
		</table>
		
			<!-- 페이징버튼 예시 [이전]  1 2 3 4 [이후] 우선 요렇게만 하자-->
			<ul>
				<c:if test="${pageMaker.prev}">
				<li></li>	
				</c:if>
			</ul>	
			
	</div>
</body>
</html>