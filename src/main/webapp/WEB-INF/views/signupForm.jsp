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

<title>회원 가입</title>
<style type="text/css">
          .btn-signup{
               background: #DE6262; color:#fff; font-weight:600;
          }
          .txtbox{
               margin-left: 27px;
               margin-top: 20px;
          }
          .main{
               background-image: url(/guide/resources/images/japan.jpg);
               background-size:100%;
     
               width: 100%;
            height: 700px;
            padding-top: 25px;
           background-repeat:no-repeat;
           background-size:auto;

           
          }

     </style>
     
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(function(){
		$("#btn1").on("click",function(){
			location.href="/guide/member/loginForm"
		})
		
		$("#btn2").on("click", function(){
			
			if($("#memberId")[0].value.length > 20 || $("#memberId")[0].value.length < 5){
				alert("아이디는 5~20자로 입력해주세요.")
				return false;
			}
			
			if($("#memberPassword")[0].value.length > 20 || $("#memberPassword")[0].value.length < 8){
				alert("비밀번호는 8~20자로 입력해주세요.")
				return false;
			}
			

				$("#signupForm")[0].submit();
				alert("회원가입이 완료되었습니다.")

		})
	})
function emailcheck(){	
	email();
/* 	emailcheck2(); */
	$("#injeung").empty();
	$.ajax({
		url:"/guide/member/auth",
		type:"post",
		data:{"memberEmail":$("#memberEmail")[0].value},
 		success:function(complete){ 
				$("#injeung").append(
						'<form action="/guide/member/join_injeung1${dice}" method="post" id="checkEmail">'+
						'인증번호 입력 : <input type="text" name="email_injeung" id="injeungText" placeholder="인증번호를 입력하세요."><br>'+
						'</form>'+
						'<a href="/guide/member/signupForm"><input type="button" value="취소"></a>'+
						'<input type="button" onclick="btn7()" value="입력">'
				);
				alert('이메일로 인증번호를 보냈습니다. 잠시만 기다려주세요.');
			}
		})
	}
	

		  
/* 	function emailcheck2(){
			var regExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
 		    if( !$('#memberEmail').val() ){
 		        alert('이메일주소를 입력 해 주세요');
 		        $('#memberEmail').focus();    
 		        return false;
 		    } else if(!regExp.test($('#memberEmail').val()){
 		            alert('이메일 주소가 유효하지 않습니다');
 		            $('#memberEmail').focus();
 		            return false;
 		    }
	}
		 */
			
	function btn7(){
		$("#checkEmail")[0].submit();
	}
	
	function email(){	
		$.ajax({
			url:"/guide/member/checkidEmail",
			type:"get",
			data:{"memberEmail":$("#memberEmail")[0].value},
			success:function(result){
				 if(result === true && $("#memberEmail")[0].value.length > 1){
					alert("존재하는 이메일입니다.")
				}else{
					
				}
			}
			})
		}
	
	function checkId(){	
		$.ajax({
			url:"/guide/member/checkId",
			type:"get",
			data:{"memberId":$("#memberId")[0].value},
			success:function(result){
				if($("#memberId")[0].value.length > 20 || $("#memberId")[0].value.length < 5){
					$("#checkId").text("아이디는 5~20자로 입력해주세요.")
					$("#checkId").css("color", "red")
				}else if(result == false){
					$("#checkId").text("중복된 아이디입니다.")
					$("#checkId").css("color", "red")
				}else{
					$("#checkId").text("사용가능한 아이디입니다.")
					$("#checkId").css("color", "green")
				}
			}
			})
		}
	
</script>
</head>
<body>
 <jsp:include page="/WEB-INF/views/Topbar.jsp"/>
	<div>
	<div>
	<!--header  -->
	</div><!--//header  -->
	
	

	
	<div class="main" >
     <div class="middle1" style="width: 450px; height: 650px; display: block; background-color: #f7f7f7; margin-left: 200px; border-radius: 15px; ">
	<form action="/guide/member/signup" method="post" id="signupForm">
          <input type="text" id="memberId" name="memberId" onchange="checkId()" maxlength="64" tabindex="10" style="width: 402px; height: 47px; "class="txtbox" placeholder="ID">
          <br>
          <div id="checkId" style="height:20px;margin-left:27px;"></div>
          <input type="password" name="memberPassword" id="memberPassword" value="" class="txtbox" placeholder="パスワード" tabindex="30"style="width: 402px; height: 47px;"><br>
          <div id="checkId" style="height:20px;margin-left:27px;"></div>
          <input type="email" id="memberEmail" name="memberEmail"   maxlength="64" class="txtbox" placeholder="メールアドレス" tabindex="10"style="width: 402px; height: 47px;"><br>
          <div id="checkId" style="height:20px;margin-left:27px;"></div>
          <input type="text" id="memberBirth" name="memberBirth" maxlength="10" class="txtbox" placeholder="生年月日" tabindex="60"style="width: 402px; height: 47px;"><br>
          <div id="checkId" style="height:20px;margin-left:27px;"></div>
          <input type="text" id="memberName" name="memberName"  maxlength="16" class="txtbox " placeholder="名前" tabindex="65"style="width: 402px; height: 47px;"><br>
          <div id="checkId" style="height:20px;margin-left:27px;"></div>
          <input type="number" id="memberPhone" name="memberPhone"  maxlength="16" class="txtbox " placeholder="スマホ" tabindex="65"style="width: 402px; height: 47px;">
          <div id="checkId" style="height:20px;margin-left:27px;"></div><br><br><br>
          <div style=" width:450px; "><input type="button" id="btn1" value="나가기" style="width: 150px; height: 47px; margin-left: 30px;" class="btn btn-signup center"><input type="button" name="commit" value="トリプラン登録" tabindex="200"style="width: 150px; height: 47px; margin-left:100px; " class="btn btn-signup center" id="btn2"></div>
	</form>
     
     </div>
     </div>
</div>

     


 
 <jsp:include page="/WEB-INF/views/BottomBar.jsp"/>         
     


</body>
</html>