<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style>
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333;
}


li a, .dropbtn {
    display: inline-block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

li.dropdown {
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left;
}

.show {display:block;}

</style>
</head>
<body>

<ul>
  <li><a class="active" href="#home">Home</a></li>
  <li><a href="#news">News</a></li>
  <li class="dropdown">
    <a href="#" class="dropbtn" onclick="myFunction()">Dropdown</a>
    <div class="dropdown-content" id="myDropdown">
      <a href="#">Link 1</a>
      <a href="#">Link 2</a>
      <a href="#">Link 3</a>
    </div>
  </li>
</ul>

<script>
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction() {
	alert("테스트1"+document.getElementById("myDropdown").classList); // dropdown-content 값을  // classList를 class의 이름을 읽을 수 있습니다.
    document.getElementById("myDropdown").classList.toggle("show");
    alert("테스트2"+document.getElementById("myDropdown").classList);
    // .toggle로 show라는 클래스 명을 붙여주었다 안붙여줬다 하고있음 확인해보면 앎 계속 안보여주고 있다가 보여줬다가 하고있음ㄴ
                                        
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(e) {
	// 아무곳이나 찍으면 나오는 부분	
}
</script>

</body>
</html>