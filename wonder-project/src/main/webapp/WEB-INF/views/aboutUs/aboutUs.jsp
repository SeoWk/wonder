<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../inc/top.jsp" %>
<!-- ============================================================== -->
<!-- Top header  -->
<!-- ============================================================== -->

<!-- ============================ Page Title Start================================== -->
<div class="page-title"
	style="background: #f4f4f4 url(<c:url value='/img/sliderss-1-1920x980.jpg' />);" data-overlay="1">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 col-md-12">

				<div class="breadcrumbs-wrap">
					<ol class="breadcrumb">
						<li class="breadcrumb-item active" aria-current="page"></li>
					</ol>
					<h2 class="breadcrumb-title">원더(wonder) 가 궁금하신가요?</h2>
				</div>

			</div>
		</div>
	</div>
</div>
<!-- ============================ Page Title End ================================== -->

<!-- ============================ Our Story Start ================================== -->
<section>

	<div class="container">

		<!-- row Start -->
		<div class="row align-items-center">

			<div class="col-lg-6 col-md-6">
				<div class="story-wrap explore-content">

					<h2>우리 서비스의 이야기</h2>
					<span class="theme-cl">우리의 원더는 이렇게 성장했어요!</span>
					<p class="mt-4">IT 관련 기업 및 직업들이 많아지면서, 
					많은 인구들은 프로그래머로써 취업하길 원했어요. 하지만 취업의 시장은 너무 높거나, 프리랜서로 활동하고 싶은 전문가들이 많았죠.
					또한 기업들과 개인들의 프로그래밍 및 디자인 등 작업물 의뢰가 많아졌습니다.
					 우리 '원더'는 이 부분을 파고들어 의뢰가 필요한 '고객'과 작업이 필요한 '전문가'들이 
					 활동할 수 있는 중개 플랫폼을 오픈했습니다. </p>
					<!-- <p class="mb-3">Lorem ipsum dolor sit amet, consectetur
						adipiscing elit, sed do eiusmod tempor incididunt ut labore et
						dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
						exercitation ullamco laboris nisi ut aliquip.</p> -->
					<a href="#" class="btn theme-bg btn-rounded">전문가에게 의뢰하기</a>
				</div>
			</div>

			<div class="col-lg-6 col-md-6">
				<img src="${pageContext.request.contextPath}/img/aboutUs.jpg"
					class="img-fluid rounded" alt="" />
			</div>

		</div>
		<!-- /row -->

	</div>

</section>
<!-- ============================ Our Story End ================================== -->

<!-- ============================ Our Counter Start ================================== -->
<section class="image-cover"
	style="background: #27ae60 url(assets/img/pattern.png) no-repeat;">
	<div class="container">

		<div class="row justify-content-center">
			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
				<div class="text-center mb-5">
					<span class="text-light">원더의 기록</span>
					<h2 class="font-weight-normal text-light">1년간 약 3천명의 고객분들과 전문가가
					 원더를 통해 작업했습니다.</h2>
				</div>
			</div>
		</div>

		<div class="row justify-content-center">
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="_morder_counter">
					<div class="_morder_counter_thumb">
						<i class="ti-cup"></i>
					</div>
					<div class="_morder_counter_caption">
						<h5 class="text-light">
							<span>147</span> 명
						</h5>
						<span class="text-light">일일 이용자</span>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="_morder_counter">
					<div class="_morder_counter_thumb">
						<i class="ti-briefcase"></i>
					</div>
					<div class="_morder_counter_caption">
						<h5 class="text-light">
							<span>4412</span> 명
						</h5>
						<span class="text-light">월별 이용자</span>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="_morder_counter">
					<div class="_morder_counter_thumb">
						<i class="ti-light-bulb"></i>
					</div>
					<div class="_morder_counter_caption">
						<h5 class="text-light">
							<span>89</span> 건
						</h5>
						<span class="text-light">월별 작업물</span>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="_morder_counter">
					<div class="_morder_counter_thumb">
						<i class="ti-heart"></i>
					</div>
					<div class="_morder_counter_caption">
						<h5 class="text-light">
							<span>1012</span> 건
						</h5>
						<span class="text-light">연간 작업물</span>
					</div>
				</div>
			</div>
		</div>

	</div>
