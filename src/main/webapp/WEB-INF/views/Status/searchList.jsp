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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="listFrm" id="listFrm">
	<div>
		<table class="table table-bordered table-sm table-hover" style="text-align: center" >
			<thead class="thead-dark">
				<tr>
					<th style="width: 10%">고객번호</th>
					<th style="width: 5%">분류</th>
					<th style="width: 25%">고객명</th>
					<th style="width: 10%">고객약명</th>
					<th style="width: 10%">담당자</th>
					<th style="width: 15%">이름/소속</th>
					<th style="width: 15%">전화번호</th>
					<th style="width: 10%">업무</th>
				</tr>
			</thead>
			
			<c:forEach items="${allList }" var="all">			
				<tr>
					<td>${all.custNo }</td>
					<td>${all.custType }</td>
					<td>${all.custName }</td>
					<td>${all.custNameShort }</td>
					<td>${all.custRegPerson }</td>
					<td>${all.manName }</td>
					<td>${all.manTel }</td>
					<td>${all.manJob }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</form>	
</body>
</html>