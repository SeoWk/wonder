<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-lg-12 col-md-12 col-sm-12">
	<ul class="pagination p-center">
		<c:if test="${pagingInfo.firstPage>1}">
			<li class="page-item"><a class="page-link" href="#"
				aria-label="Previous" onclick="pageProc(${pagingInfo.firstPage-1})">
					<span class="ti-arrow-left"></span> <span class="sr-only">Previous</span>
			</a></li>
		</c:if>
		<c:forEach var="i" begin="${pagingInfo.firstPage}"
			end="${pagingInfo.lastPage}">
			<c:if test="${i==pagingInfo.currentPage}">
				<li class="page-item active"><a class="page-link" href="#">${i}
				</a></li>
			</c:if>
			<c:if test="${i!=pagingInfo.currentPage}">
				<li class="page-item"><a class="page-link" href="#"
					onclick="pageProc(${i })">${i} </a></li>
			</c:if>
		</c:forEach>
		<c:if test="${pagingInfo.lastPage < pagingInfo.totalPage}">
			<li class="page-item"><a class="page-link" href="#"
				aria-label="Next" onclick="pageProc(${pagingInfo.lastPage+1})">
					<span class="ti-arrow-right"></span> <span class="sr-only">Next</span>
			</a></li>
		</c:if>
	</ul>
</div>




