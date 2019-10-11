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
  <style type="text/css">
          .btn-signup{
               background: #DE6262; color:#fff; font-weight:600;
          }
          .txtbox{
               margin-left: 27px;
               margin-top: 30px;
          }
          .main{
               background-image: url(/guide/resources/images/huzisan.jpg);
               background-size:100%;
               display: inline-flex;
     
               width: 100%;
            height: 700px;
            padding-top: 25px;
           background-repeat:no-repeat;
           background-size: 100% auto;

          }
          /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width:100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */                          
        }
        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
            .text{
          width: 400px;
          height: 200px;
          font-size: 70px;
          
          color: white;
          }
          .update{
            width: 480px;
          height: 200px;
          font-size: 80px;
      margin-top: 80px;
      margin-left: 80px;
          color: white;
          font-weight: 10px;
          }


     </style>
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("#memberPassword").on("change",function(){
			if(!flag){
			passwordCheck();}
		})
		$("#btn1").on("click",function(){
			location.href="/guide/"
		})
		
		$("#btn2").on("click", function(){
			var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
			var birthdayCheck = RegExp(/^(19|20)[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/); // 생년월일을 체크하는 정규식 1900~2000년대 까지 가능 ex)19930329
			var birthdayCheck2 = RegExp(/^[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/); //ex)930329
			var phoneNumberCheck = RegExp(/^01[0][0-9]{7,8}$/);
			if($("#memberPassword")[0].value.length > 20 || $("#memberPassword")[0].value.length < 8){
				$("#checkPw").text("パスワードは８～２０文字に入力してください。")
				$("#checkPw").css("color", "red")
				$("#memberPassword").focus();
				return false;
			}
			
			if(!flag){
				$("#checkPw").text("パスワードを確認してください。")
				$("#checkPw").css("color", "red")
				$("#memberPassword").focus();
				return false;
			}

			if($("#memberPassword")[0].value.length > 20 || $("#memberPassword")[0].value.length < 8){
				$("#checkPw").text("パスワードは８～２０文字に入力してください。")
				$("#checkPw").css("color", "red")
				$("#memberPassword").focus();
				return false;
			}
			
			if( !$('#memberEmail').val() ){
				$("#checkEmail").text("メールアドレスを入力してください。")
				$("#checkEmail").css("color", "red")
 		        $('#memberEmail').focus();    
 		        return false;
 		    }  
			
            if($("#memberId").val() == $("#memberPassword").val()){
				$("#checkId").text("IDとパスワードが同じです。")
				$("#checkId").css("color", "red")
				$("#memberPassword").focus();
                return false;
            }
			
			if(!regExp.test($('#memberEmail').val())){
				$("#checkEmail").text("メールアドレスが正しくありません。")
				$("#checkEmail").css("color", "red")
 		        $('#memberEmail').focus();
 		        return false;
 		    }
			
			if( !$('#memberBirth').val() ){
				$("#checkBirth").text("生年月日を確認してください。")
				$("#checkBirth").css("color", "red")
 		        $('#memberBirth').focus();    
 		        return false;
 		    }  
			if(!(birthdayCheck.test($("#memberBirth").val())||birthdayCheck2.test($("#memberBirth").val()))){ 
				$("#checkBirth").text("生年月日を確認してください。")
				$("#checkBirth").css("color", "red")
				$("#memberBirth").focus();
				return false; 
			}
			if( !$('#memberName').val() ){
				$("#checkName").text("名前を確認してください。")
				$("#checkName").css("color", "red")
 		        $('#memberName').focus();    
 		        return false;
 		    }  
			if( !$('#memberPhone').val() ){
				$("#checkPhone").text("携帯電話を確認してください。")
				$("#checkPhone").css("color", "red")
 		        $('#memberPhone').focus();    
 		        return false;
 		    }  
			if(!phoneNumberCheck.test($("#memberPhone").val())){ 
				$("#checkPhone").text("携帯電話を確認してください。")
				$("#checkPhone").css("color", "red")
				 $("#memberPhone").focus();
				return false; 
			}

				$("#updateForm")[0].submit();
				alert("編集しました。")
		

		})
		$("#btn3").on("click", function(){
			if(confirm("IDを削除しますか。")){
				 $("#myModal")[0].style.display = "block";
			}
		})
		$("#myModal > div > div.modal-header > button").on("click", function(){
			$("#myModal")[0].style.display = "none";
			
		})
		$("#btn4").on("click",function(){
			if(userPw == $("#modalPass").val()){
				if(confirm("IDを削除しますか。")){
					location.href="/guide/member/deleteId?memberPassword="+userPw;
				}
			}else{
				$("#checkPw").text("パスワードを確認してください。")
				$("#checkPw").css("color", "red")
				$("#memberPassword").focus();
			}
		})
		
		checkId()

	})
	var userPw
	var flag = false;
