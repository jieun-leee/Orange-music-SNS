<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Music Board</title>

<script src="../js/httpRequest.js"></script>
<script>
		function addListf( musicidx, memberidx ) { //플레이리스트 담기
			if(memberidx == 0){
				location.href = "../login/check_login.jsp";
				return;
			}
			var url = "playlist_insert.korea";
			var param = "musicidx=" + musicidx + "&memberidx=" + memberidx;
			sendRequest(url, param, resultFn, "POST");
		}
		function resultFn() {
			if( xhr.readyState == 4 && xhr.status == 200 ) {
				var data = xhr.responseText;
				var json = eval(data);
				if( json[0].result == 'yes' ) {
					alert("playlist에 담았습니다.");
					if( confirm("playlist로 이동하시겠습니까?") == true ) {
						location.href = "playlist_list.korea";
					}
				}
				else {
					alert("이미 playlist에 담겨져 있습니다.");
				}
			}
		}
		function goodpoint(idx,name){ //게시물 좋아요 올리기
			var url = "goodpoint_add.korea";
			var param = "idx="+idx+"&name="+name;
			sendRequest(url, param, resultFnAdd, "POST");
		}
		function resultFnAdd() {
			if( xhr.readyState == 4 && xhr.status == 200 ) {
				var data = xhr.responseText;
				var json = eval(data);
				location.href = "view.korea?idx="+${vo.idx}+"&name="+json[0].name;
			}
		}
		function deletef( didx ) { //내 게시물 삭제
			var url = "music_delete.korea";
			var param = "idx="+didx;
			sendRequest(url, param, delresultFn, "POST");
		}
		function delresultFn() {
			if( xhr.readyState == 4 && xhr.status == 200 ) {
				location.href = "list.korea";
			}
		}
		function writedata(f,name,checkidx){ //댓글달기
			if(checkidx == 0){
				location.href = "../login/check_login.jsp";
				return;
			}
			var c_content = f.c_content.value.trim();
			if( c_content == '') {			//추가-댓글 입력안할경우	
				alert("Please Input Comment!!");
				return;
			}
			var musicidx = f.musicidx.value.trim();
			f.action = "comments_insert.korea?name="+name;
			f.method = "POST";
			f.submit();
		}
		function CgoodFn(cidx,name){ //댓글좋아요
			var url = "comments_goodpoint_add.korea";
			var param = "idx="+cidx+"&name="+name;
			sendRequest(url, param, resultFnAdd_cmt, "POST");
		}
		function resultFnAdd_cmt() {
			if( xhr.readyState == 4 && xhr.status == 200 ) {
				var data = xhr.responseText;
				var json = eval(data);
				location.href = "view.korea?idx="+${vo.idx}+"&name="+json[0].name;
			}
		}
		function Cmtdel(cdidx,name){ //내 댓글 삭제
			var url = "comments_delete.korea";
			var param = "idx="+cdidx+"&name="+name;
			sendRequest(url, param, delresultFn_cmt, "POST");
		}
		function delresultFn_cmt() {
			if( xhr.readyState == 4 && xhr.status == 200 ) {
				var data = xhr.responseText;
				var json = eval(data);
				location.href = "view.korea?idx="+${vo.idx}+"&name="+json[0].name;
			}
		}
		
		
</script>

