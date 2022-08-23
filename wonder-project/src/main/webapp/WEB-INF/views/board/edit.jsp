<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@ include file="../inc/top.jsp"%>

<link rel="stylesheet" type="text/css"  href="<c:url value='/css/board.css'/>" />
<title>wonder - 자유게시판 수정하기</title>
<script type="text/javascript">

</script>
<!--테스트용  -->
<script type="text/javascript">
/* 	테스트
	var userId="<c:out value='${userId}'/>";
*/
	var userId="<c:out value='${sessionScope.userId}'/>";
	var adminId="<c:out value='${sessionScope.adminId}'/>"; 

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
<section>
	<div class="container">
		<div class="row">
			<form name="frmEdit" method="post" enctype="multipart/form-data"
				action="<c:url value='/board/edit'/>">
				<input type="hidden" name="boardNo" value="${param.boardNo}" />
			
				<fieldset>
					<div class="col-lg-12 col-md-12">
						<div class="submit-page p-0">
							<div class="frm_submit_block">
								<h2>게시글 수정</h2>
								<hr>
								<div class="frm_submit_wrap writeEdit">
									<div class="form-row">
									<!--제목  -->
										<div class="form-group col-md-7" id="">
											<label for="boardTitle">제목</label>
											<input type="text" class="form-control" name="boardTitle" id="boardTitle" value="${vo.boardTitle}" />
										</div><div class="form-group col-md-4 box"></div>
									<!--작성자  -->
										<div class="form-group col-md-4" id="">
											<label for="nickname">작성자</label>
											<input type="text" name="nickname" id="nickname" value="${vo.nickname}" class="form-control" readonly="readonly">
										</div>
										<div class="form-group col-md-7 box"></div>
									<!--비밀번호  -->	
									<c:if test="${!empty sessionScope.userId}">
										<div class="form-group col-md-4" id="">
											<label for="pwd">비밀번호확인</label>
											<input type="password" name="pwd" maxlength="4" class="form-control" id="pwd">
										</div>
										<div class="form-group col-md-7 box"></div>
									</c:if>
									<!--첨부파일  -->	
									   <input type="hidden" name="oldFileName" value="${vo.fileName}"/>
										<div class="form-group col-md-6">
											<label for="upfile">첨부파일</label>
											<input type="file" id="upfile" name="upfile" class="form-control" value="" />
											<c:if test="${!empty vo.fileName}">
												<span class="red" style="font-size: 14px"> 
												새로운 파일을 첨부하는 경우,&nbsp;&nbsp;기존 파일&nbsp;
												'&nbsp;${vo.originalFileName}&nbsp;'은(는) 삭제됩니다.
												</span>
											</c:if>
										</div>
										<div class="form-group col-md-3" id="byte">
											<span>(최대 2MB)</span>
										</div>
									</div>
									<!-- 내용-->
									<div class="frm_submit_block">
										<div class="frm_submit_wrap">
											<div class="form-row">
												<div class="form-group col-md-12" id="content">
													<label for="boardContent">내용</label>
													<textarea class="form-control ht-120" rows="50" cols="50"
														id="boardContent" name="boardContent">${vo.boardContent}</textarea>
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
											<button class="btn btn-theme" type="submit" id="btedit">
												<i class="fa fa-pen-nib"></i> 수정완료
											</button>
											<button class="btn btn-theme" type="button" id="btlist"
												onclick="location.href='<c:url value='list'/>'">
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
