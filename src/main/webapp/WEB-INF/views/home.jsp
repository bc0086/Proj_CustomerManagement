<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="java.util.*"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<html>
<head>
<title>Home</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
	<div style="border: 1px solid red; text-align: center;">
		<h1>안녕하세요. 환영합니다.</h1>
		<P>The time on the server is ${serverTime}.</P>
	</div>
	<br /><br /><br /><br /><br />
	
	<div class="row justify-content-around">
		<div class="col-4" style="border: 1px solid red">
			<h3 style="text-align: center">개발환경</h3>
		</div>
		
		<div class="col-4" style="border: 1px solid red">
			<h3 style="text-align: center">바로가기</h3>
			<a href="${contextPath }/listCust.do">고객등록으로 이동합니다.</a>
		</div>
	</div>
	
</div>
</body>
</html>