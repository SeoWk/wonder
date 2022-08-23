<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<!--  
	<해결과제>
	
	-게시글 암호화
	-옵션없는 전체검색? 앞뒤 공백제거
-->
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/board.css'/>" />
<script type="text/javascript">
	function pageProc(currentPage) {
		var totalPage = 	"<c:out value='${pagingInfo.totalPage}'/>";
		if(currentPage<1){
			currentPage=1;
		}
	
		if(currentPage>totalPage){
			currentPage=totalPage;
		}
	
		$('input[name=currentPage]').val(currentPage);
		$('form[name=frmPage]').submit();
	}
	
	
	$(function (){
		var selectedText = $('#searchCondition option:selected').text();
			if(selectedText=="전체"){
					$('#searchKeyword').attr("readonly","readonly");
					$('#searchKeyword').removeAttr("placeholder");
			}		
		//<input type="text" class="form-control" name="searchKeyword" readonly value="" id="searchKeyword">
	});
	

	

	
	
</script>
<!--  테스트  -->
<script type="text/javascript">
//검색바 설정
$(function (){
	$('#searchCondition').change(function() {
		var selectedText = $('#searchCondition option:selected').text();
		
		$.ajax({
			success:function(){
				if(selectedText!="전체"){
					$('#searchKeyword').attr("placeholder","검색어 입력");
					$('#searchKeyword').removeAttr("readonly");
				}else{
					$('#searchKeyword').val("");
					$('#btnSearch').get(0).click();
				} 	
			},
			error:function(xhr, status, error){
				alert("code = "+ xhr.status + " message = " + xhr.responseText + " error = " + error);
			}
		});
	});
});
</script>
<title>wonder - 자유게시판</title>

