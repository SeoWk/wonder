<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>

<!-- ============================================================== -->
<!-- All Jquery -->
<!-- ============================================================== -->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/ion.rangeSlider.min.js"></script>
<script src="${pageContext.request.contextPath}/js/select2.min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath}/js/slick.js"></script>
<script src="${pageContext.request.contextPath}/js/slider-bg.js"></script>
<script src="${pageContext.request.contextPath}/js/lightbox.js"></script>
<script src="${pageContext.request.contextPath}/js/imagesloaded.js"></script>
<script src="${pageContext.request.contextPath}/js/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/js/custom.js"></script>

<script src="${pageContext.request.contextPath}/js/dropzone.js"></script>

<script
	src="${pageContext.request.contextPath}/js/ion.rangeSlider.min.js"></script>

<!--  -->
<!-- ============================================================== -->
<!-- This page plugins -->
<!-- ============================================================== -->

<!-- New Js -->

<!--  -->
<!-- Date Booking Script -->
<script src="${pageContext.request.contextPath}/js/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/js/daterangepicker.js"></script>
<!-- ============================================================== -->
<!-- This page plugins -->
<!-- ============================================================== -->

<head>
<meta charset="utf-8" />
<meta name="author" content="Themezhub" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript"
	src="<c:url value='/js/jquery.min.js'/>"></script>
<title>RentUP - Residence & Real Estate Template</title>

