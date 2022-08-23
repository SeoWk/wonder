<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../inc/top.jsp"%>
<head>
<meta charset="utf-8" />
<meta name="author" content="Themezhub" />
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>RentUP - Residence & Real Estate Template</title>

<!-- Custom CSS -->
<link href="assets/css/styles.css" rel="stylesheet">

</head>
<script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
<body class="yellow-skin">
   <script type="text/javascript">
      function updateProductList(type, pdInfo) {
         //console.log(item);
         var pdList = pdInfo.pdLists;
         console.log('length :' + pdList.length);
         if(pdList.length == 0) {
            alert("검색한 상품이 없습니다!"); 
            location.href = "/wonder/pd/pdList"
         } else {
            $('#ProductList').empty();
            var html = '';
            pdList.forEach(function(item, index) {
               var str = '<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">';
               str += '<div class="property-listing list_view">';
               str += '<div class="listing-img-wrapper">';
               str += '<div class="list-img-slide">';
               str += '<div class="click">';
               item.pdImages.forEach(function(image, index) {
                     str += '<div><a href="/wonder/pd/pdDetail?pdNo=' + item.pdNo +'"><img src="${pageContext.request.contextPath}/img/pdupload/'+ image.fileName + '" class="img-fluid mx-auto" alt="" /></a></div>';
                  });

               str += '</div>';
               str += '</div>';
               str += '</div>';
               str += '';
               str += '<div class="list_view_flex">';
               str += '<div class="listing-detail-wrapper mt-1">';
               str += '<div class="listing-short-detail-wrap">';
               str += '<div class="_card_list_flex mb-2">';
               str += '<div class="_card_flex_01">';
               str += '<span class="_list_blickes _netork" id="pdTerm">기한: ' + item.pdDetail.pdTerm + '</span>';
               str += '<span class="_list_blickes types" id="editCount">수정: ' + item.pdDetail.editCount + '</span>';
               str += '</div>';
               str += '<div class="_card_flex_last">';
               str += '<div class="prt_saveed_12lk">';
               if (item.dupFlag == 'H')
                  str += '<label class="toggler toggler-danger"><input type="checkbox" checked="checked" id="pdDibs" value="' + item.pdNo + '"><i class="fas fa-heart"></i></label>';
               else
                  str += '<label class="toggler toggler-danger"><input type="checkbox" id="pdDibs" value="' + item.pdNo + '"><i class="fas fa-heart"></i></label>';
               str += '</div>';
               str += '</div>';
               str += '';
               str += '</div>';
               str += '<div class="_card_list_flex">';
               str += '<div class="_card_flex_01">';
                str += '<h4 class="listing-name verified"><a href="/wonder/pd/pdDetail?pdNo=' + item.pdNo +'" class="prt-link-detail" id="pdTitle" style="margin-left: 5px">' + item.pdTitle + '</a></h4>';
               str += '</div>';
               str += '</div>';
               str += '</div>';
               str += '</div>';
               str += '';
               str += '<div class="price-features-wrapper">';
               str += '<div class="list-fx-features">';
               str += '<div class="">';
               str += '<div class="inc-fleat-icon">' + item.lang + '</div>';
               str += '</div>';
               str += '<div class="">||';
               str += '<div class="inc-fleat-icon">' + item.frame + '</div>';
               str += '</div>';
               str += '';
               str += '</div>';
               str += '</div>';
               str += '<div class="listing-detail-footer">';
               str += '<div class="footer-first">';
               str += '<div class="foot-location">';
               str += '<h6 class="listing-card-info-price mb-0" id="pdPrice">' + item.pdDetail.pdPrice + '</h6>/ ' + item.pdDetail.pdType + '</div>';
               str += '</div>';
               str += '<div class="footer-flex">';
               str += '<a href="/wonder/pd/pdDetail?pdNo=' + item.pdNo +'" id="viewDetail" class="prt-view">상품 상세보기</a>';
               str += '</div>';
               str += '</div>';
               str += '</div>';
               str += '</div>';

               html = $(str);
               $('#ProductList').append(html);
            });
         }
      };

         function updatePaging(type, pdList) {
             console.log(type);
             console.log("updatePaging");
             var page = pdList.pageNo;
             var maxpage = pdList.maxpage;
             $('#Paging').empty();
             
             var html = '';
             html += '<div class="element">';
             var full = page/4 - (page/4 % 1);
             full *=4;
             var scope = page%4;
             var prev = 0;
             var next = 0;
             if(scope == 0) {
                prev = 4;
                next = 1;
             } else if(scope < 5) {
                prev = scope;
                next = 5 - scope;
             }
             
             html += '<ul class="pagination p-center">';
             html += '<li class="page-item">';
             html += '<span class="ti-arrow-left"></span>';
             
             var prevb = 0;
             if(page > 4) {
                prevb = (page-1)/4 - (((page-1)/4) % 1);
                prevb = (prevb-1)*4 + 1;
                html += '<span id="prevBtn" class="prev button" value="' + prevb + '"><a href="#" onclick="getPaging(\'' + type + '\', ' +  prevb + ');"> < </a></span>';
             }
             html += '</li>';
             
             html += '<li class="page-item">';
             if(page != 1) {
                var j = prev;
                for (i = 1; i <= (prev-1); i++) {
                   j -= 1;
                   if((page - j) > 0) {
                      html += '<span class="no"><a href="#" onclick="getPaging(\'' + type + '\', ' + (page - j) + ');"> ' + (page - j) + ' </a></span>';
                   }
                }
             }
             html += '</li>';
             
             html += '<li class="page-item active">';
             html += '<span class="no selected"> ' + page + ' </span>';
             html += '</li>';

             html += '<li class="page-item">';
             if(page != maxpage) {
                for(i = 1; i <= next-1; i++) {
                   if(maxpage >= (page + i)) {
                      html += '<span class="no"> <a id="pageLink" href="#" onclick="getPaging(\'' + type + '\', ' + (page + i) +');"> ' + (page + i) + ' </a></span>';
                   }
                }
             }
             html += '</li>';

             html += '<li class="page-item">';
             html += '<span class="ti-arrow-right"></span>';
             if(maxpage >= (page + next)) {
                var nextb = (page-1)/4 - (((page-1)/4) % 1);
                nextb = (nextb+1)*4 + 1;
                
                html += '<span id="nextBtn" class="next button" value="' + nextb + '"> <a href="#" onclick="getPaging(\'' + type + '\', ' + nextb + ');"> > </a>';
                html += '</span>';
             }
             html += '</li>';
             html += '</ul>';
             
             $('#Paging').append($(html));
          };
      
      function updateWished() {
         $('[id=pdDibs]').each(function() {
            $(this).click(function() {
               var userId = '<%=(String) session.getAttribute("userId")%>';
               console.log(userId, typeof userId);
               if(userId == "null") {
                  alert("로그인후 이용해주세요.");
                  return false;                  
               }
               
               var sendInfo = {
                     "pdNo" : $(this).val(),
                     "checked" : $(this).is(':checked')
                  };

                  console.log(sendInfo);
                  $.ajax({
                     url : '/wonder/pd/pdWished',
                     data : JSON.stringify(sendInfo),
                     contentType : 'application/json',
                     processData : false,
                     type : 'POST',
                     success : function() {
                     }
                  });
            });
         });
      };
   
      function getPaging(type, pageNo) {
//         console.log("getPaging............");
//         console.log(type + " : " + pageNo);
         
         var url = '/wonder/pd/' + type + '?pageNo=' + pageNo;
         console.log(url);
         
         if(type == 'pdList') {
            $.ajax({
               url : url,
               contentType : 'application/json',
               processData : false,
               type : 'POST',
               success : function(pdList) {
                  updateProductList(type, pdList);
                  updatePaging(type, pdList);
                  updateWished();
               }
            });
         } else if(type == 'pdSearch') {
            console.log("상품검색....");
            var pdTitle = $('input[name=pdTitle]').val();
            var editCount = $('#editCount').val();
            if (editCount === '')
               editCount = 0;

            var pdTermMin = $('input[name=pdTermMin]').val();
            if (pdTermMin === '')
               pdTermMin = 0;
            var pdTermMax = $('input[name=pdTermMax]').val();
            if (pdTermMax === '')
               pdTermMax = 0;

            var pdPriceMin = $('span[class=irs-from]').text().replace(/(\s*)/g, "");
            var pdPriceMax = $('span[class=irs-to]').text().replace(/(\s*)/g, "");

            var pdLang = new Array();
            $('[name=langchbox]').each(function() {
               if ($(this).is(':checked') == true) {
                  pdLang.push($(this).val());
               }
            });
            var pdFrame = new Array();
            $('[name=framechbox]').each(function() {
               if ($(this).is(':checked') == true) {
                  pdFrame.push($(this).val());
               }
            });
            var sendInfo = {
               "pdTitle" : pdTitle,
               "editCount" : editCount,
               "pdTermMin" : pdTermMin,
               "pdTermMax" : pdTermMax,
               "pdPriceMin" : pdPriceMin,
               "pdPriceMax" : pdPriceMax,
               "pdLang" : pdLang,
               "pdFrame" : pdFrame
            };

            $.ajax({
               url : url,
               data : JSON.stringify(sendInfo),
               contentType : 'application/json',
               processData : false,
               type : 'POST',
               success : function(pdList) {
                     updateProductList(type, pdList);
                     updatePaging(type, pdList);
                     updateWished();
                  }
            });
         }
         
      };
      
      $(function() {
         
         $('#pdWrite').click(function() {
            var userType = '<%=(String) session.getAttribute("type")%>';
            console.log(userType);
            if (userType == '프리랜서') {
               location.href = "/wonder/pd/pdWrite"
            } else {
               alert("전문가 아이디로 로그인 해주세요.");
            }
         });

         updateWished();
         
         $('#searchPd').click(function() {
            /*
            console.log("상품검색....");
            var pdTitle = $('input[name=pdTitle]').val();
            var editCount = $('#editCount').val();
            if (editCount === '')
               editCount = 0;

            var pdTermMin = $('input[name=pdTermMin]').val();
            if (pdTermMin === '')
               pdTermMin = 0;
            var pdTermMax = $('input[name=pdTermMax]').val();
            if (pdTermMax === '')
               pdTermMax = 0;

            var pdPriceMin = $('span[class=irs-from]').text().replace(/(\s*)/g, "");
            var pdPriceMax = $('span[class=irs-to]').text().replace(/(\s*)/g, "");

            var pdLang = new Array();
            $('[name=langchbox]').each(function() {
               if ($(this).is(':checked') == true) {
                  pdLang.push($(this).val());
               }
            });

            var pdFrame = new Array();
            $('[name=framechbox]').each(function() {
               if ($(this).is(':checked') == true) {
                  pdFrame.push($(this).val());
               }
            });

            var sendInfo = {
               "pdTitle" : pdTitle,
               "editCount" : editCount,
               "pdTermMin" : pdTermMin,
               "pdTermMax" : pdTermMax,
               "pdPriceMin" : pdPriceMin,
               "pdPriceMax" : pdPriceMax,
               "pdLang" : pdLang,
               "pdFrame" : pdFrame
            };

            $.ajax({
               url : '/wonder/pd/pdSearch?pageNo=1',
               data : JSON.stringify(sendInfo),
               contentType : 'application/json',
               processData : false,
               type : 'POST',
               success : function(pdList) {
                     updateProductList('pdSearch', pdList);
                     updatePaging('pdSearch', pdList);
                     updateWished();
                  }
            });
            */
            alert("상품이 검색되었습니다.");
            window.scrollTo(0,0);
            getPaging('pdSearch', 1);
         });
      });
   </script>
   <!-- ============================ All Property ================================== -->
   <section class="gray pt-4">
      <div class="container">
         <div class="row">

            <!-- 검색 바 -->
            <div class="col-lg-4 col-md-12 col-sm-12">
               <div class="page-sidebar p-0">
                  <div class="collapse" id="fltbox">
                     <!-- Find New Property -->
                     <div class="sidebar-widgets p-4">

                        <!-- 제목 -->
                        <div class="form-group">
                           <div class="input-with-icon">
                              <input type="text" class="form-control" placeholder="제목을 입력하세요" name="pdTitle">
                              <i class="ti-search"></i>
                           </div>
                        </div>

                        <!-- 수정횟수 -->
                        <div class="form-group">
                           <div class="simple-input">
                              <select id="editCount" class="form-control" name="editCount">
                                 <option value="">수정횟수</option>
                                 <option value="1">1</option>
                                 <option value="2">2</option>
                                 <option value="3">3</option>
                                 <option value="4">4</option>
                                 <option value="5">5</option>
                                 <option value="6">6</option>
                                 <option value="7">7</option>
                                 <option value="8">8</option>
                                 <option value="9">9</option>
                                 <option value="10">10</option>
                              </select>
                           </div>
                        </div>


                        <!-- 기한 -->
                        <div class="row">
                           <div class="col-lg-6 col-md-6 col-sm-6">
                              <div class="form-group">
                                 <div class="simple-input">
                                    <input type="text" class="form-control" placeholder="최소 기한 (일)" name="pdTermMin">
                                 </div>
                              </div>
                           </div>

                           <div class="col-lg-6 col-md-6 col-sm-6">
                              <div class="form-group">
                                 <div class="simple-input">
                                    <input type="text" class="form-control" placeholder="최대 기한 (일)" name="pdTermMax">
                                 </div>
                              </div>
                           </div>
                        </div>

                        <!-- 가격 -->
                        <div class="row">
                           <div class="col-lg-12 col-md-12 col-sm-12 pt-4 pb-4">
                              <h6>Choose Price</h6>
                              <div class="rg-slider">
                                 <input type="text" class="js-range-slider" name="my_range" value="" name="pdPrice" />
                              </div>
                           </div>
                        </div>

                        <div class="row">
                           <div class="col-lg-12 col-md-12 col-sm-12 pt-4">
                              <h6>개발 언어</h6>
                              <div class="classlanguage">
                                 <ul class="no-ul-list third-row">
                                    <c:forEach var="langVo" items="${langList}">
                                       <li><input id="${langVo.langNo}" name="langchbox" class="checkbox-custom" type="checkbox" value="${langVo.lang}"> <label for="${langVo.langNo}" class="checkbox-custom-label">${langVo.lang }</label></li>
                                    </c:forEach>
                                 </ul>
                              </div>
                           </div>
                        </div>

                        <div class="row">
                           <div class="col-lg-12 col-md-12 col-sm-12 pt-4">
                              <h6>프레임 워크</h6>
                              <div class="classframe">
                                 <ul class="no-ul-list third-row">
                                    <c:forEach var="frameVo" items="${frameList}">
                                       <li><input id="f-${frameVo.frameNo}" name="framechbox" class="checkbox-custom" type="checkbox" value="${frameVo.frame}"> <label for="f-${frameVo.frameNo}" class="checkbox-custom-label">${frameVo.frame }</label></li>
                                    </c:forEach>
                                 </ul>
                              </div>
                           </div>
                        </div>

                        <div class="row">
                           <div class="col-lg-12 col-md-12 col-sm-12 pt-4">
                              <button class="btn theme-bg rounded full-width" id="searchPd">상품 검색</button>
                           </div>
                        </div>

                     </div>
                  </div>
               </div>
               <!-- Sidebar End -->
            </div>

            <div class="col-lg-8 col-md-12 col-sm-12">
               <div class="row justify-content-center" id="ProductList">
                  <div class="col-lg-12 col-md-12 col-sm-12">
                  <c:if test="${userType eq '프리랜서' }">
                     <div class="stbooking-footer mt-1">
                        <div class="form-group mb-0 pb-0">
                           <a href="#" class="btn book_btn theme-bg" id="pdWrite" >상품 등록하기</a>
                           <br>
                        </div>
                     </div>
                    </c:if>
                  </div>
                  <!-- Single Property -->
                  <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                     <c:forEach var="pdListVo" items="${pdList}" varStatus="status">
                        <div class="property-listing list_view">
                           <div class="listing-img-wrapper">
                              <div class="list-img-slide">
                                 <div class="click">
                                    <c:forEach var="PdImageVO" items="${pdListVo.pdImages}" varStatus="status">
                                       <div>
                                          <a href="<c:url value='/pd/pdDetail?pdNo=${pdListVo.pdNo}'/>"><img src="${pageContext.request.contextPath}/img/pdupload/${PdImageVO.fileName}" class="img-fluid mx-auto" alt="" /></a>
                                       </div>
                                    </c:forEach>
                                 </div>
                              </div>
                           </div>

                           <div class="list_view_flex">
                              <div class="listing-detail-wrapper mt-1">
                                 <div class="listing-short-detail-wrap">
                                    <div class="_card_list_flex mb-2">
                                       <div class="_card_flex_01">
                                          <span class="_list_blickes _netork" id="pdTerm">기한: ${pdListVo.pdDetail.pdTerm}</span> <span class="_list_blickes types" id="editCount">수정: ${pdListVo.pdDetail.editCount}</span>
                                       </div>
                                       <div class="_card_flex_last">
                                          <div class="prt_saveed_12lk">
                                             <label class="toggler toggler-danger"> <c:choose>
                                                   <c:when test="${pdListVo.dupFlag eq 'H'}">
                                                      <input type="checkbox" id="pdDibs" checked="checked" value="${pdListVo.pdNo}">
                                                   </c:when>
                                                   <c:otherwise>
                                                      <input type="checkbox" id="pdDibs" value="${pdListVo.pdNo}">
                                                   </c:otherwise>
                                                </c:choose> <i class="fas fa-heart"></i></label>
                                          </div>
                                       </div>

                                    </div>
                                    <div class="_card_list_flex">
                                       <div class="_card_flex_01">
                                          <h4 class="listing-name verified"><a href="<c:url value='/pd/pdDetail?pdNo=${pdListVo.pdNo}'/>" 
                                          class="prt-link-detail" id="pdTitle" style="margin-left: 5px">${pdListVo.pdTitle}</a></h4>
                                       </div>
                                    </div>
                                 </div>
                              </div>

                              <div class="price-features-wrapper">
                                 <div class="list-fx-features">
                                    <div class="">
                                       <div class="inc-fleat-icon">${pdListVo.lang}</div>
                                    </div>
                                    <div class="">||
                                       <div class="inc-fleat-icon">${pdListVo.frame}</div>
                                    </div>

                                 </div>
                              </div>
                              <div class="listing-detail-footer">
                                 <div class="footer-first">
                                    <div class="foot-location" id="detailPd">
                                       <h6 class="listing-card-info-price mb-0" id="pdPrice">${pdListVo.pdDetail.pdPrice}</h6>
                                       / ${pdListVo.pdDetail.pdType}
                                    </div>
                                 </div>
                                 <div class="footer-flex">
                                    <a href="<c:url value='/pd/pdDetail?pdNo=${pdListVo.pdNo}'/>" id="viewDetail" class="prt-view">상품 상세보기</a>
                                 </div>
                              </div>
                           </div>

                        </div>
                     </c:forEach>
                  </div>

                  <!-- End Single Property -->

                  <!-- Single Property -->
                  <!--  
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                           <div class="property-listing list_view">
                              
                              <div class="listing-img-wrapper">
                                 <div class="_exlio_125">For Sale</div>
                                 <div class="list-img-slide">
                                    <div class="click">
                                       <div><a href="single-property-1.html"><img src="https://via.placeholder.com/800x500" class="img-fluid mx-auto" alt="" /></a></div>
                                       <div><a href="single-property-1.html"><img src="https://via.placeholder.com/800x500" class="img-fluid mx-auto" alt="" /></a></div>
                                       <div><a href="single-property-1.html"><img src="https://via.placeholder.com/800x500" class="img-fluid mx-auto" alt="" /></a></div>
                                    </div>
                                 </div>
                              </div>
                              
                              <div class="list_view_flex">
                              
                                 <div class="listing-detail-wrapper mt-1">
                                    <div class="listing-short-detail-wrap">
                                       <div class="_card_list_flex mb-2">
                                          <div class="_card_flex_01">
                                             <span class="_list_blickes _netork">8 Network</span>
                                             <span class="_list_blickes types">Apartment</span>
                                             
                                          </div>
                                          <div class="_card_flex_last">
                                          <div class="prt_saveed_12lk">
                                             <label class="toggler toggler-danger"><input type="checkbox"><i class="fas fa-heart"></i></label>
                                          </div>
                                       </div>
                                       
                                       </div>
                                       <div class="_card_list_flex">
                                          <div class="_card_flex_01">
                                             <h4 class="listing-name verified"><a href="single-property-1.html" class="prt-link-detail">8512 Red Reveals Market, Montreal Canada, SHQT45O</a></h4>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 
                                 <div class="price-features-wrapper">
                                    <div class="list-fx-features">
                                       <div class="listing-card-info-icon">
                                          <div class="inc-fleat-icon"><img src="assets/img/bed.svg" width="13" alt="" /></div>5 Beds
                                       </div>
                                       <div class="listing-card-info-icon">
                                          <div class="inc-fleat-icon"><img src="assets/img/bathtub.svg" width="13" alt="" /></div>2 Bath
                                       </div>
                                       <div class="listing-card-info-icon">
                                          <div class="inc-fleat-icon"><img src="assets/img/move.svg" width="13" alt="" /></div>900 sqft
                                       </div>
                                    </div>
                                 </div>
                                    <div class="listing-detail-footer">
                                 <div class="footer-first">
                                    <div class="foot-location">
                                             <h6 class="listing-card-info-price mb-0">$8,700</h6>/sqft</div>
                                 </div>
                                 <div class="footer-flex">
                                       <a href="property-detail.html" class="prt-view">View Detail</a>
                                    </div>
                              </div>
                              </div>
                              
                           </div>
                        </div>
                        -->
                  <!-- End Single Property -->




                  <!-- Single Property -->
                  <!--  
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                           <div class="property-listing list_view">
                              
                              <div class="listing-img-wrapper">
                                 <div class="_exlio_125">For Sale</div>
                                 <div class="list-img-slide">
                                    <div class="click">
                                       <div><a href="single-property-1.html"><img src="https://via.placeholder.com/800x500" class="img-fluid mx-auto" alt="" /></a></div>
                                       <div><a href="single-property-1.html"><img src="https://via.placeholder.com/800x500" class="img-fluid mx-auto" alt="" /></a></div>
                                       <div><a href="single-property-1.html"><img src="https://via.placeholder.com/800x500" class="img-fluid mx-auto" alt="" /></a></div>
                                    </div>
                                 </div>
                              </div>
                              
                              <div class="list_view_flex">
                              
                                 <div class="listing-detail-wrapper mt-1">
                                    <div class="listing-short-detail-wrap">
                                       <div class="_card_list_flex mb-2">
                                          <div class="_card_flex_01">
                                             <span class="_list_blickes _netork">8 Network</span>
                                             <span class="_list_blickes types">Apartment</span>
                                             
                                          </div>
                                          <div class="_card_flex_last">
                                          <div class="prt_saveed_12lk">
                                             <label class="toggler toggler-danger"><input type="checkbox"><i class="fas fa-heart"></i></label>
                                          </div>
                                       </div>
                                       
                                       </div>
                                       <div class="_card_list_flex">
                                          <div class="_card_flex_01">
                                             <h4 class="listing-name verified"><a href="single-property-1.html" class="prt-link-detail">8512 Red Reveals Market, Montreal Canada, SHQT45O</a></h4>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 
                                 <div class="price-features-wrapper">
                                    <div class="list-fx-features">
                                       <div class="listing-card-info-icon">
                                          <div class="inc-fleat-icon"><img src="assets/img/bed.svg" width="13" alt="" /></div>5 Beds
                                       </div>
                                       <div class="listing-card-info-icon">
                                          <div class="inc-fleat-icon"><img src="assets/img/bathtub.svg" width="13" alt="" /></div>2 Bath
                                       </div>
                                       <div class="listing-card-info-icon">
                                          <div class="inc-fleat-icon"><img src="assets/img/move.svg" width="13" alt="" /></div>900 sqft
                                       </div>
                                    </div>
                                 </div>
                                    <div class="listing-detail-footer">
                                 <div class="footer-first">
                                    <div class="foot-location">
                                             <h6 class="listing-card-info-price mb-0">$8,700</h6>/sqft</div>
                                 </div>
                                 <div class="footer-flex">
                                       <a href="property-detail.html" class="prt-view">View Detail</a>
                                    </div>
                              </div>
                              </div>
                              
                           </div>
                        </div>
                        -->
                  <!-- End Single Property -->
                  <!-- Single Property -->
                  <!--  
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                           <div class="property-listing list_view">
                              
                              <div class="listing-img-wrapper">
                                 <div class="_exlio_125">For Sale</div>
                                 <div class="list-img-slide">
                                    <div class="click">
                                       <div><a href="single-property-1.html"><img src="https://via.placeholder.com/800x500" class="img-fluid mx-auto" alt="" /></a></div>
                                       <div><a href="single-property-1.html"><img src="https://via.placeholder.com/800x500" class="img-fluid mx-auto" alt="" /></a></div>
                                       <div><a href="single-property-1.html"><img src="https://via.placeholder.com/800x500" class="img-fluid mx-auto" alt="" /></a></div>
                                    </div>
                                 </div>
                              </div>
                              
                              <div class="list_view_flex">
                              
                                 <div class="listing-detail-wrapper mt-1">
                                    <div class="listing-short-detail-wrap">
                                       <div class="_card_list_flex mb-2">
                                          <div class="_card_flex_01">
                                             <span class="_list_blickes _netork">8 Network</span>
                                             <span class="_list_blickes types">Apartment</span>
                                             
                                          </div>
                                          <div class="_card_flex_last">
                                          <div class="prt_saveed_12lk">
                                             <label class="toggler toggler-danger"><input type="checkbox"><i class="fas fa-heart"></i></label>
                                          </div>
                                       </div>
                                       
                                       </div>
                                       <div class="_card_list_flex">
                                          <div class="_card_flex_01">
                                             <h4 class="listing-name verified"><a href="single-property-1.html" class="prt-link-detail">8512 Red Reveals Market, Montreal Canada, SHQT45O</a></h4>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 
                                 <div class="price-features-wrapper">
                                    <div class="list-fx-features">
                                       <div class="listing-card-info-icon">
                                          <div class="inc-fleat-icon"><img src="assets/img/bed.svg" width="13" alt="" /></div>5 Beds
                                       </div>
                                       <div class="listing-card-info-icon">
                                          <div class="inc-fleat-icon"><img src="assets/img/bathtub.svg" width="13" alt="" /></div>2 Bath
                                       </div>
                                       <div class="listing-card-info-icon">
                                          <div class="inc-fleat-icon"><img src="assets/img/move.svg" width="13" alt="" /></div>900 sqft
                                       </div>
                                    </div>
                                 </div>
                                    <div class="listing-detail-footer">
                                 <div class="footer-first">
                                    <div class="foot-location">
                                             <h6 class="listing-card-info-price mb-0">$8,700</h6>/sqft</div>
                                 </div>
                                 <div class="footer-flex">
                                       <a href="property-detail.html" class="prt-view">View Detail</a>
                                    </div>
                              </div>
                              </div>
                              
                           </div>
                        </div>
                        -->
                  <!-- End Single Property -->

               </div>
         <div class="col-lg-12 col-md-12 col-sm-12">
               <div class="Paging" id="Paging">
               
                  <div class="element">
                     <c:set var="page" value="${pageNo}" />

                     <!-- page maxpage를 넘었을 경우 제한 -->
                     <c:if test="${page > maxpage}">
                        <c:set var="page" value="${maxpage}" />
                     </c:if>

                     <!-- 페이지를 8개씩 나누기 위해 현재 페이지에 보여줄 max값 설정 -->
                     <fmt:formatNumber value="${page/4 - (page/4 % 1)}" type="pattern" pattern="0" var="full" />
                     <c:set var="full" value="${full * 4}" />

                     <!-- prev(전페이지), next(다음페이지) 개수 설정 -->
                     <c:set var="scope" value="${page%4}" />
                     <c:choose>
                        <c:when test="${scope == 0}">
                           <c:set var="prev" value="4" />
                           <c:set var="next" value="1" />
                        </c:when>
                        <c:when test="${scope < 5}">
                           <c:set var="prev" value="${scope}" />
                           <c:set var="next" value="${5-scope}" />
                        </c:when>
                     </c:choose>


                  <ul class="pagination p-center">
                   <li class="page-item">
                     <!-- prev 버튼 -->
                     <span class="ti-arrow-left"></span>
                     <c:if test="${page > 4}">
                        <fmt:formatNumber value="${(page-1)/4 - (((page-1)/4) % 1)}" type="pattern" pattern="0" var="prevb" />
                        <c:set value="${(prevb-1)*4 + 1}" var="prevb" />
                        <span id="prevBtn" class="prev button" value="${prevb}"><a class="page-link" href="#"onclick="getPaging('pdList', ${prevb});"> < </a></span>
                     </c:if>
                           </li>
                     <!-- 전 페이지 -->
                     <li class="page-item">
                     <c:if test="${page != 1}">
                        <c:set var="j" value="${prev}" />
                        <c:forEach var="i" begin="1" end="${prev-1}">
                           <c:set var="j" value="${j - 1}" />
                           <c:if test="${(page - j) > 0}">
                              <span class="no"><a  onclick="getPaging('pdList', ${page-j});">${page - j}</a></span>
                           </c:if>
                        </c:forEach>
                     </c:if>
                     </li>
                     <!-- 현재 페이지 -->
                     <li class="page-item active">
                        <span class="no selected">${page}</span>
                     </li>
                     <!-- 다음 페이지 -->
                     <li class="page-item">
                     <c:if test="${page != maxpage}">
                        <c:forEach var="i" begin="1" end="${next-1}">
                           <c:if test="${maxpage >= page+i}">
                              <span class="no"> <a id="pageLink" href="#" onclick="getPaging('pdList', ${page+i});">${page+i}</a></span>
                           </c:if>
                        </c:forEach>
                     </c:if>
                     </li>

                     <!-- next 버튼 -->
                     <li class="page-item">
                     <span class="ti-arrow-right"></span>
                     <c:if test="${maxpage >= page + next}">
                        <fmt:formatNumber value="${(page-1)/4 - (((page-1)/4) % 1)}" type="pattern" pattern="0" var="nextb" />
                        <c:set value="${(nextb+1)*4 + 1}" var="nextb" />
                        <span id="nextBtn" class="next button" value="${nextb}"> <a class="page-link" href="#" onclick="getPaging('pdList', ${nextb});"> > </a>
                        </span>
                     </c:if>
                     </li>
                     </ul>
                     
                  </div>
               </div>
