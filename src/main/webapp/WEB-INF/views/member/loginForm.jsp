<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <head>
 	<meta charset="UTF-8">
 	<meta name="viewport" content="width=divice-width",intial-scale="1">
 	<title>トリプラン</title> 	
 	<link rel="stylesheet" href="/guide/resources/css/bootstrap.css">
  <link rel="stylesheet" href="/guide/resources/css/codingBooster.css">
<title>로그인</title>
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(function(){
		$("#btn0").on('click', function(){
			location.href = "/guide/"
		})
		$("#btn4").on("click", function(){
			if($('#memberId').val().length<5||$('#memberId').val().length>20){
				alert("IDは５～２０文字に入力してください。")
				return false;
			}
			if($('#memberPassword').val().length<8||$('#memberPassword').val().length>20){
				alert("パスワードは８～２０文字に入力してください。")
				return false;
			}
			$.ajax({
				url:"/guide/member/login",
				type:"post",
				data:{"memberId":$("#memberId").val(),"memberPassword":$("#memberPassword").val()},
				success:function(result){
					
					if(result){
						location.href="/guide/";
					}else{
						alert("IDまたはパスワードを確認してください。")
					}
				}
			})
		})
	})
</script>
 	<style type="text/css">
 		.btn-login{
 			background: #DE6262; color:#fff; font-weight:600;
 		}
 		
 		</style>
</head>
<body>
<!-- <div>
	<form action="/guide/member/login" method="post" id="login">
	아이디 입력:<input type="text" id="memberId" name="memberId" placeholder="아이디" ><br>
	비밀번호 입력:<input type="password" id="memberPassword" name="memberPassword" placeholder="비밀번호" ><br>
	</form>
	<a href="/guide/member/idfindForm"><input type="button" id="btn0" value="아이디/비밀번호 찾기"></a>
	<a href="/guide/member/signupForm"><input type="button" id="btn3" value="회원 가입"></a>
	<input type="button" id="btn4" value="로그인" >
	<div>
	
	</div> -->
 	
 <jsp:include page="/WEB-INF/views/Topbar.jsp"/>
 
 

    <div class="middle" style="width: 1200px; height: 550px; margin-top:50px; display: inline-flex; margin-right: 100px;">
	
		<div class="col-md-4 login-sec"  style="width: 600px; height: 250px; margin-left: 150px; margin-top: 100px;">
		    <h2 class="text-center">ログイン</h2>
		    
	<form id="login" class="login-form">
	
		    
		    
		    
  <div class="form-group">
    <label for="exampleInputEmail1" class="text-uppercase">アイディー</label>
    <input type="text" id="memberId" name="memberId" placeholder="" class="form-control">
  </div>
  
    <label for="exampleInputPassword1" class="text-uppercase">パスワード</label>
    <input type="password" id="memberPassword" name="memberPassword" placeholder="" class="form-control">
      <br> <br>
      <a href="/guide/member/signupForm">
    <button type="button" class="btn btn-login float-left" id="btn3">登録</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
    <button type="button" class="btn btn-login float-right" id="btn4">ログイン</button>
    <button type="button" class="btn btn-login float-center" id="btn0">ホーム</button>
      
</form>
  </div>
  <img src="/guide/resources/images/ryokou3.jpg" style="width: 1000px; height: 400px; margin-left: 50px; margin-right: 50px; margin-top: 50px;">


  
  </div>
 <jsp:include page="/WEB-INF/views/BottomBar.jsp"/>

	

</body>
</html>