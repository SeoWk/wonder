<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/mypage/incSide" />
<%-- <%@ include file="incSide.jsp" %> --%>
<input type="hidden" id="pageCheck" value="changePwd">

<link href="${pageContext.request.contextPath}/css/mypage.css" rel="stylesheet">
<style type="text/css">
.success{
	color: green;
}

.fail{
	color: red;
}
</style>
<script type="text/javascript">
	$(function(){
		$('form[name=frmChangePwd]').submit(function() {
			if ($('#beforePwd').val().length < 1) {
				alert("이전 비밀번호를 입력하세요");
				$('#beforePwd').focus();
				event.preventDefault();
			} else if ($('#newPwd').val().length < 1) {
				alert("새 비밀번호를 입력하세요");
				$('#newPwd').focus();
				event.preventDefault();
			} else if ($("#newPwd").val() != $("#newPwdCheck").val()) {
				alert("새로운 비밀번호가 서로 일치하지 않습니다");
				$("#newPwdCheck").focus();
				event.preventDefault();
			} else if($('.beforePwd').text() != "기존 암호와 일치합니다"){
				alert("이전 비밀번호가 일치하지 않습니다");
				$("#beforePwd").focus();
				event.preventDefault();
			}
		});
		
		$('#beforePwd').keyup(function() {
			var data = $(this).val();

			$.ajax({
				url : "<c:url value='/mypage/checkBefore'/>",
				type : 'GET',
				data : "beforePwd=" + data,
				success : function(response) {
					var output = "";
					if (response) {
						output = "기존 암호와 일치합니다";
						$('.beforePwd').addClass('success');
						$('.beforePwd').removeClass('fail');
					} else {
						output = "기존 암호와 불일치합니다";
						$('.beforePwd').addClass('fail');
						$('.beforePwd').removeClass('success');
					}
					$('.beforePwd').text(output);
				},
				error : function(xhr, status, error) {
					alert("beforePwd:" + beforePwd);
				}
			});
		});
		
		
		$('#newPwd').keyup(function() {
			var newPwd = $('#newPwd').val();
			var newPwdCheck = $('#newPwdCheck').val();

			if (newPwd.length < 1) {
				$('.newPwd').text("필수 입력 사항입니다");
				$('.newPwd').addClass('fail');
				$('.newPwd').removeClass('success');
			} else if (newPwd.length >= 1 && newPwdCheck.length >= 1) {
				if (newPwd != newPwdCheck) {
					$('.newPwdCheck').text("새로운 비밀번호는 서로 일치해야합니다");
					$('.newPwdCheck').addClass('fail');
					$('.newPwdCheck').removeClass('success');
				} else if (newPwd == newPwdCheck) {
					$('.newPwdCheck').text("비밀번호 사용 가능");
					$('.newPwdCheck').addClass('success');
					$('.newPwdCheck').removeClass('fail');
				}
			} else if (newPwd.length >= 1) {
				$('.newPwd').text("");
			}
		});
		
		
		$('#newPwdCheck').keyup(function() {
			var newPwd = $('#newPwd').val();
			var newPwdCheck = $('#newPwdCheck').val();

			if (newPwdCheck.length < 1) {
				$('.newPwdCheck').text("필수 입력 사항");
				$('.newPwdCheck').addClass('fail');
			} else if (newPwd.length >= 1 && newPwdCheck.length >= 1) {
				if (newPwd != newPwdCheck) {
					$('.newPwdCheck').text("새로운 비밀번호는 서로 일치해야합니다");
					$('.newPwdCheck').addClass('fail');
					$('.newPwdCheck').removeClass('success');
				} else if (newPwd == newPwdCheck) {
					$('.newPwdCheck').text("비밀번호 사용 가능");
					$('.newPwdCheck').addClass('success');
					$('.newPwdCheck').removeClass('fail');
				}
			}
		});
		
		
		$('#pwdChangeBt').click(function(){
			if(!confirm('정보를 수정하시겠습니까?')){
				return false;
			}
		});
		
	});
</script>
						
						<div class="col-lg-9 col-md-8">
							<div class="dashboard-body">
							
								<div class="dashboard-wraper" >
								
									<!-- Basic Information -->
									<form name="frmChangePwd" method="post" action="<c:url value='/mypage/changePwd'/>">
										<div class="frm_submit_block">	
											<h4>암호 변경</h4>
											<div class="frm_submit_wrap">
												<div class="form-row">
												
													<div class="form-group col-lg-12 col-md-6">
														<label>이전 비밀번호</label>
														<div class="form-group col-md-6 " style="display: inline-block; margin-left: 40px;">
															<span class="beforePwd"></span>
														</div>
														<input type="password" autocomplete="off" id="beforePwd" name="beforePwd" class="form-control">
													</div>
													
													<div class="form-group col-md-6">
														<label>새로운 비밀번호</label>
														<div class="form-group col-md-6 " style="display: inline-block; margin-left: 40px;">
															<span class="newPwd"></span>
														</div>
														<input type="password" autocomplete="off" id="newPwd" name="newPwd" class="form-control">
													</div>
													
													<div class="form-group col-md-6">
														<label>새로운 비밀번호 확인</label>
														<div class="form-group col-md-6 " style="display: inline-block; margin-left: 40px;">
															<span class="newPwdCheck"></span>
														</div>
														<input type="password" autocomplete="off" id="newPwdCheck" name="newPwdCheck" class="form-control">
													</div>
													
													<div class="form-group col-lg-12 col-md-12">
														<button class="btn btn-theme" type="submit" id="pwdChangeBt">비밀번호 변경하기</button>
													</div>
													
												</div>
											</div>
										</div>
									</form>
								</div>
							
							</div>
						</div>
						
					</div>
				</div>
			</section>
			<!-- ============================ User Dashboard End ================================== -->

			
<%@ include file="../inc/bottom.jsp" %>