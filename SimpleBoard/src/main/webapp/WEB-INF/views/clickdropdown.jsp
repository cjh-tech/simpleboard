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
	alert("�׽�Ʈ1"+document.getElementById("myDropdown").classList); // dropdown-content ����  // classList�� class�� �̸��� ���� �� �ֽ��ϴ�.
    document.getElementById("myDropdown").classList.toggle("show");
    alert("�׽�Ʈ2"+document.getElementById("myDropdown").classList);
    // .toggle�� show��� Ŭ���� ���� �ٿ��־��� �Ⱥٿ���� �ϰ����� Ȯ���غ��� �� ��� �Ⱥ����ְ� �ִٰ� ������ٰ� �ϰ�������
                                        
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(e) {
	// �ƹ����̳� ������ ������ �κ�	
}
</script>

</body>
</html>