<script type="text/javascript">
	var arr_PdImgNo = new Array();
	Dropzone.autoDiscover = false;
	var addedFiles = [];

	$(function() {

		const dropzone = new Dropzone(
				'form#pdImage',
				{
					url : '/wonder/image/write', // 파일을 업로드할 서버 주소 url.
					method : 'post', // 기본 post로 request 감. put으로도 할수있음
					headers : {},
					autoProcessQueue : false, // 자동으로 보내기. true : 파일 업로드 되자마자 서버로 요청, false : 서버에는 올라가지 않은 상태. 따로 this.processQueue() 호출시 전송
					clickable : true, // 클릭 가능 여부
					autoQueue : false, // 드래그 드랍 후 바로 서버로 전송
					createImageThumbnails : true, //파일 업로드 썸네일 생성

					thumbnailHeight : 120, // Upload icon size
					thumbnailWidth : 120, // Upload icon size

					maxFiles : 10, // 업로드 파일수
					maxFilesize : 100, // 최대업로드용량 : 100MB
					paramName : 'file', // 서버에서 사용할 formdata 이름 설정 (default는 file)
					parallelUploads : 2, // 동시파일업로드 수(이걸 지정한 수 만큼 여러파일을 한번에 넘긴다.)
					uploadMultiple : false, // 다중업로드 기능
					timeout : 300000, //커넥션 타임아웃 설정 -> 데이터가 클 경우 꼭 넉넉히 설정해주자

					addRemoveLinks : true, // 업로드 후 파일 삭제버튼 표시 여부
					dictRemoveFile : '삭제', // 삭제버튼 표시 텍스트
					acceptedFiles : '.jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF', // 이미지 파일 포맷만 허용

					init : function() {
						// 최초 dropzone 설정시 init을 통해 호출
						console.log('최초 실행');
						let myDropzone = this; // closure 변수 (화살표 함수 쓰지않게 주의)

						// 파일이 업로드되면 실행
						this.on('addedfile',
										function(file) {
											// 중복된 파일의 제거
											console.log(this.files.length);
											if (this.files.length) {
												// -1 to exclude current file
												var hasFile = false;
												for (var i = 0; i < this.files.length - 1; i++) {
													if (this.files[i].name === file.name
															&& this.files[i].size === file.size
															&& this.files[i].lastModifiedDate
																	.toString() === file.lastModifiedDate
																	.toString()) {
														hasFile = true;
														this.removeFile(file);
													}
												}

												if (!hasFile) {
													addedFiles.push(file);
												}
											} else {
												addedFiles.push(file);
											}
										});

						// 업로드한 파일을 서버에 요청하는 동안 호출 실행
						this.on('sending', function(file, xhr, formData) {
							console.log('보내는중');
						});

						// 서버로 파일이 성공적으로 전송되면 실행
						this.on('success', function(file, responseText) {
							console.log('성공');
						});

						// 업로드 에러 처리
						this.on('error', function(file, errorMessage) {
							alert(errorMessage);
						});
					},
				});

		// 의미적으로 활성화 표기를 위해 true로 설정된 aria-selected 속성 추가
		$(
				".property_block_wrap_header li:first-of-type, .tab-pane:first-of-type")
				.find("a").attr("aria-expanded", "true");
		$(".property_block_wrap_header li:first-of-type").find("a").attr(
				"aria-selected", "true");
		$(".property_block_wrap_header li:first-of-type").siblings().find("a")
				.attr("aria-expanded", "false");
		$(".property_block_wrap_header li:first-of-type").siblings().find("a")
				.attr("aria-selected", "false");

		/* 탭 클릭 시 전환 */
		$('.property_block_wrap_header li').click(function(e) {
			e.preventDefault();
			$(this).find("a").attr("aria-selected", "true");
			$(this).siblings().find("a").attr("aria-selected", "false");
		})

		$('#pd_reg').click(
						function() {
							var pdWrite = new FormData();

							var pdTitle = $('#pdTitle').val();
							if (pdTitle == '') {
								alert("제목을 입력해주세요.");
								return false;
							}

							pdWrite.append('pdTitle', pdTitle);

							var pdLang = new Array();
							$('[name=langchbox]').each(function() {
								if ($(this).is(':checked') == true) {
									pdLang.push($(this).val());
								}
							});

							if (pdLang.length == 0) {
								alert("개발 언어를 선택해주세요.");
								return false;
							}

							pdWrite.append('pdLang', pdLang);

							var pdFrame = new Array();
							$('[name=framechbox]').each(function() {
								if ($(this).is(':checked') == true) {
									pdFrame.push($(this).val());
								}
							});

							if (pdFrame.length == 0) {
								alert("프레임 워크를 선택해주세요.");
								return false;
							}

							pdWrite.append('pdFrame', pdFrame);

							var priceType = "";
							$('.property_block_wrap_header li').find('a').each(
											function() {
												if ($(this).attr(
														'aria-selected') === 'true')
													priceType = $(this).text();
											});

							pdWrite.append('priceType', priceType);

							if (priceType === 'TYPE1') {

								// 가격 입력 체크
								if ($("#pdPrice").val() == '') {
									alert($('#pdType').val() + " 가격을 입력해주세요.");
									return false;
								}

								// 기한 입력 체크
								if ($("#pdTerm").val() == '') {
									alert($('#pdType').val() + " 기한을 입력해주세요.");
									return false;
								}

								// 서비스 설명 체크
								if ($("#serviceExplanation").val() == '') {
									alert($('#pdType').val()
											+ " 서비스 설명을 입력해주세요.");
									return false;
								}

								// 수정횟수 체크
								if ($("#editCount").val() == '') {
									alert($('#pdType').val() + " 수정횟수를 입력해주세요.");
									return false;
								}

								// 수정설명 체크
								if ($("#editExplanation").val() == '') {
									alert($('#pdType').val() + " 수정설명을 입력해주세요.");
									return false;
								}

								pdWrite.append('pdType', $('#pdType').val());
								pdWrite.append('pdPrice', $('#pdPrice').val());
								pdWrite.append('pdTerm', $('#pdTerm').val());
								pdWrite.append('serviceExplanation', $(
										'#serviceExplanation').val());
								pdWrite.append('editCount', $('#editCount')
										.val());
								pdWrite.append('editExplanation', $(
										'#editExplanation').val());
								pdWrite.append('commercial', $('#commercial')
										.is(':checked'));
								pdWrite.append('codeSupply', $('#codeSupply')
										.is(':checked'));
								pdWrite.append('customize', $('#customize').is(
										':checked'));
								pdWrite.append('payment', $('#payment').is(
										':checked'));
							} else if (priceType === 'TYPE2') {

								// 가격 입력 체크
								if ($("#pdPrice1").val() == '') {
									alert($('#pdType1').val() + " 가격을 입력해주세요.");
									return false;
								}
								if ($("#pdPrice2").val() == '') {
									alert($('#pdType2').val() + " 가격을 입력해주세요.");
									return false;
								}
								if ($("#pdPrice3").val() == '') {
									alert($('#pdType3').val() + " 가격을 입력해주세요.");
									return false;
								}

								// 기한 입력 체크
								if ($("#pdTerm1").val() == '') {
									alert($('#pdType1').val() + " 기한을 입력해주세요.");
									return false;
								}
								if ($("#pdTerm2").val() == '') {
									alert($('#pdType2').val() + " 기한을 입력해주세요.");
									return false;
								}
								if ($("#pdTerm3").val() == '') {
									alert($('#pdType3').val() + " 기한을 입력해주세요.");
									return false;
								}

								// 서비스 설명 체크
								if ($("#serviceExplanation1").val() == '') {
									alert($('#pdType1').val()
											+ " 서비스 설명을 입력해주세요.");
									return false;
								}
								if ($("#serviceExplanation2").val() == '') {
									alert($('#pdType2').val()
											+ " 서비스 설명을 입력해주세요.");
									return false;
								}
								if ($("#serviceExplanation3").val() == '') {
									alert($('#pdType3').val()
											+ " 서비스 설명을 입력해주세요.");
									return false;
								}

								// 수정횟수 체크
								if ($("#editCount1").val() == '') {
									alert($('#pdType1').val()
											+ " 수정횟수를 입력해주세요.");
									return false;
								}
								if ($("#editCount2").val() == '') {
									alert($('#pdType2').val()
											+ " 수정횟수를 입력해주세요.");
									return false;
								}
								if ($("#editCount3").val() == '') {
									alert($('#pdType3').val()
											+ " 수정횟수를 입력해주세요.");
									return false;
								}

								// 수정설명 체크
								if ($("#editExplanation1").val() == '') {
									alert($('#pdType1').val()
											+ " 수정설명을 입력해주세요.");
									return false;
								}
								if ($("#editExplanation2").val() == '') {
									alert($('#pdType2').val()
											+ " 수정설명을 입력해주세요.");
									return false;
								}
								if ($("#editExplanation3").val() == '') {
									alert($('#pdType3').val()
											+ " 수정설명을 입력해주세요.");
									return false;
								}

								pdWrite.append('pdType1', $('#pdType1').val());
								pdWrite
										.append('pdPrice1', $('#pdPrice1')
												.val());
								pdWrite.append('pdTerm1', $('#pdTerm1').val());
								pdWrite.append('serviceExplanation1', $(
										'#serviceExplanation1').val());
								pdWrite.append('editCount1', $('#editCount1')
										.val());
								pdWrite.append('editExplanation1', $(
										'#editExplanation1').val());
								pdWrite.append('commercial1', $('#commercial1')
										.is(':checked'));
								pdWrite.append('codeSupply1', $('#codeSupply1')
										.is(':checked'));
								pdWrite.append('customize1', $('#customize1')
										.is(':checked'));
								pdWrite.append('payment1', $('#payment1').is(
										':checked'));

								pdWrite.append('pdType2', $('#pdType2').val());
								pdWrite
										.append('pdPrice2', $('#pdPrice2')
												.val());
								pdWrite.append('pdTerm2', $('#pdTerm2').val());
								pdWrite.append('serviceExplanation2', $(
										'#serviceExplanation2').val());
								pdWrite.append('editCount2', $('#editCount2')
										.val());
								pdWrite.append('editExplanation2', $(
										'#editExplanation2').val());
								pdWrite.append('commercial2', $('#commercial2')
										.is(':checked'));
								pdWrite.append('codeSupply2', $('#codeSupply2')
										.is(':checked'));
								pdWrite.append('customize2', $('#customize2')
										.is(':checked'));
								pdWrite.append('payment2', $('#payment2').is(
										':checked'));

								pdWrite.append('pdType3', $('#pdType3').val());
								pdWrite.append('pdPrice3', $('#pdPrice3')
												.val());
								pdWrite.append('pdTerm3', $('#pdTerm3').val());
								pdWrite.append('serviceExplanation3', $(
										'#serviceExplanation3').val());
								pdWrite.append('editCount3', $('#editCount3')
										.val());
								pdWrite.append('editExplanation3', $(
										'#editExplanation3').val());
								pdWrite.append('commercial3', $('#commercial3')
										.is(':checked'));
								pdWrite.append('codeSupply3', $('#codeSupply3')
										.is(':checked'));
								pdWrite.append('customize3', $('#customize3')
										.is(':checked'));
								pdWrite.append('payment3', $('#payment3').is(
										':checked'));
							} else {
								alert("가격 정책이 잘못 입력 되었습니다.");
							}

							for (let i = 0; i < addedFiles.length; i++) {
								pdWrite.append('files', addedFiles[i]);
							}

							var request = new XMLHttpRequest();
							
					          request.onreadystatechange = function() {
			                        console.log(this.readyState + ' : ' + this.status);
			                         if (this.readyState == 4 && this.status == 200) {
			                             console.log("상품이 등록 되었습니다.");
			                             alert("상품이 등록 되었습니다.");
			                             //location.reload(true);
			                             location.href = '<c:url value="/pd/pdList"/>';
			                         }
			                     }
							
							request.open("POST", "/wonder/pd/pdWrite");
							request.send(pdWrite);

						});

		$('#btWrite').click(function() {
			alert("제목을 입력해주세요.");
			location.href = '<c:url value="/pd/pdList"/>';
		});
		
		 

	});
