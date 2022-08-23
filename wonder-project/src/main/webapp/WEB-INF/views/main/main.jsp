<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@ include file="../inc/top.jsp"%>

<!-- ============================ Hero Banner  Start================================== -->
<div class="home-slider margin-bottom-0">

	<!-- Slide -->
<%-- <div data-background-image="<c:url value='/img/main.jpg'/>" --%>
<div data-background-image="<c:url value='/img/coding.jpg'/>"  style="background:url(<c:url value='/img/coding.jpg' />);"
class="item">
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<div class="home-slider-container">

				<!-- Slide Title -->
	<div class="home-slider-desc">
		
		
	<div class="home-slider-title">
		<c:if test='${("일반회원") eq (sessionScope.type) }'>
			<h5 class="offers_tags">작업물 의뢰를 원하시나요?</h5>
			<h3>
				원더에서 의뢰하세요!<br> <span class="trans_text">WONDER</span>
			</h3>
			<%-- <input type="text" value="${sessionScope.type }"> --%>
		</c:if>
		
		<c:if test='${("프리랜서") eq (sessionScope.type) }'>
			<h5 class="offers_tags">상품 등록을 원하시나요?</h5>
			<h3>
				원더에서 등록하세요!<br> <span class="trans_text">WONDER</span>
			</h3>
			<%-- <input type="text" value="${sessionScope.type }"> --%>
		</c:if>
		
		<c:if test='${("프리랜서") ne (sessionScope.type) && ("일반회원") ne (sessionScope.type)}'>
			<h5 class="offers_tags">작업물 의뢰를 원하시나요?</h5>
			<h3>
				원더에서 의뢰하세요!<br> <span class="trans_text">WONDER</span>
			</h3>
			<%-- <input type="text" value="${sessionScope.type }"> --%>
		</c:if>
	</div>
		
		<c:if test='${("일반회원") eq (sessionScope.type) }'>
 		<a href="<c:url value='/pd/pdList'/>"
			class="read-more theme-bg"> 상품목록<i
			class="fa fa-arrow-right ml-2"></i>
		</a>
		</c:if>
		<c:if test='${("승인대기") eq (sessionScope.type) }'>
 		<a href="<c:url value='/pd/pdList'/>"
			class="read-more theme-bg"> 상품목록<i
			class="fa fa-arrow-right ml-2"></i>
		</a>
		</c:if>
		<c:if test='${("프리랜서") eq (sessionScope.type) }'>
		<a href="<c:url value='/pd/pdWrite'/>"
			class="read-more theme-bg"> 상품등록<i
			class="fa fa-arrow-right ml-2"></i>
		</a>
		</c:if>
		<c:if test='${empty sessionScope.type }'>
 		<a href="<c:url value='/aboutUs/aboutUs'/>"
			class="read-more theme-bg"> 원더가 뭐에요?<i
			class="fa fa-arrow-right ml-2"></i>
		</a>
		</c:if>
	</div>
	<!-- Slide Title / End -->

					</div>
				</div>
			</div>
		</div>
	</div>


</div>
<!-- ============================ Hero Banner End ================================== -->

<!-- ============================ Hero Search Start ================================== -->
<section class="p-0 top_overlio">

</section>
<!-- ============================ Hero Search End ================================== -->

<!-- ============================ How It Works Start ================================== -->
<section class="min">
	<div class="container">

		<div class="row justify-content-center">
			<div class="col-lg-6 col-md-6">
				<div class="sec-heading center">
					<h2>의뢰는 어떻게 하나요?</h2>
					<p>처음오신 여러분은 원더에 회원가입 하세요! 그리고 저희가 제공하는 양식에 맞게 의뢰서를 작성해보세요! 원더에
						등록된 전문가들이 연락 드릴거예요!</p>
				</div>
			</div>
		</div>

		<div class="row justify-content-center">

			<div class="col-lg-4 col-md-4 col-sm-12">
				<div class="wpk_process">
					<div class="wpk_thumb">
						<div class="wpk_thumb_figure">
							<img src="assets/img/account-cl.svg" class="img-fluid" alt="" />
						</div>
					</div>
					<div class="wpk_caption">
						<h4>먼저 가입하세요!</h4>
						<p>우리 원더에서는 간편하게 회원가입 할 수 있어요. 지금! 가입하세요.</p>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-4 col-sm-12">
				<div class="wpk_process active">
					<div class="wpk_thumb">
						<div class="wpk_thumb_figure">
							<img src="assets/img/search.svg" class="img-fluid" alt="" />
						</div>
					</div>
					<div class="wpk_caption">
						<h4>전문가 검색 & 의뢰서 작성</h4>
						<p>전문가를 검색해서 직접 의뢰하거나, 의뢰서를 작성해서 전문가들이 의뢰서를 보고 요청해요.</p>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-4 col-sm-12">
				<div class="wpk_process">
					<div class="wpk_thumb">
						<div class="wpk_thumb_figure">
							<img src="assets/img/booking-cl.svg" class="img-fluid" alt="" />
						</div>
					</div>
					<div class="wpk_caption">
						<h4>작업물 확인</h4>
						<p>매칭된 전문가와 회의 및 조율을 통해서 요청하신 작업물을 확인하고, 대금을 지불해요.</p>
					</div>
				</div>
			</div>

		</div>

	</div>
