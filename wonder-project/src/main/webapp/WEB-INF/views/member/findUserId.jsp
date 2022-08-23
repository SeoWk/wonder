<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID</title>
<style>
:root { -
	-input-padding-x: 1.5rem; -
	-input-padding-y: .75rem;
}

body {
	background-color: white;
}

.card-signin {
	border: 0;
	border-radius: 1rem;
	box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.card-signin .card-title {
	margin-bottom: 2rem;
	font-weight: 300;
	font-size: 1.5rem;
}

.card-signin .card-body {
	padding: 2rem;
}

.form-signin {
	width: 100%;
}

.form-signin .btn {
	font-size: 80%;
	border-radius: 5rem;
	letter-spacing: .1rem;
	font-weight: bold;
	padding: 1rem;
	transition: all 0.2s;
}

.form-label-group {
	position: relative;
	margin-bottom: 1rem;
}

.form-label-group input {
	height: auto;
	border-radius: 2rem;
}

.form-label-group>input, .form-label-group>label {
	padding: var(- -input-padding-y) var(- -input-padding-x);
}

.form-label-group>label {
	position: absolute;
	top: 0;
	left: 0;
	display: inline_block;
	width: 100%;
	margin-bottom: 0;
	/* Override default `<label>` margin */
	line-height: 1.5;
	color: #495057;
	border: 1px solid transparent;
	border-radius: .25rem;
	transition: all .1s ease-in-out;
}

.form-label-group input::-webkit-input-placeholder {
	color: transparent;
}

.form-label-group input:-ms-input-placeholder {
	color: transparent;
}

.form-label-group input::-ms-input-placeholder {
	color: transparent;
}

.form-label-group input::-moz-placeholder {
	color: transparent;
}

.form-label-group input::placeholder {
	color: transparent;
}

.form-label-group input:not(:placeholder-shown) {
	padding-top: calc(var(- -input-padding-y)+ var(- -input-padding-y)* (2/3));
	padding-bottom: calc(var(- -input-padding-y)/3);
}

.form-label-group input:not(:placeholder-shown) ~label {
	padding-top: calc(var(- -input-padding-y)/3);
	padding-bottom: calc(var(- -input-padding-y)/3);
	font-size: 12px;
	color: #777;
}
</style>
<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">

<!-- Bootstrap core JavaScript -->
<script src="jquery/jquery.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
<script type="text/javascript">

	$(function(){
		$("#findUserId").click(function(){
			var name = $("#userName").val();
			var email = $("#userEmail").val();
			
			var output="";
			
			$.ajax({
				type: "post",
				url : "/wonder/member/ajaxFindUserId",
				dataType : "json",
				data : {"name":name, "email":email},
				success : function(res){
						console.log(res);

						output=res.msg;
						var text1="찾으시는 아이디는 ";
						var text2=" 입니다."
						document.querySelector("#chkId").innerText =output;
						if(res.SUCCESS) {
							$("#resBtn").html("<button onClick=resIdPass()>사용하기</button>");
						}else{
							$("#resBtn").html("");
						}
						
					},
					error : function(xhr, status, error) {
	                  alert("error:" + error);
					}
			});
		});
		
	});	
	

	function resIdPass() {
		$(opener.document).find('#loginId').val(document.querySelector("#chkId").innerText);
		
		self.close();
	}
</script>
</head>
<body>
		<div style="text-align: center"> Wonder 아이디 찾기</div>
		<br><br>
		<div class="" style="text-align: center">
			<input type="text" style="color: black" id="userName" name="userName" class="" placeholder="이름을 입력하세요"/>
			<input type="text" id="userEmail" name="userEmail" class="" placeholder="이메일을 입력하세요"/>
		</div>
		
		<div class="form-label-group">
		</div>

		<div class="form-label-group" style="text-align: center">
			<button type="button" id="findUserId" class="btn btn-md full-width pop-login">아이디 찾기</button>
			<p id="text1"></p>
			<p id="chkId"></p>
			<p id="text2"></p>
			<span id="resBtn"></span>
		</div>
</body>
</html>