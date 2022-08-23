<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@ include file="../inc/top.jsp"%>

<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script> 
 <style>
  .ck-editor__editable { height: 300px; }
</style>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/qna.css'/>" />

<title>wonder - QNA 게시판 수정하기</title>
<script type="text/javascript"
	src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>

<!-- ============================ Page Title Start================================== -->

<!-- ============================ Page Title End ================================== -->

<!-- ============================ Submit Property Start ================================== -->
<section>
	<div class="container">
		<div class="row">
			<form name="frmWrite" method="post" enctype="multipart/form-data"
				action="<c:url value='/qna/qnaEdit'/>">
<input type="hidden" name="qnaNo" value="${param.qnaNo }" />
<fieldset>
	<!-- Submit Form -->
<div class="col-lg-12 col-md-12">

	<div class="submit-page p-0">

		<!-- Basic Information -->
<div class="frm_submit_block">
	<h2>게시글 수정하기</h2>
	<hr>
	<div class="frm_submit_wrap">
		<div class="form-row">

			<!--div class="form-group col-md-12"-->
		<div class="form-group col-md-7" id="">
			<label for="boardTitle">제목</label> <input type="text"
				class="form-control" name="qnaTitle" id="qnaTitle"
				value="${vo.qnaTitle}" />
		</div>
		<div class="form-group col-md-4 box"></div>

		<div class="form-group col-md-4" id="">
			<label for="userId">작성자</label> <input type="text"
				class="form-control" readonly="readonly" name="userId"
				id="userId" value="${vo.userId}">
		</div>
		<div class="form-group col-md-7 box"></div>

	 <div class="form-group col-md-4" id="">
			<!-- <label for="pwd">비밀번호</label> -->
			<input type="hidden" maxlength="4" class="form-control" id="pwd" name="pwd" value="">
		</div>
		
		<div class="form-group col-md-4"></div>

		<div class="form-group col-md-5">
			<label for="upfile">첨부파일</label> <input type="file"
				id="upfile" name="upfile" class="form-control" />
			<c:if test="${!empty vo.fileName}">
				<span style="color: green"> 새로운 파일을 첨부하는 경우 기존 파일 <img
					src="<c:url value='/img/file.gif'/>" />
					${vo.originalFileName}은(는) 삭제됩니다.
				</span>
			</c:if>
		</div>
		<div class="form-group col-md-3" id="byte">
			<span>(최대 2MB)</span>
		</div>
	</div>

	<!-- Detailed Information -->
	<div class="frm_submit_block">
		<div class="frm_submit_wrap">
			<div class="form-row">
				<div class="form-group col-md-12" id="content">
					<label for="qnaContent">내용</label>
					<textarea class="form-control ht-120" rows="50" cols="50" id="qnaContent" name="qnaContent">
					${vo.qnaContent}
					</textarea>
					<script>
						ClassicEditor.create( document.querySelector( '#qnaContent' ), {
						language: "ko"
					});
	 		</script>
				</div>
			</div>
		</div>
	</div>

	<div class="form-group" id="submitlist">
		<div class="col-lg-12 col-md-12">
			<button class="btn btn-theme" type="submit" id="btEdit"
				onclick="">
				<i class="fa fa-pen-nib"></i> 수정
			</button>
			<button class="btn btn-theme" type="button" id="btlist"
				onclick="location.href='<c:url value='/qna/qnaList'/>'">
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
<!-- ============================ Submit Property End ================================== -->


<%@ include file="../inc/bottom.jsp"%>
