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
<title>목록 보기</title>
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript"
	src="/guide/resources/ckeditor/ckeditor.js"></script>
<script>
	$(function() {

		getCommentList();

	});
	/*
	 * 게시글 삭제
	 */
	function fn_delete() {

		var id = <%= '"' + (String)session.getAttribute("memberId")  + '"' %>
		
		//로그인 체크
		if(id == "null"){
			alert('この機能はログイン必要になります。ログインした後、ご利用ください。');
			location.href = "/guide/member/loginForm";
			return false;
		}
		
		else if (confirm("本当に削除しますか？") == true) {

		var objParams = {
			boardNum : $("#boardNum").val()
		}
			
			$.ajax({
					type : 'POST',
					url : "/guide/board/deleteBoard",
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					async : true,
					data : objParams,
					success : getBoardList()
				})
	} else { // 삭제 취소
		return false;
	}
	}

	function getBoardList() {

		var objParams = {
			boardNum : $("#boardNum").val()
		}

		$.ajax({
			type : 'POST',
			url : "/guide/deleteComment",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			async : false,
			data : objParams,
			success : location.href = "/guide/board/boardList"
		})
	}

	/*
	 * 수정 페이지 이동
	 */
	function fn_update() {

		var id = <%= '"' + (String)session.getAttribute("memberId")  + '"' %>
		
		//로그인 체크
		if(id == "null"){
			alert('この機能はログイン必要になります。ログインした後、ご利用ください。');
			location.href = "/guide/member/loginForm";
			return false;
		}
		
		//아이디 체크
		if(id != "${result.memberId}"){
			alert('修正は作成者のみできます。')
		}
		
		var form = document.getElementById("viewForm");
		
		form.action = "/guide/board/updateForm";
		
		form.submit();
	}

	/*
	 * 댓글 등록하기(Ajax)
	 */
	function fn_comment(code) {

		$.ajax({
			type : 'POST',
			url : "/guide/board/addComment",
			data : $("#commentForm").serialize(),
			success : function(data) {
				if (data == "success") {
					alert("登録しました。");
					getCommentList()
					$("#comment").val("");
				}
			},
			error : function(){
					alert('この機能はログイン必要になります。ログインした後、ご利用ください。')
					location.href = "/guide/member/loginForm"
			}

		});
	}

	/**
	 * 초기 페이지 로딩시 댓글 불러오기
	 */

	/**
	 * 댓글 불러오기(Ajax)
	 */
	function getCommentList() {

		$.ajax({
					type : 'post',
					url : "/guide/board/commentList",
					dataType : "json",
					data : $("#commentForm").serialize(),
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					success : function(data) {

						var html = "";
						var cCnt = data.length;
						if (data.length > 0) {
							number = 0
							for (i = 0; i < data.length; i++) {
								html += "作成者　<div>";
								html += "<div><table class='table'><h6><strong>"
										+ data[i].commentId + "</strong></h6>";
								html += data[i].commentView
										+ "<tr><td></td></tr><br>";
								html += data[i].commentDate + "<br>";
								html += "<div><br><input type='button' onClick='fn_reply("
										+ data[i].commentNum
										+ ","
										+ data[i].boardNum
										+ ","
										+ data[i].commentLocation
										+ ")' class='btn pull-right btn1' id='reply' value='コメント' /></div>";
								html += "</table></div>";
								html += "</div>";
								html += "<div id="+data[i].commentNum+"></div>";
							}

						} else {
							html += "<div class='text' style='margin-left: 380px; font-weight: border; font-size: 20px;'>コメントがありません。";
							html += "</div>";
						}

						$("#cCnt").html(cCnt);
						$("#commentList").html(html);

					},
					error : function(request, status, error) {

					}

				});
	}
	
	
	/*  대댓글 불러오기(Ajax)
	
	function getReplyList() {

		$.ajax({
			type : 'post',
			url : '/guide/board/replyList',
			dataType : "json",
			data : $("#replyList").serialize(),
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(data) {

				var html = "";
				var cCnt = data.length;
				if (data.length > 0) {

					for (i = 0; i < data.length; i++) {
						html += "<div>";
						html += "<div><table class='table'><h6><strong>"
								+ data[i].commentId + "</strong></h6>";
						html += ">>" + data[i].commentView
								+ "<tr><td></td></tr><br>";
						html += "</table></div>";
						html += "</div>";
					}
				}
			}
		});
	} */
	
	/*
	 * 대댓글 입력창 불러오기
	 */
	function fn_reply(number, boardNum, commentLocation) {

		if (commentLocation == "0") {
			commentLocation = "1"
		} else if (commentLocation == "1") {
			commentLocation = "2"
		}

		//대댓글 입력창
		$("#" + number)
				.each(
						function(index, item) {
							$(item)
									.append(
											"<div>"
													+

													"<form id='replyForm'>"
													+ "<table class='table'>"
													+ "<td>"
													+ "<textarea style='width: 500px' rows='10' cols='10'"+
				"id='replyView' name='commentView' placeholder='コメントを入力してください。'></textarea>"
													+ "<div>"
													+ "<input type='button' class='btn pull-right btn1' value='登録' onclick='insertReply()'>"
													+ "<input type='hidden' name='boardNum' value='" + boardNum + "' />"
													+ "<input type='hidden' name='commentLocation' value='" + commentLocation + "' />"
													+ "</div>" + "</td>"
													+ "</table>" + "</form>"
													+ "</div>")

						})
	}
	
	/*
	 * 대댓글 등록하기(Ajax)
	 */
	function insertReply() {

		//AJAX 호출
		$.ajax({
			type : 'POST',
			url : "/guide/board/addComment",
			data : $("#replyForm").serialize(),
			success : function(data) {
				if (data == "success") {
					getCommentList();
					$("#comment").val("");
				}
			},
			error : function(){
					alert('この機能はログイン必要になります。ログインした後、ご利用ください。')
					location.href = "/guide/member/loginForm"
			}

		});
	}
