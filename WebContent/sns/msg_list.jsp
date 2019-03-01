<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>쪽지함</title>
	<script src="../js/httpRequest.js"></script>
	<script>
		function show_msg( sendId ) {
			var url = "msg_insert_form.korea?receivedId="+sendId;
			window.open(url, "메세지보내기", "width=500, height=300, left=400, top=50");
		}
		
		function del( idx ) {
			var url = "msg_delete.korea";
			var param = "idx=" + idx;
			
			sendRequest( url, param, delResultFn, "POST" );
		}
		
		function delResultFn() {
			if( xhr.readyState == 4 && xhr.status == 200 ) {
				var data = xhr.responseText;
				var json = eval(data);
				
				if (json[0].result == 'yes') {
					alert("Delete!");
					location.href = "msg_list.korea";
				}
			}
		}
	</script>
</head>
<body>
	<jsp:include page="../music/index.jsp"/>
	<div class="jumbotron text-center">
	<div class="container">
		<h3>My Message</h3><br>
	<table class="table table-striped"align="center" width="600"  style="border-collapse : collapse">
		<c:if test="${ empty list }">
			<tr>
				<td align="center" colspan="3">Not Exist Message.</td>
			</tr>
		</c:if>
		<tr>
			<th width="20%">Sender</th>
			<th width="60%">Message</th>
			<th width="20%"></th>
		</tr>
		<c:forEach var="m" items="${list}">
			
			
			<tr>
				<td align="left">${m.sendId}</td>
				<td align="left">${m.msg}</td>
				<td align="right">
					<input type="button" class="btn btn-warning btn-sm" value="reply" onclick="show_msg('${m.sendId}');">
					<input type="button" class="btn btn-warning btn-sm" value="delete" onclick="del('${m.idx}');">
				</td>
			</tr>
		</c:forEach>
	
		<!-- 페이징 -->
		<tr>
			<td colspan="5" align="center">
				<!-- 첫 페이지로 이동하는 버튼. 그냥 파라미터로 1넣으면 됨 -->
				<input type="button" class="btn btn-warning btn-sm" value="처음" onclick="location.href='${url}?page=1&id=${id}'">
				
				<!-- 이전 페이지로 이동하는 버튼. 현재페이지-1 -->
				<c:if test="${paging.currentPage > 1}">
					<input type="button" class="btn btn-warning btn-sm" value="이전" onclick="location.href='${url}?page=${paging.currentPage-1}&id=${id}'">
				</c:if>
				<!-- 현재 페이지가 1이면 '이전'은 비활성화 버튼으로 만든다. -->
				<c:if test="${paging.currentPage <= 1}">
					<input type="button" class="btn btn-warning btn-sm" value="이전" disabled="disabled">
				</c:if>
				
				<!-- 1~10 각 페이지 버튼 만들기
						startPage, endPage 이런 값들은 이미 Paging 객체 생성 시 다 계산해놨다!! -->
				<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}" step="1">
					
					<!-- 현재 페이지의 버튼이라면 클릭할 필요 없다. 비활성화 -->
					<c:if test="${paging.currentPage == i}">
						<input type="button" class="btn btn-warning btn-sm" value="${i}" disabled="disabled">
					</c:if>
					
					<c:if test="${paging.currentPage != i}">
						<input type="button" class="btn btn-warning btn-sm" value="${i}" onclick="location.href='${url}?page=${i}&id=${id}'">
					</c:if>
					
				</c:forEach>
				
				<!-- 다음 버튼 (현재페이지+1) -->
				<c:if test="${paging.currentPage < paging.totalPage}">
					<input type="button" class="btn btn-warning btn-sm" value="다음" onclick="location.href='${url}?page=${paging.currentPage+1}&id=${id}'">
				</c:if>
				<!-- 현재 페이지가 마지막페이지이면 '다음'은 비활성화 버튼으로 만든다. -->
				<c:if test="${paging.currentPage >= paging.totalPage}">
					<input type="button" class="btn btn-warning btn-sm" value="다음" disabled="disabled">
				</c:if>

				<!-- 마지막 페이지로 이동하는 버튼. -->
				<input type="button" class="btn btn-warning btn-sm" value="끝" onclick="location.href='${url}?page=${paging.totalPage}&id=${id}'">
			</td>
		</tr>
	</table>
	</div>
	</div>
</body>
</html>