<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- ============================ Call To Action ================================== -->
<section class="theme-bg call_action_wrap-wrap">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">

				<div class="call_action_wrap">
					<div class="call_action_wrap-head">
						<h3>원더의 프리랜서가 당신의 연락을 기다립니다</h3>
					</div>
					<a href="<c:url value='/contactUs/contactUs'/>"
						class="btn btn-call_action_wrap">문의하기</a>
				</div>

			</div>
		</div>
	</div>
</section>
<!-- ============================ Call To Action End ================================== -->

<!-- ============================ Footer Start ================================== -->
<footer class="dark-footer skin-dark-footer style-2">
	<div class="footer-middle">
		<div class="container">
			<div class="row">

				<div class="col-lg-5 col-md-5">
					<div class="footer_widget">
						<!-- img src="${pageContext.request.contextPath}/img/logo-light.png" class="img-footer small mb-2" alt="" / -->
						<h4 class="extream mb-3">WONDER</h4>
						<p style="font-size: 1.4em">원더는 실력있는 개발자, 디자이너와 함께합니다</p>
					</div>
				</div>

				<div class="col-lg-6 col-md-7 ml-auto">
					<div class="row">

						<div class="col-lg-4 col-md-4">
							<div class="footer_widget">
								<h4 class="widget_title">Service</h4>
								<ul class="footer-menu">
									<li><a href="<c:url value='/aboutUs/aboutUs'/>">서비스소개</a></li>
									<li><a href="<c:url value='/faq/faq'/>"">FAQ</a></li>
									<%-- <li><a href="<c:url value='/contactUs/contactUs'/>">고객센터</a></li> --%>
								</ul>
							</div>
						</div>

						<div class="col-lg-4 col-md-4">
							<div class="footer_widget">
								<h4 class="widget_title">Company</h4>
								<ul class="footer-menu">
									<!-- <li><a href="#">회사소개</a></li> -->
									<li><a href="<c:url value='/contactUs/contactUs'/>">고객센터 및 제휴제안</a></li>
								</ul>
							</div>
						</div>

						<div class="col-lg-4 col-md-4">
							<div class="footer_widget">
								<h4 class="widget_title">Provision</h4>
								<ul class="footer-menu">
									<li><a href="<c:url value='/provision/terms'/>">이용약관</a></li>
									<li><a href="<c:url value='/provision/provision'/>">개인정보처리방침</a></li>
									<!-- <li><a href="#">위치기반서비스 이용약관</a></li> -->
								</ul>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="footer-bottom">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-12 col-md-12 text-center">
					<a href="<c:url value='/admin/login'/>">
						<p class="mb-0">© WONDER Corp</p>
					</a>
				</div>
			</div>
		</div>
	</div>
</footer>
<!-- ============================ Footer End ================================== -->

<!-- kakao -->



<!-- Log In Modal -->
<div class="modal fade" id="login" tabindex="-1" role="dialog"
	aria-labelledby="registermodal" aria-hidden="true">
	<div class="modal-dialog modal-xl login-pop-form" role="document">
		<div class="modal-content overli" id="registermodal">
			<div class="modal-body p-0">
				<div class="resp_log_wrap">
					<div class="resp_log_thumb"
						style="background:url(${pageContext.request.contextPath}/img/coding.jpg)no-repeat;"></div>
					<div class="resp_log_caption">
						<span class="mod-close" data-dismiss="modal" aria-hidden="true"><i
							class="ti-close"></i></span>
						<div class="edlio_152">
							<ul class="nav nav-pills tabs_system center" id="pills-tab"
								role="tablist">
								<li class="nav-item"><a class="nav-link active"
									id="pills-login-tab" data-toggle="pill" href="#pills-login"
									role="tab" aria-controls="pills-login" aria-selected="true"><i
										class="fas fa-sign-in-alt mr-2"></i>로그인</a></li>
								<li class="nav-item"><a class="nav-link"
									id="pills-signup-tab" data-toggle="pill" href="#pills-signup"
									role="tab" aria-controls="pills-signup" aria-selected="false"><i
										class="fas fa-user-plus mr-2"></i>회원가입</a></li>
							</ul>
						</div>
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-login"
								role="tabpanel" aria-labelledby="pills-login-tab">
								<div class="login-form">
				
				
				<!-- 로그인 -->
	<script type="text/javascript" src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/member.js'/>"></script>
	<script type="text/javascript">
			$(function() {
			$('form[name=loginForm]').submit(function(){
			if($.trim($('#loginId').val()) == "") {
				alert("아이디를 입력해주세요.");
				$('#loginId').focus();
				event.preventDefault();
			} else if ($("#loingPwd").val().length < 1) {
				alert("비밀번호를 입력하세요");
				$("#loingPwd").focus();
				event.preventDefault();
			}
		});
	});
