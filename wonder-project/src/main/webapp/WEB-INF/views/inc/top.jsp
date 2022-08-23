<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>

<html lang="ko">
<head>
<style type="text/css">
button.api-btn {
	color: white;
	background-color: #27ae60;
	border: 0px solid;
	padding: 5px;
	border-radius: 10px;
	width: 80px;
	margin-left: 10px;
	margin-right: 10px;
}
</style>
<meta charset="utf-8" />
<meta name="author" content="Themezhub" />
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>작업물 중개는 원더(WONDER)</title>
<!-- Custom CSS -->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<script type="text/javascript"
	src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<body class="yellow-skin">

	<!-- ============================================================== -->
	<!-- Preloader - style you can find in spinners.css -->
	<!-- ============================================================== -->
	<div class="preloader"></div>

	<!-- ============================================================== -->
	<!-- Main wrapper - style you can find in pages.scss -->
	<!-- ============================================================== -->
	<div id="main-wrapper">
		<!-- ============================================================== -->
		<!-- Top header  -->
		<!-- ============================================================== -->
		<!-- Start Navigation -->
		<div class="header header-light">
			<div class="container">
				<nav id="navigation" class="navigation navigation-landscape">
					<div class="nav-header">
						<a class="nav-brand" href="<c:url value='/'/>"> <img
							src="${pageContext.request.contextPath}/img/logo.png"
							class="logo" alt="" />
						</a>
						<div class="nav-toggle"></div>
						<div class="mobile_nav">
							<ul>
							</ul>
						</div>
					</div>
					<div class="nav-menus-wrapper" style="transition-property: none;">
						<ul class="nav-menu">

							<li class="active"><a
								href="<c:url value='/aboutUs/aboutUs'/>">WONDER?<span
									class="submenu-indicator"></span></a></li>


							<li><a href="<c:url value='/pd/pdList'/>">상품 목록<span
									class="submenu-indicator"></span></a>
							<li><a href="<c:url value='/board/list'/>">자유게시판<span
									class="submenu-indicator"></span></a>
							<li><a href="<c:url value='/qna/qnaList'/>">Q&A게시판<span
									class="submenu-indicator"></span></a>
							<li></li>

						</ul>
						<!-- 로그인 안된 경우 -->
						<c:if test="${empty sessionScope.userId }">
							<ul class="nav-menu nav-menu-social align-to-right">
								<li><a href="#" class="alio_green" data-toggle="modal"
									data-target="#login" id="topLogin"> <i
										class="fas fa-sign-in-alt mr-1"></i><span class="dn-lg">로그인
											하세요</span>
								</a></li>
							</ul>
						</c:if>
						<!-- 로그인 된 경우 -->
						<c:if test="${!empty sessionScope.userId }">
							<ul class="nav-menu nav-menu-social align-to-right">
								<li>${sessionScope.userId }님환영합니다!<%-- <input type="text" name="sessionDel" id="sessionDel" value="${sessionScope.userId }"/> --%>
									<%-- <li><a href="<c:url value='/member/logout'/>" onclick="unlinkApp()">로그아웃</a></li> --%>
									<button class="api-btn" onclick="unlinkApp()" style="">로그아웃</button>
									<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
									<script type="text/javascript">
										function unlinkApp() {
											var loginType = "${sessionScope.LoginType}";
											/* alert(loginType); */
											if (loginType == "normal") {
												location.href = "<c:url value='/member/logout'/>";
											}

											Kakao
													.init('e001f5b6437ab5c78a358d107808c37c');
											Kakao.API
													.request({
														url : '/v1/user/unlink',
														success : function(res) {
															/* alert ('success: '
																	+ JSON.stringify(res)); */
															window.location = "/wonder/member/logout";
														},
														fail : function(err) {
															window.location = "/wonder/";
															/* alert('fail: '+ JSON.stringify(err)); */
														},
													})
										}
									</script> <input type="hidden" name="sessionDel" id="sessionDel"
									value="${sessionScope.userId }" /> <input type="hidden"
									name="sessionNick" id="sessionNick"
									value="${sessionScope.nickname }" />




								</li>
								<li class="add-listing"><c:if test="${userId=='admin'}">
										<a href="<c:url value='/admin/dashboard'/>" class=""> <i
											class="fas fa-user-circle fa-lg"></i>
										</a>
									</c:if> <c:if test="${userId!='admin' }">
										<a href="<c:url value='/mypage/profile'/>" class=""> <i
											class="fas fa-user-circle fa-lg"></i>
										</a>
									</c:if></li>
							</ul>
						</c:if>
					</div>
				</nav>
			</div>
		</div>
		<!-- End Navigation -->
		<div class="clearfix"></div>