<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/mypage/incSide" />
<%-- <%@ include file="incSide.jsp" %> --%>

<script type="text/javascript">
	$(function(){
		$('#submitBt').click(function(){
			if(!confirm('정보를 수정하시겠습니까?')){
				return false;
			}
		});
		
		if(${memVo.type=='일반회원'}){
			$('.form-row div').hide();
			$('.generalMember').show();
		}
		

		
	});

</script>
<input type="hidden" id="pageCheck" value="application">

<script src="<c:url value='/js/jquery.nice-select.js' />"></script>
<link href="<c:url value='/css/mypage.css'/>" rel="stylesheet">
<link href="<c:url value='/css/nice-select.css' />" rel="stylesheet">
	<div class="col-lg-9 col-md-8 col-sm-12">
		<div class="dashboard-body">
								
		<div class="dashboard-wraper">
			<div class="col-lg-12 col-md-12">
				<h4>프리랜서 등록 신청 상태</h4><br>
						<div class="dashboard_property">
							<div>
								<table class="table" id="memList">
									<thead class="thead-dark">
										<tr>
											<th scope="col">회원번호 / 아이디</th>
											<th scope="col" class="m2_hide">이름</th>
											<th scope="col" class="m2_hide">닉네임</th>
											<th scope="col" class="m2_hide">메일</th>
											<th scope="col" class="m2_hide">가입일</th>
											<th scope="col">회원상태</th>
										</tr>
									</thead>
									<tbody>
										<!-- tr block -->
										<c:if test="${empty memVo }">
											<tr>
												<td colspan="5">승인 대기 신청이 존재하지 않습니다.</td>
											</tr>
										</c:if>
										<c:if test="${!empty memVo}">
											<!--게시판 내용 반복문 시작  -->
												<tr>
													<td>
														<div class="dash_prt_wrap">
															<div class="dash_prt_caption">
																<div class="prt_dashb_lot">No. ${memVo.memNo }</div>
																<h5>${memVo.userId}</h5>
															</div>
														</div>
													</td>
													<td class="m2_hide">
														<div class="prt_leads">
															<h6>${memVo.name }</h6>
														</div>
													</td>
													<td class="m2_hide">
														<div class="prt_leads">
															<h6>${memVo.nickname }</h6>
														</div>
													</td>
													<td class="m2_hide">
														<div class="_leads_view">
															<h5>${memVo.email }</h5>
														</div>
														<div class="_leads_view_title">
														</div>
													</td>
													<td class="m2_hide">
														<div class="_leads_posted">
															<h5>
																<fmt:formatDate value="${memVo.regdate }"
																	pattern="yyyy-MM-dd HH:mm" />
															</h5>
														</div>
														<div class="_leads_view_title">
														</div>
													</td>
													<td>
														<c:if test="${memVo.type eq '일반회원' }">
																<div class="_leads_status" id="type1">
																	<span class="active" id="type">일반회원</span>
																</div>
														</c:if> 
														<c:if test="${memVo.type eq '승인대기' }">
																<div class="_leads_status" id="type1">
																	<span class="application" id="type">승인대기</span>
																</div>
														</c:if> 
														<c:if test="${memVo.type eq '프리랜서' }">
																<div class="_leads_status" id="type1">
																	<span class="expire" id="type">프리랜서</span>
																</div>
														</c:if>
													
													</td>
												</tr>
										</c:if>
										<!-- tr block -->
									</tbody>
								</table>

							</div>
						</div><br><br><br>
						<h4>프리랜서 등록 신청 정보</h4>
					</div>
					<br>
							<form name="frmProfile" method="post" enctype="multipart/form-data" action="<c:url value='/mypage/profile' />">
								
									<!-- Basic Information -->
									<div class="frm_submit_block">	
										
										<div class="frm_submit_wrap">
											<div class="form-row"> <!-- 기준디브 -->
											
												<div class="form-group col-md-6 generalMember">
													<label>이름</label>
													<input type="text" class="form-control profile_disabled" value="${memVo.name }" disabled="disabled">
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
													<input type="text" class="form-control profile_disabled" name="major" value="${expertVo.major }">
												</div>
												
												<div class="form-group col-md-6">
													<label>학력</label>
													<input type="text" class="form-control profile_disabled" name="grade" value="${expertVo.grade }">
												</div> 
												
												<div class="form-group col-md-6">
													<label>은행명</label>
													<input type="text" class="form-control profile_disabled" name="bankName" value="${expertVo.bankName }">
												</div> 
												
												<div class="form-group col-md-6">
													<label>계좌번호 (하이픈" - "을 빼고 입력해주세요)</label>
													<input type="text" class="form-control profile_disabled" name="accountNo" value="${expertVo.accountNo }">
												</div> 
												
												<div class="form-group col-md-12">
													<label>보유 자격증</label>
													<input type="text" class="form-control profile_disabled" name="certificate" value="${expertVo.certificate }">
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
													
													
													/* 제출시 히든시켜둔 언어/프레임워크 필드값 넘기기 */
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
																<c:set var="usableLang" value="N" />
																<c:forEach var="langList" items="${langArr }">
																	<c:if test="${listVo.lang == langList}">
																		<c:set var="usableLang" value="Y" />
																	</c:if>
																</c:forEach>
																
																<c:if test="${usableLang == 'Y' }">
																	<input id="lang_${listVo.langNo }" class="checkbox-custom" name="${listVo.lang }" type="checkbox" checked>
																</c:if>
																<c:if test="${usableLang == 'N' }">
																	<input id="lang_${listVo.langNo }" class="checkbox-custom" name="${listVo.lang }" type="checkbox">
																</c:if>
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
													
												</div>
												<div class="form-group col-md-12">
													<label>소개</label>
													<textarea class="form-control" name="introduction" readonly="readonly">${expertVo.introduction }</textarea>
												</div>	
												
												
												
												


												
											</div>
										</div>
									</div>
									
									<div class="frm_submit_block">	
										<!-- <h4>Social Accounts</h4> -->
									
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