</div>
               
            </div>

         </div>
      </div>
   </section>
   <!-- ============================ All Property ================================== -->
         
   <!-- ============================ Call To Action ================================== -->

   <!-- ============================ Call To Action End ================================== -->

   <!-- ============================ Footer Start ================================== -->

   <!-- ============================================================== -->
   <!-- End Wrapper -->
   <!-- ============================================================== -->

   <!-- ============================================================== -->
   <!-- All Jquery -->
   <!-- ============================================================== -->
   <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
   <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
   <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
   <script src="${pageContext.request.contextPath}/js/ion.rangeSlider.min.js"></script>
   <script src="${pageContext.request.contextPath}/js/select2.min.js"></script>
   <script src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
   <script src="${pageContext.request.contextPath}/js/slick.js"></script>
   <script src="${pageContext.request.contextPath}/js/slider-bg.js"></script>
   <script src="${pageContext.request.contextPath}/js/lightbox.js"></script>
   <script src="${pageContext.request.contextPath}/js/imagesloaded.js"></script>
   <script src="${pageContext.request.contextPath}/js/daterangepicker.js"></script>
   <script src="${pageContext.request.contextPath}/js/custom.js"></script>

   <!-- ============================================================== -->
   <!-- This page plugins -->
   <!-- ============================================================== -->


</body>
<%@ include file="../inc/bottom.jsp"%>