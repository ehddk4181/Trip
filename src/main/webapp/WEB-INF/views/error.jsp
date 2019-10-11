<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
 	<link rel="stylesheet" href="/guide/resources/css/bootstrap.css">
  <link rel="stylesheet" href="/guide/resources/css/codingBooster.css">
<script>
$(function(){
	$("#home").on('click',function(){
		location.href = "/guide/"
	})
})
</script>
<style type="text/css">
.errText{
	text-align: center;
	font-size:35px;
	color:#f274a9;
	margin-top:200px;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1 style="text-align: center;font-size:60px;color:#bd3970;margin-top:50px;">TripRun</h1>
	<div class="errText">
	<b style="font-size:40px;"">すみません！</b>　間違った経路です！<br>
	
	<div style="color:black;font-size:35px;">ホームページに帰ってください！</div>
	<button id="home" style="margin-top:50px; border-style:none; background-color:#f75297; border-radius:20px; color:white;">ホームページへ</button>
	</div>
</body>
</html>