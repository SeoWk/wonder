<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>message</title>
</head>
<body>
<script type="text/javascript" src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
	<script type="text/javascript">
		$(function(){
			alert("${msg}");
			$(opener.location).attr("href", "<c:url value='${url}'/>");
			self.close();
		});
	</script>
</body>
</html>