</script>


<form name="loginForm" action="<c:url value='/member/login'/>" method="post">
	<div class="form-group">
		<label>회원 아이디</label>
		<div class="input-with-icon">
			<input type="text" class="form-control"
			name="userId" id="loginId">
			<i class="ti-user">	</i>
		</div>
	</div>

	<div class="form-group">
		<label>비밀 번호</label>
		<div class="input-with-icon">
			<input type="password" class="form-control"
			 name="pwd" id="loingPwd">
			 <i class="ti-unlock">	</i>
		</div>
	</div>
	<div class="form-group">
		<button type="button" id="CallLogin" class="btn btn-md full-width pop-login">로그인</button>
	</div>
</form>

<script type="text/javascript">
	$(function(){
		$('#CallLogin').click(function(){
			var userId = $("#loginId").val();
			var userPwd = $("#loingPwd").val();
/* 			if($.trim($('#loginId').val()) == "") {
				alert("아이디를 입력해주세요.");
				$('#loginId').focus();
				event.preventDefault();
			} else if ($("#loingPwd").val().length < 1) {
				alert("비밀번호를 입력하세요");
				$("#loingPwd").focus();
				event.preventDefault();
			} */
			
			$.ajax({
				type: "post",
				url : "/wonder/member/ajaxLogin",
				dataType : "json",
				data : {"userId":userId, "pwd":userPwd},
				success : function(data){
					console.log(data);
					if (data == 1){
						 alert('로그인 되었습니다.'); 
						location.reload();
						return false;
					} else {
						 alert('계정 정보를 확인하세요.'); 
					}
				}
			});
		});

	});
		function findUserId(){
			window.open("/wonder/member/findUserId","findUserId",
		"width=400,height=350,location=yes,resizable=yes,top=100,left=50");	
		}
		function findPwd(){
			window.open("/wonder/member/findPwd","findPwd",
		"width=400,height=350,location=yes,resizable=yes,top=100,left=50");	
		}