function checkId(){	
	$.ajax({
		url:"/guide/member/updateInfo",
		type:"get",
		data:{"memberId":$("#memberId")[0].value},
		dataType:"json",
		success:function(result){
			userPw = result.memberPassword;
			$("#updateForm>input")[2].value = result.memberEmail;
			$("#updateForm>input")[3].value = result.memberBirth;
			$("#updateForm>input")[4].value = result.memberName;
			$("#updateForm>input")[5].value = result.memberPhone;
		}
	})
	}
	function passwordCheck(){ //수정할 때 현재 비밀번호를 입력 후 변경가능
		if(userPw!=$("#memberPassword").val()){
			$("#checkPw").text("パスワードを確認してください。")
			$("#checkPw").css("color", "red")
			$("#memberPassword").focus();
		}

        else{ // 비밀번호 확인 후 새로운 비밀번호를 입력하라는 텍스트 출력 후 새로운 비밀번호 입력
			flag = true;
			$("#memberPassword").val("");
			$("#memberPassword")[0].placeholder = "新しいパスワード";
			$("#memberPassword").focus();
			$("#checkPw").text("確認されました。新しいパスワードを入力してください。")
			$("#checkPw").css("color", "blue")
			checkPassword2();
		}
	}
	
	function checkEmail(){	
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/; // 이메일 형식 체크 정규식
		if( !$('#memberEmail').val() ){ // 이메일이 공백일 때 발생
			$("#checkEmail").text("メールアドレスを入力してください。")
			$("#checkEmail").css("color", "red")

		    }  
		else if(!regExp.test($('#memberEmail').val())){
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
		var birthdayCheck = RegExp(/^(19|20)[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/); // 생년월일을 체크하는 정규식 1900~2000년대 까지 가능 ex)19930329
		var birthdayCheck2 = RegExp(/^[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/); //ex)930329
		if(!$('#memberBirth').val()){ //생년월일이 빈칸일 때 발생
			$("#checkBirth").text("生年月日を確認してください。")
			$("#checkBirth").css("color", "red")

		}
		
		else if(!(birthdayCheck.test($("#memberBirth").val())||birthdayCheck2.test($("#memberBirth").val()))){ //생년월일 형식이 올바르지 않을 때 
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
		var nameCheck = /^[가-힣あ-んア-ヴ一-龠a-zA-Z]{3,15}$/; // 한글, 히라가나, 가타카나, 한자만 입력가능하게 하는 정규식
		var space = /\s/; // 스페이스가 포함되있는지 확인하는 정규식
		if(!$('#memberName').val()){
			$("#checkName").text("名前を確認してください。")
			$("#checkName").css("color", "red")

		}  
        else if(space.exec($('#memberName').val())){ // 이름이 공백일 때 발생
        	$('#memberName').focus();
        	$("#checkName").text("名前を確認してください。")
			$("#checkName").css("color", "red")
			$("#memberName").val("");	
		    return false;
		    }
        else if(!nameCheck.test($('#memberName').val())){ // 한글, 히라가나, 가타카나, 한자 외의 문자를 입력했을 때 발생
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
	
	function checkPassword2(){
	var space = /\s/;
  	 if(space.exec($('#memberPassword').val())){
  	  	$('#memberPassword').focus();
		$("#checkPw").text("パスワードを確認してください。")
		$("#checkPw").css("color", "red")
		$("#memberPassword").val("");	
	    return false;
	    }
	}
	function checkPhone(){	
		var phoneNumberCheck = RegExp(/^01[0][0-9]{7,8}$/);
		if( !$('#memberPhone').val() ){ // 핸드폰번호가 공백일 때 발생
			$("#checkPhone").text("携帯電話を確認してください。")
			$("#checkPhone").css("color", "red")

		}  
		else if(!phoneNumberCheck.test($("#memberPhone").val())){ // 핸드폰 번호 형식이 올바르지 않을 때 발생
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
	
	function checkPw(){	
		var space = /\s/;
        if($("#memberId").val() == $("#memberPassword").val()){
			$("#memberPassword").val("");
			$("#memberPassword").focus();
			$("#checkPw").text("IDとパスワードが同じです")
			$("#checkPw").css("color", "red")

        }
        else if(space.exec($('#memberPassword').val())){
        	$('#memberPassword').focus();
			$("#checkPw").text("パスワードを確認してください。")
			$("#checkPw").css("color", "red")
			$("#memberPassword").val("");	
		    return false;
		    }
        
        else if(($("#memberPassword")[0].value.length > 20 || $("#memberPassword")[0].value.length < 8)||!$('#memberPassword').val()){
			$("#memberPassword").val("");
			$("#memberPassword").focus();
			$("#checkPw").text("8～20文字に入力してください。")
			$("#checkPw").css("color", "red")

		}
        
        else {
			$("#checkPw").text("正しいパスワードです。")
			$("#checkPw").css("color", "green")
		}

	}
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Topbar.jsp"/>
	<div class="main" >
     <div class="middle1" style="width: 450px; height: 640px; display: inline-flex; background-color: #f7f7f7; margin-left: 200px; border-radius: 15px; ">
	<form action="/guide/member/updateId" method="post" id="updateForm">
          <input type="text" id="memberId" name="memberId" onkeyup="checkId()" maxlength="64" tabindex="10" style="width: 402px; height: 47px; margin-bottom:17px; "class="txtbox" placeholder="ID" value="${sessionScope.memberId}" readonly="readonly"><br>         
          <input type="password" name="memberPassword" id="memberPassword" onchange="checkPw()" value="" class="txtbox" placeholder="パスワードチェック" tabindex="30"style="width: 402px; height: 47px;"><br>
          <div id="checkPw" style="height:20px;margin-left:27px;"></div>
          <input type="email" id="memberEmail" name="memberEmail" onchange="checkEmail()" maxlength="64" class="txtbox" placeholder="メールアドレス" tabindex="10"style="width: 402px; height: 47px;"><br>
          <div id="checkEmail" style="height:20px;margin-left:27px;"></div>
          <input type="text" id="memberBirth" name="memberBirth" maxlength="10" onchange="checkBirth()" class="txtbox" placeholder="生年月日" tabindex="60"style="width: 402px; height: 47px;"><br>
          <div id="checkBirth" style="height:20px;margin-left:27px;"></div>
          <input type="text" id="memberName" name="memberName"  maxlength="16" onchange="checkName()" class="txtbox " placeholder="名前" tabindex="65"style="width: 402px; height: 47px;"><br>
          <div id="checkName" style="height:20px;margin-left:27px;"></div>
          <input type="text" id="memberPhone" name="memberPhone"  onchange="checkPhone()" maxlength="16" class="txtbox " placeholder="スマホ" tabindex="65"style="width: 402px; height: 47px;"><br>
          <div id="checkPhone" style="height:20px;margin-left:27px;"></div>
          <div style=" width:450px; ">
          <input type="button" id="btn1" value="ホームページへ" style="width: 150px; height: 40px; margin-left: 10px;" 
          class="btn btn-signup float-left">
          <input type="button" name="commit" value="登録情報の編集" tabindex="200"style="width:
150px; height: 40px; margin-right:10px; " class="btn btn-signup float-right" id="btn2"></div>
          <input type="button" name="commit" value="ID削除" tabindex="200"style="width: 80px; height: 40px; margin-left: 25px;
          " class="btn btn-signup float-center" id="btn3">
	</form>
	     <div class="text">
     <div class="update">
     登録情報編集</div>
     </div>
     
     </div>
     </div>
</div>
 <jsp:include page="/WEB-INF/views/BottomBar.jsp"/>  
 
 <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
      <div class="modal-header">
      ID削除
         <button class="close" data-dismiss="modal">&times;</button> 
         </div>   
          <div class="modal-body" style="text-align: center ">
                   <h5 style="color: red;">留意事項</h5> <br>
                   <h6 style="color:black">一度削除したら取り消しはできません。<br>パスワードを入力してください。</h6>                                                         
        <p><input type="password" name="memberPassword" id="modalPass" value="" class="txtbox" placeholder="パスワード入力" tabindex="30"style="width: 402px; height: 47px;"><br></p>
        <input type="button" name="commit" value="削除する" tabindex="200"style="width: 150px; height: 47px; margin-left:100px; " class="btn btn-signup center" id="btn4"></div>
      </div>
      
 
    </div>

     

</body>
</html>