<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/mypage/incSide" />
<%-- <%@ include file="incSide.jsp" %> --%>

<script type="text/javascript">
	$(function(){
		 var fileTarget = $('#profileUpload');
		  fileTarget.on('change', function(){  // 값이 변경되면
		    if(window.FileReader){  // modern browser
		      var filename = $(this)[0].files[0].name;
		    } 
		    else {  // old IE
		      var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
		    }
		    // 추출한 파일명 삽입
		    $(this).siblings('.upload_name').val(filename);
		  });
		  
		  //preview image 
		    var imgTarget = $('.preview-image #profileUpload');
		    imgTarget.on('change', function(){
		        var parent = $(this).parent();
		        parent.children('.upload-display').remove();
		        $('.upload-display').remove();
		        var html="";
		        var preview="";

		        if(window.FileReader){
		            //image 파일만
		            if (!$(this)[0].files[0].type.match(/image\//)) return;
		            
		            var reader = new FileReader();
		            reader.onload = function(e){
		                var src = e.target.result;
		                html += '<div class="upload-display">';
   			            html += '<div class="upload-thumb-wrap">'
   			            html += '<img src="'+src+'" class="upload-thumb">';
   			            html += '</div>';
   			            html += '</div>';
   			
						preview += '<div class="upload-display">';
   			            preview += '<div class="upload-thumb-wrap">'
   			            preview += '<img src="'+src+'" class="upload-thumb" style="border-radius: 75px">';
   			            preview += '</div>';
   			     	    preview += '</div>';
   		                
   		                parent.append(html);
		                $('#profile_preview').append(preview);
		            }
		            reader.readAsDataURL($(this)[0].files[0]);
		        }else{
		            $(this)[0].select();
		            $(this)[0].blur();
		            var imgSrc = document.selection.createRange().text;
		            html += '<div class="upload-display">';
					html += '<div class="upload-thumb-wrap">'
					html += '<img class="upload-thumb">';
					html += '</div>';
					html += '</div>';
					
					preview += '<div class="upload-display">';
					preview += '<div class="upload-thumb-wrap">'
					preview += '<img src="'+src+'" class="upload-thumb" style="border-radius: 75px">';
					preview += '</div>';
					preview += '</div>';
					
					parent.append(html);
		            $('#profile_preview').append(html);
		            var img = $(this).siblings('.upload-display').find('img');
		            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
		        }
		    });
		    
		   

		$('#submitBt').click(function(){
			if(!confirm('작성하신 정보로 프리랜서 등급 신청을 하시겠습니까?')){
				return false;
			}
		});
		
		$('#appCheckBt').click(function(){
			var check = $('#checkGrant').val();
			var userId = $('#applicationUserId').val();
			console.log(userId);
			
			if(check>0){
				location.href="<c:url value='/mypage/applicationCheck?userId="+userId+"'/>";
			}else if(check==0){
				alert('먼저 등록신청을 해야합니다');				
			}
		});
		

	
	});

</script>
<input type="hidden" id="pageCheck" value="application">

<script src="<c:url value='/js/jquery.nice-select.js' />"></script>
<link href="<c:url value='/css/mypage.css'/>" rel="stylesheet">
<link href="<c:url value='/css/nice-select.css' />" rel="stylesheet">
						<div class="col-lg-9 col-md-8 col-sm-12">
							<div class="dashboard-body">
							
								<div class="dashboard-wraper">
									<form name="frmProfile" method="post" enctype="multipart/form-data" action="<c:url value='/mypage/application' />"> 
								
									<!-- Basic Information -->
									<div class="frm_submit_block">	
										<div class="appCheckDiv">
											<h4 class="appCheckH4">프리랜서 등록 신청</h4>
											<button class="btn btn-theme btn-lg appCheck" type="button" id="appCheckBt">신청확인</button><br>
											<input type="hidden" value="${checkGrant }" id="checkGrant">
										</div>
										<div class="frm_submit_wrap">
											<div class="form-row"> <!-- 기준디브 -->
											
												<div class="form-group col-md-6 generalMember">
													<label>이름</label>
													<input type="text" class="form-control profile_disabled" value="${memVo.name }" disabled="disabled">
													<input type="hidden" id="applicationUserId" value="${memVo.userId }" disabled="disabled">
												</div>
												
												<div class="form-group col-md-6 generalMember">
													<label>가입일</label>
													<input type="text" class="form-control profile_disabled" 
														value="<fmt:formatDate value="${memVo.regdate }" pattern="yyyy년 MM월 dd일" />" disabled="disabled">
												</div>
												
												<div class="form-group col-md-6 generalMember">
													<label>회원분류</label>
													<input type="text" class="form-control profile_disabled" value="${memVo.type }" disabled="disabled">
												</div>
												
												<div class="form-group col-md-6 generalMember">
													<label>이메일</label>
													<input type="email" class="form-control profile_disabled" name="email" value="${memVo.email }">
												</div>
												
												<div class="form-group col-md-6 generalMember">
													<label>닉네임</label>
													<input type="text" class="form-control profile_disabled" name="nickname" value="${memVo.nickname }">
												</div>
												
												<div class="form-group col-md-6 generalMember">
													<label>연락처</label>
													<input type="text" class="form-control profile_disabled" name="tel" value="${memVo.tel }">
												</div>
												

												
												<div class="form-group col-md-6">
													<label>전공</label>
													<input type="text" class="form-control" name="major" value="${expertVo.major }">
												</div>
												
												<div class="form-group col-md-6">
													<label>학력</label>
													<input type="text" class="form-control" name="grade" value="${expertVo.grade }">
												</div> 
												
												<div class="form-group col-md-6">
													<label>은행명</label>
													<input type="text" class="form-control" name="bankName" value="${expertVo.bankName }">
												</div> 
												
												<div class="form-group col-md-6">
													<label>계좌번호 (하이픈" - "을 빼고 입력해주세요)</label>
													<input type="text" class="form-control" name="accountNo" value="${expertVo.accountNo }">
												</div> 
												
												<div class="form-group col-md-12">
													<label>보유 자격증</label>
													<input type="text" class="form-control" name="certificate" value="${expertVo.certificate }">
												</div> 
												
												<div class="form-group col-md-6">
													<label>완료된 작업 건수</label>
													<input type="text" class="form-control profile_disabled" value="${expertVo.workAmount }건" disabled="disabled">
												</div> 
												
												<div class="form-group col-md-4">
													<label>개발 경력</label>
													<select id="bage" class="form-control" name="career">
														<option value="">경력을 선택하세요</option>
														<option value="0,1">0 - 1년</option>
														<option value="1,3" selected="selected">1 - 3년</option>
														<option value="3,5">3 - 5년</option>
														<option value="5,10">5 - 10년</option>
														<option value="10,over">10년+</option>
													</select>
												</div>
												

												<script type="text/javascript">
												$(function(){
													/* 실제 제출용 */
													$('#submitBt').click(function(){
														$('#usableLanguage').val("");
														$('#usableFramework').val("");

														$('.langLi').each(function(idx,item){
															var before = $(this).find('input[type="checkbox"]:checked').attr('name');
															console.warn(before);
															var name = <c:out value='before' />;
															if(name != null && name != ""){
																var value=$('#usableLanguage').val();
																$('#usableLanguage').val(value+name+",");
															}
														})
														$('.frameLi').each(function(idx,item){
															var before = $(this).find('input[type="checkbox"]:checked').attr('name');
															console.warn(before);
															var name = <c:out value='before' />;
															if(name != null && name != ""){
																var value=$('#usableFramework').val();
																$('#usableFramework').val(value+name+",");
															}
														})
													}); 
													
													
													/* 테스트용 */
													 $('#checked').click(function(){
														$('#usableLanguage').val("");
														$('#usableFramework').val("");

														$('.langLi').each(function(idx,item){
															var before = $(this).find('input[type="checkbox"]:checked').attr('name');
															console.warn(before);
															var name = <c:out value='before' />;
															if(name != null && name != ""){
																var value=$('#usableLanguage').val();
																$('#usableLanguage').val(value+name+",");
															}
														})
														$('.frameLi').each(function(idx,item){
															var before = $(this).find('input[type="checkbox"]:checked').attr('name');
															console.warn(before);
															var name = <c:out value='before' />;
															if(name != null && name != ""){
																var value=$('#usableFramework').val();
																$('#usableFramework').val(value+name+",");
															}
														})
													});
													
													
													/* 제출시 히든시켜둔 언어 프레임워크 필드값 넘기기 */
													$('form[name=frmProfile]').submit(function(){
														var checkedLang = $('#usableLanguage').val();
														var checkedFrame = $('#usableFramework').val();
														
														if(checkedLang == null || checkedLang ==""){
															$('#usableLanguage').val("없음");
														}
														if(checkedFrame == null || checkedFrame ==""){
															$('#usableFramework').val("없음");
														}
													});
													
													
												});
												</script>
												
												<div class="form-group col-md-12">
													<br>
													<label>개발 가능 언어</label>
													<div class="o-features">
														<ul class="no-ul-list third-row usableLangCheck" style="justify-content:start">
															<c:forEach var="listVo" items="${langList }">
															<li class="langLi">
																
																<%-- <c:set var="usableLang" value="N" />
																<c:forEach var="langList" items="${langArr }">
																	<c:if test="${listVo.lang == langList}">
																		<c:set var="usableLang" value="Y" />
																	</c:if>
																</c:forEach> 
																
																<c:if test="${usableLang == 'Y' }">
																	<input id="lang_${listVo.langNo }" class="checkbox-custom" name="${listVo.lang }" type="checkbox" checked>
																</c:if>
																<c:if test="${usableLang == 'N' }">--%>
																	<input id="lang_${listVo.langNo }" class="checkbox-custom" name="${listVo.lang }" type="checkbox">
																<%-- </c:if> --%>
																<label for="lang_${listVo.langNo }" class="checkbox-custom-label">${listVo.lang }</label>
															</li>
															</c:forEach>
														
														</ul>
													</div>
													<br>
													<label>개발 가능 프레임워크</label>
													<div class="o-features">
														<ul class="no-ul-list third-row usableFrameCheck" style="justify-content:start">
															<c:forEach var="frameVo" items="${frameList }">
															<li class="frameLi">
																<c:set var="usableFrame" value="N" />
																<c:forEach var="frameList" items="${frameArr }">
																	<c:if test="${frameVo.frame == frameList}">
																		<c:set var="usableFrame" value="Y" />
																	</c:if>
																</c:forEach>
																
																<c:if test="${usableFrame == 'Y' }">
																	<input id="frame_${frameVo.frameNo }" class="checkbox-custom" name="${frameVo.frame }" type="checkbox" checked>
																</c:if>
																<c:if test="${usableFrame == 'N' }">
																	<input id="frame_${frameVo.frameNo }" class="checkbox-custom" name="${frameVo.frame }" type="checkbox">
																</c:if>
																<label for="frame_${frameVo.frameNo }" class="checkbox-custom-label">${frameVo.frame }</label>
															</li>
															</c:forEach>
															

														
								
														</ul>
													</div>
													<div id="checked">
														<input type="hidden" value="체크 테스트" class="checkBt">
													</div>
																
													<!-- <script type="text/javascript">
														$(function(){
															$('#checked').click(function(){
																$('.checkbox-custom').prop("checked",true);
															});
															$('#unchecked').click(function(){
																$('.checkbox-custom').prop("checked",false);
															});
														});
													</script>
													<div class="checkBt" id="checked">
														<p>모두 선택</p>
													</div>
													<div class="checkBt" id="unchecked">
														<p>모두 취소</p>
													</div>
													 -->
													<input type="hidden" name="lang" id="usableLanguage"  style="width:100%">
													<input type="hidden" name="frame" id="usableFramework"  style="width:100%">
													<input type="hidden" id="langArr" style="width:100%"">
													
												</div>
												<div class="form-group col-md-12">
													<label>소개</label>
													<textarea class="form-control" name="introduction">${expertVo.introduction }</textarea>
												</div>	
												
												
												<div class="form-group col-md-12">
												<br>
												<div class="uploadBoxWrap">
													<label>프로필 사진 (150x150 사이즈의 이미지 파일을 업로드를 권장합니다)</label><br>
														<div class="uploadBox">
															<div class="uploadBox_inner">
																<label class="uploadBox_inner_p" for="profileUpload">프로필 사진<br>업로드</label>
															</div>
	
															<div class="uploadBox_innerRight  preview-image">
																<input type="hidden" class="upload_name" value="" disabled="disabled">
																<input type="file" id="profileUpload" name="upfile"> <!-- file -->
															</div>
	
														</div>
														
														<div class="uploadBox uploadBox2">
															<div class="uploadBox_inner">
																<label class="uploadBox_inner_v">프로필 사진<br>미리보기</label>
															</div>
	
															<div class="uploadBox_innerRight  preview-image" id="profile_preview" >
																<input type="hidden">
															</div>
	
														</div>
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
													<button class="btn btn-theme btn-lg " type="submit" id="submitBt">신청하기</button><br>
													<label style="font-size: 11px;"> * 신청 승인에는 영업일 기준 최대 3일의 기간이 소요될 수 있습니다</label>
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