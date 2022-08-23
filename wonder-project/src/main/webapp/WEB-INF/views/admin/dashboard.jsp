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
			<input type="hidden" id="link" value="dashboard">
			<%@ include file="../admin/menubar.jsp"%>


			<div class="col-lg-9 col-md-8">
				<div class="dashboard-body">

					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12">
							<h4>
								Wonder 현황 통계: <span class="pc-title theme-cl">Wonder
									Status Statistics</span>
							</h4>
						</div>
					</div>

					<div class="row">

						<div class="col-lg-4 col-md-6 col-sm-12">
							<div class="dashboard_stats_wrap widget-1">
								<div class="dashboard_stats_wrap_content">
									<h4>${sumAllSales}원</h4>
									<span>누적매출</span>
								</div>
								<div class="dashboard_stats_wrap-icon">
									<i class="ti-money"></i>
								</div>
							</div>
						</div>

						<div class="col-lg-4 col-md-6 col-sm-12">
							<div class="dashboard_stats_wrap widget-1">
								<div class="dashboard_stats_wrap_content">
									<h4>${monthlySales}원</h4>
									<span>월매출</span>
								</div>
								<div class="dashboard_stats_wrap-icon">
									<i class="ti-money"></i>
								</div>
							</div>
						</div>

						<div class="col-lg-4 col-md-6 col-sm-12">
							<div class="dashboard_stats_wrap widget-3">
								<div class="dashboard_stats_wrap_content">
									<h4>${countProduct}건</h4>
									<span>상품수</span>
								</div>
								<div class="dashboard_stats_wrap-icon">
									<i class="ti-receipt"></i>
								</div>
							</div>
						</div>

						<div class="col-lg-4 col-md-6 col-sm-12">
							<div class="dashboard_stats_wrap widget-2">
								<div class="dashboard_stats_wrap_content">
									<h4>${countMembers}명</h4>
									<span>누적가입자수</span>
								</div>
								<div class="dashboard_stats_wrap-icon">
									<i class="ti-stats-up"></i>
								</div>
							</div>
						</div>

						<div class="col-lg-4 col-md-6 col-sm-12">
							<div class="dashboard_stats_wrap widget-2">
								<div class="dashboard_stats_wrap_content">
									<h4>${countExperts}명</h4>
									<span>누적프리랜서수</span>
								</div>
								<div class="dashboard_stats_wrap-icon">
									<i class="ti-stats-up"></i>
								</div>
							</div>
						</div>

						<div class="col-lg-4 col-md-6 col-sm-12">
							<div class="dashboard_stats_wrap widget-3">
								<div class="dashboard_stats_wrap_content">
									<h4>${countPayment}건</h4>
									<span>누적거래건수</span>
								</div>
								<div class="dashboard_stats_wrap-icon">
									<i class="ti-receipt"></i>
								</div>
							</div>
						</div>
					</div>


					<div class="row">
						<div class="col-lg-8 col-md-12">
							<div class="card">
								<div class="card-header">
									<h4 class="mb-0">최근 의뢰서 목록</h4>
								</div>
								<div class="card-body p-0">
									<div class="table-responsive">
										<table class="table table-lg table-hover">
											<thead>
												<tr>
													<th>제목</th>
													<th>프리랜서명</th>
													<th>결제여부</th>
													<th>금액</th>
													<th>의뢰일</th>
												</tr>
											</thead>

											<tbody>

												<c:if test="${!empty list}">
													<c:forEach var="formVo" items="${list }">
														<tr>
															<td><a href="#"><c:if
																		test="${fn:length(formVo.formTitle)>20}">
																		<a href="../mypage/form?formNo=${formVo.formNo}">${fn:substring(formVo.formTitle,0,19) }...</a>
																	</c:if> <c:if test="${fn:length(formVo.formTitle)<=20}">
																		<a href="../mypage/form?formNo=${formVo.formNo}">${formVo.formTitle}</a>
																	</c:if></a></td>
															<td>${formVo.PUserId}</td>
															<td><c:if test="${formVo.payFlag eq 'Y'}">
																	<div class="label text-success bg-success-light">결제완료</div>
																</c:if> <c:if test="${formVo.payFlag eq 'N'}">
																	<div class="label text-danger bg-danger-light">결제전</div>
																</c:if></td>
															<td>${formVo.price }원</td>
															<td><fmt:formatDate value="${formVo.formRegdate}"
																	pattern="yyyy-MM-dd HH:mm" /></td>
														</tr>
													</c:forEach>
												</c:if>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-3 col-md-12">
							<div class="card">
								<div class="card-header">
									<h4 class="mb-0">회원 분포율</h4>
								</div>
								<div class="card-body p-0">
									<div class="table-responsive">
										<canvas id="logChart" style="width: 310px; height: 310px;"></canvas>
										<script>
											var ctx = document.getElementById(
													"logChart")
													.getContext('2d');
											var myChart = new Chart(
													ctx,
													{
														type : 'doughnut',
														data : {
															labels : [
																	"일반회원(명)",
																	"프리랜서(명)" ],
															datasets : [ {
																data : [
																		'${NormalMem}',
																		'${ExpertMem}' ],
																backgroundColor : [
																		'rgba(39, 174, 96, 0.2)',
																		'rgba(206, 2, 75, 0.2)'

																],
																borderColor : [
																		'rgba(39,174,96,1)',
																		'rgba(206,2,75,1)'

																],
																borderWidth : 1
															} ]
														},
														options : {
															responsive : false,
															plugins : {
																legend : {
																	labels : {
																		font : {
																			size : 17,
																		}
																	}
																}
															}
														}
													});
										</script>
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-8 col-md-12">
							<div class="card">
								<div class="card-header">
									<h4 class="mb-0">조회수순 게시글 목록 (이번달 기준)</h4>
								</div>
								<div class="card-body p-0">
									<div class="table-responsive">
										<table class="table table-lg table-hover">
											<thead>
												<tr>
													<th>제목</th>
													<th>프리랜서명</th>
													<th>조회수</th>
													<th>등록일</th>
												</tr>
											</thead>
											<tbody>
												<c:if test="${!empty listbyread}">
													<c:forEach var="productVo" items="${listbyread }">
														<tr>
															<td><a href="#"><c:if
																		test="${fn:length(productVo.pdTitle)>30}">
																		<a href="../pd/pdDetail?PdNo=${productVo.pdNo}">${fn:substring(productVo.pdTitle,0,29) }...</a>
																	</c:if> <c:if test="${fn:length(productVo.pdTitle)<=30}">
																		<a href="../pd/pdDetail?PdNo=${productVo.pdNo}">${productVo.pdTitle}</a>
																	</c:if> </a></td>
															<td>${productVo.userId}</td>
															<td>${productVo.readCount}</td>
															<td><fmt:formatDate value="${productVo.regdate }"
																	pattern="yyyy-MM-dd" /></td>
														</tr>
													</c:forEach>
												</c:if>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- row -->
				</div>
</section>
<!-- ============================ User Dashboard End ================================== -->
<%@ include file="../inc/bottom.jsp"%>