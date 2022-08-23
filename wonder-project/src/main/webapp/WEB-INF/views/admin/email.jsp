<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>

<!-- ============================================================== -->
<!-- Top header  -->
<!-- ============================================================== -->

<!-- ============================ Page Title Start================================== -->
<%@ include file="../adminInc/pageTitle.jsp"%>
<!-- ============================ Page Title End ================================== -->

<!-- ============================ User Dashboard ================================== -->
<section class="gray pt-5 pb-5">
	<div class="container-fluid">

		<div class="row">
			<%@ include file="../admin/menubar.jsp"%>

			<div class="col-lg-9 col-md-8 col-sm-12">
				<div class="dashboard-body">
					<div class="dashboard-wraper">
						<!-- row -->
						<form method="get" action="<c:url value='/admin/adEmail' />">
							<div class="frm_submit_block">
								<div class="row">
									<div class="col-lg-12 col-md-12 col-sm-12">
										<h3 class="ml-0">
											관리자 메일 전송 <i class="fa fa-envelope"></i>
										</h3>
									</div>

									<div class="col-lg-12 col-md-12 col-sm-12">
										<div class="form-group">
											<label>이름<i class="req">*</i></label> <input type="text"
												class="form-control simple" name="name">
										</div>
									</div>

									<div class="col-lg-12 col-md-12 col-sm-12">
										<div class="form-group">
											<label>받는사람<i class="req">*</i></label> <input type="email"
												class="form-control" name="email" id="name">
										</div>
									</div>

									<div class="col-lg-12 col-md-12 col-sm-12">
										<div class="form-group">
											<label>제목<i class="req">*</i></label> <input type="text"
												class="form-control" name="title" id="title">
										</div>
									</div>

									<div class="col-lg-12 col-md-12 col-sm-12">
										<div class="form-group">
											<label>내용<i class="req">*</i></label>
											<textarea class="form-control ht-50" name="content"
												id="content"></textarea>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<button class="btn btn-theme" type="submit">전송</button>
							</div>
						</form>
						<!--/row -->
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- ============================ User Dashboard End ================================== -->
<%@ include file="../inc/bottom.jsp"%>
