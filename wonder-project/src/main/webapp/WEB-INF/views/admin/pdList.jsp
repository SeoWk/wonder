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
			<input type="hidden" id="link" value="pdList">
			<%@ include file="../admin/menubar.jsp"%>

			<form action="<c:url value='/admin/pdList'/>" method="post"
				name="frmPage">
				<input type="hidden" name="searchKeyword"
					value="${param.searchKeyword }"> <input type="hidden"
					name="searchCondition" value="${param.searchCondition }"> <input
					type="hidden" name="currentPage">
			</form>

			<div class="col-lg-9 col-md-8 col-sm-12">
				<div class="dashboard-body">

					<div class="row">
						<div class="col-lg-12 col-md-12">
							<div class="_prt_filt_dash">

								<div class="divSearch">
									<form name="frmSearch" method="post" id="formflex"
										action='<c:url value="/admin/pdList"/>'>
										<div class="_prt_filt_dash_flex">
											<div class="foot-news-last" id="optionbar">
												<div class="col-lg-6 col-md-6 col-sm-6">
													<div class="form-group">
														<select name="searchCondition" class="form-control">
															<option value="pd_Title"
																<c:if test="${param.searchCondition == 'pd_Title'}">selected="selected"</c:if>>제목</option>
															<option value="user_Id"
																<c:if test="${param.searchCondition == 'user_Id'}">selected="selected"</c:if>>아이디</option>
															<option value="lang"
																<c:if test="${param.searchCondition == 'lang'}">selected="selected"</c:if>>언어</option>
															<option value="frame"
																<c:if test="${param.searchCondition == 'frame'}">selected="selected"</c:if>>프레임워크</option>
														</select>
													</div>
												</div>
												<div class="input-group">
													<input type="text" class="form-control" id="searchinput"
														name="searchKeyword" placeholder="회원명, 아이디 등으로 조회"
														value="${param.searchKeyword}">
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>

					<c:if test="${!empty param.searchKeyword }">
						<p id="searchment">
							"${param.searchKeyword}" 검색 결과 총 <strong class="tit_cnt">${pagingInfo.totalRecord}</strong>
							건 검색되었습니다.
						</p>
					</c:if>

					<div class="row">
						<div class="col-lg-12 col-md-12">
							<div class="dashboard_property">
								<div class="table-responsive">
									<table class="table">
										<thead class="thead-dark">
											<tr>
												<th scope="col">게시글목록 / 제목</th>
												<th scope="col" class="m2_hide">아이디</th>
												<th scope="col" class="m2_hide">조회수</th>
												<th scope="col" class="m2_hide">언어/프레임워크</th>
												<th scope="col" class="m2_hide">등록일</th>
												<th scope="col">삭제</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${empty list }">
												<tr>
													<td colspan="5">게시글이 존재하지 않습니다.</td>
												</tr>
											</c:if>
											<c:if test="${!empty list }">
												<!-- tr block -->
												<c:forEach var="productVo" items="${list }">
													<tr>
														<td>
															<div class="dash_prt_wrap">
																<div class="dash_prt_thumb">
																	<a href="../pd/pdDetail?pdNo=${productVo.pdNo}"><img
																		<%-- src="${pageContext.request.contextPath}/img/pdupload/${pdImageVo.fileName }" --%>
																		src="${pageContext.request.contextPath}/img/adminImg/formImg.jpg"
																		class="img-fluid" alt="상품 사진" /></a>
																</div>
																<div class="dash_prt_caption">
																	<c:if test="${fn:length(productVo.pdTitle)>30}">
																		<a href="../pd/pdDetail?pdNo=${productVo.pdNo}"><h5>${fn:substring(productVo.pdTitle,0,30) }...</h5></a>
																	</c:if>
																	<c:if test="${fn:length(productVo.pdTitle)<=30}">
																		<a href="../pd/pdDetail?pdNo=${productVo.pdNo}"><h5>${productVo.pdTitle}</h5></a>
																	</c:if>
																</div>
															</div>
														</td>
														<td class="m2_hide">
															<div class="prt_leads">
																<h6>${productVo.userId }</h6>
															</div>
														</td>
														<td class="m2_hide">
															<div class="prt_leads">
																<span>${productVo.readCount }회</span>
															</div>
															<div class="prt_leads_list">
																<ul>
																	<li><a href="#"><img
																			src="https://via.placeholder.com/500x500"
																			class="img-fluid img-circle" alt="" /></a></li>
																	<li><a href="#"><img
																			src="https://via.placeholder.com/500x500"
																			class="img-fluid img-circle" alt="" /></a></li>
																	<li><a href="#" class="_leads_name style-1">read</a></li>
																	<li><a href="#"><img
																			src="https://via.placeholder.com/500x500"
																			class="img-fluid img-circle" alt="" /></a></li>
																	<li><a href="#" class="leades_more">${productVo.readCount }+</a></li>
																</ul>
															</div>
														</td>
														<td class="m2_hide">
															<div class="_leads_view">
																<c:if test="${fn:length(productVo.lang)>6}">
																	<h5>${fn:substring(productVo.lang,0,6) }...</h5>
																</c:if>
																<c:if test="${fn:length(productVo.lang)<=6}">
																	<h5>${productVo.lang}</h5>
																</c:if>
																<c:if test="${fn:length(productVo.frame)>6}">
																	<h5>/${fn:substring(productVo.frame,0,6) }...</h5>
																</c:if>
																<c:if test="${fn:length(productVo.frame)<=6}">
																	<h5>/${productVo.frame}</h5>
																</c:if>
															</div>
															<div class="_leads_view_title">
																<span>language/framework</span>
															</div>
														</td>
														<td class="m2_hide">
															<div class="_leads_posted">
																<h5>
																	<fmt:formatDate value="${productVo.regdate }"
																		pattern="yyyy-MM-dd HH:mm" />
																</h5>
															</div>
														</td>
														<td>
															<div class="_leads_action">
																<a href="delProduct?pdNo=${productVo.pdNo }" onclick="return confirm('해당상품을 삭제처리 하시겠습니까?');"><i
																	class="fas fa-trash"></i></a>
															</div>
														</td>
													</tr>
												</c:forEach>
											</c:if>

										</tbody>
									</table>
								</div>
							</div>
						</div>
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