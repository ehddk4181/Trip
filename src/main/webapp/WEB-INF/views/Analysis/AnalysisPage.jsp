<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=divice-width" ,intial-scale="1">
<title>トリプラン</title>
<link rel="stylesheet" href="/guide/resources/css/bootstrap.css">
<link rel="stylesheet" href="/guide/resources/css/codingBooster.css">

<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(function() {
		$("#getFile").on("click", function() {
			$("#imageButton")[0].click();
		})
		$("#imageButton").on("change", function() {
			$("#fileName").empty();
			$("#fileName").append('<span style="color:#DE6262;font-size:25px;">今のファイル  : </span>' + $("#imageButton")[0].value)
		})
		$("#goAnaly").on("click", function() {
			goAnaly();
		})
	})
	function goAnaly() {
		if ($("#imageButton")[0].value.length == 0) {
			location.href = "/guide/analysis/goAnaly"
		} else {
			$("#uploadForm")[0].submit();
		}
	}
</script>
<style type="text/css">
.middle {
	width: 1300px;
	height: 600px;
	display: inline-flex;
}

.text {
	width: 500px;
	height: 500px;
	display: block;
	padding-left: 100px;
	padding-top: 100px;
}

.text1 {
	width: 500px;
	height: 100px;
	font-size: 50px;
	color:#DE6262;
}

.text2 {
	font-color: gray;
}

.btn-bunseki {
	border-style:solid;
	border-width:0px;
	background: #DE6262;
	color: white;
	font-weight: 100px;
	width: 120px;
	height: 50px;
	
	border-radius: 20px;
}
.img{
border-width:0px;
width: 120px;
border-radius: 20px;
background: #DE6262;
	color: white;
	font-weight: 120px;
	height: 40px;
}
.tsugi{
border-width:0px;
width: 80px;
border-radius: 20px;
background: #DE6262;
	color: white;
	font-weight: 120px;
	height: 40px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Topbar.jsp" />
	<div class="middle">
		<img src="/guide/resources/images/bunseki1.jpg"
			style="width: 500px; height: 400px; margin-left: 230px; margin-top: 100px; ">
		<div class="text">
			<div class="text1">&nbsp;分析しましょう！</div>
			<div class="text2">
				計画書のイメージまたは自分の計画をホームページへ<br>
				<!-- 작성하실수있습니다.트립런 은 작성하신 계획을 따로 보관하거나 <br> -->
				作成できます。トリプランは作成した計画を別に保管したり、<br>
				<!-- 정보를 수집하지않습니다.<br> -->
				情報を集めることはしません。
				<!-- 분석에 걸리는 시간은 약 3~7분정도 소요되며 분석중일때<br> -->
				分析に掛かる時間は約3~7分です。分析中には
				<!-- 새로고침 또는 웹페이지를 종료하지 말아주시기 바랍니다.<br> -->
				リロードやウェブページを終了しないでください。
				<!-- 그럼 분석하러 가보실까요? -->
				それでは、分析しましょう!

			</div>
			<br>
			
			
				<button type="button" class="btn-bunseki" data-target="#modal" data-toggle="modal">分析する</button>
			






		</div>




	</div>
	<div class="row">
		<div class="modal" id="modal" tabindex="-1">
			<div class="modal-dialog" style="max-width: 1000px;">
				<div class="modal-content">
					<div class="modal-header" style="color:#DE6262; font-size:25px; font-weight: bold;">
						留意事項
						<button class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="text-align: center;">
						<div style="font-size:20px; font-weight: bold;">分析する方法を決めてください！<br> イメージでしない方は次へをクリック！！<br> <br></div>
						<div style="display:inline-flex;">
						<div style="float:left;display:block; height:400px; width:500px;">
						
							<div style="width:500px; color:#DE6262; font-size:25px; font-weight: bold;">正しい例</div> 
							<img src="/guide/resources/images/nan.jpg" style="height:300px; width:400px; margin-top:30px;">
						</div>
						<div style="width:500px; height:400px;">
							<span style="color:#DE6262; font-size:25px; font-weight: bold;">ご注意ください<br></span>
							<table style="width:400px; text-align:left; margin-left:30px; margin-top:30px; font-size:20px; border-width:20px; border-color:white;">
								<tr style="margin-top:20px;">
									<th style="width:40px;">1.</th>
									<td>フォントを統一してください！</td>
								</tr>
								<tr style="margin-top:20px;">
									<th style="width:40px;">2.</th>
									<td>動詞を確認してください！</td>
								</tr>
								<tr style="margin-top:20px;">
									<th style="width:40px;">3.</th>
									<td>タイトルを入れないでください!</td>
								</tr>
								<tr style="margin-top:20px;">
									<th style="width:40px;">4.</th>
									<td>長い計画は時間がかかります！!</td>
								</tr>
								<tr style="margin-top:20px;">
									<th style="width:40px;">5.</th>
									<td>この分析結果はぜひお楽しみに！!</td>
								</tr>
								<tr style="margin-top:20px;">
									<th style="width:40px;">6.</th>
									<td>イメージを添付して次へをクリック</td>
								</tr>
								<tr style="margin-top:20px;">
									<th style="width:40px;">7.</th>
									<td>添付したイメージが計画でしょうか？</td>
								</tr>
								<tr style="margin-top:20px;">
									<th style="width:40px;">8.</th>
									<td>空白は入れないでください</td>
								</tr>
								
							</table>
							
							
						</div>
						</div>
						<div id="fileName"><span style="color:#DE6262;font-size:25px;">今のファイル :</span> なし</div>
						<br>
						
						<div style="width: 300px; display: inline-flex;">
							<button type="button" class="img" id="getFile"
								style="margin-left: 10px;">イメージ添付</button>

							&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
							
							<button type="button" class="tsugi"
								style="margin-right: 10px;" id="goAnaly">次へ</button>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<form action="/guide/analysis/goAnalysisWithFile" method="post"
		enctype="multipart/form-data" id="uploadForm" style="display: none;">
		<input type="file" name="mFile" style="margin-left: 50px;"
			id="imageButton">
	</form>

	<jsp:include page="/WEB-INF/views/BottomBar.jsp" />
	<script src="/guide/resources/js/bootstrap.js"></script>
</body>
</html>