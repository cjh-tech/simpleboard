<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style type="text/css">
    	lis {list-style: none; display:inline; padding: 6px;}
    </style>
   
<ul>
	<li><a href="/home/list">목록</a></li>
	<li><a href="/home/writeView">글 작성</a></li>
	<li>
		<c:if test="${member != null}">
			<p>${member.userId}님 안녕하세요.</p>
		</c:if>
	</li>
</ul>
