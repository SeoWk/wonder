<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<script src="${pageContext.request.contextPath}/js/adminpaging.js"></script>
<style type="text/css">
#img {
	padding-left: 10px;
}

.divSearch {
	flex: 0 0 100%;
	display: flex;
	justify-content: space-between;
}

#formflex {
	display: contents;
}

#optionbar {
	max-width: 300px;
	display: flex;
}

#searchinput {
	width: 220px;
}

div#srchTitBar {
	height: 30px;
}

#searchment {
	padding-left: 20px;
}
</style>
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
			<input type="hidden" id="link" value="nonApprovalList">
			<%@ include file="../admin/menubar.jsp"%>

			<form action="<c:url value='/admin/nonApprovalList'/>" method="post"
				name="frmPage">
				<input type="hidden" name="searchKeyword"
					value="${param.searchKeyword }"> <input type="hidden"
					name="searchCondition" value="${param.searchCondition }"> <input
					type="hidden" name="currentPage">
			</form>

			<div class="col-lg-9 col-md-8 col-sm-12">
				<div class="dashboard-body">

					<div class="col-lg-12 col-md-12">
						<div class="_prt_filt_dash">

							<div class="divSearch">
								<form name="frmSearch" method="post" id="formflex"
									action='<c:url value="/admin/nonApprovalList"/>'>
									<div class="_prt_filt_dash_flex">
										<div class="foot-news-last" id="optionbar">
											<div class="col-lg-6 col-md-6 col-sm-6">
												<div class="form-group">
													<select name="searchCondition" class="form-control">
														<option value="user_Id"
															<c:if test="${param.searchCondition == 'user_Id'}">selected="selected"</c:if>>아이디</option>
													</select>
												</div>
											</div>
											<div class="input-group">
												<input type="text" class="form-control" id="searchinput"
													name="searchKeyword" placeholder="아이디로 조회"
													value="${param.searchKeyword}">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>

					<c:if test="${!empty param.searchKeyword }">
						<p id="searchment">
							"${param.searchKeyword}" 검색 결과 총 <strong class="tit_cnt">${pagingInfo.totalRecord}</strong>
							건 검색되었습니다.
						</p>
					</c:if>

					<div class="dashboard-wraper">

						<!-- Bookmark Property -->
						<div class="frm_submit_block">
							<h4>거래대기 목록</h4>
						</div>
						<table class="property-table-wrap responsive-table bkmark">

							<tbody>
								<tr>
									<th><i class="fa fa-file-text"></i>결제 승인되지 않은 거래 내역</th>
									<th></th>
								</tr>
								<c:if test="${!empty list }">
									<c:forEach var="formVo" items="${list }">
										<!-- Item #1 -->
										<tr>
											<td class="dashboard_propert_wrapper"><a
												href="../mypage/form?formNo=${formVo.formNo}"><img
													src="${pageContext.request.contextPath}/img/adminImg/formImg.jpg"
													alt="상품 사진" /></a>
												<div class="title">
													<c:if test="${fn:length(formVo.formTitle)>40}">
														<h4>
															<a href="../mypage/form?formNo=${formVo.formNo}">${fn:substring(formVo.formTitle,0,40)}...</a>
														</h4>
													</c:if>
													<c:if test="${fn:length(formVo.formTitle)<=40}">
														<h4>
															<a href="../mypage/form?formNo=${formVo.formNo}">${formVo.formTitle}</a>
														</h4>
													</c:if>
													<span>${formVo.userId }</span> <span
														class="table-property-price">${formVo.price } 만원</span>
												</div></td>
											<td class="action"><a
												href="deleteForm?formNo=${formVo.formNo}" class="delete" onclick="return confirm('해당의뢰서를 삭제처리 하시겠습니까?');"><i
													class="ti-close"></i> Delete</a></td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<!-- row -->
					<%@ include file="../adminInc/pagination.jsp"%>
				</div>
			</div>

		</div>
	</div>
</section>
<!-- ============================ User Dashboard End ================================== -->
<%@ include file="../inc/bottom.jsp"%>