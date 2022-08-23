<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/mypage/incSide" />

 <!-- iamport.payment.js -->
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js" type="text/javascript"></script> 
 
<%-- <%@ include file="incSide.jsp" %> --%>
<script type="text/javascript">

 $(function(){
	 $('.CModalContainer').each(function(item,idx){
		 $(this).click(function(){
			 $(this).find('.modalD').modal('show');
		 });
		 
		 $(this).find('.mod-close').click(function(){
			 $(this).modal('hide');
		 });
	 });
	 
	 $('#modalA').each(function(item,idx){
		 $(this).click(function(){
			 $('.modalA').modal('show');
		 });
	 });
	 

	 $('#formTypeUpdate').click(function(){
			if(!confirm('해당 의뢰를 수락하시겠습니까?')){
				return false;
			}
		});
	 
	 $('.formCancle').click(function(){
			if(!confirm('해당 의뢰를 취소하시겠습니까?')){
				return false;
			}
	});

	 $('#applicationDone').click(function(){
			if(!confirm('해당 의뢰를 완료처리하시겠습니까?')){
				return false;
			}
	});
	 
     //모달 닫으면 뒷 배경 스크롤 가능

 
	 
 }); //function.ready
 
 
function pageProc(curPage){
	$('input[name=currentPage]').val(curPage);
	$('form[name=frmPage]').submit();
}


//결제 시스템
const IMP = window.IMP; // 생략 가능
IMP.init("imp71307268"); // Example: imp00000000

<c:forEach var="map" items="${list }" varStatus="status">
	function requestPay${status.index }() {
	    // IMP.request_pay(param, callback) 결제창 호출
	    IMP.request_pay({ // param
	        pg: "html5_inicis",
	        pay_method: "card",
	        merchant_uid: "${map.FORM_NO }",
	       	name: "${map.PD_TITLE }",
	        amount: ${map.PRICE },
	        buyer_email: "${map.EMAIL }",
	        buyer_name: "${map.NAME }",
	        buyer_tel: "${map.TEL }"
	    }, function (rsp) { // callback
	    	if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
	            // jQuery로 HTTP 요청
	            jQuery.ajax({
	            	url: "<c:url value='/mypage/payment' />", 
	                method: "POST",
	                headers: { "Content-Type": "application/json" },
	                data: JSON.stringify({
	                    payCode: rsp.imp_uid, //결제번호
	                    formNo: rsp.merchant_uid, //주문번호
	                    payMethod: rsp.pay_method,
	                    pdName: rsp.name,
	                    price: ${map.PRICE },
	                    buyerName: rsp.buyer_name,
	                    buyerTel: rsp.buyer_tel
	                }),
	                success: function(res){
			          if(res == 1){
						alert('결제 성공')	;		           
			          }
			        },
			        error:function(xhr, status, error){
			          console.log("error : ajax 통신 실패!!!");
			        }
				}) //ajax
			} else {
	            alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
			}
	    	m_redirect_url: "<c:url value='/mypage/transaction' />";
	    });
	  }
</c:forEach>  

</script>
<input type="hidden" id="pageCheck" value="transaction">

