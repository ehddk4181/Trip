<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">

.main {
	background-image: url(resources/images/ryokou1.png);
	background-size: auto auto;
	width: 100%;
	height: 700px;
	color: black;
	font-weight: bolder;
}

.mainimg {
	width: 1500px;
	height: 450px;
}

.headfont {
	font-weight: bolder;
	color: black;
}

.btn-bunseki {
	color: white;
	font-weight: bolder;
	border-radius: 20px;
    border: 3px solid #ffffff;
    background: #ffffff00;
	width: 110px;
	height: 50px;
	margin-left: 100px;
	font-size: 20px;
}

.btn-bunseki:hover {
	background-color: white;
	color: black;
}

.btn1 {
	color: #1df0d7;
	font-weight: bolder;
	border-radius: 30px;
	border-color: black;
	border-width: 2px;
	font-size: 30px;
}
.btn1:hover {
	color: #7345d6;
}
.navbar-brand:hover {
	color:#8f8f8f;
}
</style>
<meta charset="UTF-8">

<meta name="viewport" content="width=divice-width" ,intial-scale="1">

<title>トリプラン</title>
<link rel="stylesheet" href="resources/css/bootstrap.css">
<link rel="stylesheet" href="resources/css/codingBooster.css">
</head>
<body>
	<div class="main">
		<div style="width: 100%;">
			<nav class="navbar navbar-default" style="">
				<div class="container-fluid">
					<div class="navbar-header">

						<a class="navbar-brand" href="/guide/">TripRun</a>
						<div class="align_right">
							<c:if test="${sessionScope.memberId==null}">
			 				<a class="navbar-brand" style="color: white;" href="/guide/member/loginForm">ログイン</a>
			 				</c:if>
			 				<c:if test="${sessionScope.memberId!=null}">
			 				<a class="navbar-brand" style="color: white;" href="/guide/member/logout">ログアウト</a>
			 				</c:if> 
							<a class="navbar-brand" href="/guide/board/boardList">掲示板</a>
							<c:if test="${sessionScope.memberId!=null}">
 							<a class="navbar-brand" style="color:white;" href="/guide/member/myPage">登録情報</a>
 							</c:if>
						</div>

					</div>
				</div>
				</nav>
		</div>

		<h1 class="text-left"
			style="font-size: 100px; color: white; margin: 40px;">
			旅行に<br>行きませんか。
		</h1>
		<br>
		<h4 class="text-left" style="color: white; margin-left: 40px;">最高の旅行で作ってあげます！</h4>
		<br>
		 <a href="/guide/analysis/goAnalysis">
    <button type="button" class="btn-bunseki" id="btn3">分析する</button></a>
	</div>
	<div class="text" style="background-color: white; height: 1600px;">

		<div class="text-center" style="margin-top: 150px;">
			<i class="headfont" style="font-size: 50px;">トリプランの特徴</i><br><br>
			<h5 class="text-center" style="color: #1df0d7; font-size: 30px; font-weight: bolder;">一緒に行きませんか。</h5><br>
			<p style="font-size:20px; font-weight:bold; color:#424242;">
				自分の旅行計画に自信がありませんか?<br>
				旅行分析サイトであるトリプランはどうですか?<br>
				計画を立てる時、迷う皆様に紹介させていただきます!<br>
				基の計画より正確さと面白さを共に旅行を楽しめましょう!<br>
			</p>

		</div>


		<div class="text-center" style="margin-top:300px;">
			<i class="headfont" style="font-size: 50px">トリプランの特徴</i>
			<br><br>
			<h5 class="text-center" style="color: #1df0d7; font-size: 30px; font-weight: bolder;">
			TRIP + RUN = TRIPRUN</h5><br>
			<p style="font-size:20px; font-weight:bold; color:#424242;">
				トリプランは旅とランニングのイメージを合わせた名前です!<br>
				分析したい計画を乗せると、ウェブ上の分析アルゴリズムで分析します!<br>
				分析では自分の旅行タイプと旅行先、食堂などを見せます!<br>
				自分の旅行の傾向を見たいなら、ぜひお楽しみください!<br>
			</p>

		</div>
	<div class="text-center" style="margin-top:300px;">
			<i class="headfont" style="font-size: 50px">みんなとシェア!</i>
			<br><br>
			<p style="font-size:20px; font-weight:bold; color:#424242;">
				分析した計画や自分の計画をユーザーどうしにシェアできます!<br>
				分析したプランを自分だけではなく、<br>
				他のユーザーとシェアする楽しみさもあります!<br>
				お互いの情報をお勧めしたり、掲載物にコメントしましょう!<br>
			</p>
			<p class="text-center">
				<a class="btn1" href="/guide/board/boardList" role="button">掲示板へ行こう！</a>
			</p>

		</div>

	</div>


	
	</div>
	<footer style="background-color: #F1E0D9; color: #ffffff">
		<div class="container">
			<br>
			<div class="row">
				<!--한줄에 여러개의 줄이 들어갈수있도록 2가아니라12면 정중앙으로 다합쳤을때 12-->
				<div class="col-sm-12" style="text-align: center;">
					<h6 style="text-align: left; color: #757373;">
						SC IT MASTER 37期<br> チーム名：行くぞ<br>
						チーム員：キム・ジェグォン、キム・サンイ、イ・ボヒョン、ジョン・ゲジン<br> 開発期間：09/02～10/02<br>
						email : 1990wormjs@naver.com<br> Copyright@All right not
						reserved<br>
					</h6>

				</div>
				



			</div>


		</div>

	</footer>



	<script src="resources/js/jquery-3.4.1.js"></script>
	<script src="resources/js/bootstrap.js"></script>
</body>
</html>