</head>
<body>
	<jsp:include page="../music/index.jsp"/>
	<div class="jumbotron text-center">
	<div class="container">
	<div class="raw">
		
	<table class="table">
	<h3>${ vo.m_title }</h3>
		<ul class="nav navbar-nav navbar-right" ><li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
            		${vo.name}님 정보<span class="caret"></span></a>
              	<ul class="dropdown-menu">
                	<li><a href="otherlist_list.korea?idx=${vo.memberidx}">${vo.name}님의 PlayList</a></li>
					<li><a href="../music/other_list.korea?idx=${vo.memberidx }">${vo.name}님의 Post</a></li>
                </ul>
            </li>
        </ul>
        
	<tr>
		<td>
			<img src ="../musicfile/${ vo.m_image }" width = "50%" class="col-lg-4" alt="Cinque Terre">
			<br><h4>${ vo.m_content }</h4><br>
			
			<h5>${ vo.m_musicfile }</h5>
			<audio src="../musicfile/${ vo.m_musicfile }" controls ></audio><br>
			Like: ${ vo.m_goodpoint}
				<input type="button" class="btn btn-warning btn-sm" value="like" onclick = "goodpoint('${vo.idx}','${vo.name }');">
				<input type="button" class="btn btn-warning btn-sm" value="addList" onclick="addListf('${vo.idx}','${sessionScope.idx}');">
				
				<c:set var = "result" value="${vo.memberidx}"/>
				<c:if test = "${ result eq sessionScope.idx && sessionScope.name ne '관리자'}"> <!-- 삭제버튼은 내가 쓴 글만 보이게 -->
					<input type="button" class="btn btn-warning btn-sm" value="delete" onclick = "deletef('${vo.idx}');">
				</c:if>
				<c:if test = "${ sessionScope.authority eq 1 }"> <!-- 관리자는 무조건 삭제버튼 -->
					<input type="button" class="btn btn-warning btn-sm" value="delete" onclick = "deletef('${vo.idx}');">
				</c:if>
			</td>
		</tr>
		</table>
		<hr>
	<!-- -----------------------------------댓글 쓰기(비회원x)----------------------------------------------->
		<form align="center"> 
			<input type="hidden" name="musicidx" value="${vo.idx}">
			<textarea name = "c_content" placeholder="comment" rows="2" cols="70"></textarea>
			<input type="button" class="btn btn-warning btn-sm" value="comment" onclick="writedata(this.form,'${vo.name}','${sessionScope.idx}');">
		<br><br><br>
		</form>
	<!-- ----------------------------------댓글리스트(비회원o)------------------------------------------------>
		<table align="center" width="600" style="border-collapse : collapse">
			<c:if test="${ empty list }">
				<tr>
					<br><td align="center">No comment.</td>
				</tr>
			</c:if>
			<c:forEach var="s" items="${list}">
				<tr>
					<td width="10%">${s.c_name} </td>
					<td width="40%">${s.c_content }</td>
					<td width="20%"><input type="button" class="btn btn-warning btn-sm" value="like" onclick ="CgoodFn('${s.idx}','${vo.name }');">  
					${s.c_goodpoint } </td> 
					<td width="20%">${ s.c_date }</td>
					<c:set var = "result" value="${s.memberidx}"/>
						<c:if test = "${ result eq sessionScope.idx && sessionScope.name ne '관리자'}"> <!-- 내 댓글만 삭제버튼 -->
						<td><input type= "button" class="btn btn-warning btn-sm" value ="delete" onclick ="Cmtdel( '${s.idx}','${vo.name }' );"></td>
					</c:if>
					<c:if test = "${ sessionScope.authority eq 1 }"> <!-- 관리자는 무조건 삭제버튼 -->
						<td><input type= "button" class="btn btn-warning btn-sm" value ="delete" onclick ="Cmtdel( '${s.idx}','${vo.name }' );"></td>
					</c:if>
				</tr>
			</c:forEach>
			
			<!---------------------------------------- 댓글 페이징 --------------------------------------------------->
			<tr>
			
			<td colspan="5" align="center">
				<br><br>
				<!-- 첫 페이지로 이동하는 버튼. 그냥 파라미터로 1넣으면 됨 -->
				<input type="button" class="btn btn-warning btn-sm" value="처음" onclick="location.href='${url}?page=1&idx=${idx}&name=${name}'">
				
				<!-- 이전 페이지로 이동하는 버튼. 현재페이지-1 -->
				<c:if test="${paging.currentPage > 1}">
					<input type="button" class="btn btn-warning btn-sm" value="이전" onclick="location.href='${url}?page=${paging.currentPage-1}&idx=${idx}&name=${name}'">
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
						<input type="button" class="btn btn-warning btn-sm" value="${i}" onclick="location.href='${url}?page=${i}&idx=${idx}&name=${name}'">
					</c:if>
					
				</c:forEach>
				
				<!-- 다음 버튼 (현재페이지+1) -->
				<c:if test="${paging.currentPage < paging.totalPage}">
					<input type="button" class="btn btn-warning btn-sm" value="다음" onclick="location.href='${url}?page=${paging.currentPage+1}&idx=${idx}&name=${name}'">
				</c:if>
				<!-- 현재 페이지가 마지막페이지이면 '다음'은 비활성화 버튼으로 만든다. -->
				<c:if test="${paging.currentPage >= paging.totalPage}">
					<input type="button" class="btn btn-warning btn-sm" value="다음" disabled="disabled">
				</c:if>

				<!-- 마지막 페이지로 이동하는 버튼. -->
				<input type="button" class="btn btn-warning btn-sm" value="끝" onclick="location.href='${url}?page=${paging.totalPage}&idx=${idx}&name=${name}'">
			</td>
		</tr>
			
		</table>
	</div>
	</div>
	</div>
	</body>
</html>