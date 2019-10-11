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
               background-image: url(/guide/resources/images/huzisan.jpg);
               background-position: center;
  				background-repeat: no-repeat;
  				background-size: 100% auto;
     
           display: inline-flex;    
            width:100%;
            height:720px;
            padding-top: 25px;

           
          }
          .ss{
          width:100%;
            height:100%;
          }
          .text{
          width: 400px;
          height: 200px;
          font-size: 70px;
          
          color: white;
          }
          .youkoso{
            width: 480px;
          height: 200px;
          font-size: 70px;
          margin-top: 60px;
          margin-left: 180px;
          color: white;
          font-weight: 10px;
          }

     </style>
     
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(function(){
		$("#btn1").on("click",function(){
			location.href="/guide/member/loginForm"
		})
		
		$("#btn2").on("click", function(){
			var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/; //이메일 체크 정규식
			var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
			var userIdCheck = /^[A-Za-z0-9_\-]{5,20}$/; //아이디 체크 정규식 영어 대 소문자 숫자만 사용가능
			var birthdayCheck = /^(19|20)[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/; // 생년월일 정규식 1900/2000대 부터 가능
																							  // ex) 19930329
			var birthdayCheck2 = RegExp(/^[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/); // ex) 930329
			var phoneNumberCheck = /^01[0][0-9]{7,8}$/; // 핸드폰 번호 정규식 010부터시작 7~8자리까지
			
			if($("#memberId")[0].value.length > 20 || $("#memberId")[0].value.length < 5){
				$("#checkId").text("5～20文字に入力してください。")
				$("#checkId").css("color", "red")
				$("#memberId").focus();
				return false;
			} 
			if(!userIdCheck.test($("#memberId").val())){ // 영문 대 소문자 숫자를 입력 안할 시 발생
				$("#checkId").text("英文の大文字、小文字、数字の組み合わせだけで入力してください。")
				$("#checkId").css("color", "red")
				$("#memberId").focus();
				return false; 
			}
            if($("#memberId").val() == $("#memberPassword").val()){ // 아이디와 비밀번호가 같을 때 발생
				$("#checkId").text("IDとパスワードが同じです。")
				$("#checkId").css("color", "red")
				$("#memberId").focus();
                return false;
            }
			

			if($("#memberPassword")[0].value.length > 20 || $("#memberPassword")[0].value.length < 8){ //8~20자리까지 입력 안할 시 발생
				$("#checkPw").text("パスワードは８～２０文字に入力してください。")
				$("#checkPw").css("color", "red")
				$("#memberPassword").focus();
				return false;
			}
			if( !$('#memberEmail').val() ){ //공백일 때 발생
				$("#checkEmail").text("メールアドレスを入力してください。")
				$("#checkEmail").css("color", "red")
 		        $('#memberEmail').focus();    
 		        return false;
 		    }  

			if(!regExp.test($('#memberEmail').val())){ //이메일 주소 형식이 올바르지 않을 때 발생
				$("#checkEmail").text("メールアドレスが正しくありません。")
				$("#checkEmail").css("color", "red")
 		        $('#memberEmail').focus();
 		        return false;
 		    }
			if( !$('#memberBirth').val() ){ //공백일 때 발생
				$("#checkBirth").text("空白が含めています。")
				$("#checkBirth").css("color", "red")
 		        $('#memberBirth').focus();    
 		        return false;
 		    }  
			if(!(birthdayCheck.test($("#memberBirth").val())||birthdayCheck2.test($("#memberBirth").val()))){ //생년월일 형식이 올바르지 않을 때 발생
				$("#checkBirth").text("生年月日を確認してください。")
				$("#checkBirth").css("color", "red")
				$("#memberBirth").focus();
				return false; 
			}
			
			if( !$('#memberName').val() ){ // 이름칸이 공백일 때 발생
				$("#checkName").text("名前を確認してください。")
				$("#checkName").css("color", "red")
 		        $('#memberName').focus();    
 		        return false;
 		    }  
			
			if( !$('#memberPhone').val() ){ //핸드폰 칸이 공백일 때 발생
				$("#checkPhone").text("携帯電話を確認してください。")
				$("#checkPhone").css("color", "red")
 		        $('#memberPhone').focus();    
 		        return false;
 		    }  
			if(!phoneNumberCheck.test($("#memberPhone").val())){ //형식이 올바르지 않을 때 발생
				$("#checkPhone").text("携帯電話を確認してください。")
				$("#checkPhone").css("color", "red")
				 $("#memberPhone").focus();
				return false; 
				}

				$("#signupForm")[0].submit(); // 회원가입 액션태그 서브밋
				alert("登録しました。")

		})
	})

	

		  
			
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
				var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);
				if($("#memberId")[0].value.length > 20 || $("#memberId")[0].value.length < 5){
					$("#memberId").val("");
					$("#memberId").focus();
					$("#checkId").text("5～20文字に入力してください。")
					$("#checkId").css("color", "red")
				}else if(!userIdCheck.test($("#memberId").val())){
					$("#memberId").val("");
					$("#memberId").focus();
					$("#checkId").text("英文字/大文字、数字の組み合わせで入力してください。")
					$("#checkId").css("color", "red")
				}else if(result == false){ // 이미 등록된 아이디일 때 발생
					$("#memberId").val("");
					$("#memberId").focus();
					$("#checkId").text("登録されているIDです。")
					$("#checkId").css("color", "red")
				}else{
					$("#checkId").text("使用できるIDです。") // 등록되지 않은 아이디일 때 발생
					$("#checkId").css("color", "green")
				}
			}
			})
		}
	
	function checkPw(){	
		var space = /\s/;
        if($("#memberId").val() == $("#memberPassword").val()){
        	$("#memberPassword").val("");
			$("#memberPassword").focus();
			$("#checkPw").text("")
			$("#checkPw").css("color", "red")
        }
        else if($("#memberPassword")[0].value.length > 20 || $("#memberPassword")[0].value.length < 8){
        	$("#memberPassword").val("");
			$("#memberPassword").focus();
			$("#checkPw").text("8～20文字に入力してください。")
			$("#checkPw").css("color", "red")
		}
        else if(space.exec($('#memberPassword').val())){ // 스페비스바가 포함되어있을 때 발생
        	$('#memberPassword').focus();
			$("#checkPw").text("空白が含めています。")
			$("#checkPw").css("color", "red")
			$("#memberPassword").val("");	
		    return false;
		    }
        
        else {
			$("#checkPw").text("正しいパスワードです。")
			$("#checkPw").css("color", "green")
		}

	}
	
	function checkEmail(){	
		var space = /\s/; // 스페이스바가 있는지 확인하는 정규식
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
		if( !$('#memberEmail').val() ){
        	$("#memberEmail").val("");
			$("#memberEmail").focus();
			$("#checkEmail").text("メールアドレスを入力してください。")
			$("#checkEmail").css("color", "red")
		    }  
		
		else if(!regExp.test($('#memberEmail').val())||space.exec($('#memberEmail').val())){
        	$("#memberEmail").val("");
			$("#memberEmail").focus();
			$("#checkEmail").text("メールアドレスを入力してください。")
			$("#checkEmail").css("color", "red")
		    }
        else {
			$("#checkEmail").text("正しいメールアドレスです。")
			$("#checkEmail").css("color", "green")
		}
		}
	
	function checkBirth(){	
		var birthdayCheck = RegExp(/^(19|20)[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/);
		var birthdayCheck2 = RegExp(/^[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/);
		if(!$('#memberBirth').val()){
			$("#memberBirth").focus();
			$("#checkBirth").text("生年月日を確認してください。")
			$("#checkBirth").css("color", "red")
		}
		
		else if(!(birthdayCheck.test($("#memberBirth").val())||birthdayCheck2.test($("#memberBirth").val()))){ 
			$("#memberBirth").val("");
			$("#memberBirth").focus();
			$("#checkBirth").text("生年月日を確認してください。")
			$("#checkBirth").css("color", "red")
		}
		
        else {
			$("#checkBirth").text("正しい生年月日です。")
			$("#checkBirth").css("color", "green")
			
		}
		}
	
	function checkName(){	
		var space = /\s/;
		var nameCheck = /^[가-힣あ-んア-ヴ一-龠a-zA-Z]{3,15}$/; // 한글, 히라가나, 가타카나, 한자만 입력하게하는 정규식
		if(!$('#memberName').val()){
			$("#memberName").focus();
			$("#checkName").text("名前を確認してください。")
			$("#checkName").css("color", "red")  
		}  
        else if(space.exec($('#memberName').val())){ // 한글, 히라가나, 가타카나, 한자만 입력하게함 특수문자 사용x
        	$('#memberName').focus();
			$("#checkName").text("名前を確認してください。")
			$("#checkName").css("color", "red")
			$("#memberName").val("");	
		    }
        else if(!nameCheck.test($('#memberName').val())){
        	$('#memberName').focus();
			$("#checkName").text("名前を確認してください。")
			$("#checkName").css("color", "red")
			$("#memberName").val("");	
		    }
        else {
			$("#checkName").text("正しい名前です")
			$("#checkName").css("color", "green")
		}
		}
	
	function checkPhone(){	
		var phoneNumberCheck = RegExp(/^01[0][0-9]{7,8}$/);
		if( !$('#memberPhone').val() ){
			$("#memberPhone").focus();
			$("#checkPhone").text("携帯電話を確認してください。")
			$("#checkPhone").css("color", "red")
		}  
		else if(!phoneNumberCheck.test($("#memberPhone").val())){ 
			$("#memberPhone").val("");
			$("#memberPhone").focus();
			$("#checkPhone").text("携帯電話を確認してください。")
			$("#checkPhone").css("color", "red")
		}  
        else {
			$("#checkPhone").text("正しい携帯電話です。")
			$("#checkPhone").css("color", "green")
		}
		}
</script>
</head>
<body>
<div class="ss">
 <jsp:include page="/WEB-INF/views/Topbar.jsp"/>
	<div>
	<div>
	<!--header  -->
	</div><!--//header  -->

	
	<div class="main"  >
     <div class="middle1" style="width: 450px; height: 650px; display: block; background-color: #f7f7f7; margin-left: 200px; border-radius: 15px; ">
	<form action="/guide/member/signup" method="post" id="signupForm">
          <input type="text" id="memberId" name="memberId" onchange="checkId()" maxlength="64" tabindex="10" style="width: 402px; height: 47px; "class="txtbox" placeholder="ID"><br>
          <div id="checkId" style="height:20px;margin-left:27px;"></div>
          <input type="password" name="memberPassword" id="memberPassword" onchange="checkPw()" value="" class="txtbox" placeholder="パスワード"  tabindex="30" style="width: 402px; height: 47px;"><br>
          <div id="checkPw" style="height:20px;margin-left:27px;"></div>
          <input type="email" id="memberEmail" name="memberEmail" maxlength="64" onchange="checkEmail()" class="txtbox" placeholder="メールアドレス"  tabindex="10" style="width: 402px; height: 47px;"><br>
          <div id="checkEmail" style="height:20px;margin-left:27px;"></div>
          <input type="text" id="memberBirth" name="memberBirth" maxlength="10" onchange="checkBirth()" class="txtbox" placeholder="生年月日"  tabindex="60" style="width: 402px; height: 47px;"><br>
          <div id="checkBirth" style="height:20px;margin-left:27px;"></div>
          <input type="text" id="memberName" name="memberName"  maxlength="16" onchange="checkName()" class="txtbox " placeholder="名前"  tabindex="65" style="width: 402px; height: 47px;"><br>
          <div id="checkName" style="height:20px;margin-left:27px;"></div>
          <input type="number" id="memberPhone" name="memberPhone"  maxlength="16" onchange="checkPhone()" class="txtbox " placeholder="スマホ"  tabindex="65" style="width: 402px; height: 47px;"><br>
          <div id="checkPhone" style="height:20px;margin-left:27px;"></div>
          <div style=" width:450px; margin-top:50px;"><input type="button" id="btn1" value="キャンスル"  style="width: 150px; height: 47px; margin-left: 30px;" class="btn btn-signup center"><input type="button" name="commit" value="トリプラン登録" tabindex="200"style="width: 150px; height: 47px; margin-left:90px; " class="btn btn-signup center" id="btn2"></div>
	</form>
     
     </div>
     <div class="text">
     <div class="youkoso">
     ようこそ<br>トリプランに</div>
     </div>
     </div>
</div>

     


 
 <jsp:include page="/WEB-INF/views/BottomBar.jsp"/>         
     

</div>
</body>
</html>