</section>
<div class="clearfix"></div>
<!-- ============================ How It Works End ================================== -->

<!-- ============================ Featured Properties Start ================================== -->
<section class="min light-bg">
	<div class="container">


		<div class="row justify-content-center">
			<div class="col-lg-7 col-md-8">
				<div class="sec-heading center">
					<h2>최근 등록된 상품 목록</h2>
					<p>최근 24시간 이내에 등록된 상품 목록입니다.</p>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12">
				<div class="list_views">

					<!-- Single Item 1 -->
					<c:forEach var="tempList" items="${resList }">
					
					<div class="single_items">
						<div class="row">
							<c:forEach var="vo" items="${tempList }">
							<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12">
								<div class="property-listing list_view">
					
									<div class="listing-img-wrapper">
										<div class=""></div>
										<div class="list-img-slide">
											<a href="single-property-1.html">
											<img src="${pageContext.request.contextPath}/img/pdupload/${vo.fileName}" class="img-fluid mx-auto" alt="" />
											</a>
										</div>
									</div>
					
									<div class="list_view_flex">
					
										<div class="listing-detail-wrapper mt-1">
											<div class="listing-short-detail-wrap">
												<div class="_card_list_flex mb-2">
													<div class="_card_flex_01">
														<span class="_list_blickes _netork" style="width: 80px">기한 :${vo.pdTerm }</span>
														<span class="_list_blickes types" style="width: 80px">수정: ${vo.editCount }</span>
													</div>
													<div class="_card_flex_last">
														<h4 class="listing-name verified">
																<a href="<c:url value='/pd/pdDetail?pdNo=${vo.pdNo}'/>"
																	class="prt-link-detail" id="pdTitle"
																	style="margin-left: 5px">${vo.pdTitle}</a>
															</h4>
													</div>
												</div>
												<div class="_card_list_flex">
													<div class="_card_flex_01">
														<h4 class="listing-name verified">
														</h4>
													</div>
												</div>
											</div>
										</div>
					
										<div class="price-features-wrapper">
									 			<div class="list-fx-features">
													<div class="">
														<p>${vo.lang}</p>
													</div>
													<div class="">
														<p>&nbsp;||${vo.frame}</p>
													</div>

												</div> 
										</div>
					
										<div class="listing-detail-footer">
												<div class="footer-first">
													<div class="foot-location" id="detailPd">
														<h3 class="listing-card-info-price mb-0" id="pdPrice">
														<fmt:formatNumber pattern="#,###" value="${vo.pdPrice }"/> 원
														</h3>
													</div>
														<p>${vo.pdType}</p>
												</div>
												<div class="footer-flex">
													<a
														href="<c:url value='/pd/pdDetail?pdNo=${vo.pdNo}'/>"
														id="viewDetail" class="prt-view">상세보기</a>
												</div>
											</div>
										</div>
									</div>
					
								</div>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
					</div>
