<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Sign in</title>

		<script src="../js/httpRequest.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<link rel="stylesheet" href="../css/style.css">

		<script>
			function send(f) {
				var id = f.id.value.trim();
				var pw = f.pw.value.trim();
				
				if( id == '' || pw == '' ) {
					alert("Input ID or PW!!");
					return;
				}
				var url = "login.korea";
				var param = "id=" + encodeURIComponent(id) +
							"&pw=" + encodeURIComponent(pw);
				// login.korea?id=111&pwd=222 형태를 만든다
				sendRequest( url, param, resultFn, "POST" );
			}
			
			function resultFn() {  // id/pw 체크 후 콜백될 함수
				if( xhr.readyState == 4 && xhr.status == 200 ) {
					var data = xhr.responseText;
					var json = eval(data);
					
					// login.korea에서 이렇게 json 값을 만들어 줄 예정!
					if( json[0].param == 'no' ) {
						alert("로그인정보가 일치하지 않습니다.");
					}
					else if( json[0].param == 'yes' ) {
						// 정상이라면 페이지 이동
						// main 페이지를 보이기 전에 거쳐갈 컨트롤러 서블릿
						location.href = "clear.korea";
					}
				}
			}
		</script>
	</head>
	<body>

	<jsp:include page="../music/index.jsp"/>
	<div class="jumbotron text-center">
		<form> 
		<div class="container">
		<div class="row">
				
				<h3>Sign in to Orange</h3><br> 
				<div class="form-group">
					<label for="ID">ID
					<input type = "text" class="form-control" name="id" placeholder="Enter ID"></label>
				<br>
				</div>
				
				
				<div class="form-group">
					<label for="PWD">Password
					<input type="password" class="form-control" name="pw" placeholder="Enter passsword"/></label>
					<br>
				</div>
				
				<div>
					<div class="form-group">
					<button type="button" value="login" class="btn btn-warning btn-sm" onclick="send(this.form);">Sign in</button>
					
					</div>
				</div>
				</div>
				</div>				
		</form>
	</div>
	</body>
</html>


