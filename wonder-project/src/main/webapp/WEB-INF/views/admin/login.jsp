<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<section class="gray pt-5 pb-5" style="text-align: center;height: 683px;"     >
	<div class="col-lg-9 col-md-8" style="text-align: center">
		<div class="dashboard-body">

			<div class="dashboard-wraper"
				style="margin-left: 175px; padding: 100px; margin-top: 50px">
	
	
	<script type="text/javascript" src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/member.js'/>"></script>
	<script type="text/javascript">
			$(function() {
			$('form[name=loginForm]').submit(function(){
			if($.trim($('#adminId').val()) == "") {
				alert("아이디를 입력해주세요.");
				$('#adminId').focus();
				event.preventDefault();
			} else if ($("#adminPwd").val().length < 1) {
				alert("비밀번호를 입력하세요");
				$("#adminPwd").focus();
				event.preventDefault();
			}
		});
	});

	
	</script>
	
	
	
	
	
	
				<!-- Basic Information -->
				<div class="frm_submit_block">
					<h4>관리자 로그인</h4>
					<form name="loginForm" action="<c:url value='/admin/login'/>" method="post">
					<div class="frm_submit_wrap">
						<div class="form-row">
							<div class="form-group col-md-6">
								<label>관리자 아이디</label> <input type="text" name="adminId"
									id="adminId" class="form-control">
							</div>

							<div class="form-group col-md-6">
								<label>비밀번호</label> <input type="password" name="adminPwd"
									id="adminPwd" class="form-control">
							</div>

							<div class="form-group col-lg-12 col-md-12">
								<button class="btn btn-theme" type="submit">로그인</button>
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
</section>
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