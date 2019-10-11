<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/guide/resources/css/bootstrap.css">
<link rel="stylesheet" href="/guide/resources/css/codingBooster.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript"
	src="/guide/resources/ckeditor/ckeditor.js"></script>
<script>
	//글쓰기
	function fn_addtoBoard() {

		//널 값 체크
		if ($("#title").val().trim() == "") {
			alert("タイトルを入力してください。");
			$("#title").focus();
			return false;
		}

		if ($("#loc option:selected").val().trim() == "地域") {
			alert("地域を選択してください。");
			$("#loc").focus();
			return false;
		}

		if ($("#type option:selected").val().trim() == "分類") {
			alert("分類を選択してください。");
			$("#type").focus();
			return false;
		}

		if (CKEDITOR.instances.boardView.getData().length < 1) {
			window.alert("内容を選択してください。");
			CKEDITOR.instances.boardView.getData().focus();
			return false;
		}

		var form = document.getElementById("writeForm");

		form.action = "/guide/board/insertBoard";

		form.submit();

	}
	//수정
	function fn_updateBoard() {

		//널 값 체크
		if ($("#title").val().trim() == "") {
			alert("タイトルを入力してください。");
			$("#title").focus();
			return false;
		}

		if ($("#loc option:selected").val().trim() == "地域") {
			alert("地域を選択してください。");
			$("#loc").focus();
			return false;
		}

		if ($("#type option:selected").val().trim() == "分類") {
			alert("分類を選択してください。");
			$("#type").focus();
			return false;
		}

		if (CKEDITOR.instances.boardView.getData().length < 1) {
			window.alert("内容を入力してください。");
			CKEDITOR.instances.boardView.getData().focus();
			return false;
		}

		var form = document.getElementById("writeForm");

		form.action = "/guide/board/updateBoard";

		form.submit();
	}

	//목록
	function fn_cancel() {

		var form = document.getElementById("writeForm");

		location.href = "/guide/board/boardList";

	}
</script>
<style type="text/css">
.buttom {
	width: 650px;
	height: 70px;
}

.btn{
 			background: #DE6262; color:#fff; font-weight:600;
 			margin-buttom: 100px;
 		}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Topbar.jsp" />
	<div align="center">
		<form id="writeForm" name="writeForm" method="post">
			<input type="hidden" id="boardNum" name="boardNum"
				value="${result.boardNum }">
			<div class="container">
				<div class="content" style="width: 70%; padding-top: 40px; height:900px;">
					<div class="row justify-content-md-center">
						<div class="col-sm-9">
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<label class="input-group-text">タイトル</label>
								</div>
								<input type="text" class="form-control" id="title"
									name="boardTitle" value="${result.boardTitle }">
							</div>
						</div>

						<div class="col-sm-3">
							<div class="input-group mb-3">
								<select class="custom-select" id="loc" name="boardLocation">
									<option selected>地域</option>
									<option value="東京">東京</option>
									<option value="大阪">大阪</option>
									<option value="沖縄">沖縄</option>
								</select> <select class="custom-select" id="type" name="boardType">
									<option selected>分類</option>
									<option value="お勧め">お勧め</option>
									<option value="相談">相談</option>
								</select>
							</div>
						</div>
					</div>

					<hr>

					<div class="row justify-content-md-center">
						<div class="col_c" style="margin-bottom: 30px">
							<div class="input-group">
								<textarea class="form-control" id="boardView" name="boardView">${result.boardView }</textarea>
								<script type="text/javascript">
									CKEDITOR
											.replace(
													'boardView',
													{//해당 이름으로 된 textarea에 에디터를 적용
														width : '100%',
														height : '400px',
														language : 'ja',
														filebrowserImageUploadUrl : '/guide/board/imageUpload' //여기 경로로 파일을 전달하여 업로드 시킨다.
													});

									CKEDITOR
											.on(
													'dialogDefinition',
													function(ev) {
														var dialogName = ev.data.name;
														var dialogDefinition = ev.data.definition;

														switch (dialogName) {
														case 'image': //Image Properties dialog
															//dialogDefinition.removeContents('info');
															dialogDefinition
																	.removeContents('Link');
															dialogDefinition
																	.removeContents('advanced');
															break;
														}
													});
								</script>
							</div>
						</div>
					</div>

					<div class="buttom">
						<c:choose>
							<c:when test="${result.boardNum != null}">
								<a href="#">
								<btn type="button" onClick='fn_updateBoard()' class="btn float-left" style="margin-left:140px;">修正</btn>
								</a>
								<a href="#">
								<btn type="button"onClick='fn_cancel()' class="btn float-right" style="margin-right:120px;">リスト</btn></a>
							</c:when>
							<c:otherwise>
								<a href="#">
								<btn type="button" onClick='fn_addtoBoard()' class="btn float-left" style="margin-left:140px;">登録</btn></a>
								</a>
								<a href="#">
								<btn type="button"onClick='fn_cancel()' class="btn  float-right" style="margin-right:120px;">リスト</btn></a>
								
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/BottomBar.jsp" />
</body>
</html>