<!-- <div class="single_items">
	<div class="row">
		Single Property
		<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12">
			<div class="property-listing list_view">

				<div class="listing-img-wrapper">
					<div class="_exlio_125">NEW</div>
					<div class="list-img-slide">
						<a href="single-property-1.html"><img
							src="https://via.placeholder.com/800x500"
							class="img-fluid mx-auto" alt="" /></a>
					</div>
				</div>

				<div class="list_view_flex">

					<div class="listing-detail-wrapper mt-1">
						<div class="listing-short-detail-wrap">
							<div class="_card_list_flex mb-2">
								<div class="_card_flex_01">
									<span class="_list_blickes _netork">JAVA</span> <span
										class="_list_blickes types">5년</span>
								</div>
								<div class="_card_flex_last">
									<h6 class="listing-card-info-price mb-0">50,000원</h6>
								</div>
							</div>
							<div class="_card_list_flex">
								<div class="_card_flex_01">
									<h4 class="listing-name verified">
										<a href="single-property-1.html" class="prt-link-detail">웹
											페이지 제작해드려요~</a>
									</h4>
								</div>
							</div>
						</div>
					</div>

					<div class="price-features-wrapper">
						<div class="list-fx-features">
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/bed.svg" width="13" alt="" />
								</div>

							</div>
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/bathtub.svg" width="13" alt="" />
								</div>

							</div>
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/move.svg" width="13" alt="" />
								</div>

							</div>
						</div>
					</div>

					<div class="listing-detail-footer">
						<div class="footer-first">
							<div class="foot-rates">
								<span class="elio_rate good">4.4</span>
								<div class="_rate_stio">
									<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
										class="fa fa-star"></i> <i class="fa fa-star"></i> <i
										class="fa fa-star"></i>
								</div>
							</div>
						</div>
						<div class="footer-flex">
							<a href="property-detail.html" class="prt-view">상품 상세보기</a>
						</div>
					</div>
				</div>

			</div>
		</div>
		Single Property 2
		<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12">
			<div class="property-listing list_view">

				<div class="listing-img-wrapper">
					<div class="_exlio_125">NEW</div>
					<div class="list-img-slide">
						<a href="single-property-1.html"><img
							src="https://via.placeholder.com/800x500"
							class="img-fluid mx-auto" alt="" /></a>
					</div>
				</div>

				<div class="list_view_flex">

					<div class="listing-detail-wrapper mt-1">
						<div class="listing-short-detail-wrap">
							<div class="_card_list_flex mb-2">
								<div class="_card_flex_01">
									<span class="_list_blickes _netork">JAVA</span> <span
										class="_list_blickes types">3년</span>
								</div>
								<div class="_card_flex_last">
									<h6 class="listing-card-info-price mb-0">30,000원</h6>
								</div>
							</div>
							<div class="_card_list_flex">
								<div class="_card_flex_01">
									<h4 class="listing-name verified">
										<a href="single-property-1.html" class="prt-link-detail">기본적인 사이트
										제작해드립니다. 망설이지마세요!</a>
									</h4>
								</div>
							</div>
						</div>
					</div>

					<div class="price-features-wrapper">
						<div class="list-fx-features">
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/bed.svg" width="13" alt="" />
								</div>
							</div>
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/bathtub.svg" width="13" alt="" />
								</div>
							</div>
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/move.svg" width="13" alt="" />
								</div>
							</div>
						</div>
					</div>

					<div class="listing-detail-footer">
						<div class="footer-first">
							<div class="foot-rates">
								<span class="elio_rate perfect">4.7</span>
								<div class="_rate_stio">
									<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
										class="fa fa-star"></i> <i class="fa fa-star"></i> <i
										class="fa fa-star"></i>
								</div>
							</div>
						</div>
						<div class="footer-flex">
							<a href="property-detail.html" class="prt-view">상품
								상세보기</a>
						</div>
					</div>
				</div>

			</div>
		</div>
		Single Property  3
		<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12">
			<div class="property-listing list_view">

				<div class="listing-img-wrapper">
					<div class="_exlio_125">NEW</div>
					<div class="list-img-slide">
						<a href="single-property-1.html"><img
							src="https://via.placeholder.com/800x500"
							class="img-fluid mx-auto" alt="" /></a>
					</div>
				</div>

				<div class="list_view_flex">

					<div class="listing-detail-wrapper mt-1">
						<div class="listing-short-detail-wrap">
							<div class="_card_list_flex mb-2">
								<div class="_card_flex_01">
									<span class="_list_blickes _netork">Python</span> <span
										class="_list_blickes types">8년</span>
								</div>
								<div class="_card_flex_last">
									<h6 class="listing-card-info-price mb-0">100,000원</h6>
								</div>
							</div>
							<div class="_card_list_flex">
								<div class="_card_flex_01">
									<h4 class="listing-name verified">
										<a href="single-property-1.html" class="prt-link-detail">파이썬 전문가인
										저와 함께 하시겠습니까?</a>
									</h4>
								</div>
							</div>
						</div>
					</div>

					<div class="price-features-wrapper">
						<div class="list-fx-features">
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/bed.svg" width="13" alt="" />
								</div>
							</div>
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/bathtub.svg" width="13" alt="" />
								</div>
							</div>
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/move.svg" width="13" alt="" />
								</div>
							</div>
						</div>
					</div>

					<div class="listing-detail-footer">
						<div class="footer-first">
							<div class="foot-rates">
								<span class="elio_rate good">4.2</span>
								<div class="_rate_stio">
									<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
										class="fa fa-star"></i> <i class="fa fa-star"></i> <i
										class="fa fa-star"></i>
								</div>
							</div>
						</div>
						<div class="footer-flex">
							<a href="property-detail.html" class="prt-view">상품 상세보기</a>
						</div>
					</div>
				</div>

			</div>
		</div>
		Single Property  4
		<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12">
			<div class="property-listing list_view">

				<div class="listing-img-wrapper">
					<div class="_exlio_125">NEW</div>
					<div class="list-img-slide">
						<a href="single-property-1.html"><img
							src="https://via.placeholder.com/800x500"
							class="img-fluid mx-auto" alt="" /></a>
					</div>
				</div>

				<div class="list_view_flex">

					<div class="listing-detail-wrapper mt-1">
						<div class="listing-short-detail-wrap">
							<div class="_card_list_flex mb-2">
								<div class="_card_flex_01">
									<span class="_list_blickes _netork">AI 인공지능</span> <span
										class="_list_blickes types">20년</span>
								</div>
								<div class="_card_flex_last">
									<h6 class="listing-card-info-price mb-0">협의</h6>
								</div>
							</div>
							<div class="_card_list_flex">
								<div class="_card_flex_01">
									<h4 class="listing-name verified">
										<a href="single-property-1.html" class="prt-link-detail">20년 경력으로 무엇이든 가능합니다.</a>
									</h4>
								</div>
							</div>
						</div>
					</div>

					<div class="price-features-wrapper">
						<div class="list-fx-features">
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/bed.svg" width="13" alt="" />
								</div>
							</div>
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/bathtub.svg" width="13" alt="" />
								</div>
							</div>
							<div class="listing-card-info-icon">
								<div class="inc-fleat-icon">
									<img src="assets/img/move.svg" width="13" alt="" />
								</div>
							</div>
						</div>
					</div>

					<div class="listing-detail-footer">
						<div class="footer-first">
							<div class="foot-rates">
								<span class="elio_rate perfect">4.8</span>
								<div class="_rate_stio">
									<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
										class="fa fa-star"></i> <i class="fa fa-star"></i> <i
										class="fa fa-star"></i>
								</div>
							</div>
						</div>
						<div class="footer-flex">
							<a href="property-detail.html" class="prt-view">상품 상세보기</a>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</div> -->

				</div>
			</div>
		</div>

	</div>