</script>
<style type="text/css">
.btn1{
	background: #DE6262;
	color: #fff;
	font-weight: 600;
	margin-buttom: 100px;
	border-color: #DE6262;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Topbar.jsp" />
	<div align="center">
		<form id="viewForm" name="viewForm" method="post">
			<input type="hidden" name="boardNum" id="boardNum"
				value="${result.boardNum }">
			<div>
				<h2>${result.boardTitle }</h2>
				<div style="width: 70%">
					<table>
						<tr>
							<th>地域</th>
							<td><input type="text" class="form-control"
								name="boardLocation" id="boardLocation"
								value="${result.boardLocation }" readonly="readonly" /></td>
						</tr>
						<tr>
							<th>内容</th>
							<td><input type="text" class="form-control" name="boardType"
								id="boardType" value="${result.boardType }" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<th>内容</th>
							<td><textarea style="width: 500px" rows="10" cols="10"
									id="content" name="boardView" readonly="readonly"><c:out
										value="${result.boardView }" /></textarea> <script
									type="text/javascript">
											CKEDITOR
													.replace(
															'boardView',
															{//해당 이름으로 된 textarea에 에디터를 적용
																language : 'ja',
																filebrowserImageUploadUrl : '/guide/imageUpload' //여기 경로로 파일을 전달하여 업로드 시킨다.

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
										</script></td>
						</tr>
						<tr>
							<th>作成者</th>
							<td>
							<input type="text" id="writer" name="memberId" value="${result.memberId }" readonly="readonly" class="form-control" />
							</td>
						</tr>
					</table>
					<br>
					<br>
					<div>
						<a href='#' onClick='fn_update()'class="btn pull-right btn1">修正</a> 
						<a href='#' onClick='fn_delete()' class="btn pull-right btn1">削除</a> 
						<a href='/guide/board/boardList' class="btn pull-right btn1">リスト</a>
					</div>
				</div>
			</div>
		</form>

		<!-- 댓글 -->
		<div>
			<div class="container">
				<form id="commentForm" name="commentForm" method="post">
					<br> <br>
					<div>
						<div class="coment" style="font-size: 20px; text-align: left;">
							<span><strong>コメント</strong></span>&nbsp;<span id="cCnt"></span>件
						</div>
						<div align="center">
							<table class="table">
								<tr>
									<td><textarea style="width: 1100px" rows="3" cols="30" id="comment" name="commentView" placeholder="コメントを入力してください。"></textarea><br>
									<br>
										<div class="sita" style="display: inline-flex;">
											<a href='#' onClick="fn_comment('${result.boardNum}')" class="btn pull-right btn1">登録</a>
												<!-- <div class="text" style="margin-left:380px; font-weight: border; font-size: 20px;">コメントがありません。</div> -->
										</div></td>
								</tr>
							</table>
						</div>
					</div>
					<input type="hidden" id="b_code" name="boardNum"
						value="${result.boardNum }" />
				</form>
			</div>
		</div>
		<!-- 댓글 목록 -->
		<div class="container">
			<form id="commentListForm" name="commentListForm" method="post">
				<div id="commentList" class="1" style="text-align:left;">
					<!-- 대댓글 목록 -->
					<div id="replyList" ></div>
				</div>
			</form>
		</div>

	</div>
	<jsp:include page="/WEB-INF/views/BottomBar.jsp" />
</body>
</html>