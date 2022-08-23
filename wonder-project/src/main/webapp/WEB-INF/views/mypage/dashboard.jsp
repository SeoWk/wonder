<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/mypage/incSide" />
<%-- <%@ include file="incSide.jsp" %> --%>
<input type="hidden" id="pageCheck" value="dashboard">
<link href="${pageContext.request.contextPath}/css/mypage.css" rel="stylesheet">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <!-- <script type="text/javascript">

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['Mushrooms', 3],
          ['Onions', 1],
          ['Olives', 1],
          ['Zucchini', 1],
          ['Pepperoni', 2]
        ]);

        // Set chart options
        var options = {'title':'사용언어별 거래량',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
    </script> -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(drawLineChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'lang per'],
          ['Java',     11],
          ['CSS',      7],
          ['HTML',  8],
          ['SPRING', 7],
          ['JavaScript',    3]
        ]);

        var options = {
          title: '성사된 거래의 언어 사용률',
          pieHole: 0.4,
          width:500,
          height:400,
          pieSliceTextStyle: 'black',
          colors: ['#3abc45', '#5cc865', '#8dd593', '#b7e8bb', '#d5ecd6']
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
      
      function drawLineChart() {
          var data = google.visualization.arrayToDataTable([
            ['Month', '거래건수', '월별 평균점수'],
            ['7월',  4, 4.5],
            ['8월',  5,4],
            ['9월',  5,4.7],
            ['10월',  4,4.3],
            ['11월',  5,4],
            ['12월',  5,4.8],
            ['1월',  5,4.2],
            ['2월',  6,4],
            ['3월',  4,4.3],
            ['4월',  5,4.7],
            ['5월',  5,4.9],
            ['6월',  4,4.7]
          ]);

          var options = {
            title: '월별 거래 건수',
            width: 700,
            curveType: 'function',
            colors: ['#3abc45','#f33066'],
            legend: { position: 'bottom' }
          };

          var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

          chart.draw(data, options);
        }
    </script>

						<div class="col-lg-9 col-md-8">
							<div class="dashboard-body">
								<div class="row">
									<div class="col-lg-12 col-md-12 col-sm-12">
										<h4>접속중인 회원 등급 : <span class="pc-title theme-cl">프리랜서</span></h4>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-4 col-md-6 col-sm-12">
										<div class="dashboard_stats_wrap widget-1">
											<div class="dashboard_stats_wrap_content"><h4>57</h4> <span>연간 거래완료건수</span></div>
											<div class="dashboard_stats_wrap-icon"><i class="ti-location-pin"></i></div>
										</div>	
									</div>
									
									<div class="col-lg-4 col-md-6 col-sm-12">
										<div class="dashboard_stats_wrap widget-3">
											<div class="dashboard_stats_wrap_content"><h4>13,580,000원</h4> <span>연간 계약 총 금액</span></div>
											<div class="dashboard_stats_wrap-icon"><i class="ti-wallet"></i></div>
										</div>	
									</div>
									
									<div class="col-lg-4 col-md-6 col-sm-12">
										<div class="dashboard_stats_wrap widget-2">
											<div class="dashboard_stats_wrap_content"><h4>54,580회</h4> <span>연간 내글의 조회수</span></div>
											<div class="dashboard_stats_wrap-icon"><i class="ti-credit-card"></i></div>
										</div>	
									</div>

								</div>
								<!--  row -->
								
								<div class="row">
									<div class="col-lg-12 col-md-7 col-sm-12">
										<div class="card">
											<div class="card-header">
												<h4 class="mb-0">판매관련 통계 그래프</h4>
											</div>
											<div class="card-body">
												<ul class="list-inline text-center m-t-40" style="margin-left: 500px">
													<!-- <li>
														<h5><i class="fa fa-circle m-r-5 text-warning"></i>Website A</h5>
													</li> -->
													<li>
														<h5><i class="fa fa-circle m-r-5 text-success"></i>거래건수</h5>
													</li>
													<li>
														<h5><i class="fa fa-circle m-r-5 text-danger"></i>월별 평균점수</h5>
													</li>
												</ul>
												<div class="chart" style="height: 300px;">    
													    <div id="donutchart" style="width: 400px; height: 310px; display: inline-block;"></div>
						   								 <div id="curve_chart" style="width: 400px; height: 310px; display: inline-block; margin-left: 100px;"></div>
						
												</div>
												
											</div>
										</div>
									</div>
									

								</div>
								<!-- row -->
								
								<div class="row">
									<div class="col-lg-4 col-md-5 col-sm-12">
										<div class="card">
											<div class="card-header">
												<h6>새 소식</h6>
											</div>
											<div class="ground-list ground-list-hove">
												<div class="ground ground-single-list">
													<a href="#">
														<div class="btn-circle-40 theme-cl theme-bg-light"><i class="ti-home"></i></div>
													</a>

													<div class="ground-content">
														<h6><a href="#">새로운 공지사항이 등록되었습니다. <strong>보러가기</strong></a></h6>
														<span class="small">방금</span>
													</div>
												</div>
												
												<div class="ground ground-single-list">
													<a href="#">
														<div class="btn-circle-40 theme-cl theme-bg-light"><i class="ti-comment-alt"></i></div>
													</a>

													<div class="ground-content">
														<h6><a href="#">Kim님으로부터 새로운 채팅이 도착했습니다</a></h6>
														<span class="small">20분 전</span>
													</div>
												</div>
												
												<div class="ground ground-single-list">
													<a href="#">
														<div class="btn-circle-40 theme-cl theme-bg-light"><i class="ti-heart"></i></div>
													</a>

													<div class="ground-content">
														<h6><a href="#">누군가 당신의 글에 리뷰를 남겼습니다</strong></a></h6>
														<span class="small">하루 전</span>
													</div>
												</div>
												
												<div class="ground ground-single-list">
													<a href="#">
														<div class="btn-circle-40 theme-cl theme-bg-light"><i class="ti-home"></i></div>
													</a>

													<div class="ground-content">
														<h6><a href="#">문의글에 관리자가 답변글을 달았습니다.</a></h6>
														<span class="small">10일 전</span>
													</div>
												</div>
												
												<div class="ground ground-single-list">
													<a href="#">
														<div class="btn-circle-40 theme-cl theme-bg-light"><i class="ti-comment-alt"></i></div>
													</a>

													<div class="ground-content">
														<h6><a href="#">Hong님으로부터 새로운 채팅이 도착했습니다</a></h6>
														<span class="small">11일 전</span>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-8 col-md-8">
										<div class="card">
											<div class="card-header">
												<h4 class="mb-0">주문 상황 조회</h4>
											</div>
											<div class="card-body p-0">
												<div class="table-responsive">
													<table class="table table-lg table-hover">
														<thead>
															<tr>
																<th>상품명</th>
																<th>구매자 아이디</th>
																<th>상태</th>
																<th>가격</th>
																<th>의뢰일</th>
															</tr>
														</thead>
														
														<tbody>
															<tr>
																<td><a href="#"><img src="https://via.placeholder.com/800x500" class="avatar avatar-30 mr-2" alt="Avatar">반응형 홈페이지 제작</a></td>
																<td>Highzess</td>
																<td><div class="label text-success bg-success-light">결제완료</div></td>                
																<td>120,000원</td>
																<td>04/10/2013</td>  
															</tr>
															
															<tr>
																<td><a href="#"><img src="https://via.placeholder.com/800x500" class="avatar avatar-30 mr-2" alt="Avatar">맞춤형 디자인 홈페이지</a></td>
																<td>Kim</td>
																<td><div class="label text-warning bg-warning-light">협의중</div></td>							
																<td>150,000원</td>
																<td>05/08/2014</td> 
															</tr>
															
															<tr>
																<td><a href="#"><img src="https://via.placeholder.com/800x500" class="avatar avatar-30 mr-2" alt="Avatar">반응형 홈페이지 제작</a></td>
																<td>Highzess</td>
																<td><div class="label text-danger bg-danger-light">취소</div></td>  
																<td>150,000원</td>
																<td>11/05/2015</td>                                          
															</tr>
															
															<tr>
																<td><a href="#"><img src="https://via.placeholder.com/800x500" class="avatar avatar-30 mr-2" alt="Avatar">반응형 홈페이지 제작</a></td>
																<td>Highzess</td>
																<td><div class="label text-success bg-success-light">결제완료</div></td>
																<td>100,000원</td>
																<td>06/09/2016</td>
															</tr>
															
															<tr>
																<td><a href="#"><img src="https://via.placeholder.com/800x500" class="avatar avatar-30 mr-2" alt="Avatar">맞춤형 디자인 홈페이지</a></td>
																<td>Hong</td>
																<td><div class="label text-success bg-success-light">결제완료</div></td>
																<td>140,000원</td>
																<td>06/09/2016</td>
															</tr>
															
															<tr>
																<td><a href="#"><img src="https://via.placeholder.com/800x500" class="avatar avatar-30 mr-2" alt="Avatar">반응형 홈페이지 제작</a></td>
																<td>Kim</td>
																<td><div class="label text-success bg-success-light">결제완료</div></td>
																<td>160,000원</td>
																<td>06/09/2016</td>
															</tr>
															
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- row -->
								
							</div>
						</div>
						
					</div>
				</div>
			</section>
			<!-- ============================ User Dashboard End ================================== -->
			
<%@ include file="../inc/bottom.jsp" %>