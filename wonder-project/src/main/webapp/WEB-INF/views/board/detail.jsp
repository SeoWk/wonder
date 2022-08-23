<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<!--  
	<해결과제>
	
	-내용 출력 제대로하기
	
	-("관리자에 의해 삭제된 게시물입니다")
	-대댓글 ~개 댓글 보이기 구현
	-수정유무 editType 추가 replyRegdate는 그대로 =>("--에 수정됨")
	-공유(url복사만 구현된 상태)
-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/board.css'/>" />
<script type="text/javascript">
	
$(function(){
	
	/* 게시글 삭제 */
	$('#btdelete').click(function(){
		var popupX = (document.body.offsetWidth/2) - (772 / 2);
		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

		var popupY= (window.screen.height/2) - (335 / 2);
		// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

		window.open("<c:url value='delete?boardNo=${param.boardNo}&fileName=${vo.fileName }'/>",
				"", 'status=no, width=772, height=335, left='+ popupX + ', top='+ popupY);
		event.preventDefault();
	});
	
	
	//대댓글 등록
	$(".reReplyForm").hide();
	
	$(".btnRereply").click(function(){
		if($(this).text()=="답글쓰기"){
			$(this).text("작성취소");
		}else{
			$(this).text("답글쓰기");
		}
		
		$(this).closest(".comment-details").find(".reReplyForm").toggle();
		//var groupNo = $(this).attr("id");
		//$(this).closest(".comment-details").find(".reReplyForm").attr("id",toggle_id);
	});
	
	
});
</script>
<script type="text/javascript">
//댓글삭제(완료)
function replyDelete(replyNo){
	var c = confirm("해당 댓글을 삭제하시겠습니까?");
	if(c==true){
		$.ajax({
			url:'<c:url value="/board/detail/replyDelete"/>',
			type:'GET',
			data:"replyNo="+replyNo,
			success:function(res){
				alert("해당 댓글이 삭제되었습니다");
				location.reload();
			},
			error:function(xhr, status, error){
				alert("code = "+ xhr.status + " message = " + xhr.responseText + " error = " + error);
			}
		});
	}
}
 	

//댓글 입력, 수정 유효성검사
function validateForm(){
	//var frm = $(event.target).find('textarea').closest('form').attr('name');
	//alert(frm);
	var taVal=$(event.target).find('textarea').val();
	var userId="<c:out value='${sessionScope.userId}'/>";
	//var dbUserId="<c:out value='${replyVo.userId}'/>";
	var cateType= "<c:out value='${vo.cateType}'/>";
	
	
	if((userId=="" || userId=='N') && cateType=='B'){
		alert("일반회원만 이용가능합니다. 로그인하세요.");
		//location.href= '<c:url value="/"/>';
		$('#topLogin').get(0).click();
		return false;
	}
	/*
	if(userId=="" && cateType!='N'){

	}
	*/
	
	if(cateType=='N'){
		alert("공지사항 댓글 입력불가!");
		return false;
	}

	if(cateType!='N' && (userId!="" || userId!='N') && $.trim(taVal).length<1){
		alert("댓글 내용을 입력하세요.");
		$(taVal).focus();
		return false;
	}

}


// 공유 - url 복사
function clip(){
    var url = window.document.location.href; //현재 주소값
    var textarea = document.createElement("textarea");  
    //url 변수 생성 후, textarea라는 변수에 textarea의 요소를 생성
    
    document.body.appendChild(textarea); //</body> 바로 위에 textarea를 추가(임시 공간)
    textarea.value = url;  // textarea 값에 url를 대입
    textarea.select();  //textarea를 선택
    document.execCommand("copy"); // 복사
    document.body.removeChild(textarea); //복사 후 textarea 요소를 없애줌
    
    alert("URL이 복사되었습니다.")  // 알림창
}



//글쓰기
function toWrite(){
	var userId="<c:out value='${sessionScope.userId}'/>";
	var adminId="<c:out value='${sessionScope.adminId}'/>";

	if(userId!="" || adminId!=""){
		location.href='<c:url value='/board/write'/>';
	}else{
		alert("로그인이 필요합니다.");
		//location.href= '<c:url value="/"/>';
		$('#topLogin').get(0).click();
		return false;
	}
}

</script>