</script>
<!-- Custom CSS -->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet">

</head>


<body class="yellow-skin">

	<!-- ============================================================== -->
	<!-- Preloader - style you can find in spinners.css -->
	<!-- ============================================================== -->
	<div class="preloader"></div>

	<!-- ============================================================== -->
	<!-- Main wrapper - style you can find in pages.scss -->
	<!-- ============================================================== -->
	<div id="main-wrapper">
		<!-- ============================ Page Title Start================================== -->
		<div class="page-title"
			style="background: #f4f4f4 url(${pageContext.request.contextPath}/img/pdWriteBd.jpg);"
			data-overlay="5">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 col-md-12">
						<div class="breadcrumbs-wrap">
							<ol class="breadcrumb">
								<li class="breadcrumb-item active" aria-current="page"></li>
							</ol>
							<h2 class="breadcrumb-title"></h2>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- ============================ Page Title End ================================== -->

		<!-- ============================ Submit Property Start ================================== -->
		<section>

			<div class="container">
				<div class="row">

					<!-- Submit Form -->
					<div class="col-lg-12 col-md-12">
						<div class="submit-page p-0">
							<!-- Basic Information -->
							<div class="frm_submit_block">
								<h3>상품을 등록하세요!</h3>
								<div class="frm_submit_wrap">
									<div class="form-row">

										<div class="form-group col-md-12">
											<br> <label>제목</label> <input type="text"
												class="form-control" id="pdTitle" name="pdTitle">
										</div>

										<div class="form-group col-md-12">
											<br> <label>개발 언어</label>
											<div class="classlanguage" id="languageWrite">
												<ul class="no-ul-list third-row">
													<c:forEach var="langVo" items="${langList}">
														<li><input id="${langVo.langNo}" name="langchbox"
															class="checkbox-custom" type="checkbox"
															value="${langVo.lang}"> <label
															for="${langVo.langNo}" class="checkbox-custom-label">${langVo.lang }</label>
														</li>
													</c:forEach>
												</ul>
											</div>
										</div>

										<div class="form-group col-md-12">
											<br> <label>프레임 워크</label>
											<div class="o-features">
												<ul class="no-ul-list third-row">
													<c:forEach var="frameVo" items="${frameList }">
														<li><input id="b-${frameVo.frameNo}"
															name="framechbox" class="checkbox-custom" type="checkbox"
															value="${frameVo.frame}"> <label
															for="b-${frameVo.frameNo}" class="checkbox-custom-label">${frameVo.frame }</label>
														</li>
													</c:forEach>
												</ul>
											</div>
										</div>


										<div class="col-lg-8 col-md-12 col-sm-12">
											<div class="form-group col-md-12">
												<br> <a href="#" class="tip-topdata"
													data-tip="Type1 - STANDARD / Type2 - STANDARD, DELUXE, PREMIUM"><i
													class="ti-help"></i></a>
											</div>


											<!-- Single Block Wrap -->
											<div class="property_block_wrap">
												<div class="property_block_wrap_header">
													<ul class="nav nav-pills tabs_system" id="pill-tab"
														role="tablist">
														<li class="nav-item"><a class="nav-link active"
															id="pills-walk-tab" data-toggle="pill" href="#pills-walk"
															role="tab" aria-controls="pills-walk">TYPE1</a></li>
														<li class="nav-item"><a class="nav-link"
															id="pills-nearby-tab" data-toggle="pill"
															href="#pills-nearby" role="tab"
															aria-controls="pills-nearby">TYPE2</a></li>
													</ul>
												</div>

												<div class="block-body">
													<div class="sidetab-content">
														<div class="tab-content" id="pill-tabContent">
															<!-- Book Now Tab -->
															<div class="tab-pane fade show active" id="pills-walk"
																role="tabpanel" aria-labelledby="pills-walk-tab">
																<div class="_walk_score_wrap">

																	<!-- Single Item -->

																	<div class="form-group col-md-6">
																		<label>타입</label> <input type="text"
																			class="form-control" value="STANDARD" id="pdType"
																			name="pdType">
																	</div>

																	<div class="form-group col-md-6">
																		<label>가격</label> <input type="TYPE" id="pdPrice" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																			name="pdPrice" class="form-control" placeholder="KRW">
																	</div>

																	<div class="form-group col-md-6">
																		<label>기한</label> <input type="text" id="pdTerm" placeholder="(일)"
																			name="pdTerm" class="form-control" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
																	</div>

																	<div class="form-group col-md-12">
																		<label>서비스설명</label>
																		<textarea class="form-control h-120"
																			id="serviceExplanation" name="serviceExplanation"></textarea>
																	</div>

																	<div class="form-group col-md-6">
																		<label>수정횟수</label> <input type="text" id="editCount" placeholder="(회)"
																			name="editCount" class="form-control" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"> 
																	</div>

																	<div class="form-group col-md-12">
																		<label>수정설명</label>
																		<textarea class="form-control h-120"
																			id="editExplanation" name="editExplanation"></textarea>
																	</div>

																	<div class="col-lg12 col-md-12 col-sm-12 mt-3">
																		<hr>
																		<input id="commercial" class="checkbox-custom"
																			name="commercial" type="checkbox"> <label
																			for="commercial" class="checkbox-custom-label">상업적
																			이용<i></i>
																		</label>
																		<hr>
																		<input id="codeSupply" class="checkbox-custom"
																			name="codeSupply" type="checkbox" > <label
																			for="codeSupply" class="checkbox-custom-label">소스코드
																			제공<i></i>
																		</label>
																		<hr>
																		<input id="customize" class="checkbox-custom"
																			name="customize" type="checkbox" > <label
																			for="customize" class="checkbox-custom-label">맞춤
																			디자인<i></i>
																		</label>
																		<hr>
																		<input id="payment" class="checkbox-custom"
																			name="payment" type="checkbox"> <label
																			for="payment" class="checkbox-custom-label">결제
																			기능<i></i>
																		</label>
																		<hr>
																	</div>




																	<!-- Single Item -->


																	<!-- Single Item -->



																</div>
															</div>

															<!-- Appointment Now Tab -->
															<div class="tab-pane fade" id="pills-nearby"
																role="tabpanel" aria-labelledby="pills-nearby-tab">
																<!-- Schools -->
																<div class="nearby-wrap">
																	<!-- Single Item -->
																	<br>
																	<div class="form-group col-md-6">
																		<label>타입</label> <input type="text" id="pdType1"
																			name="pdType1" class="form-control" value="STANDARD">
																	</div>

																	<div class="form-group col-md-6">
																		<label>가격</label> <input type="TYPE" id="pdPrice1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																			name="pdPrice1" class="form-control"
																			placeholder="KRW">
																	</div>

																	<div class="form-group col-md-6">
																		<label>기한</label> <input type="text" id="pdTerm1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																			placeholder="(일)" name="pdTerm1" class="form-control">
																	</div>

																	<div class="form-group col-md-12">
																		<label>서비스설명</label>
																		<textarea class="form-control h-120"
																			id="serviceExplanation1" name="serviceExplanation1"></textarea>
																	</div>

																	<div class="form-group col-md-6">
																		<label>수정횟수</label> <input type="text" id="editCount1" placeholder="(회)"
																			name="editCount1" class="form-control" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
																	</div>

																	<div class="form-group col-md-12">
																		<label>수정설명</label>
																		<textarea class="form-control h-120"
																			id="editExplanation1" name="editExplanation1"></textarea>
																	</div>


																	<div class="col-lg12 col-md-12 col-sm-12 mt-3">
																		<hr>
																		<input id="commercial1" class="checkbox-custom"
																			name="commercial1" type="checkbox"> <label
																			for="commercial1" class="checkbox-custom-label">상업적
																			이용<i></i>
																		</label>
																		<hr>
																		<input id="codeSupply1" class="checkbox-custom"
																			name="codeSupply1" type="checkbox"> <label
																			for="codeSupply1" class="checkbox-custom-label">소스코드
																			제공<i></i>
																		</label>
																		<hr>
																		<input id="customize1" class="checkbox-custom"
																			name="customize1" type="checkbox"> <label
																			for="customize1" class="checkbox-custom-label">맞춤
																			디자인<i></i>
																		</label>
																		<hr>
																		<input id="payment1" class="checkbox-custom"
																			name="payment1" type="checkbox"> <label
																			for="payment1" class="checkbox-custom-label">결제
																			기능<i></i>
																		</label>
																		<hr>
																	</div>
																	<br>
																	<hr>
																	<br>
																	<!-- Single Item -->

																	<div class="form-group col-md-6">
																		<label>타입</label> <input type="text" id="pdType2"
																			name="pdType2" class="form-control" value="DELUXE">
																	</div>

																	<div class="form-group col-md-6">
																		<label>가격</label> <input type="TYPE" id="pdPrice2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																			name="pdPrice2" class="form-control"
																			placeholder="KRW">
																	</div>

																	<div class="form-group col-md-6">
																		<label>기한</label> <input type="text" id="pdTerm2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																			placeholder="(일)" name="pdTerm2" class="form-control">
																	</div>

																	<div class="form-group col-md-12">
																		<label>서비스설명</label>
																		<textarea class="form-control h-120"
																			id="serviceExplanation2" name="serviceExplanation2"></textarea>
																	</div>

																	<div class="form-group col-md-6">
																		<label>수정횟수</label> <input type="text" placeholder="(회)"
																			class="form-control" id="editCount2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																			name="editCount2">
																	</div>

																	<div class="form-group col-md-12">
																		<label>수정설명</label>
																		<textarea class="form-control h-120"
																			id="editExplanation2" name="editExplanation2"></textarea>
																	</div>

																	<div class="col-lg12 col-md-12 col-sm-12 mt-3">
																		<hr>
																		<input id="commercial2" class="checkbox-custom"
																			name="commercial2" type="checkbox"> <label
																			for="commercial2" class="checkbox-custom-label">상업적
																			이용<i></i>
																		</label>
																		<hr>
																		<input id="codeSupply2" class="checkbox-custom"
																			name="codeSupply2" type="checkbox" > <label
																			for="codeSupply2" class="checkbox-custom-label">소스코드
																			제공<i></i>
																		</label>
																		<hr>
																		<input id="customize2" class="checkbox-custom"
																			name="customize2" type="checkbox" > <label
																			for="customize2" class="checkbox-custom-label">맞춤
																			디자인<i></i>
																		</label>
																		<hr>
																		<input id="payment2" class="checkbox-custom"
																			name="payment2" type="checkbox"> <label
																			for="payment2" class="checkbox-custom-label">결제
																			기능<i></i>
																		</label>
																		<hr>
																	</div>


																	<br>
																	<hr>
																	<br>
																	<!-- Single Item -->

																	<div class="form-group col-md-6">
																		<label>타입</label> <input type="text" id="pdType3"
																			name="pdType3" class="form-control" value="PREMIUM">
																	</div>

																	<div class="form-group col-md-6">
																		<label>가격</label> <input type="TYPE" id="pdPrice3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																			name="pdPrice3" class="form-control"
																			placeholder="KRW">
																	</div>

																	<div class="form-group col-md-6">
																		<label>기한</label> <input type="text" id="pdTerm3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																			placeholder="(일)" name="pdTerm3" class="form-control">
																	</div>
																	<div class="form-group col-md-12">
																		<label>서비스설명</label>
																		<textarea class="form-control h-120"
																			id="serviceExplanation3" name="serviceExplanation3"></textarea>
																	</div>

																	<div class="form-group col-md-6">
																		<label>수정횟수</label> <input type="text" id="editCount3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
																			placeholder="(회)" name="editCount3" class="form-control">
																	</div>

																	<div class="form-group col-md-12">
																		<label>수정설명</label>
																		<textarea class="form-control h-120"
																			id="editExplanation3" name="editExplanation3"></textarea>
																	</div>

																	<div class="col-lg12 col-md-12 col-sm-12 mt-3">
																		<hr>
																		<input id="commercial3" class="checkbox-custom"
																			name="commercial3" type="checkbox"> <label
																			for="commercial3" class="checkbox-custom-label">상업적
																			이용<i></i>
																		</label>
																		<hr>
																		<input id="codeSupply3" class="checkbox-custom"
																			name="codeSupply3" type="checkbox" > <label
																			for="codeSupply3" class="checkbox-custom-label">소스코드
																			제공<i></i>
																		</label>
																		<hr>
																		<input id="customize3" class="checkbox-custom"
																			name="customize3" type="checkbox" > <label
																			for="customize3" class="checkbox-custom-label">맞춤
																			디자인<i></i>
																		</label>
																		<hr>
																		<input id="payment3" class="checkbox-custom"
																			name="payment3" type="checkbox"> <label
																			for="payment3" class="checkbox-custom-label">결제
																			기능<i></i>
																		</label>
																		<hr>
																	</div>



																</div>



															</div>
														</div>

													</div>

												</div>
											</div>



										</div>









									</div>
								</div>
							</div>

							<!-- Gallery -->
							<div class="frm_submit_block">
								<h3>IMAGE</h3>
								<div class="frm_submit_wrap">
									<div class="form-row">

										<div class="form-group col-md-12">
											<label>사진을 첨부하세요</label>
											<form id="pdImage" name="pdImage"
												action="/wonder/image/write"
												class="dropzone dz-clickable primary-dropzone"
												enctype="multipart/form-data">
												<div class="dz-default dz-message">
													<i class="ti-gallery"></i> <span>원하는 파일을 드래그해주세요</span>
												</div>
											</form>
										</div>

									</div>
								</div>
							</div>

						</div>
					</div>
				</div>

				<div class="form-group">
					<div class="col-lg-12 col-md-12">
						<button id="pd_reg" class="btn btn-theme" type="submit">상품
							등록하기</button>
					</div>
				</div>

			</div>
	</div>

	</div>
	</div>
	</form>
	</section>
	<!-- ============================ Submit Property End ================================== -->

	<!-- ============================ Call To Action ================================== -->

	<!-- ============================ Call To Action End ================================== -->

	<!-- Log In Modal -->
	<div class="modal fade" id="login" tabindex="-1" role="dialog"
		aria-labelledby="registermodal" aria-hidden="true">
		<div class="modal-dialog modal-xl login-pop-form" role="document">
			<div class="modal-content overli" id="registermodal">
				<div class="modal-body p-0">
					<div class="resp_log_wrap">
						<div class="resp_log_thumb"
							style="background: url(assets/img/log.jpg) no-repeat;"></div>
						<div class="resp_log_caption">
							<span class="mod-close" data-dismiss="modal" aria-hidden="true"><i
								class="ti-close"></i></span>
							<div class="edlio_152">
								<ul class="nav nav-pills tabs_system center" id="pills-tab"
									role="tablist">
									<li class="nav-item"><a class="nav-link active"
										id="pills-login-tab" data-toggle="pill" href="#pills-login"
										role="tab" aria-controls="pills-login" aria-selected="true"><i
											class="fas fa-sign-in-alt mr-2"></i>Login</a></li>
									<li class="nav-item"><a class="nav-link"
										id="pills-signup-tab" data-toggle="pill" href="#pills-signup"
										role="tab" aria-controls="pills-signup" aria-selected="false"><i
											class="fas fa-user-plus mr-2"></i>Register</a></li>
								</ul>
							</div>
							<div class="tab-content" id="pills-tabContent">
								<div class="tab-pane fade show active" id="pills-login"
									role="tabpanel" aria-labelledby="pills-login-tab">
									<div class="login-form">
										<form>

											<div class="form-group">
												<label>User Name</label>
												<div class="input-with-icon">
													<input type="text" class="form-control"> <i
														class="ti-user"></i>
												</div>
											</div>

											<div class="form-group">
												<label>Password</label>
												<div class="input-with-icon">
													<input type="password" class="form-control"> <i
														class="ti-unlock"></i>
												</div>
											</div>

											<div class="form-group">
												<div class="eltio_ol9">
													<div class="eltio_k1">
														<input id="dd" class="checkbox-custom" name="dd"
															type="checkbox"> <label for="dd"
															class="checkbox-custom-label">Remember Me</label>
													</div>
													<div class="eltio_k2">
														<a href="#">Lost Your Password?</a>
													</div>
												</div>
											</div>

											<div class="form-group">
												<button type="submit"
													class="btn btn-md full-width pop-login">Login</button>
											</div>

										</form>
									</div>
								</div>
								<div class="tab-pane fade" id="pills-signup" role="tabpanel"
									aria-labelledby="pills-signup-tab">
									<div class="login-form">
										<form>

											<div class="form-group">
												<label>Full Name</label>
												<div class="input-with-icon">
													<input type="text" class="form-control"> <i
														class="ti-user"></i>
												</div>
											</div>

											<div class="form-group">
												<label>Email ID</label>
												<div class="input-with-icon">
													<input type="email" class="form-control"> <i
														class="ti-user"></i>
												</div>
											</div>

											<div class="form-group">
												<label>Password</label>
												<div class="input-with-icon">
													<input type="password" class="form-control"> <i
														class="ti-unlock"></i>
												</div>
											</div>

											<div class="form-group">
												<div class="eltio_ol9">
													<div class="eltio_k1">
														<input id="dd" class="checkbox-custom" name="dd"
															type="checkbox"> <label for="dd"
															class="checkbox-custom-label">By using the
															website, you accept the terms and conditions</label>
													</div>
												</div>
											</div>

											<div class="form-group">
												<button type="submit"
													class="btn btn-md full-width pop-login" id="btWrite">Register</button>
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

	<a id="back2Top" class="top-scroll" title="Back to top" href="#"><i
		class="ti-arrow-up"></i></a>


	</div>
	<!-- ============================================================== -->
	<!-- End Wrapper -->
	<!-- ============================================================== -->

</body>

<%@ include file="../inc/bottom.jsp"%>