<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>dropdown</title>
<style>
	/* id ���� nav�� �±��� ul�� display�� none���� �Ѵ�*/
	#nav ul{
		display: none;
	}
	
	/* id���� nav�� �±��� li�� ���콺�� �ö������ ul�±׸� display : block���� �Ѵ� block���� �����ش���*/
	#nav li:hover ul{
		display: block;
	}
 	/* ������� ���콺 ������ ��� �� ��Ӵٿ� css */
												
</style>
</head>
<body>

	<div> 
	<h1>css�� html�� �̿��� ���콺 �ø��� ��Ӵٿ�</h1>
		<ul id="nav">
			<li><a href="#">���� �޴�1</a>
				<ul>
					<li><a href = "#">���� �޴� 1</a></li>
					<li><a href = "#">���� �޴� 2</a></li>
				</ul>
			</li>
			<li><a href="#">���� �޴�2</a>
				<ul>
					<li><a href = "#">���� �޴� 1</a></li>
					<li><a href = "#">���� �޴� 2</a></li>
				</ul>
			</li>
		</ul>
	</div>
		
</body>
	
</html>