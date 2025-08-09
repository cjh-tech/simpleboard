<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
<title>SimpleBoardPortFolio</title>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<!-- Jquery 동적인 움직임을 위해 필요함? -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
   
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
          	<c:if test="${member != null}">
				<li>${member.userId}님 안녕하세요.</li>
				<li><a href="/home/logout">로그아웃</a></li>
			</c:if>
			<c:if test="${member == null}">
				<li><a href="/home/login">로그인</a></li>
			</c:if>
			<c:if test="${member != null}">
				<li class="active"><a href="/home/memberUpdateView">마이페이지</a></li>
			</c:if>
			<c:if test="${member == null}">
				 <li class="active"><a href="/home/register">회원가입</a></li>
			</c:if>
           </ul>
        </div><!--/.nav-collapse -->
     

      <!-- 박스 소개글 -->
      <div class="jumbotron">
        <h1>Read Me</h1>
        <h3>스프링MVC 모델을 이용한 게시판 제작</h3>
        <h3>공공데이터포털의 행정안전부 openapi(XML) 이용</h3>
        <h3>영화진흥위원회의 openapi(JSON) 이용 </h3>
        <hr></hr>
        <h4> HTML CSS JQUERY AJAX SPRING ORACLE 등 여러가지 언어를 사용</h4>
        <h4> 서버배포 제외 프로젝트 기여도 100%</h4>
        <hr></hr>
        <h4> 배운내용을 깃허브에 올려가며 개발자의 역량을 쌓고 있습니다 </h4>
        <a class="btn btn-lg btn-success" href="https://github.com/cjh-tech/simpleboard.git" role="button">GitHub로 이동</a>
        
      </div>
    
       <!-- 소개글  -->	
      <div class="row">
        <div class="col-lg-4">
           <img src ="resources/pictures/htmlcss.png">
        </div>
        <div class="col-lg-4">
           <img src ="resources/pictures/chartjs.png">
        </div>
        <div class="col-lg-4">
           <img src ="resources/pictures/bootstrap.png">
        </div>
     </div>
      
      <div class="row">
      	<div class="col-lg-4">
          <img src ="resources/pictures/jquery.png">
        </div>
         <div class="col-lg-4">
          <img src ="resources/pictures/ajax.png">
        </div>
        <div class="col-lg-4">
           <img src ="resources/pictures/java.png">
        </div>
      </div>
      
      <div class="row">
      	<div class="col-lg-4">
           <img src ="resources/pictures/oracle.png">
        </div>
        <div class="col-lg-4" >
           <img src ="resources/pictures/spring.png">
        </div>
      </div>
      
      <footer class="footer">
       
      </footer>
    </div>
</body>
</html>