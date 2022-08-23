<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/mypage/incSide" />
<%-- <%@ include file="incSide.jsp" %> --%>
 
<script type="text/javascript">
	$(function(){
		    $("#portfolioUpload").on('change', function () {

		        //등록한 사진 갯수
		        var countFiles = $(this)[0].files.length;

		        var imgPath = $(this)[0].value;
		        var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
		        var image_holder = $("#image-holder");
		        image_holder.empty();
                $('#reviewProtfolioName').val(""); //파일 업로드 이름 미리보기칸 리셋


		        if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg" || extn == "") {
		            if (typeof (FileReader) != "undefined") {
						if(countFiles <=5){
			                //사진갯수만큼 for문
			                for (var i = 0; i < countFiles; i++) {
								var name = $(this)[0].files[i].name;
								var before = $('#reviewProtfolioName').val();
			                    var reader = new FileReader();
			                    reader.onload = function (e) {
			                        $("<img />", {
			                            "src": e.target.result,
			                                "class": "thumb-image"
			                        }).appendTo(image_holder);
			                    }
	
			                    image_holder.show();
			                    reader.readAsDataURL($(this)[0].files[i]);
			                    $('#reviewProtfolioName').val(before + ", " + name);
			                }
						}else{
			                alert("이미지는 최대 5개까지 올릴 수 있습니다.");
						}

		            } else {
		                alert("해당 브라우저에서 FileReader를 지원하지 않습니다.");
		            }
		        } else {
		            alert("이미지 파일만 등록할 수 있습니다.");
		        }
		    });
		    


		   

		$('#submitBt').click(function(){
			if(!confirm('새로운 포트폴리오 업로드시 기존 포트폴리오는 삭제됩니다. \n\n정말 수정하시겠습니까?')){
				return false;
			}
		});
		

		
	});

</script>
<input type="hidden" id="pageCheck" value="portfolio">

<script src="<c:url value='/js/jquery.nice-select.js' />"></script>
<link href="<c:url value='/css/mypage.css'/>" rel="stylesheet">
<link href="<c:url value='/css/nice-select.css' />" rel="stylesheet">
						<div class="col-lg-9 col-md-8 col-sm-12">
							<div class="dashboard-body">
							
								<div class="dashboard-wraper">
									<form name="frmProfile" method="post" enctype="multipart/form-data" action="<c:url value='/mypage/portfolio' />">
								
									<!-- Basic Information -->
									<div class="frm_submit_block">	
										<h4>나의 포트폴리오 정보</h4>
										<div class="frm_submit_wrap">
											<div class="form-row"> <!-- 기준디브 -->
											
																		
												
												<div class="form-group col-md-12">
												<br>
												<div class="uploadBoxWrap">
													<label>포트폴리오 사진</label><br>
														<div class="uploadBox" style="width:100%; height: 300px;" id="portfolioBox">
															<!-- <div class="uploadBox_inner">
																<label class="uploadBox_inner_p portfolioView">포트폴리오 사진</label>
															</div> -->
															<c:forEach var="vo" items="${list }" varStatus="vs">
															<div class="portfolioBox_outter">
																<div class="portfolioBox_innerRight align_c">
																	
																	<img alt="포트폴리오 이미지" src="<c:url value='/img/mypage/expert_portfolio/${vo.fileName }' />" 
																		class="portfolioImg" id="portfolioImg${vs.index }">
																		
																	<div class="portfolioModal" id="portfolioModal${vs.index }">
																	  <div class="portfolioModal_content" title="클릭하면 창이 닫힙니다.">
																	  	<img alt="포트폴리오 모달 이미지" src="<c:url value='/img/mypage/expert_portfolio/${vo.fileName }' />"
																	  		style="height: 700px;">
																	  </div>
																	</div>
																																		
																</div>
																<div>
																	<p class="align_c">클릭시 확대</p>
																</div>
															</div>
															
															<script type="text/javascript">
																$(function(){
																	 $("#portfolioImg${vs.index }").click(function(){
																		var imgSrc = $('#portfolioBox_innerRight img').attr("src");
																		var jstl = "<c:out value='${vs.index }' />";
																		$('#portfolioModal_content img').attr("src",imgSrc);
																	    $(".portfolioModal").eq(jstl).fadeIn();
																	 });
																		  
																	  $(".portfolioModal_content img").click(function(){
																		var jstl = "<c:out value='${vs.index }' />";
																	    $(".portfolioModal").eq(jstl).fadeOut();
																	 });
																});
															</script>
															
													
															</c:forEach>
														</div>
													</div>
												</div>	
												
												
												<div class="form-group col-md-12">
												<br>
												<div class="uploadBoxWrap">
													<label>포트폴리오 사진 업로드 (최대 5개의 이미지파일만 업로드할 수 있습니다)</label><br>
														<div class="uploadBox" style="width:100%">
															<div class="uploadBox_inner">
																<label class="uploadBox_inner_p" for="portfolioUpload">포트폴리오 사진<br>업로드</label>
															</div>
	
															<div class="uploadBox_innerRight  preview-image">
																<input type="hidden" class="upload_name" value="" disabled="disabled">
																<input type="file" id="portfolioUpload" name="portfolioFile" multiple="multiple"> <!-- file -->
															</div>
															<div id="image-holder">
															
															</div>
														</div>
														<br>
														<input type="text" id="reviewProtfolioName" name="reviewProtfolioName" style="width:100%">
													</div>
												</div>	
											</div>
										</div>
									</div>
									
									<div class="frm_submit_block">	
										<!-- <h4>Social Accounts</h4> -->
										<div class="frm_submit_wrap">
											<div class="form-row">
											

												
												<div class="form-group col-lg-12 col-md-12 mt-4 generalMember">
													<button class="btn btn-theme btn-lg " type="submit" id="submitBt">변경사항 적용</button>
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