<section class="gray pt-5 pb-5">
	<div class="property_block_title">
		<h2>&nbsp;자유게시판</h2>
	</div>
	<hr>
	<c:if test="${!empty param.searchKeyword }">
		<div class="tit" id="srchTitBar">
			<p>
				"${param.searchKeyword}" 검색 결과 총<strong class="tit_cnt">${pagingInfo.totalRecord}</strong>
				건 검색되었습니다.
			</p>
		</div>
	</c:if>

	<form action="<c:url value='/board/list'/>" method="post"
		name="frmPage">
		<input type="hidden" name="searchKeyword"
			value="${param.searchKeyword }"> <input type="hidden"
			name="searchCondition" value="${param.searchCondition }">
		<input type="hidden" name="currentPage">
	</form>

	<div class="container-fluid">
		<div class="list row">
			<div class="col-lg-9 col-md-8 col-sm-12">
				<div class="dashboard-body">
					<div class="list row">
						<div class="col-lg-12 col-md-12">
							<div class="dashboard_property">
								<div class="table-responsive margin-o">
									<table class="table margin-o">
										<colgroup>
											<col style="width: 10%;" />
											<col style="width: 50%;" />
											<col style="width: 15%;" />
											<col style="width: 15%;" />
											<col style="width: 10%;" />
										</colgroup>
										<thead class="thead-dark">
											<tr>
												<th scope="col" class="m2_hide">번호</th>
												<th scope="col">제목</th>
												<th scope="col" class="m2_hide">작성자</th>
												<th scope="col" class="m2_hide">작성일</th>
												<th scope="col">조회수</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${empty list }">
												<tr>
													<td colspan="5" class="">게시글이 존재하지 않습니다.</td>
												</tr>
											</c:if>
											<c:if test="${!empty list }">
												<c:forEach var="vo" items="${list }">
													<tr>
														<!--번호  -->
														<td class="m2_hide">
															<div class="prt_leads">
																<span class="bold">${vo.boardNo}</span>
															</div>
														</td>
														<!--제목  -->
														<td>
															<div class="dash_prt_wrap">
																<div class="dash_prt_caption">
																	<div class="prt_dash_rate">
																		<!--공지인 경우  -->
																		<c:if test="${vo.cateType=='N'}">
																			<a class="notice"
																				href="<c:url value='/board/countUpdate?boardNo=${vo.boardNo}'/>">
																				<span class="notice">공지</span> <c:if
																					test="${fn: length(vo.boardTitle)>20}">
																					<span class="boardTitle">${fn:substring(vo.boardTitle,0,20) }...</span>
																				</c:if> <c:if test="${fn: length(vo.boardTitle)<=20}">
																					<span class="boardTitle">${vo.boardTitle }</span>
																				</c:if>
																			</a>
																		</c:if>
																		<c:if test="${vo.cateType!='N'}">
																			<a
																				href="<c:url value='/board/countUpdate?boardNo=${vo.boardNo}'/>">
																				<c:if test="${fn: length(vo.boardTitle)>20}">
																					<span class="boardTitle">${fn:substring(vo.boardTitle,0,20) }...</span>
																				</c:if> <c:if test="${fn: length(vo.boardTitle)<=20}">
																					<span class="boardTitle">${vo.boardTitle }</span>
																				</c:if> <span class="totalComment">(${vo.totalComment})</span>
																			</a>
																		</c:if>
																		<c:if test="${!empty vo.fileName }">
																			<em class="ic ic_list_file"></em>
																		</c:if>
																		<c:if test="${vo.dateTerm<24 }">
																			<span class="new">new</span>
																		</c:if>
																	</div>
																</div>
															</div>
														</td>

														<td class="m2_hide">
															<div class="_leads_view">
																<h5 class="up">${vo.nickname }</h5>
															</div>
														</td>

														<td class="m2_hide">
															<div class="_leads_posted">
																<fmt:formatDate value="${vo.regdate}"
																	pattern="yyyy-MM-dd" />
															</div>
														</td>

														<td>
															<div class="_leads_view_title">
																<span>${vo.readCount }</span>
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

						<div class="search col-lg-12 col-md-12">
							<div class="list _prt_filt_dash">
								<!-- 검색바  -->
								<div class="divSearch">
									<div class="divSearch_bar">
										<form name="frmSearch" method="post"
											action='<c:url value="/board/list"/>'>
											<div class="_prt_filt_dash_flex">
												<div class="foot-news-last">
													<div class="form-group col-md-4">
														<select name="searchCondition" class="form-control"
															id="searchCondition">
															<option value=""
																<c:if test="${param.searchCondition=='' }">
											            		selected="selected"
											            	</c:if>>전체</option>
															<option value="board_title"
																<c:if test="${param.searchCondition=='board_title' }">
											            		selected="selected"
											            	</c:if>>제목</option>
															<option value="board_content"
																<c:if test="${param.searchCondition=='board_content' }">
											            		selected="selected"
											            	</c:if>>내용</option>
															<option value="nickname"
																<c:if test="${param.searchCondition=='nickname' }">
											            		selected="selected"
											            	</c:if>>작성자</option>
														</select>
													</div>
													<div class="input-group">
														<input type="text" class="form-control"
															name="searchKeyword" placeholder="검색어 입력"
															value="${param.searchKeyword}" id="searchKeyword">

														<div class="input-group-append">
															<button type="submit" title="검색" id="btnSearch"
																class="btn input-group-text theme-bg b-0 text-light">
																<i class="fas fa-search"></i>
															</button>
														</div>
													</div>
												</div>

											</div>
										</form>
									</div>
									<button class="btn btn-theme" type="button" id=""
										onclick="location.href='<c:url value='write'/>'">
										<i class="fas fa-edit"></i> 글쓰기
									</button>
								</div>
							</div>
							<!--페이지이동  -->
							<div class="col-lg-12 col-md-12 col-sm-12">
								<ul class="pagination p-center">
									<!-- 이전 블럭으로 -->
									<c:if test="${pagingInfo.firstPage>=1 }">
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Previous"
											onclick="pageProc(${pagingInfo.firstPage-1})"> <span
												class="">◀</span>
										</a></li>
									</c:if>
									<!-- 페이지 번호-->
									<c:forEach var="i" begin="${pagingInfo.firstPage }"
										end="${pagingInfo.lastPage }">
										<c:if test="${i==pagingInfo.currentPage }">
											<li class="page-item active"><a class="page-link"
												href="#">${i } </a></li>
										</c:if>
										<c:if test="${i!=pagingInfo.currentPage }">
											<li class="page-item"><a class="page-link" href="#"
												onclick="pageProc(${i })">${i } </a></li>
										</c:if>
									</c:forEach>
									<!-- 다음 블럭으로 이동 -->
									<c:if test="${pagingInfo.lastPage <= pagingInfo.totalPage }">
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Next"
											onclick="pageProc(${pagingInfo.lastPage+1})"> <span
												class="">▶</span>
										</a></li>
									</c:if>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>


<%@ include file="../inc/bottom.jsp"%>
