<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		let link = $('#link').val();
		if (link == 'dashboard') {
			$('#dashboard').addClass("active");
		} else if (link == 'memberList') {
			$('#memberList').addClass("active");
		} else if (link == 'nonApprovalEx') {
			$('#nonApprovalEx').addClass("active");
		} else if (link == 'pdList') {
			$('#pdList').addClass("active");
		} else if (link == 'nonApprovalList') {
			$('#nonApprovalList').addClass("active");
		} else if (link == 'subadminList') {
			$('#subadminList').addClass("active");
		} else if (link == 'editAccount') {
			$('#editAccount').addClass("active");
		} else if (link == 'createAdmin') {
			$('#createAdmin').addClass("active");
		}
	});
</script>
<div class="col-lg-3 col-md-4 col-sm-12">
	<div class="property_dashboard_navbar">

		<div class="dash_user_avater">
			<img src="${pageContext.request.contextPath}/img/adminImg/adminProfile.jpg"
				class="img-fluid avater" alt="관리자 프로필 사진">
			<h4>${adminId}</h4>
			<span>관리자 계정</span>
		</div>

		<div class="dash_user_menues">

			<ul>
				<li id="dashboard"><a href="<c:url value='/admin/dashboard'/>"><i
						class="fa fa-tachometer-alt"></i>매출현황 통계</a></li>
				<li id="memberList"><a
					href="<c:url value='/admin/memberList'/>"><i
						class="fa fa-users"></i>회원 관리</a></li>
				<li id="nonApprovalEx"><a
					href="<c:url value='/admin/nonApprovalEx'/>"><i
						class="fa fa-check-square"></i>전문가 승인 대기 목록</a></li>
				<li id="pdList"><a href="<c:url value='/admin/pdList'/>"><i
						class="fa fa-tasks"></i>게시글 관리</a></li>
				<li id="nonApprovalList"><a
					href="<c:url value='/admin/nonApprovalList'/>"><i
						class="fa fa-bookmark"></i>거래대기 목록</a></li>
				<li id="subadminList"><a
					href="<c:url value='/admin/subadminList'/>"><i
						class="fa fa-id-badge"></i>부서별 관리자 관리</a></li>
				<li id="editAccount"><a
					href="<c:url value='/admin/editAccount'/>"><i
						class="fa fa-user-tie"></i>내 정보</a></li>
				<li id="createAdmin"><a
					href="<c:url value='/admin/createAdmin'/>"><i
						class="fa fa-plus-circle"></i>부서별 관리자 생성</a></li>
			</ul>
		</div>
		<div class="dash_user_footer">
			<ul>
				<li><a href="<c:url value='/admin/logout'/>"><i
						class="fa fa-power-off"></i></a></li>
				<li><a href="<c:url value='/admin/email'/>"><i
						class="fa fa-envelope"></i></a></li>
				<li><a href="<c:url value='/admin/editAccount'/>"><i class="fa fa-cog"></i></a></li>
			</ul>
		</div>
	</div>
</div>