</section>
<!-- ============================ Featured Properties End ================================== -->

<!-- ============================ Property By Location ================================== -->
<!-- 
<section class="min">
	<div class="container">

		<div class="row justify-content-center">
			<div class="col-lg-7 col-md-10 text-center">
				<div class="sec-heading center">
					<h2>의뢰 테이블</h2>
					<p>원더는 3가지의 의뢰 테이블로 구성되어, 각 전문가들이 준비하고 있습니다.
					선택하신 테이블에 맞춰지는 전문가의 컨설팅으로 원더를 시작하세요!</p>
				</div>
			</div>
		</div>

		<div class="row align-items-center">

			Single Package
<div class="col-lg-4 col-md-4">
	<div class="pricing_wrap">
		<div class="prt_head">
			<h4>STANDARD</h4>
		</div>
		<div class="prt_price">
			<h2>
				<span>30,000~</span>
			</h2>
			<span>per user, per month</span>
		</div>
		<div class="prt_body">
			<ul>
				<li>99.5% Uptime Guarantee</li>
				<li>120GB CDN Bandwidth</li>
				<li>5GB Cloud Storage</li>
				<li class="none">Personal Help Support</li>
				<li class="none">Enterprise SLA</li>
			</ul>
		</div>
		<div class="prt_footer">
			<a href="#" class="btn choose_package">STANDARD로 원더</a>
		</div>
	</div>
</div>

Single Package
<div class="col-lg-4 col-md-4">
	<div class="pricing_wrap">
		<div class="prt_head">
			<div class="recommended">인기</div>
			<h4>DELUXE</h4>
		</div>
		<div class="prt_price">
			<h2>
				<span>70,000~</span>
			</h2>
			<span>per user, per month</span>
		</div>
		<div class="prt_body">
			<ul>
				<li>99.5% Uptime Guarantee</li>
				<li>150GB CDN Bandwidth</li>
				<li>10GB Cloud Storage</li>
				<li>Personal Help Support</li>
				<li class="none">Enterprise SLA</li>
			</ul>
		</div>
		<div class="prt_footer">
			<a href="#" class="btn choose_package active">DELUXE로 원더</a>
		</div>
	</div>
</div>

Single Package
			<div class="col-lg-4 col-md-4">
				<div class="pricing_wrap">
					<div class="prt_head">
						<h4>PREMIUM</h4>
					</div>
					<div class="prt_price">
						<h2>
							<span>100,000~</span>
						</h2>
						<span>2 user, per month</span>
					</div>
					<div class="prt_body">
						<ul>
							<li>100% Uptime Guarantee</li>
							<li>200GB CDN Bandwidth</li>
							<li>20GB Cloud Storage</li>
							<li>Personal Help Support</li>
							<li>Enterprise SLA</li>
						</ul>
					</div>
					<div class="prt_footer">
						<a href="#" class="btn choose_package">PREMIUM으로 원더</a>
					</div>
				</div>
			</div>

		</div>

	</div>
</section>
 -->
<%@ include file="../inc/bottom.jsp"%>