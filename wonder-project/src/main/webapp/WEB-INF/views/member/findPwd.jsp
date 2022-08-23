<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
				$('#findPwd').click(function() {
					if ($.trim($('#userId').val()).length < 1) {
						alert("아이디를 입력해주세요");
						$('#userId').focus();
						event.preventDefault();
					} else if ($.trim($('#name').val()).length < 1) {
						alert("이름을 입력해주세요");
						$('#name').focus();
						event.preventDefault();
					} else if ($.trim($('#email').val()).length < 1) {
						alert("이메일을 입력해주세요");
						$('#email').focus();
						event.preventDefault();
					} else{
						var userId = $('#userId').val();
						var name = $('#name').val();
						var email = $('#email').val();
						
						$.ajax({
							url: "<c:url value='/member/ajaxFindPwd'/>",
							type:"GET",
							data:{
								userId:userId,
								name:name,
								email:email
							},
							async:false,
							success:function(data){
								if(data==0){
									alert('사용자의 정보와 일치하는 계정이 없습니다.');
									
								}else if(data==1){
									var num = Math.floor(Math.random() * 10000)+1;
									$.ajax({
										url: "<c:url value='/email/pwdEmail'/>",
										type:"GET",
										data:{
											pwd:num,
											receiver:email
										},
										async:false,
										success:function(data){
											if(data==0){
												alert('이메일 발송이 실패했습니다');
											}else if(data==1){
												alert('회원님의 이메일로 임시비밀번호가 발송되었습니다.');
												alert('로그인 후 꼭 비밀번호를 변경하세요!');
											}
										},
										error:function(){
											alert('내부 ajax');
										}
									});
								}
							},
							error:function(){
								alert('바깥 ajax');
							}
						});
					}
				});
			});
			function closePwd() {
				
				self.close();
			}
		</script>
</head>
<body>
<!-- Basic Information -->
			<div style="text-align: center"> Wonder 비밀번호 찾기</div>
			<br><br>
						<div class="frm_submit_wrap">
							<div class="form-row">
								<div class="form-group ">
									<label>아이디</label>
									<input type="text" name="userId" id="userId" class="form-control">
								</div>

								<div class="form-group ">
									<label>이름 </label>
									<input type="text" name="name" id="name" class="form-control" style="margin-left: 16px">
								</div>
								<div class="form-group ">
									<label>이메일</label>
									<input type="text" name="email" id="email" class="form-control">
								</div>
								
								<br>
								<div class="form-label-group" style="text-align: center">
									<button class="btn btn-theme" type="submit" id="findPwd">찾기</button>
									<button class="btn btn-theme" onclick="closePwd()">닫기</button>
								</div>
				</div>
			</div>




<!-- All Jquery -->
<!-- ============================================================== -->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/ion.rangeSlider.min.js"></script>
<script src="${pageContext.request.contextPath}/js/select2.min.js'"></script>
<script
	src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath}/js/slick.js"></script>
<script src="${pageContext.request.contextPath}/js/slider-bg.js"></script>
<script src="${pageContext.request.contextPath}/js/lightbox.js"></script>
<script src="${pageContext.request.contextPath}/js/imagesloaded.js"></script>
<script src="${pageContext.request.contextPath}/js/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/js/custom.js"></script>

<!-- Date Booking Script -->
<script src="${pageContext.request.contextPath}/js/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/js/daterangepicker.js"></script>

<!-- 대시보드 js -->
<!-- Morris.js charts -->
<script src="${pageContext.request.contextPath}/js/raphael.min.js"></script>
<script src="${pageContext.request.contextPath}/js/morris.min.js"></script>

<!-- Custom Morrisjs JavaScript -->
<script src="${pageContext.request.contextPath}/js/morris.js"></script>

<!-- ============================================================== -->
<!-- This page plugins -->
<!-- ============================================================== -->

</body>
</html>