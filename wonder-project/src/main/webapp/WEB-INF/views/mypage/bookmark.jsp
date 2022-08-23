<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/mypage/incSide" />
<%-- <%@ include file="incSide.jsp" %> --%>
<script type="text/javascript">
	$(function(){
		
		$('.action').each(function(item,idx){
			$(this).find('.delete').click(function(){
				if(!confirm('찜 목록에서 제거하시겠습니까?')){
					return false;
				}else{
					var deleteNo = $(this).next().val();
					
					location.href="<c:url value='/mypage/bookmarkDel?no="+deleteNo+"' />"
					
				}//컨펌
			}); //삭제버튼 클릭 이벤트
		});
	});
	
	function pageProc(curPage){
		$('input[name=currentPage]').val(curPage);
		$('form[name=frmPage]').submit();
	}
</script>
<input type="hidden" id="pageCheck" value="bookmark">


<link href="${pageContext.request.contextPath}/css/mypage.css" rel="stylesheet">
						<div class="col-lg-9 col-md-8 col-sm-12">
							<div class="dashboard-body">
							
								<div class="dashboard-wraper">
								
									<!-- Bookmark Property -->
									<div class="frm_submit_block">	
										<h4>찜해둔 상품 목록</h4>
									</div>
									<table class="property-table-wrap responsive-table bkmark">
										<tbody>
											<!-- Item #1 -->
											<c:choose>
												<c:when test="${fn:length(list) == 0 }" >
													 <td colspan="8">
													 	<br>
													 	<h5 class="noneList">찜 목록이 비어있습니다</h5>
													 </td>
													</c:when>
													<c:otherwise>
														<c:forEach var="map" items="${list }">
														<tr>
															<td class="dashboard_propert_wrapper">
																<img src="<c:url value='/img/pdupload/${map.FILE_NAME }' />" alt="찜목록 사진" class="bookmarkImg">
																<div class="title">
																	<h4><a href="<c:url value='/pd/pdDetail?pdNo=${map.PD_NO}'/>">${map.PD_TITLE }</a></h4>
																	<span>${map.INTRODUCTION }</span>
																	
																	<span class="table-property-price">
																		<fmt:formatNumber value="${map.PD_PRICE }" pattern="#,###" />
																		 원 부터~</span>
																</div>
															</td>
															<td class="action">
																<a class="delete pointer"><i class="ti-close"></i> 찜 취소</a>
																<input type="hidden" value="${map.PD_NO }" class="pdNo">
															</td>
														</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
<%-- 



											<!-- Item #2 -->
											<tr>
												<td class="dashboard_propert_wrapper">
													<img src="<c:url value='/img/mypage/bookmark/ex02.jpg' />" alt="찜목록 사진">
													<div class="title">
														<h4><a href="#">메이크홈즈</a></h4>
														<span>SEO최적화 거품없는 가격으로 반응형 홈페이지 제작해 드립니다.</span>
														<span class="table-property-price">550,000 원</span>
													</div>
												</td>
												<td class="action">
													<a href="#" class="delete"><i class="ti-close"></i> Delete</a>
												</td>
											</tr>

											<!-- Item #3 -->
											<tr>
												<td class="dashboard_propert_wrapper">
													<img src="<c:url value='/img/mypage/bookmark/ex03.png' />" alt="찜목록 사진">
													<div class="title">
														<h4><a href="#">빌러블</a></h4>
														<span>디자인 파일을 주시면 퍼블리싱해 드립니다. </span>
														<span class="table-property-price">55,000 원</span>
													</div>
												</td>
												<td class="action">
													<a href="#" class="delete"><i class="ti-close"></i> Delete</a>
												</td>
											</tr>

											<!-- Item #4 -->
											<tr>
												<td class="dashboard_propert_wrapper">
													<img src="<c:url value='/img/mypage/bookmark/ex04.jpg' />" alt="찜목록 사진">
													<div class="title">
														<h4><a href="#">따따따디자인</a></h4>
														<span> 반응형 홈페이지제작 및 기업 맞춤형 홈페이지 제작해 드립니다. </span>
														<span class="table-property-price">550,000 원</span>
													</div>
												</td>
												<td class="action">
													<a href="#" class="delete"><i class="ti-close"></i> Delete</a>
												</td>
											</tr>
 --%>
										</tbody>
									</table>
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
									
									<%-- 
									<c:forEach var="i" begin="${pagingInfo.firstPage }" end="${pagingInfo.lastPage }">		
									<c:if test="${i==pagingInfo.currentPage }">
										<span style="color: blue;font-weight: bold;font-size: 1em">
											${i }</span>
									</c:if>
									<c:if test="${i!=pagingInfo.currentPage }">			
										<a href="#" onclick="pageProc(${i})">	
											[${i}]
										</a>
									</c:if>		
									</c:forEach>
									 --%>
								</div>
								
								<div class="row">
									<div class="col-md-12 col-lg-12 mt-4">
										<footer class="text-center">
											<p class="mb-0">© 2019 Rikada. Designd By <a href="https://themezhub.com">Themez Hub</a> All Rights Reserved</p>
										</footer>
									</div>
								</div>
								<!-- row -->
							
							</div>
						</div>
						
					</div>
				</div>
			</section>
			<!-- ============================ User Dashboard End ================================== -->
<form action="<c:url value='/mypage/bookmark'/>" 
	method="post" name="frmPage">
	<input type="hidden" name="searchKeyword" value="${param.searchKeyword }">
	<input type="hidden" name="searchCondition" value="${param.searchCondition }">
	<input type="hidden" name="currentPage" >	
</form>

<%@ include file="../inc/bottom.jsp" %>