</section>
<!-- ============================ Our Counter End ================================== -->

<!-- ================= Our Team================= -->
<section>
	<div class="container">

		<div class="row">
			<div class="col-lg-12 col-md-12">
				<div class="sec-heading center">
					<h2>원더의 개발자를 만나보세요</h2>
					<p>이젠아카데미 파이널 프로젝트 2조</p>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12">

				<div class="team-slide item-slide">

					<!-- Single Teamm -->
					<div class="single-team">
						<div class="team-grid">

							<div class="teamgrid-user">
								<img src="https://via.placeholder.com/500x500" alt=""
									class="img-fluid" />
							</div>

							<div class="teamgrid-content">
								<h4>이 지현</h4>
								<span>2조의 조장</span>
							</div>

							<div class="teamgrid-social">
								<ul>
									<li><a href="#" class="f-cl"><i class="ti-facebook"></i></a></li>
									<li><a href="#" class="t-cl"><i class="ti-twitter"></i></a></li>
									<li><a href="#" class="i-cl"><i class="ti-instagram"></i></a></li>
									<li><a href="#" class="l-cl"><i class="ti-linkedin"></i></a></li>
								</ul>
							</div>

						</div>
					</div>

					<!-- Single Teamm -->
					<div class="single-team">
						<div class="team-grid">

							<div class="teamgrid-user">
								<img src="https://via.placeholder.com/500x500" alt=""
									class="img-fluid" />
							</div>

							<div class="teamgrid-content">
								<h4>오 지훈</h4>
								<span>2조의 팀원</span>
							</div>

							<div class="teamgrid-social">
								<ul>
									<li><a href="#" class="f-cl"><i class="ti-facebook"></i></a></li>
									<li><a href="#" class="t-cl"><i class="ti-twitter"></i></a></li>
									<li><a href="#" class="i-cl"><i class="ti-instagram"></i></a></li>
									<li><a href="#" class="l-cl"><i class="ti-linkedin"></i></a></li>
								</ul>
							</div>

						</div>
					</div>

					<!-- Single Teamm -->
					<div class="single-team">
						<div class="team-grid">

							<div class="teamgrid-user">
								<img src="https://via.placeholder.com/500x500" alt=""
									class="img-fluid" />
							</div>

							<div class="teamgrid-content">
								<h4>이 정진</h4>
								<span>2조의 팀원</span>
							</div>

							<div class="teamgrid-social">
								<ul>
									<li><a href="#" class="f-cl"><i class="ti-facebook"></i></a></li>
									<li><a href="#" class="t-cl"><i class="ti-twitter"></i></a></li>
									<li><a href="#" class="i-cl"><i class="ti-instagram"></i></a></li>
									<li><a href="#" class="l-cl"><i class="ti-linkedin"></i></a></li>
								</ul>
							</div>

						</div>
					</div>

					<!-- Single Teamm -->
					<div class="single-team">
						<div class="team-grid">

							<div class="teamgrid-user">
								<img src="https://via.placeholder.com/500x500" alt=""
									class="img-fluid" />
							</div>

							<div class="teamgrid-content">
								<h4>서 원기</h4>
								<span>2조의 팀원</span>
							</div>

							<div class="teamgrid-social">
								<ul>
									<li><a href="#" class="f-cl"><i class="ti-facebook"></i></a></li>
									<li><a href="#" class="t-cl"><i class="ti-twitter"></i></a></li>
									<li><a href="#" class="i-cl"><i class="ti-instagram"></i></a></li>
									<li><a href="#" class="l-cl"><i class="ti-linkedin"></i></a></li>
								</ul>
							</div>

						</div>
					</div>

					<!-- Single Teamm -->
					<div class="single-team">
						<div class="team-grid">

							<div class="teamgrid-user">
								<img src="https://via.placeholder.com/500x500" alt=""
									class="img-fluid" />
							</div>

							<div class="teamgrid-content">
								<h4>장 현수</h4>
								<span>2조의 팀원</span>
							</div>

							<div class="teamgrid-social">
								<ul>
									<li><a href="#" class="f-cl"><i class="ti-facebook"></i></a></li>
									<li><a href="#" class="t-cl"><i class="ti-twitter"></i></a></li>
									<li><a href="#" class="i-cl"><i class="ti-instagram"></i></a></li>
									<li><a href="#" class="l-cl"><i class="ti-linkedin"></i></a></li>
								</ul>
							</div>

						</div>
					</div>

					<!-- Single Teamm -->
					<div class="single-team">
						<div class="team-grid">

							<div class="teamgrid-user">
								<img src="https://via.placeholder.com/500x500" alt=""
									class="img-fluid" />
							</div>

							<div class="teamgrid-content">
								<h4>김 효건</h4>
								<span>2조의 팀원</span>
							</div>

							<div class="teamgrid-social">
								<ul>
									<li><a href="#" class="f-cl"><i class="ti-facebook"></i></a></li>
									<li><a href="#" class="t-cl"><i class="ti-twitter"></i></a></li>
									<li><a href="#" class="i-cl"><i class="ti-instagram"></i></a></li>
									<li><a href="#" class="l-cl"><i class="ti-linkedin"></i></a></li>
								</ul>
							</div>

						</div>
					</div>

				</div>

			</div>
		</div>

	</div>
