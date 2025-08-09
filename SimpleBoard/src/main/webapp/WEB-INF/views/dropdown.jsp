<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>dropdown</title>
<style>
	/* id 값이 nav인 태그의 ul의 display를 none으로 한다*/
	#nav ul{
		display: none;
	}
	
	/* id값이 nav인 태그의 li가 마우스가 올라왔을때 ul태그를 display : block으로 한다 block으로 보여준다임*/
	#nav li:hover ul{
		display: block;
	}
 	/* 여기까지 마우스 가져다 대는 형 드롭다운 css */
												
</style>
</head>
<body>

	<div> 
	<h1>css와 html을 이용한 마우스 올림형 드롭다운</h1>
		<ul id="nav">
			<li><a href="#">메인 메뉴1</a>
				<ul>
					<li><a href = "#">하위 메뉴 1</a></li>
					<li><a href = "#">하위 메뉴 2</a></li>
				</ul>
			</li>
			<li><a href="#">메인 메뉴2</a>
				<ul>
					<li><a href = "#">하위 메뉴 1</a></li>
					<li><a href = "#">하위 메뉴 2</a></li>
				</ul>
			</li>
		</ul>
	</div>
		
</body>
	
</html>