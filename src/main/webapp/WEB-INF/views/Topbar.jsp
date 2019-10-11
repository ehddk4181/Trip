<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="navbar navbar-default" style="background-color: #F1E0D9; ">
 		<div class="container-fluid">
 			<div class="navbar-header">
 				
 				<a class="navbar-brand"  style="color: #050505;" href="/guide/">TripRun</a>
 				<div class="align_right">
 				<c:if test="${sessionScope.memberId==null}">
 				<a class="navbar-brand" style="color: #050505;" href="/guide/member/loginForm">ログイン</a>
 				</c:if>
 				<c:if test="${sessionScope.memberId!=null}">
 				<a class="navbar-brand" style="color: #050505;" href="/guide/member/logout">ログアウト</a>
 				</c:if>
 				<a class="navbar-brand" style="color: #050505;" href="/guide/board/boardList">掲示板</a>
 				<c:if test="${sessionScope.memberId!=null}">
 				<a class="navbar-brand" style="color: #050505;" href="/guide/member/myPage">登録情報</a>
 				</c:if>
 				</div>

 			</div>
 			
 		
 </div>
 
 
</nav>

</body>
</html>