</section>
<!-- =============================== Our Team ================================== -->

<!-- ============================ Smart Testimonials ================================== -->
<!-- <section class="gray-simple">
	<div class="container">

		<div class="row justify-content-center">
			<div class="col-lg-7 col-md-8">
				<div class="sec-heading center">
					<h2>고객분들의 전문가 리뷰를 확인하세요.</h2>
					<p>우리 원더에서는, 고객분들의 생생한 리뷰를 확인 하실 수 있습니다. 원하는 것을 찾아 자신의 
					작업물에 더해보세요. 우리와 함께하는 전문가들은 직접 선별하고 확인하여, 전문가로 등록합니다.
					리뷰를 확인하세요!
					</p>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12 col-md-12">
				<div class="item-slide space">

					Single Item
					<div class="single_items">
						<div class="_testimonial_wrios">
							<div class="_testimonial_flex">
								<div class="_testimonial_flex_first">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/500x500"
											class="img-fluid" alt="">
									</div>
									<div class="_tsl_flex_capst">
										<h5>홍길동</h5>
										<div class="_ovr_posts">
											<span>JAVA개발 의뢰인</span>
										</div>
										<div class="_ovr_rates">
											<span><i class="fa fa-star"></i></span>4.7
										</div>
									</div>
								</div>
								<div class="_testimonial_flex_first_last">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/120x120"
											class="img-fluid" alt="">
									</div>
								</div>
							</div>

							<div class="facts-detail">
								<p>빠르게 원하는 부분까지 다 작업해줘서 너무 좋았어요~ 
								또 이용하고 싶어요!</p>
							</div>
						</div>
					</div>

					Single Item
					<div class="single_items">
						<div class="_testimonial_wrios">
							<div class="_testimonial_flex">
								<div class="_testimonial_flex_first">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/500x500"
											class="img-fluid" alt="">
									</div>
									<div class="_tsl_flex_capst">
										<h5>박길동</h5>
										<div class="_ovr_posts">
											<span>Python 개발 의뢰인</span>
										</div>
										<div class="_ovr_rates">
											<span><i class="fa fa-star"></i></span>4.5
										</div>
									</div>
								</div>
								<div class="_testimonial_flex_first_last">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/120x120"
											class="img-fluid" alt="">
									</div>
								</div>
							</div>

							<div class="facts-detail">
								<p>개발 관련해서 필요한 것들은 다음에도 원더를 이용할게요~ 너무 좋아요.
								앞으로도 다른 사람들이 원더를 이용하면 좋을 것 같아요 ㅎㅎㅎ</p>
							</div>
						</div>
					</div>

					Single Item
					<div class="single_items">
						<div class="_testimonial_wrios">
							<div class="_testimonial_flex">
								<div class="_testimonial_flex_first">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/500x500"
											class="img-fluid" alt="">
									</div>
									<div class="_tsl_flex_capst">
										<h5>김효건</h5>
										<div class="_ovr_posts">
											<span>홈페이지 의뢰인</span>
										</div>
										<div class="_ovr_rates">
											<span><i class="fa fa-star"></i></span>4.9
										</div>
									</div>
								</div>
								<div class="_testimonial_flex_first_last">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/120x120"
											class="img-fluid" alt="">
									</div>
								</div>
							</div>

							<div class="facts-detail">
								<p>최근들어 제 주변 사람들이 왜 원더를 이용하는지 알 것 같아요.
								너무 빠르고 간편하고, 또 전문가분들이 친절하게 해주셔서 저도 부담없이 질문 드릴 수 있었어요
								작업물 의뢰는 역시~ 원더~</p>
							</div>
						</div>
					</div>

					Single Item
					<div class="single_items">
						<div class="_testimonial_wrios">
							<div class="_testimonial_flex">
								<div class="_testimonial_flex_first">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/500x500"
											class="img-fluid" alt="">
									</div>
									<div class="_tsl_flex_capst">
										<h5>Dorothy K. Shipton</h5>
										<div class="_ovr_posts">
											<span>Linkedin Leader</span>
										</div>
										<div class="_ovr_rates">
											<span><i class="fa fa-star"></i></span>4.7
										</div>
									</div>
								</div>
								<div class="_testimonial_flex_first_last">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/120x120"
											class="img-fluid" alt="">
									</div>
								</div>
							</div>

							<div class="facts-detail">
								<p>Faucibus tristique felis potenti ultrices ornare rhoncus
									semper hac facilisi Rutrum tellus lorem sem velit nisi non
									pharetra in dui.</p>
							</div>
						</div>
					</div>

					Single Item
					<div class="single_items">
						<div class="_testimonial_wrios">
							<div class="_testimonial_flex">
								<div class="_testimonial_flex_first">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/500x500"
											class="img-fluid" alt="">
									</div>
									<div class="_tsl_flex_capst">
										<h5>Robert P. McKissack</h5>
										<div class="_ovr_posts">
											<span>CEO, Leader</span>
										</div>
										<div class="_ovr_rates">
											<span><i class="fa fa-star"></i></span>4.7
										</div>
									</div>
								</div>
								<div class="_testimonial_flex_first_last">
									<div class="_tsl_flex_thumb">
										<img src="https://via.placeholder.com/120x120"
											class="img-fluid" alt="">
									</div>
								</div>
							</div>

							<div class="facts-detail">
								<p>Faucibus tristique felis potenti ultrices ornare rhoncus
									semper hac facilisi Rutrum tellus lorem sem velit nisi non
									pharetra in dui.</p>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>

	</div>
