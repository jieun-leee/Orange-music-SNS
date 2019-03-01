<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String url = (String)request.getAttribute("url");
	if( url == null ) {
		request.setAttribute("url", "../music/list.korea");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome To Orange</title>
	<style>
		.regi {	witdh : 600px;
				align : center;
				text-align : center;
				margin : auto;
				margin-bottom : 6px; }
	</style>
	<script>
		function regi() {
			location.href = "../music/insert_form.korea";
		}
	</script>

</head>
<body>
	<jsp:include page="../music/index.jsp"/>
		<div class="jumbotron text-center">
		<div class="container">
		<div class="raw">
       	<!-- music upload button -->
       	<c:if test="${ sessionScope.name ne null }"> <!-- 로그인만 게시물등록버튼 -->
       		<button type="button" class="btn btn-warning btn-block" value="Musicupload" onclick="regi();">Write</button>
       	</c:if>
       	<br>
       	<!-- music list -->
					                  	
		<table>
		<c:if test="${ empty list }">
			<tr>
				<td>Music list Empty</td>
			</tr>
		</c:if>
		<c:forEach var="p" items="${list}" varStatus="cnt">
			<td width="33%">
				<a href="../music/view.korea?idx=${p.idx}&name=${p.name}">
				<img src="../musicfile/${ p.m_image }" width="100%" height="150" class="img-thumbnail"><br></a>
				${ p.name }님의<br> ${ p.m_title }<br>
			</td>
			<c:if test = "${ cnt.count mod 3 eq 0 }"> <!-- 게시물은 3열씩 -->
				<tr></tr>
			</c:if>
		</c:forEach>
		
		<!-- 페이징 -->
		<tr>
			
			<td colspan="5" align="center">
				<!-- 첫 페이지로 이동하는 버튼. 그냥 파라미터로 1넣으면 됨 -->
				<input type="button" class="btn btn-warning btn-sm" value="처음" onclick="location.href='${url}?page=1&idx=${idx}'">
				
				<!-- 이전 페이지로 이동하는 버튼. 현재페이지-1 -->
				<c:if test="${paging.currentPage > 1}">
					<input type="button" class="btn btn-warning btn-sm" value="이전" onclick="location.href='${url}?page=${paging.currentPage-1}&idx=${idx}'">
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
						<input type="button" class="btn btn-warning btn-sm" value="${i}" onclick="location.href='${url}?page=${i}&idx=${idx}'">
					</c:if>
					
				</c:forEach>
				
				<!-- 다음 버튼 (현재페이지+1) -->
				<c:if test="${paging.currentPage < paging.totalPage}">
					<input type="button" class="btn btn-warning btn-sm" value="다음" onclick="location.href='${url}?page=${paging.currentPage+1}&idx=${idx}'">
				</c:if>
				<!-- 현재 페이지가 마지막페이지이면 '다음'은 비활성화 버튼으로 만든다. -->
				<c:if test="${paging.currentPage >= paging.totalPage}">
					<input type="button" class="btn btn-warning btn-sm" value="다음" disabled="disabled">
				</c:if>

				<!-- 마지막 페이지로 이동하는 버튼. -->
				<input type="button" class="btn btn-warning btn-sm" value="끝" onclick="location.href='${url}?page=${paging.totalPage}&idx=${idx}'">
			</td>
		</tr>
		</table>
       	</div>
		</div>     
		</div>
	</body>
</html>