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
		<h1> �׽�Ʈ</h1>			
		
		<table>
			<tr>
			  <td>111</td><td>222</td><td>333</td>
			</tr>
				
			<!-- var=test�� ��Ī���� ��������  list���� ���� ��ŭ ���������� ���ʴ�� �ѷ���-->
			<c:forEach var="test" items="${list}">
					<!--  c:out value �� ����� ������  ���� �׳� �̰ž��� -->
					<td><c:out value="${test}"/></td>
				    
			</c:forEach>
										
		</table>
		
			<!-- ����¡��ư ���� [����]  1 2 3 4 [����] �켱 �䷸�Ը� ����-->
			<ul>
				<c:if test="${pageMaker.prev}">
				<li></li>	
				</c:if>
			</ul>	
			
	</div>
</body>
</html>