<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>

<link rel="stylesheet" type="text/css" 	href="<c:url value='/css/board.css'/>" />
<title>wonder - 자유게시판 글쓰기</title>
<script type="text/javascript">
/* 	테스트
	
	var userId="<c:out value='${userId}'/>";
*/
	var userId="<c:out value='${sessionScope.userId}'/>";
	var nickname="<c:out value='${sessionScope.nickname}'/>";
	var adminId="<c:out value='${sessionScope.adminId}'/>"; 
	
	//alert(nickname);
	$(function(){
		if(userId=="" && adminId==""){
			alert("로그인이 필요합니다");
			//location.href= '<c:url value="/" />';
			$('#topLogin').get(0).click();
			return false;
		}else if(adminId!=""  && userId==""){
			alert("공지 작성이 가능합니다");
		}else if(adminId==""  && userId!=""){
			alert("작성글은 자유게시판에 등록됩니다");
		}

	});
	
	//유효성검사
	function validateForm(){

		var boardTitle=$(event.target).find('#boardTitle').val();
		var boardContent=myEditor.getData();
		var pwd=$(event.target).find('#pwd').val();
		//alert(boardTitle);
		//alert(boardContent);
		//alert(pwd);
		
		if($.trim(boardTitle).length<1){
			alert("제목을 입력하세요.");
			$(this).focus();
			return false;
		}
		
		if($.trim(boardContent).length< 1){
			alert("내용을 입력하세요");
			$(boardContent).focus();
			return false;
		}
		

	}
</script>

<!--테스트용  -->
<script type="text/javascript">

/*	ajax

$(function(){
	$('#pwd').keyup(function (){
		alert("");
		$(this).focus();
		if($.trim(pwd).length>4){
			alert("비밀번호는 최대 4자리만 입력가능합니다.");
			$(this).focus();
			return false;
		}
	
	});
});
	
*/
</script>
<section>
	<div class="container">
		<div class="row">
			<form name="frmWrite" method="post" enctype="multipart/form-data"
				action="<c:url value='/board/write'/>" onsubmit="return validateForm();">
<!-- 
empty sessionScope.userId && empty sessionScope.adminId
	로그인필요(기본 회원 로그인으로 전제)
empty sessionScope.userId && !empty sessionScope.adminId
	관리자=>공지작성
!empty sessionScope.userId && empty sessionScope.adminId
	특별한 alert 없음
!empty sessionScope.userId && !empty sessionScope.adminId
	있을 수 없음
 -->
				<fieldset>
					<!-- Submit Form -->
					<div class="col-lg-12 col-md-12">
						<div class="submit-page p-0">
							<!-- Basic Information -->
							<div class="frm_submit_block">
								<h2>글쓰기</h2>
								<hr>
								<div class="frm_submit_wrap writeEdit">
									<div class="form-row">
									<!--제목-->
										<div class="form-group col-md-7" id="">
											<label for="boardTitle">제목</label> 
											<input type="text" class="form-control" name="boardTitle" id="boardTitle" placeholder="(필수입력)">
										</div><div class="form-group col-md-4 box"></div>
									<!-- 작성자 -->
										<div class="form-group col-md-4" id="">
											<label for="nickname">작성자</label>
									<c:choose>
									<c:when test="${!empty sessionScope.userId}">
									<!--  
											<input type="text" name="nickname" value="회원1" class="form-control" readonly="readonly" id="nickname">
									-->
											<input type="text" name="nickname" value="${sessionScope.nickname }" class="form-control" readonly="readonly" id="nickname">
											<input type="hidden" name="cateType" value="B" />
											<input type="hidden" name="userId" value="${sessionScope.userId }">
											<input type="hidden" name="adminId" value="N" />
									</c:when>
									<c:when test="${!empty sessionScope.adminId}">
											<input type="text" name="nickname" value="관리자" class="form-control" readonly="readonly" id="nickname">
											<input type="hidden" name="cateType" value="N" />
											<input type="hidden" name="userId" value="N" />
											<input type="hidden" name="adminId" value="${sessionScope.adminId }">
									</c:when>
									<c:otherwise>
										<input type="text" name="nickname" value="로그인하세요" class="form-control" readonly="readonly" id="nickname">
										<input type="hidden" name="cateType" value="B" />
										<input type="hidden" name="userId" value="${sessionScope.userId }" />
										<input type="hidden" name="adminId" value="${sessionScope.adminId }">
									</c:otherwise>
									</c:choose>

										</div><div class="form-group col-md-7 box"></div>
									<!-- 비밀번호 -->
									<c:if test="${empty sessionScope.adminId}">
										<div class="form-group col-md-2" id="">
											<label for="pwd">비밀번호</label>
											<input type="password" name="pwd" id="pwd" class="form-control" placeholder="(최대 4자리)" maxlength="4"/>
										</div>
										<div class="form-group col-md-7 box"></div>
									</c:if>
									<!-- 첨부파일  -->	
										<div class="form-group col-md-5">
											<label for="upfile">첨부파일</label>
											<input type="file" id="upfile" name="upfile" class="form-control" />
										</div>
										<div class="form-group col-md-3" id="byte">
											<span>(최대 2MB)</span>
										</div>
									</div>
									<!--내용 -->
									<div class="frm_submit_block">
										<div class="frm_submit_wrap">
											<div class="form-row">
												<div class="form-group col-md-12" id="content">
													<label for="boardContent">내용</label>
													<textarea class="form-control ht-120" name="boardContent" id="boardContent" placeholder="(필수입력)"></textarea>
												<!--ckEditor  -->
													<script
														src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
													<script
														src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
													<script type="text/javascript"
														src="<c:url value='/js/board.js'/>"></script>
												</div>
											</div>
										</div>
									</div>

									<div class="form-group" id="submitlist">
										<div class="col-lg-12 col-md-12">
											<button class="btn btn-theme" type="submit">
												<i class="fas fa-edit"></i> 등록완료
											</button>
											<button class="btn btn-theme" type="button" id="btlist"
												onclick="location.href='<c:url value='/board/list'/>'">
												<span class="ti-view-list"></span> 목록
											</button>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</section>


<%@ include file="../inc/bottom.jsp"%>