<!-- 테스트용 js -->
<script type="text/javascript">
//댓글 수정폼 열기
function replyEditView(replyNo){
	var userId = '<c:out value="${sessionScope.userId}" />';
	if(userId!=""){
		//alert(userId);
		$.ajax({
			url:'<c:url value="/board/detail/replyEditView"/>',
			type:'GET',
			data:"replyNo="+replyNo,
			//dataType:'json',
			success:function(res){
				//alert(res.replyContent);
				var editView1 = "";
				var editView2 = "";
				/*댓글 수정취소 */
				editView1 +='<div class="replyButtons" id="'+replyNo+'replyButtons">';
				editView1 +=	'<button class="btnReplyEditOpen"';
				editView1 +=		'onclick="getReplylist('+replyNo+')">수정취소</button>';
				editView1 +='</div>';
				/*등록된 댓글 내용 */
				editView2 +='<div class="comment-reply" id="'+replyNo+'comment-reply">';
				editView2 +=	'<form name="frmReplyEdit" method="post" action="<c:url value="/board/detail/replyEdit"/>" onsubmit="validateForm()" ';
				editView2 +=		'onsubmit="return validateForm();">';
				editView2 +=			'<input type="hidden" name="replyNo"  value="'+replyNo+'" />';
				editView2 +=			'<input type="hidden" name="boardNo" value="${param.boardNo }" />';
				editView2 +=			'<div class="boardReply" id="'+replyNo+'boardReply" style="margin-top:10px;">';
				editView2 += 				'<textarea name="replyContent" class="comments form-control" id="replyContent" placeholder="댓글을 입력하세요">';
				editView2 += 					res.replyContent;
				editView2 += 				'</textarea>';
				editView2 +=			'</div>';
				editView2 +=			'<div class="ReplyEditSubmit">';
				editView2 += 				'<button class="btReplyEdit btn btn-theme" type="submit" id="comment_edit" ';
				editView2 += 			'>수정완료</button>';
				editView2 +=		'</div>';
				editView2 +=	'</form>';
				editView2 +='</div>';
				
				$('#'+replyNo+'replyButtons').replaceWith(editView1);
				$('#'+replyNo+'comment-reply').replaceWith(editView2);
			},
			
			error:function(xhr, status, error){
				alert("code = "+ xhr.status + " message = " + xhr.responseText + " error = " + error);
			}
		});
	}
}

//댓글 수정취소
function getReplylist(replyNo){
	//var userId = '<c:out value="${sessionScope.userId}" />';
	//alert(userId);
	
	$.ajax({
		url:'<c:url value="/board/detail/getReplylist"/>',
		type:'GET',
		data:"replyNo="+replyNo,
		success:function(res){
			//alert(res.replyContent);
			var replyList1 = "";
			var replyList2 = "";
			replyList1 +='<div class="replyButtons" id="'+replyNo+'replyButtons">';
			replyList1 +=	'<button class="btnReplyEditOpen"';
			replyList1 +=		' onclick="replyEditView('+replyNo+')">수정</button>';
			replyList1 +=	'<button class="btnReplyDelete"';
			replyList1 +=		' onclick="replyDelete('+replyNo+')">삭제</button>';
			replyList1 +='</div>';
			
			replyList2 +='<div class="comment-reply" id="'+replyNo+'comment-reply">';	
			replyList2 +=	'<div class="boardReply" id="'+replyNo+'boardReply">';
			replyList2 +=		'<p class="comments"><br>';
			replyList2 +=			'<span id="'+replyNo+'replyContent">'+res.replyContent+'</span>';
										/*24시간 이내 작성 댓글 */
			replyList2 +=			'<c:if test="'+res.dateTerm+'<24">';
			replyList2 +=				'&nbsp;<span class="new">new</span>';
			replyList2 +=			'</c:if><br>';
			replyList2 +=		'</p>';
										/*답글쓰기(대댓글은 불가)  */
			replyList2 +=		'<c:if test="'+res.step+'==0">';
			replyList2 +=			'<button class="btnRereply">답글쓰기</button>';
			replyList2 +=		'</c:if>';
			replyList2 +=	'</div>';
			replyList2 +='</div>';
			/*등록된 댓글 끝*/
			
			$('#'+replyNo+'replyButtons').replaceWith(replyList1);
			$('#'+replyNo+'comment-reply').replaceWith(replyList2);

		},
		error:function(xhr, status, error){
			alert("code = "+ xhr.status + " message = " + xhr.responseText + " error = " + error);
		}
	});
}

</script>


<title>wonder - 자유게시판 상세보기</title>

