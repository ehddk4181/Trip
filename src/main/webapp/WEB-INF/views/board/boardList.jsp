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
<title>boardList</title>
<script src="/guide/resources/js/jquery-3.4.1.js"></script>
<script>
	function pageProc(currentPage, searchItem, searchKeyword) {
		location.href="/guide/?currentPage=" + currentPage + "&searchItem=" + searchItem + "&searchKeyword=" + searchKeyword;
	}
	
	function fn_searchList(){

		var searchItem = $("#select_searchItem option:selected").val();
		var searchKeyword = $("#searchKeyword").val();
		
		// 검색버튼을 클릭할 때 마다 1번째 페이지를 보여주기 위해 currentPage의 값을 1로 고정한다.
		window.location.href="/guide/board/boardList?currentPage=1&searchItem=" + searchItem + "&searchKeyword=" + searchKeyword;
	}
	
	function fn_check(){
		
		var id = <%= '"' + (String)session.getAttribute("memberId")  + '"' %>
		
		if(id == "null"){
			alert('この機能はログイン必要になります。ログインした後、ご利用ください。');
			location.href = "/guide/member/loginForm";
		} else {
			location.href = "/guide/board/boardEdit";
		}
	}
</script>
<style type="text/css">
.btn{
 			background: #DE6262; color:#fff; font-weight:600;
 		}
#searchKeyword{
width: 300px;
height: 37px;
}
</style>
</head>
<body>
	 <jsp:include page="/WEB-INF/views/Topbar.jsp"/>
	<div class="container" style="width: 100%; height: 550px;">
		
		<div class="aaa" style="padding-top: 50px; margin-bottom: 50px;">
		<form id="boardForm" name="boardForm" method="post">
			<table class="table table-striped table-hover" style="text-align: center; padding-top: 50px;">
				<thead>
					<tr>
						<th>ナンバー</th>
						<th>タイトル</th>
						<th>作成者</th>
						<th>デート</th>
						<th>分類</th>
					</tr>	
				</thead>
				<tbody id="boardList">
					<c:choose>
						<c:when test="${!empty list}">
							<c:forEach var="result" items="${list }" varStatus="status">
								<tr>
									<td><c:out value="${result.boardNum }"/></td>
									<td><a href = "/guide/board/boardView?boardNum=${result.boardNum}"><c:out value="${result.boardTitle }"/></a></td>
									<td><c:out value="${result.memberId }" /></td>
									<td><c:out value="${result.boardDate }" /></td>
									<td><c:out value="${result.boardType }" /></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5">登録された情報がありません。</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
				
				<!-- 페이징 -->
				<c:choose>
					<c:when test="${!empty list }">
						<tr>
							<td id="navigator" colspan="5">
								<a href="javascript:pageProc(${navi.currentPage - navi.pagePerGroup}, '${searchItem}', '${searchKeyword}')">◁◁ </a> &nbsp;&nbsp;
								<a href="javascript:pageProc(${navi.currentPage - 1}, '${searchItem}', '${searchKeyword}')">◀</a> &nbsp;&nbsp;
			
							<c:forEach var="counter" begin="${navi.startPageGroup}" end="${navi.endPageGroup}"> 
								<c:if test="${counter == navi.currentPage}"><b></c:if>
									<a href="javascript:pageProc(${counter}, '${searchItem}', '${searchKeyword}')">${counter}</a>&nbsp;
								<c:if test="${counter == navi.currentPage}"></b></c:if>
							</c:forEach>
							&nbsp;&nbsp;
							<a href="javascript:pageProc(${navi.currentPage + 1}, '${searchItem}', '${searchKeyword}')">▶</a> &nbsp;&nbsp;
							<a href="javascript:pageProc(${navi.currentPage + navi.pagePerGroup}, '${searchItem}', '${searchKeyword}')">▷▷</a>
						</td>
					</tr>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</table>
			
			<div>
				<div>
					<p>${navi.totalRecordsCount} 件の情報があります。</p>
					<div class="kensaku" style="display: inline-flex; margin-bottom: 20px;">
					
					
						<select class="custom-select"  style="width: 110px" name="searchItem" id="select_searchItem">
							<c:choose>
								<c:when test="${searchItem == 'boardTitle'}">
									<option value="boardTitle" selected="selected">タイトル</option>
									<option value="boardType">内容</option>
									<option value="memberId">作成者</option>
								</c:when>
								<c:when test="${searchItem == 'boardType'}">
									<option value="boardTitle">タイトル</option>
									<option value="boardType" selected="selected">内容</option>
									<option value="memberId">作成者</option>
								</c:when>
								<c:when test="${searchItem == 'memberId'}">
									<option value="boardTitle">タイトル</option>
									<option value="boardType">内容</option>
									<option value="memberId" selected="selected">作成者</option>
								</c:when>
							</c:choose>
						</select>
						<input type="text" name="searchKeyword" id="searchKeyword" >&nbsp;&nbsp;&nbsp;
						<a href='javascript:fn_searchList()'>
						<btn type="button" class="btn">検索</btn></a><br>
					
					</div>
				</div><br>
				<button type="button" onclick="fn_check()" class="btn">書く</button></a>
			</div>
		</form>
	</div>
	
</div>
	 <jsp:include page="/WEB-INF/views/BottomBar.jsp"/>
</body>
</html>