<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<body class="yellow-skin">
	<!-- ============================ Page Title Start================================== -->
	<section class="image-cover faq-sec text-center"
		style="background: url(<c:url value='/img/sliderss-1-1920x980.jpg' />) no-repeat;"
		data-overlay="6">
		<div class="container">
			<div class="row">

				<div class="col-lg-12 col-md-12">
					<h1 class="text-light">자주 묻는 질문</h1>
				</div>

			</div>
		</div>
	</section>
	<!-- ============================ Page Title End ================================== -->

	<!-- ================= Our Mission ================= -->
	<section>
		<div class="container">
			<div class="row">
				<div class="col-lg-10 col-md-12 col-sm-12">

					<!-- Single Basics List -->
					<div class="faq_wrap">
						<div class="faq_wrap_title">
							<h4>일반 회원</h4>
						</div>
						<div class="faq_wrap_body mb-5">
							<div class="accordion" id="generalac">
								<div class="card">
									<div class="card-header" id="headingOne">
										<h2 class="mb-0">
											<button class="btn btn-link" type="button"
												data-toggle="collapse" data-target="#collapseOne"
												aria-expanded="true" aria-controls="collapseOne">제
												상품 정보를 보고싶어요.</button>
										</h2>
									</div>

									<div id="collapseOne" class="collapse show"
										aria-labelledby="headingOne" data-parent="#generalac">
										<div class="card-body">
											<p class="ac-para">우선 로그인 하신 후 우측 상단의 마이페이지 버튼을 눌러보세요.
											<br> 고객님의 정보와 함께, 상품 정보를 볼 수 있어요</p>
										</div>
									</div>
								</div>
								<div class="card">
									<div class="card-header" id="headingTwo">
										<h2 class="mb-0">
											<button class="btn btn-link collapsed" type="button"
												data-toggle="collapse" data-target="#collapseTwo"
												aria-expanded="false" aria-controls="collapseTwo">
												서비스 이용 시 의뢰 내용은 보호되나요?</button>
										</h2>
									</div>
									<div id="collapseTwo" class="collapse"
										aria-labelledby="headingTwo" data-parent="#generalac">
										<div class="card-body">
											<p class="ac-para">공개하기 어려운 의뢰 내용이 있다면, 아래의 방법으로 보호하실 수
												있습니다.<br>
												의뢰인 의뢰 글 작성 시 공개 불가한 내용은 제외하고 등록해 주세요. <br>
												전담 매니저가 배정된 경우에는 전담 매니저에게, 프로젝트에 제안한 전문가와 직접 소통하는 경우에는 해당 전문가에게만 관련 내용을
												전달하셔도 됩니다.
												<br>
												의뢰하신 프로젝트 내용은 바로 사이트에 노출되지
												않고 크몽 전담 매니저와 유선 상담 후 사이트에 최종 등록됩니다.
												전담 매니저에게 공개 불가한 내용을 알려주시면, 전문가가 업무 내용을 이해할 수 있을 정도의 최소한의 내용만 전달해 드립니다. 
												<br>
												필요한 경우, 크몽에서 제공하는 NDA(비밀 유지 계약서) 작성이 가능합니다. 전문가와의 미팅 시 전문가와 NDA
												계약 체결 후 자료 공유가 가능합니다.</p>
										</div>
									</div>
								</div>
								<div class="card">
									<div class="card-header" id="headingThree">
										<h2 class="mb-0">
											<button class="btn btn-link collapsed" type="button"
												data-toggle="collapse" data-target="#collapseThree"
												aria-expanded="false" aria-controls="collapseThree">
												거래는 어떻게 하나요?</button>
										</h2>
									</div>
									<div id="collapseThree" class="collapse"
										aria-labelledby="headingThree" data-parent="#generalac">
										<div class="card-body">
											<p class="ac-para">거래는 프리랜서와 연결 된 후 채팅을 통해서 서로의 의견을 조율합니다.
											그리고 회원님이 결제를 원하시면, 원더 결제시스템을 통해 결제 합니다. <br>
											이후 프리랜서의 작업물을 받고, 확인 후 거래 완료 버튼을 누르면 거래가 완료됩니다.</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Single Basics Account & Settings -->
					<div class="faq_wrap">
						<div class="faq_wrap_title">
							<h4>전문가, 프리랜서</h4>
						</div>
						<div class="faq_wrap_body">
							<div class="accordion" id="account">
								<div class="card">
									<div class="card-header" id="headingEight">
										<h2 class="mb-0">
											<button class="btn btn-link" type="button"
												data-toggle="collapse" data-target="#collapseeight"
												aria-expanded="true" aria-controls="collapseeight">
												고객과의 연락은 어떻게 이루어지나요?</button>
										</h2>
									</div>

									<div id="collapseeight" class="collapse show"
										aria-labelledby="headingEight" data-parent="#account">
										<div class="card-body">
											<p class="ac-para">전문가 께서는 고객분이 의뢰를 신청하면, 의뢰서를 받고 
											채팅 혹은 쪽지, 유선상 연락을 주고 받을 수 있습니다.
											좋은 작품 부탁드립니다!</p>
										</div>
									</div>
								</div>
								<div class="card">
									<div class="card-header" id="headingNine">
										<h2 class="mb-0">
											<button class="btn btn-link collapsed" type="button"
												data-toggle="collapse" data-target="#collapsenine"
												aria-expanded="false" aria-controls="collapsenine">
												거래를 취소 하고 싶어요.</button>
										</h2>
									</div>
									<div id="collapsenine" class="collapse"
										aria-labelledby="headingNine" data-parent="#account">
										<div class="card-body">
											<p class="ac-para">
											취소하고 싶으시다면, 진행중인 거래 목록에서 거래를 취소 하시면 됩니다!</p>
										</div>
									</div>
								</div>
								<div class="card">
									<div class="card-header" id="headingTen">
										<h2 class="mb-0">
											<button class="btn btn-link collapsed" type="button"
												data-toggle="collapse" data-target="#collapseten"
												aria-expanded="false" aria-controls="collapseten">
												제 이메일은 어떻게 변경 하나요?</button>
										</h2>
									</div>
									<div id="collapseten" class="collapse"
										aria-labelledby="headingTen" data-parent="#account">
										<div class="card-body">
											<p class="ac-para">오른쪽 위의 마이페이지에 들어가시면
											정보 변경할수 있는 창이 뜹니다.
											그쪽으로 정보를 변경 하시면 됩니다!</p>
										</div>
									</div>
								</div>
								<div class="card">
									<div class="card-header" id="headingEle">
										<h2 class="mb-0">
											<button class="btn btn-link collapsed" type="button"
												data-toggle="collapse" data-target="#collapseele"
												aria-expanded="false" aria-controls="collapseele">
												주요 기능</button>
										</h2>
									</div>
									<div id="collapseele" class="collapse"
										aria-labelledby="headingEle" data-parent="#account">
										<div class="card-body">
											<p class="ac-para">
											원더를 사랑해주셔서 감사합니다.
											모두 건강하시고 행복하세요.</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ================= Our Mission ================= -->
	<%@ include file="../inc/bottom.jsp"%>