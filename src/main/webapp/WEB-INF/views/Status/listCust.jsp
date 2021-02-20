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
<title>고 객 현 황</title>
<style>
	input[type=text] {
		text-align: center;
	}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script>
	// 조회 버튼
	$(function(){
		$("#searchBtn").click(function(){
			/* $("#searchFrm").attr({"action":"searchList.do","method":"get"}).submit(); */
				// 페이지 이동시 select창이 풀려버림. -> ajax로 변경
			$.ajax({
				url:"searchList.do",
				data:$("#searchFrm").serialize(),
				type:"get",
				success: function(data) {
					alert("조회가 완료되었습니다.");
					$("#listFrm").html(data);
				},
				error: function(){
					alert("실패하였습니다.");
				}
			})
		})
	})
</script>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col" style="text-align: left">
			<input type="button" name="searchBtn" id="searchBtn" value="조회" class="btn btn-warning btn-sm"/>
		</div>
		
		<div class="col-6"style="text-align: center">
			<span class="badge badge-secondary" style="font-size: 25px;">고 객 현 황</span>
		</div>
		
		<div class="col" style="text-align: right">
			<input type="button" value="고객등록" onclick="location.href='addCust.do'" class="btn btn-default btn-sm"/>/
			<input type="button" value="고객조회" onclick="location.href='infoCust.do'" class="btn btn-default btn-sm"/>
		</div>
	</div><br /><br />

<form id="searchFrm" name="searchFrm">	
	<div class="row justify-content-around">
		<div class="col-3">
			<span class="badge badge-info" style="font-size: 17px; width:100px;">고객분류</span>
			<select name="custType" id="custType" style="margin-left: 11px; width: 70px;">
				<option value="all">전체</option>
				<option value="sales">영업</option>
				<option value="operation">운영</option>
				<option value="cancel">해지</option>
				<option value="perform">수행</option>
				<option value="cooperation">협력</option>
			</select>
		</div>
		
		<div class="col-9" >
			<span class="badge badge-info" style="font-size:17px; width:100px;">고객명</span>
			<input type="text" name="custName" id="custName" value="${custName }" style="margin-left: 11px">
		</div>
	</div><br />
</form>

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
</div>
</body>
</html>