<section class="gray">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-8 col-md-12">
				<div class="property_block_wrap">
					<div class="">
						<!-- 제목 -->
						<div class="title">
							<h3 class="property_block_title black">
								<a href="<c:url value='list'/>">자유게시판<span
									class="submenu-indicator"></span></a>
							</h3>
							<hr>
							<h4 class="black">
								<c:choose>
									<c:when test="${vo.cateType=='N'}">
										<span class="notice">공지</span>
									</c:when>
									<c:otherwise>
										<span class="normal">일반</span>
									</c:otherwise>
								</c:choose>
								${vo.boardTitle}
							</h4>
						</div>
						<div class="register_info right">
						<!-- 작성자 -->
							<span class=""><i class="ti-user theme-cl">
								${vo.nickname}</i></span> |
						<!-- 작성일 -->	
							<span class="black">
								<em class="ic ic_regdate"></em>
								<fmt:formatDate value="${vo.regdate}"
									pattern="yyyy-MM-dd HH:mm:ss" />
							</span> | 
						<!--  조회수-->
							<span class="color_gray">
								<em class="ic ic_view"></em>
									${vo.readCount}
							</span> | 
						<!--  공유하기-->
							<a href="#" class="bold navy" onclick="clip();"><em class="ic ic_share"></em>URL복사</a> 
							<em class="ic ic_more"></em>
						</div>
						<hr>
					</div>
					<div class="block-body">
						<div class="right">
							<c:if test="${!empty vo.fileName }">
							<em class="ic ic_list_file"></em>
							<span class="upfile">첨부파일&nbsp;</span>
								<span class="fileInfo"> 
									<a href="<c:url value='/board/download?boardNo=${param.boardNo}&fileName=${vo.fileName}'/>">
										${fileInfo} 
									</a></span>
							</c:if>
						</div>
						<%
							pageContext.setAttribute("newLine", "\r\n");
						%>
						<div class="lastDiv">
							<p class="content black">${fn:replace(vo.boardContent, newLine, "<br>")}</p>
						</div>
					</div>
		
					<div class="btn center">
						<button class="btn btn-theme" type="button" id=""
							onclick="toWrite()">
							<i class="fas fa-edit"></i> 글쓰기
						</button>
				
					<c:if test="${vo.adminId == sessionScope.adminId || vo.userId == sessionScope.userId}">	
						<button class="btn btn-theme" type="button" id="btedit"
							onclick="location.href='<c:url value='edit?boardNo=${param.boardNo}'/>'">
							<i class="fa fa-pen-nib"></i> 수정
						</button>
					</c:if>
					
					<c:if test="${!empty sessionScope.adminId || vo.userId == sessionScope.userId}">	
						<button class="btn btn-theme" type="button" id="btdelete">
							<i class="fas fa-trash"></i> 삭제
						</button>
					</c:if>
					
						<button class="btn btn-theme" type="button" id="btlist"
							onclick="location.href='<c:url value='list'/>'">
							<span class="ti-view-list"></span> 목록
						</button>
					</div>

<!-- 댓글 등록  -->
<div class="comment-box submit-form">
	<form name="frmReply" method="post" action="<c:url value='/board/detail/reply'/>" onsubmit="return validateForm();">
		<c:choose>
			<c:when test="${vo.cateType=='B'}">
				<input type="hidden" name="userId" value="${sessionScope.userId}" />
				<input type="hidden" name="nickname" value="${sessionScope.nickname}" />
				<!-- 접속계정의 닉네임으로 처리  변경
				<input type="hidden" name="userId" value="Tester2" />
				<input type="hidden" name="nickname" value="testnick2" />
				-->
				<input type="hidden" name="boardNo" value="${param.boardNo }" />
				<div class="form-group">
					<h5 class="comments-title black">댓글 ${totalComment }개</h5>
					<textarea class="reply comments form-control" name="replyContent" id="" placeholder="댓글을 입력하세요"></textarea>
					<button class="btn btn-theme comments_write" type="submit">
						<i class="fas fa-edit"></i> 등록
					</button>
				</div>
			</c:when>
			<c:when test="${vo.cateType=='N'}">
				<div class="form-group">
					<h5 class="comments-title black">댓글</h5>
					<textarea class="reply comments form-control" name="replyContent" id="noUserTa" placeholder="공지사항 댓글 입력불가" readonly></textarea>
					<button class="btn btn-theme comments_write" type="button" onclick="validateForm()">
						<i class="fas fa-edit"></i> 등록
					</button>
				</div>
			</c:when>
				<c:otherwise>
					<div class="form-group">
						<h5 class="comments-title black">댓글 ${totalComment }개</h5>
						<textarea class="reply comments form-control" name="replyContent" id="noUserTa" placeholder="회원만 이용가능합니다"></textarea>
						<button class="btn btn-theme comments_write" type="button" id="noUser"  onclick="validateForm()">
							<i class="fas fa-edit"></i> 등록
						</button>
					</div>
				</c:otherwise>
		</c:choose>
	</form>
</div>
<!--공지가 아닌 경우 노출하기  -->
<c:if test="${vo.cateType!='N'}">	
<!-- 댓글 리스트(replyList) -->
<c:if test="${empty replyList}">
<div id="replyList" style="background: #ffffff;">
	<p class="NoReply">아직 댓글이 없습니다</p>