</section> --> 
<!-- ============================ Smart Testimonials End ================================== -->
<hr>
<!-- ============================ article Start ================================== -->
<!-- <section class="min">
	<div class="container">

		<div class="row justify-content-center">
			<div class="col-lg-7 col-md-8">
				<div class="sec-heading center">
					<h2>실시간 상품 및 의뢰 요청</h2>
					<p>지금 이 순간에도 고객분들은 의뢰를 요청하고, 전문가들은 이를 해결 하고 있어요.
					최신 순위 상품들과 의뢰서를 보여드릴게요</p>
				</div>
			</div>
		</div>

		<div class="row">

			Single blog Grid
			<div class="col-lg-4 col-md-6">
				<div class="grid_blog_box">

					<div class="gtid_blog_thumb">
						<a href="blog-detail.html"><img
							src="https://via.placeholder.com/1200x740" class="img-fluid"
							alt="" /></a>
						<div class="gtid_blog_info">
							<span>1</span>2022년 3월
						</div>
					</div>

					<div class="blog-body">
						<h4 class="bl-title">
							<a href="blog-detail.html">디자인 작업 해드립니다~!</a><span
								class="latest_new_post">New</span>
						</h4>
						<p>5년 경력의 디자이너 입니다. 필요하신 디자인 있으면 말씀해주세요~</p>
					</div>

					<div class="modern_property_footer">
						<div class="property-author">
							<div class="path-img">
								<a href="agent-page.html" tabindex="-1"><img
									src="https://via.placeholder.com/500x500" class="img-fluid"
									alt=""></a>
							</div>
							<h5>
								<a href="agent-page.html" tabindex="-1">디자이너 홍</a>
							</h5>
						</div>
						<span class="article-pulish-date"><i
							class="ti-comment-alt mr-2"></i>202</span>
					</div>

				</div>
			</div>

			Single blog Grid
			<div class="col-lg-4 col-md-6">
				<div class="grid_blog_box">

					<div class="gtid_blog_thumb">
						<a href="blog-detail.html"><img
							src="https://via.placeholder.com/1200x740" class="img-fluid"
							alt="" /></a>
						<div class="gtid_blog_info">
							<span>2</span>2022년 5월
						</div>
					</div>

					<div class="blog-body">
						<h4 class="bl-title">
							<a href="blog-detail.html">풀스택 개발의 모든것</a><span
								class="latest_new_post hot">Hot</span>
						</h4>
						<p>현재 실무경력 22년의 고급 개발자입니다. 무엇이든지 회의후에 만들어 내보도록 하겠습니다
							언제든지 문의주세요!.</p>
					</div>

					<div class="modern_property_footer">
						<div class="property-author">
							<div class="path-img">
								<a href="agent-page.html" tabindex="-1"><img
									src="https://via.placeholder.com/500x500" class="img-fluid"
									alt=""></a>
							</div>
							<h5>
								<a href="agent-page.html" tabindex="-1">코딩박사</a>
							</h5>
						</div>
						<span class="article-pulish-date"><i
							class="ti-comment-alt mr-2"></i>407</span>
					</div>

				</div>
			</div>

			Single blog Grid
			<div class="col-lg-4 col-md-6">
				<div class="grid_blog_box">

					<div class="gtid_blog_thumb">
						<a href="blog-detail.html"><img
							src="https://via.placeholder.com/1200x740" class="img-fluid"
							alt="" /></a>
						<div class="gtid_blog_info">
							<span>6</span>2022년 6월
						</div>
					</div>

					<div class="blog-body">
						<h4 class="bl-title">
							<a href="blog-detail.html">회사 홈페이지 의뢰드립니다.</a><span
								class="latest_new_post">New</span>
						</h4>
						<p>안녕하세요. 새로 회사를 설립하게된 이젠입니다. 회사 설립에 필요한 홈페이지를 제작하고싶어요.
							전문가분들 부탁드릴게요</p>
					</div>

					<div class="modern_property_footer">
						<div class="property-author">
							<div class="path-img">
								<a href="agent-page.html" tabindex="-1"><img
									src="https://via.placeholder.com/500x500" class="img-fluid"
									alt=""></a>
							</div>
							<h5>
								<a href="agent-page.html" tabindex="-1">이젠 대표</a>
							</h5>
						</div>
						<span class="article-pulish-date"><i
							class="ti-comment-alt mr-2"></i>410</span>
					</div>

				</div>
			</div>

		</div>

	</div>
</section>
<div class="clearfix"></div> -->
<!-- ============================ article End ================================== -->
<%@ include file="../inc/bottom.jsp" %>