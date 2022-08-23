<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../inc/top.jsp" %>
    
<script type="text/javascript">
	$(function(){
		$('#genaral').click(function(){
			location.href="<c:url value='/mypage/dashboard/general' />";
		});
		$('#free').click(function(){
			location.href="<c:url value='/mypage/dashboard/free' />";
		});
		$('#out').click(function(){
			location.href="<c:url value='/mypage/dashboard/out' />";
		});
		
		$('.linkFreeWrite').click(function(){
			var type = "<c:out value='${memVo.type}' />";
			if(type=='프리랜서'){
				open("<c:url value='/mypage/freeDetailWrite?sellUserId=${memVo.userId}' />", "상세보기","width=1000, height=800,location=yes, resizable=yes, top=300px, left=300px");
			}			
		});

		var page=$('#pageCheck').val();
		/* 
		if(page=='dashboard'){
			$('#li_00').addClass("active");
		}else 
			 */
		if(page=='profile'){
			$('#li_01').addClass("active");
		}else if(page=='portfolio'){
			$('#li_02').addClass("active");
		}else if(page=='application'){
			$('#li_02').addClass("active");
		}else if(page=='bookmark'){
			$('#li_03').addClass("active");
		}else if(page=='transaction'){
			$('#li_04').addClass("active");
		}else if(page=='chatting'){
			$('#li_05').addClass("active");
		}else if(page=='changePwd'){
			$('#li_06').addClass("active");
		}
		/* 
		$('.sideBt').click(function(){
			if(!confirm('로그아웃 하시겠습니까??')){
				return false;
			}
		});
		 */
		
	});
</script>
    
			<!-- ============================================================== -->
			<!-- Top header  --> 
			<!-- ============================================================== -->
			
			<!-- ============================ Page Title Start================================== -->
			<div class="page-title" style="background:#f4f4f4 url(<c:url value='/img/mypage/mypage_banner.jpg' />);" data-overlay="5">
				<div class="container">
					<div class="row">
						<div class="col-lg-12 col-md-12">
							
							<div class="breadcrumbs-wrap">
								<ol class="breadcrumb">
									<li class="breadcrumb-item active" aria-current="page">반갑습니다</li>
								</ol>
								<h2 class="breadcrumb-title">${userId }님의 개인페이지입니다</h2>
							</div>
							
						</div>
					</div>
				</div>
			</div>
			<!-- ============================ Page Title End ================================== -->
			
			<!-- ============================ User Dashboard ================================== -->
			<section class="gray pt-5 pb-5">
				<div class="container-fluid">
								
					<div class="row">
						
						<div class="col-lg-3 col-md-4">
							<div class="property_dashboard_navbar">
								<div class="dash_user_avater">
										<c:if test="${profileVo.fileName !=null && profileVo.fileName != ''}">
											<a class="linkFreeWrite">
												<img src="<c:url value='/img/mypage/expert_profile/${profileVo.fileName }' />" class="img-fluid avater" alt="프로필이미지">
											</a>
										</c:if>
										<c:if test="${profileVo.fileName ==null || profileVo.fileName == ''}">
											<%-- <a href="<c:url value='/mypage/freeDetailWrite' />"> --%>
											<a class="linkFreeWrite">
												<img src="<c:url value='/img/mypage/default_profile.png' />" class="img-fluid avater" alt="프로필이미지">
											</a>
										</c:if>
									<h4>${userId }</h4>
									<span>${vo.email }</span>
								</div>

								<div class="dash_user_menues">
									<ul>
										<%-- <li id="li_00"><a href="<c:url value='/mypage/dashboard' />"><i class="fa fa-tachometer-alt"></i>대시보드</a></li> --%>
										<li id="li_01"><a href="<c:url value='/mypage/profile' />"><i class="fa fa-user-tie"></i>내 정보</a></li>
										<c:if test="${memVo.type=='프리랜서' }">
											<li id="li_02"><a href="<c:url value='/mypage/portfolio' />">　└ 포트폴리오 관리</a></li>
										</c:if>
										<c:if test="${memVo.type=='일반회원' }">
											<li id="li_02"><a href="<c:url value='/mypage/application' />">　└ 프리랜서 등록 신청</a></li>
										</c:if>
										<c:if test="${memVo.type=='승인대기' }">
											<li id="li_02"><a href="<c:url value='/mypage/application' />">　└ 프리랜서 등록 신청</a></li>
										</c:if>
										<li id="li_03"><a href="<c:url value='/mypage/bookmark' />"><i class="fa fa-bookmark"></i>찜해둔 상품</a></li>
										<li id="li_04"><a href="<c:url value='/mypage/transaction' />"><i class="fa fa-tasks"></i>거래내역</a></li>
										<li id="li_05"><a href="<c:url value='/mypage/chatting' />"><i class="fa fa-envelope"></i>메세지</a></li>
										<li id="li_06"><a href="<c:url value='/mypage/changePwd' />"><i class="fa fa-unlock-alt"></i>암호변경</a></li>
									</ul>
								</div>
								
								<div class="dash_user_footer">
									<ul>
										<li><span onclick="unlinkApp()" class="sideBt"><i class="fa fa-power-off"></i></span></li>
										<li><a href="<c:url value='/mypage/chatting' />"><i class="fa fa-comment"></i></a></li>
										<li><a href="<c:url value='/mypage/profile' />"><i class="fa fa-cog"></i></a></li>
									</ul>
								</div>
							</div>
						</div>