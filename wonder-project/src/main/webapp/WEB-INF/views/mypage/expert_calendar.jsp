<%@page import="com.ez.wonder.form.model.FormVo"%> 
<%@page import="java.util.List"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/mypage/incSide" />
<%-- <%@ include file="incSide.jsp" %> --%>
<input type="hidden" id="pageCheck" value="chatting">

<link href="<c:url value='/css/mypage.css'/>" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<style type="text/css">
#fc-dom-1{
	margin-right: 50px;
}

.fc .fc-daygrid-day.fc-day-today {
      background-color: #2c3e5080;
      background-color: var(--fc-today-bg-color, #2c3e5080);
    }
.fc .fc-highlight {
    background: '';
    background: var(--fc-highlight-color, '');
  }
.fc-daygrid-day-events{
	font-size: 13px;
}
</style>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
		events:[ 
			<c:if test="${!empty list }">
           	<c:forEach var="formVo" items="${list }">
	            {
	                title:'${formVo.formTitle }',
	                start:'${formVo.orderstart }',
	                end:'${formVo.orderend }',
	                color : '#' + Math.round(Math.random() * 0xffffff).toString(16)
	            }
	        </c:forEach>
	        </c:if>
        ],
		headerToolbar : { // 헤더에 표시할 툴 바
			start : 'prev today',
			center : 'title',
			end : 'next'
			 /* end : 'dayGridMonth,dayGridWeek,dayGridDay'  */
		},
		titleFormat : function(date) {
			return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
		},
		//initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
		selectable : true, // 달력 일자 드래그 설정가능
		droppable : false,
		editable : true,
		displayEventTime: false,
		nowIndicator: true, // 현재 시간 마크
		locale: 'ko' // 한국어 설정

	});
	calendar.render();
});
</script>
<div class="col-lg-9 col-md-8 col-sm-12">
	<div class="dashboard-body">
		<div class="dashboard-wraper">
			<div id='calendar' style="width: 760px"></div>
		</div>
	</div>
</div>
			
			
</section>
<%@ include file="../inc/bottom.jsp" %>