<link href="${pageContext.request.contextPath}/css/mypage.css" rel="stylesheet">


						
						<div class="col-lg-9 col-md-8 col-sm-12">
							<div class="dashboard-body">
							
								<div class="row">
									<div class="col-lg-12 col-md-12">
										<div class="_prt_filt_dash">
											<div class="_prt_filt_dash_flex">
											
											
    
												<div class="foot-news-last">
													<div class="input-group">
														<form name="frmSearch" method="post" 
													   		action='<c:url value="/mypage/transaction" />'>
																<div class="input-group-append">
																<input type="text" class="form-control transSearch" name="searchKeyword" title="검색어 입력"
													        		value="${param.searchKeyword}" placeholder="상품명으로 검색">
													        	<input type="hidden" name="searchCondition" value="PD_TITLE">
																	<button type="submit" class="input-group-text theme-bg b-0 text-light"><i class="fas fa-search"></i></button>
																</div>
													    </form>
													</div>
												</div>
											</div>
											<div class="_prt_filt_dash_last m2_hide">
												<div class="_prt_filt_radius">
													
												</div>
												<div class="_prt_filt_add_new">
													<a href="<c:url value='/pd/pdList' />" class="greenLabel"><i class="fas fa-plus-circle"></i><span class="d-none d-lg-block d-md-block">　더 많은 상품 보러가기</span></a>
												</div>
												
												
											  <c:if test="${vo.type=='프리랜서' }">
												<div class="_prt_filt_add_new">
													<a href="#" class="greenLabel" id="modalA"><i class="fas fa-plus-circle"></i><span class="d-none d-lg-block d-md-block">　내 일정 보기</span></a>
												</div>
												</c:if>
												
												<!-- Modal A -->
														<div class="modal fade modalA" id="exampleModalToggleA${status.index }" data-backdrop="static" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
														  <div class="modal-dialog modal-xl modal-dialog-centered">
														    <div class="modal-content">
														      <div class="modal-header" style="margin: 0 auto; border-bottom: 3px solid #27ae60;">
														        <h5 class="modal-title" id="exampleModalToggleLabel">제작자 일정</h5>
														        <span class="mod-close" data-dismiss="modal" aria-hidden="true" style="border-radius: 50%;"><i class="ti-close"></i></span>
														      </div>
														      <div class="modal-body">
																<iframe src="<c:url value='/pd/calendar?userId=${vo.userId }'/>" width="790px" height="650px" style="border:none"></iframe>
														      </div>
														    </div>
														  </div>
														</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-12 col-md-12">
										<div class="dashboard_property">
											<div class="table-responsive">
												<table class="table">
													<thead class="thead-dark">
														<tr>
														  <th scope="col">상품명</th>
														  <th scope="col" class="m2_hide transactionTd center">조회수</th>
														  <th scope="col" class="m2_hide transactionTd center">작업기간</th>
														  <th scope="col" class="transactionTd center">상태</th>
														  <c:if test="${vo.type == '일반회원' || vo.type == '승인대기' }">
														  	<th scope="col" class="transactionTd center">거래취소</th>
														  </c:if>
														  <c:if test="${vo.type=='프리랜서' }">
														  	<th scope="col" class="transactionTd center">프리랜서</th>
														  </c:if>
														  <th scope="col" class="transactionTdIcon center">메세지</th>
														  <th scope="col" class="transactionTdIcon center">의뢰서</th>
														  <th scope="col" class="transactionTdIcon center">결제</th>
														  <th scope="col" class="transactionTdIcon center">완료</th>
														</tr>
													</thead>
													<tbody>
													
													<c:choose>
														<c:when test="${fn:length(list) == 0 }" >
														 <td colspan="9">
														 	<br>
														 	<h5 class="noneList">거래내역이 없습니다</h5>
														 </td>
														</c:when>
														<c:otherwise>
															<c:forEach var="map" items="${list }" varStatus="status">
																<!-- tr block -->
																<tr>
																	<td>
																		<a href="<c:url value='/pd/pdDetail?pdNo=${map.PD_NO }'/>" >
																			<div class="dash_prt_wrap">
																				<div class="dash_prt_thumb">
																					<img src="<c:url value='/img/pdupload/${map.FILE_NAME }' />" alt="거래 상품 사진" class="bookmarkImg">
																				</div>
																				<div class="dash_prt_caption">
																					<h5>${map.PD_TITLE }</h5>
																					<div class="prt_dashb_lot"><p>${map.INTRODUCTION }</p></div>
																					<div class="prt_dash_rate">
																						<span class="table-property-price">
																							<fmt:formatNumber value="${map.PRICE }" pattern="#,###" />
																							 원</span>
																					</div>
																				</div>
																			</div>
																		</a>
																	</td>
																	<td class="m2_hide transactionTd center">
																		<div class="prt_leads">
																			<span>
																				<fmt:formatNumber value="${map.READ_COUNT }" pattern="#,###" />
																			</span>
																		</div>
																	</td>
																	<td class="m2_hide transactionTd center">
																		<div class="_leads_posted"><h5>${map.PD_TERM }일 소요</h5></div>
																	</td>
																	<td class="center"> <!-- 거래성태 -->
																		<c:if test="${map.PAY_FLAG=='N'}">
																			<div class="_leads_status"><span class="expire">의뢰대기</span></div>
																		</c:if>
																		<!-- 여기에 거래중 다른 조건 걸기 -->
																		<c:if test="${map.PAY_FLAG=='Y'}">
																			<div class="_leads_status"><span class="application">의뢰수락</span></div>
																		</c:if>
																		<c:if test="${map.PAY_FLAG=='P'}">
																			<div class="_leads_status"><span class="application">결제완료</span></div>
																		</c:if>
																		<c:if test="${map.PAY_FLAG=='D'}">
																			<div class="_leads_status"><span class="active">의뢰완료</span></div>
																		</c:if>
																		<c:if test="${map.PAY_FLAG=='C'}">
																			<div class="_leads_status"><span class="expire">의뢰취소</span></div>
																		</c:if>
																	</td>
																	
																	
																	<td class="center"> <!-- 수락/취소 -->
																		<div class="_leads_action">
																		
																			<c:if test="${vo.type=='프리랜서' }">
																				<a href="<c:url value='/mypage/transactionFormUpdate?formNo=${map.FORM_NO}'/>"  id="formTypeUpdate"><span style="font-weight: bold;">O</span></a>
																				<a href="<c:url value='/mypage/transactionFormCancle?formNo=${map.FORM_NO}'/>" class="formCancle"><span style="font-weight: bold;">X</span></a>
																			</c:if>
																		
																			<c:if test="${vo.type=='일반회원' or '승인대기'}">
																				<a href="<c:url value='/mypage/transactionFormCancle?formNo=${map.FORM_NO}'/>" class="formCancle"><span style="font-weight: bold;">X</span></a>
																			</c:if>
																		
																		
																		</div>
																	</td>
																	
																	
																	
																	
																	<td class="center"> <!-- 메세지 -->
																		<div class="_leads_action">
																			<c:if test="${vo.type=='프리랜서' }">
																				<a href="<c:url value='/mypage/chatting?userId=${map.B_USER_ID}'/>"><i class="fas fa-envelope"></i></a>
																			</c:if>
																			<c:if test="${vo.type=='일반회원' or vo.type=='승인대기'}">
																				<a href="<c:url value='/mypage/chatting?userId=${map.S_USER_ID}'/>"><i class="fas fa-envelope"></i></a>
																			</c:if>
																		</div>
																	</td>
																	<td class="center"> <!-- 의뢰서 -->
																		<div class="_leads_action CModalContainer">
																			<a href="#"><i class="fas fa-edit"></i></a>
																				<!-- Modal C -->
																			   <div class="modal fade modalD" data-backdrop="static" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
																			     <div class="modal-dialog modal-lg modal-dialog-centered">
																			       <div class="modal-content">
																			         <div class="modal-header" style="margin: 0 auto; border-bottom: 3px solid #27ae60;">
																			           <h5 class="modal-title" id="exampleModalToggleLabel">의뢰서</h5>
																			           <span class="mod-close" data-dismiss="modal" aria-hidden="true" style="border-radius: 50%;"><i class="ti-close"></i></span>
																			         </div>
																			         <div class="modal-body">
																			            <c:import url="/pd/formConfirm">
																			               <c:param name="userId" value="${map.B_USER_ID }"></c:param>
																			               <c:param name="pdNo" value="${map.PD_NO }"></c:param>
																			            </c:import>
																			         </div>
																			         <div class="modal-footer d-flex justify-content-center">
																			            <button type="button" class="btn theme-bg rounded" data-dismiss="modal">확인</button>
																			         </div>
																			       </div>
																			     </div>
																			   </div>
																		</div>
																	</td>
																	<td class="center"> <!-- 결제 -->
																		<div class="_leads_action">
																			<c:if test="${map.PAY_FLAG == 'Y'}">
																				<a href="#" onclick="requestPay${status.index }()"><i class="fas fa-credit-card"></i></a>
																			</c:if>
																			<c:if test="${map.PAY_FLAG == 'P'}">
																				<a href="<c:url value='/contactUs/contactUs' />" style="border: 0;">환불 문의</a>
																			</c:if>
																			<input type="hidden" name="formTitle" readonly="readonly" value="${map.PAY_FLAG }">
																		</div>
																	</td>
																	
																	<!-- 거래완료버튼 -->
																	<td class="center"> 
																		<div class="_leads_action">
																			<c:if test="${map.PAY_FLAG == 'P'}">
																				<a href="<c:url value='/mypage/transactionDone?formNo=${map.FORM_NO}'/>" id="applicationDone"><i class="fas fa-check"></i></a>
																			</c:if>
																			<input type="hidden" name="formTitle" readonly="readonly" value="${map.PAY_FLAG }">
																		</div>
																	</td>
																</tr>
															</c:forEach>
														</c:otherwise>
													</c:choose>
														
														
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								<!-- row -->
								
								<div class="col-lg-12 col-md-12 col-sm-12">
										<ul class="pagination p-center">
											<c:if test="${pagingInfo.firstPage>1}">
												<li class="page-item"><a class="page-link" href="#"
													aria-label="Previous" onclick="pageProc(${pagingInfo.firstPage-1})">
														<span class="ti-arrow-left"></span> <span class="sr-only">Previous</span>
												</a></li>
											</c:if>
											<c:forEach var="i" begin="${pagingInfo.firstPage}"
												end="${pagingInfo.lastPage}">
												<c:if test="${i==pagingInfo.currentPage}">
													<li class="page-item active"><a class="page-link" href="#">${i}
													</a></li>
												</c:if>
												<c:if test="${i!=pagingInfo.currentPage}">
													<li class="page-item"><a class="page-link" href="#" 
													onclick="pageProc(${i })">${i} </a></li>
												</c:if>
											</c:forEach>
											<c:if test="${pagingInfo.lastPage < pagingInfo.totalPage}">
												<li class="page-item"><a class="page-link" href="#"
													aria-label="Next" onclick="pageProc(${pagingInfo.lastPage+1})">
														<span class="ti-arrow-right"></span> <span class="sr-only">Next</span>
												</a></li>
											</c:if>
										</ul>
									</div>
							
							<form action="<c:url value='/mypage/transaction' />" method="post" name="frmPage">
								<input type="hidden" name="searchKeyword" value="${param.searchKeyword }">
								<input type="hidden" name="searchCondition" value="${param.searchCondition }">
								<input type="hidden" name="currentPage" >	
							</form>
							
									
									
								
							</div>
								
						</div>
						
					</div>
				</div>
			</section>
			<!-- ============================ User Dashboard End ================================== -->
			
			<!-- ============================ Call To Action ================================== -->

			
			
			
<%@ include file="../inc/bottom.jsp" %>