</c:if>
<c:if test="${!empty replyList }">
<div id="replyList">
	<c:forEach var="replyVo" items="${replyList }">
		<div class="reply comment-details">
			<c:if test="${replyVo.delType=='Y'}">
				<div class="deleted comment-meta">
       				<p class="">(삭제된 댓글입니다)</p>
     			</div>
     		</c:if>
			<c:if test="${replyVo.delType!='Y'}">
				<!-- 대댓글의 경우 들여쓰기 -->
				<c:if test="${replyVo.step>0}">
					<div class="reReply comment-meta" 
						id='${replyVo.replyNo}comment-meta'
						onclick="replyDetail(${replyVo.replyNo})">
				</c:if>
				<!--  1차댓글의 경우 -->
				<c:if test="${replyVo.step==0}">
					<div class="original comment-meta " 
						id='${replyVo.replyNo}comment-meta'
						onclick="replyDetail(${replyVo.replyNo})">
				</c:if>
					<!-- 등록된 댓글 작성자&등록일-->
						<div class="comment-info flex-space">
							<div class="list comment-left-meta">
								<c:if test="${replyVo.step>0}">
									<em class="ic ic_reReply"></em>
								</c:if>
								<span class="author-name" id="">
									<i class="ti-user theme-cl"> ${replyVo.nickname}</i>
								</span>
								<span class="comment-date">&nbsp;
									<fmt:formatDate
										value="${replyVo.replyRegdate}" type="both" />
								</span>
							</div>
					<!-- 댓글 수정, 댓글 삭제 -->
							<div class="replyButtons" id="${replyVo.replyNo}replyButtons">
								<c:if test="${replyVo.userId==sessionScope.userId }" >
								<button class="btnReplyEditOpen" id="${replyVo.replyNo}btnReplyEditOpen"
									onclick="replyEditView(${replyVo.replyNo})">수정</button>
								</c:if>
								<c:if test="${replyVo.userId==sessionScope.userId || !empty sessionScope.adminId}" >
								<button class="btnReplyDelete" id="${replyVo.replyNo}btnReplyDelete"
									onclick="replyDelete(${replyVo.replyNo})">삭제</button>
								</c:if>
							</div>
						</div>
				<!--등록된 댓글 내용-->
						<div class="comment-reply" id='${replyVo.replyNo}comment-reply'>
							<div class="boardReply" id="${replyVo.replyNo}boardReply">
								<p class="comments">
									<br>
									<span id="${replyVo.replyNo}replyContent">${replyVo.replyContent }</span>
									<!-- 24시간 이내 작성 댓글 -->
									<c:if test="${replyVo.dateTerm<24 }">
										&nbsp;<span class="new">new</span>
									</c:if>
									<br>
								</p>
									<!-- 답글쓰기(대댓글은 불가) -->
								<c:if test="${!empty sessionScope.userId && replyVo.step==0 }">
									<button class="btnRereply">답글쓰기</button>
								</c:if>
							</div>
						</div>
					</div>
		<!-- 등록된 댓글 끝-->	
<!--  대댓글 등록-->
					<div class="reReplyForm" id="${replyVo.groupNo}reReplyForm" style="padding-left:30px">
						<form name="frmReReply" method="post" action="<c:url value='/board/detail/reReply'/>" onsubmit="return validateForm();">
							<input type="hidden" name="userId" value="${sessionScope.userId}" />
							<input type="hidden" name="nickname" value="${sessionScope.nickname}" />
							<!-- 접속계정정보 처리  변경
							<input type="hidden" name="userId" value="testUser3" />
							<input type="hidden" name="nickname" value="testNick3" />
							-->
							<input type="hidden" name="boardNo" value="${param.boardNo }" />
							<input type="hidden" name="groupNo" value="${replyVo.groupNo }" />
							<input type="hidden" name="step" value="${replyVo.step }">
							<input type="hidden" name="sortNo" value="${replyVo.sortNo }">
							<div class="form-group">
								<h5 class="comments-title">댓글</h5>
								<textarea class="reReply comments form-control" name="replyContent" placeholder="댓글을 입력하세요"></textarea>
								<button class="btn btn-theme comments_write" type="submit">
									<i class="fas fa-edit"></i> 등록
								</button>
							</div>
						</form>
					</div>
					<!--대댓등 등록양식 끝-->
			</c:if>
		</div>
	</c:forEach>
</div>	
</c:if>
</c:if>	<!-- 공지가 아닌 경우 노출 끝 -->
<!-- 댓글리스트 종료 -->
						</div>
						<!--  -->
					</div>
				</div>
			</div>
		<!-- /row -->
	</div>

</section>
<%@ include file="../inc/bottom.jsp"%>
