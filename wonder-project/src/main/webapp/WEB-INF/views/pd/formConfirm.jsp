<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type="text/css">
.confirm {
    display: inline-block;
    width: 200px;
    margin: 0.5rem;
}

.title{
	width: 80px;
    display: inline-block;
}

#formConfirm hr{
	border: 0;
    border-top: 1px solid #27ae6080;
}
</style>
<div style="border: 1px solid #27ae6080;padding: 10px;" id="formConfirm">
    <div class="col-lg-12 col-md-12 col-sm-12">
    	<div class="form-group">
			<span class="title">의뢰 번호 :</span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" style="width: 100px;" value="${map['FORM_NO'] }">
		</div>
	</div>
    <div class="col-lg-12 col-md-12 col-sm-12">
	    <div class="form-group">
			<span class="title">구매자 ID : </span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" value="${map['USER_ID'] }">
			<span style="margin-left: 30px;" class="title">판매자 : </span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" value="${expertVo.nickname }">
		</div>
	</div>
	<hr>
	<div class="col-lg-12 col-md-12 col-sm-12">
	    <div class="form-group">
			<span class="title">상품 타입 : </span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" value="${map['PD_TYPE'] }">
			<span style="margin-left: 30px;" class="title">가 &nbsp;&nbsp; 격 : </span>
			<fmt:formatNumber value="${map['PRICE'] }" pattern="#,###" var="price"/>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" value="${price } 원">
		</div>
	</div>
	<div class="col-lg-12 col-md-12 col-sm-12">
	    <div class="form-group">
			<span class="title">의뢰 상태 : </span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" style="width: 105px;" value="${map['PAY_FLAG'] }">
			<span style="margin-left: 15px;" class="title">작 업 일 : </span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" style="width: 105px;" value="${map['PD_TERM'] } 일">
			<span style="margin-left: 15px;" class="title">수정 횟수 : </span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" style="width: 103px;" value="${map['EDIT_COUNT'] } 회">
		</div>
	</div>
	<hr>
    <div class="col-lg-12 col-md-12 col-sm-12">
		<div class="form-group">
			<span class="title">제 &nbsp;&nbsp; 목 : </span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" style="width: 522px;" value="${map['FORM_TITLE'] }">
		</div>
	</div>
	
	<div class="col-lg-12 col-md-12 col-sm-12">
		<div class="form-group">
			<span class="title" style="float: left; margin-top: 38px;margin-right: 4px;">메 세 지 : </span>
			<textarea class="form-control ht-80 confirm" name="formContent" readonly="readonly" style="width: 522px;">${content }</textarea>
		</div>
	</div>
	<hr>
	<div class="col-lg-12 col-md-12 col-sm-12">
	    <div class="form-group">
			<span class="title">시 작 일 : </span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" value="<fmt:formatDate value="${map['ORDERSTART'] }" pattern="yyyy-MM-dd"/>">
			<span style="margin-left: 30px;" class="title">종 료 일 : </span>
			<input type="text" class="form-control confirm" name="formTitle" readonly="readonly" value="<fmt:formatDate value="${map['ORDEREND'] }" pattern="yyyy-MM-dd"/>">
		</div>
	</div>
	<hr>
	<div class="col-lg-12 col-md-12 col-sm-12 d-flex justify-content-center">
		<div class="form-group">
			<span class="title">의뢰 접수 : </span>
			<span><fmt:formatDate value="${map['FORM_REGDATE'] }" pattern="yyyy년 MM월 dd일 HH시 mm분"/></span>
		</div>
	</div>
</div>