</script>
	
	<div class="form-group">
		<div class="eltio_ol9">
			<div class="eltio_k2">
			
			</div>
			<div class="eltio_k2">
				<a href='#' onclick="findUserId();">아이디 찾기</a>
				<a href="#" onclick="findPwd();" style="margin-left: 225px;">비밀번호 찾기</a>
			</div>
		</div>
	</div>

	<!-- e001f5b6437ab5c78a358d107808c37c -->
	<!-- 카카오 로그인 api 어떻게 사용하징? -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
	function loginFormWithKakao(){
		Kakao.init('e001f5b6437ab5c78a358d107808c37c');
		Kakao.Auth.login({
	        success: function(authObj) {
	          //2. 로그인 성공시, API 호출
	          Kakao.API.request({
	            url: '/v2/user/me',
	            success: function(res) {
	              console.log(res);
	              var id = res.id;
	              var account = res.kakao_account;
	              $('#form-kakao-login input[name=email]').val(account.email);
	              $('#form-kakao-login input[name=nick]').val(account.profile.nickname);
	              $('#form-kakao-login input[name=img]').val(account.profile.img);
				  scope : 'account_email';
				alert('로그인성공');
				document.querySelector('#form-kakao-login').submit();
	        }
	          })
	          console.log(authObj);
	          var token = authObj.access_token;
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      });
	};
	</script>
	<div class="kakao_login">
	<a class="kakao" id="reauthenticate-popup-btn" href="javascript:loginFormWithKakao()">
		<img width="100%" src="<c:url value='/img/kakao_login_large_wide.png'/>">
	</a>
				</div>
	<form id="form-kakao-login" method="post" action="<c:url value='/member/kakaoLogin'/>">
			<input type="hidden" name="email"/>
			<input type="hidden" name="nick"/>
			<input type="hidden" name="img"/>
			</form>

		
	</div>
</div>
					
<script type="text/javascript" src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/member.js'/>"></script>
<script type="text/javascript">
	$(function() {
		$('form[name=registerForm]').submit(function() {

		if(!validate_userid($("#userId").val())) {
			alert("아이디는 영문, 숫자, _(밑줄문자)만 가능합니다");
			$("#userId").focus();
			event.preventDefault();	
		}else if ($.trim($('#name').val()) == "") {
			alert("이름을 입력해주세요.");
			$('#name').focus();
			event.preventDefault();
		} else if ($.trim($('#nickname').val()) == "") {
			alert("닉네임을 입력해주세요.");
			$('#nickname').focus();
			event.preventDefault();
		} else if ($("#pwd").val().length < 1) {
			alert("비밀번호를 입력하세요");
			$("#pwd").focus();
			event.preventDefault();
		} else if ($("#pwd").val() != $("#pwd2").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#pwd2").focus();
			event.preventDefault();
		} else if ($("#tel").val().length < 1) {
			alert("전화번호를 입력해 주세요");
			$("#tel").focus();
			event.preventDefault();
		}  else if ($('#chkId').val() != 'Y') {
			alert("아이디 중복확인해야 합니다");
			$("#btnChkId").focus();
			event.preventDefault();  
		} 
});
		
		$('#userId').keyup(function() {
	         var data = $(this).val();
	         if (validate_userid(data) && data.length >= 2) {
	            $.ajax({
	               url : "<c:url value='/member/dupId'/>",
	               type : 'GET',
	               data : "userId=" + data,
	               success : function(res) {

	                  var output = "";
	                  if (res) {
	                     output = "사용가능한 아이디";
	                     $('#chkId').val('Y');
	                  } else {
	                     output = "이미 등록된 아이디";
	                     $('#chkId').val('N');
	                  }
	                  $('.error').text(output);
	               },
	               error : function(xhr, status, error) {
	                  alert("error:" + error);
	               }

	            });
	         } else {
	            $('.error').text('아이디 규칙에 맞지 않습니다.');
	            $('#chkId').val('N');
	         }
	      });
		});
</script>


<div class="tab-pane fade" id="pills-signup" role="tabpanel"
	aria-labelledby="pills-signup-tab">
	<div class="login-form">
		<!-- 회원가입 -->
	<form name="registerForm"
		action="<c:url value='/member/register'/>" method="post">
		<div class="form-group">
			<label>회원 ID</label>
			<div class="input-with-icon">
				<input type="text" class="form-control" name="userId" id="userId">
				<i class="ti-user"></i>
				<span class="error" style="color:red"></span>
		<!-- 		
				<input type="button" value="중복확인" id="btnChkId" 
						title="새창열림"> -->
			</div>
		</div>
		<div class="form-group">
			<label>이름</label>
			<div class="input-with-icon">
				<input type="text" class="form-control" name="name" id="name">
				<i class="ti-user"></i>
			</div>
		</div>
		<div class="form-group">
			<label>닉네임</label>
			<div class="input-with-icon">
				<input type="text" class="form-control" name="nickname" id="nickname">
				<i class="ti-user"></i>
			</div>
		</div>
		<div class="form-group">
			<label>비밀번호</label>
			<div class="input-with-icon">
				<input type="password" class="form-control" name="pwd" id="pwd">
				<i class="ti-unlock"></i>
			</div>
		</div>
		<div class="form-group">
			<label>비밀번호 확인</label>
			<div class="input-with-icon">
				<input type="password" class="form-control" name="pwd2" id="pwd2">
				<i class="ti-unlock"></i>
			</div>
		</div>

		<div class="form-group">
			<label>이메일</label>
			<div class="input-with-icon">
				<input type="email" class="form-control" name="email" id="email">
				<i class="ti-user"></i>
			</div>
		</div>
		<div class="form-group">
			<label>연락처</label>
			<div class="input-with-icon">
				<input type="text" class="form-control" name="tel" id="tel" placeholder="공백 없이 - 를 사용해서 작성하세요.">
				<i class="ti-user"></i>
			</div>
		</div>
				<input type="hidden" name="chkId" id="chkId">
		<!-- <div class="form-group">
			<div class="eltio_ol9">
				<div class="eltio_k1">
					<input id="dd" class="checkbox-custom" name="dd"
						type="checkbox"> <label for="dd"
						class="checkbox-custom-label">이용약관에 동의 해주세요.</label>
				</div>
			</div>
		</div> -->

		<div class="form-group">
			<button type="submit" class="btn btn-md full-width pop-login">회원가입</button>
		</div>

									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- End Modal -->

<!-- Video Modal -->
<div class="modal fade" id="popup-video" tabindex="-1" role="dialog"
	aria-labelledby="popup-video" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<iframe class="embed-responsive-item" class="full-width" height="480"
			src="https://www.youtube.com/embed/qN3OueBm9F4?rel=0" frameborder="0"
			allowfullscreen></iframe>
	</div>
</div>
<!-- End Video Modal -->

<a id="back2Top" class="top-scroll" title="Back to top" href="#"><i
	class="ti-arrow-up"></i></a>


</div>
<!-- ============================================================== -->
<!-- End Wrapper -->
<!-- ============================================================== -->

<!-- ============================================================== -->
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