<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>MemberList</title>
		<style>
		.regi {	witdh : 600px;
				align : center;
				text-align : center;
				margin : auto;
				margin-bottom : 6px; }
		</style>
		<script src="../js/httpRequest.js"></script>
		<script>
			function del(idx){
				if(confirm("정말 삭제하시겠습니까?") == false) {
					return;
				}
				var url = "member_delete.korea";
				var param = "idx=" + idx;
				sendRequest( url, param, resultFn, "POST" );
			}
			function resultFn() {
				if( xhr.readyState == 4 && xhr.status == 200 ){
					location.href = "member_list.korea";
				}
			}
		</script>
	</head>
	<body>
		<jsp:include page="../music/index.jsp"/>
		<div class="jumbotron text-center">
		<div class="container">
		<h3>Member List</h3><br>
		
  		<table class="table table-striped">
   		 <thead class="thead-light">
     	 <tr>
         <th>Index:</th>
        <th>Name:</th>
        <th>ID:</th>
        <th>PW:</th>
        <th>Age:</th>
        <th>Phone:</th>
      </tr>
    </thead>
    <tbody>
    <tr>
	<c:forEach var="vo" items="${ list }">
	<c:if test = "${ vo.name ne '관리자'}"> <!-- 관리자는 회원리스트에 안보여줄거다. -->
    <td>${ vo.idx }</td>
    
    <td>${ vo.name }</td>
    
    <td>${ vo.id }</td>
    
    <td>${ vo.pw }</td>
    
    <td>${ vo.age }</td>
    
    <td>${ vo.phone }</td>
    
	<td><input type="button" class="btn btn-warning btn-sm" value="delete" onclick="del('${vo.idx}');" /></td>
	</tr>    
				</c:if>
			</c:forEach>
    </tbody>
    
    <!-- 페이징 -->
    	<tfoot>
					<td colspan="7" align="center">
						<!-- 첫 페이지로 이동하는 버튼. 그냥 파라미터로 1넣으면 됨 --> <input type="button"
						class="btn btn-warning btn-sm" value="처음"
						onclick="location.href='${url}?page=1&idx=${idx}'"> <!-- 이전 페이지로 이동하는 버튼. 현재페이지-1 -->
						<c:if test="${paging.currentPage > 1}">
							<input type="button" class="btn btn-warning btn-sm" value="이전"
								onclick="location.href='${url}?page=${paging.currentPage-1}&idx=${idx}'">
						</c:if> <!-- 현재 페이지가 1이면 '이전'은 비활성화 버튼으로 만든다. --> <c:if
							test="${paging.currentPage <= 1}">
							<input type="button" class="btn btn-warning btn-sm" value="이전"
								disabled="disabled">
						</c:if> <!-- 1~10 각 페이지 버튼 만들기
						startPage, endPage 이런 값들은 이미 Paging 객체 생성 시 다 계산해놨다!! --> <c:forEach
							var="i" begin="${paging.startPage}" end="${paging.endPage}"
							step="1">

							<!-- 현재 페이지의 버튼이라면 클릭할 필요 없다. 비활성화 -->
							<c:if test="${paging.currentPage == i}">
								<input type="button" class="btn btn-warning btn-sm" value="${i}"
									disabled="disabled">
							</c:if>

							<c:if test="${paging.currentPage != i}">
								<input type="button" class="btn btn-warning btn-sm" value="${i}"
									onclick="location.href='${url}?page=${i}&idx=${idx}'">
							</c:if>

						</c:forEach> <!-- 다음 버튼 (현재페이지+1) --> <c:if
							test="${paging.currentPage < paging.totalPage}">
							<input type="button" class="btn btn-warning btn-sm" value="다음"
								onclick="location.href='${url}?page=${paging.currentPage+1}&idx=${idx}'">
						</c:if> <!-- 현재 페이지가 마지막페이지이면 '다음'은 비활성화 버튼으로 만든다. --> <c:if
							test="${paging.currentPage >= paging.totalPage}">
							<input type="button" class="btn btn-warning btn-sm" value="다음"
								disabled="disabled">
						</c:if> <!-- 마지막 페이지로 이동하는 버튼. --> <input type="button"
						class="btn btn-warning btn-sm" value="끝"
						onclick="location.href='${url}?page=${paging.totalPage}&idx=${idx}'">
					</td>

				</tfoot>
  </table>
</div>
</div>
	</body>
</html>
