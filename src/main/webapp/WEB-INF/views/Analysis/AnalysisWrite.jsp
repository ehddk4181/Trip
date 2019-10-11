<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="/guide/resources/css/bootstrap.css">
  <link rel="stylesheet" href="/guide/resources/css/codingBooster.css">
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script>
	$(function(){
		getFile();
		$("#analysis").on("click",function(){
			if(checkFunc()){
				$("#getInputList")[0].submit();
			}
		})
		
	})
	function checkFunc(){
		$(".monndaiText").remove();
		var flag = true;
		$("#getInputList>div>input").each(function(i,item){
			if(item.value.length<2){
		  		item.focus();
		  		$(item).parent().after(
		  			"<div class='monndaiText' style='color:red;'>こちらにデータを入力してください。</div>"		
		  		)
		  		flag = false;
		  		return false;
		  		
			}
		})
		return flag;
	}
	function addFunc(item){
		$(item).parent().after(
				'<div class="inputClass">'+
				'<input type="text" name="time" class="tInput" placeholder="時間">'+
				'<input type="text" name="japan" class="jInput" placeholder="内容">'+
				'<input type="button" value="追加" class="tbutton" onclick="addFunc(this)">'+
				'<input type="button" value="削除" class="tbutton" onclick="minusFunc(this)">'+
				'</div>'
		);
	}
	function minusFunc(item){
		$(item).parent().remove();
	}
	function distFunc(){
		for(var i = 0 ; i<5; i++){
			$("#getInputList").prepend(
					'<div class="inputClass">'+
					'<input type="text" name="time" class="tInput" placeholder="時間">'+
					'<input type="text" name="japan" class="jInput" placeholder="内容">'+
					'<input type="button" value="追加" class="tbutton" onclick="addFunc(this)">'+
					'<input type="button" value="削除" class="tbutton" onclick="minusFunc(this)">'+
					'</div>'	
			)
		}
	}
	
	function getFile(){
		
		$.ajax({
			url:"/guide/analysis/getTextList",
			type:"get",
			datatype:"json",
			success:function(result){
				if(result!=""){
					$(result).each(function(i,item){
						$("#getInputList").prepend(
								'<div class="inputClass">'+
								'<input type="text" name="time" class="tInput" placeholder="時間"  value="'+item.time+'">'+
								'<input type="text" name="japan" class="jInput" placeholder="内容" value="'+item.japan+'">'+
								'<input type="button" value="追加" class="tbutton" onclick="addFunc(this)">'+
								'<input type="button" value="削除" class="tbutton" onclick="minusFunc(this)">'+
								'</div>'
						)
						
					})
				}else{
					distFunc();
				}
			}
		})
	}
	
</script>
<style>
	.tInput{
		height:50px;
		width:120px;
		margin-left:20px;
		margin-top:10px;
		border-width:0 0 1px 0;
	}
	.jInput{
		height:50px;
		width:300px;
		margin-left:30px;
		margin-top:10px;
		border-width:0 0 1px 0;
	}
	.inputClass{
		margin-left:70px;
		margin-top:20px;
		margin-bottom:10px;
		text-align:center;
		height:80px;
		width:650px;
		border-width:1px;
		border-style:solid;
		border-color:black;
		border-radius: 1px;
		margin-bottom: 20px;
		background-color:white;
		

	}
	.tbutton{
		height:37px;
		width:55px;
		margin-left:15px;
		margin-top:12px;
		border-style:solid;
		padding-bottom: 12px;
		background-color: skyblue;
		border-radius: 3px;
		border-width: 1px;
		border-color:skyblue;
		color: white;
		
	}
	.InputList{
	text-align:center;
		
		border-style:solid;
		background-color:rgba(255,255,255,0.8);
		margin-left:400px;
		border-width:1px;
		border-color:rgba(0,0,0,0.3);
		border-radius:10px;
		width:800px;
		margin-bottom: 50px;
		padding-top: 20px;

		
	}
	.allbody{
		background-image: url(/guide/resources/images/yoru.jpg);
		background-size: 100% auto;
		height: 100%;;
		margin-top: 0px;
		padding:30px 30px;
	}
	.btn-bunseki{
               background: #3b1ee3;  font-weight:80px; color: white;
               width: 200px; height: 50px; border-radius: 15px; border-color:#3b1ee3;
               border-style:solid;
         
	}

</style>
</head>
<body>
<div>
		<jsp:include page="/WEB-INF/views/Topbar.jsp"/>
	<div class="allbody">
		<div class="InputList">
		<form id="getInputList"  action="/guide/analysis/anaResult" method="get">
			<input type="button" value="分析する" class="btn-bunseki" style="width:100px; margin-bottom:30px;" id="analysis">
			
		</form>
		</div>
	</div>	
		<jsp:include page="/WEB-INF/views/BottomBar.jsp"/>
</div>
</body>
</html>