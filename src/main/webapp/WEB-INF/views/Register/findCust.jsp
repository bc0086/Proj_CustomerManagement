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
<title>고 객 등 록</title>
<style>
	input[type=text] {
		text-align: center;
	}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script>
	$(function(){
		// 입력 버튼
		$("#insertBtn").click(function(){
			// 유효성 검사
			if(confirm("입력을 하시겠습니까?")) {
				var msg = "(필수항목 : 담당자, 고객명, 이름/소속, 전화번호)";
				
				if($("#custRegPerson").val()=='') {
					alert("담당자를 입력하세요. \n"+ msg);
					$("#custRegPerson").focus();
					return false;
				}
				else if($("#custName").val()=='') {
					alert("고객명을 입력하세요. \n"+ msg);
					$("#custName").focus();
					return false;
				} 
				else if($("#manName").val()=='') {
					alert("이름/소속을 입력하세요. \n" + msg);
					$("#manName").focus();
				}
				else if($("#manTel").val() == '') {
					alert("전화번호를 입력하세요. \n" + msg);
					$("#manTel").focus();
					return false;
				}
				else {
					var cNo = document.getElementById("custNo").value;
					
					cNo = parseInt(cNo) + 1;
					document.getElementById("custNo").value = cNo;
					alert("입력이 완료되었습니다.");
				}
			} // /유효성 검사 
			else {
				alert("취소를 선택하셨습니다.");
			}
		});
		
		
		
		
		// 조회 버튼
		$("#findBtn").click(function(){
			if($("#custName").val()=='' && $("#custNameShort").val()=='') {
				alert("조회하실 고객명 또는 약명을 입력하세요.");
				$("#custName").focus();
				return false;
			}
			else {
				alert("조회 완료");
				$("#allFrm").attr("action","findCust.do").attr("method","get").submit();	
			}
		});
		
		
		
		
		
		
		
		
		
		
		
		
		// 수정 버튼
		
		// 삭제 버튼
		$("#deleteBtn").click(function(){
			if(confirm("주의 : 삭제를 하시겠습니까?")) {
				var cNo = document.getElementById("custNo").value;
				
				if(cNo ==1) {
					alert("삭제 할 내용이 없습니다.");
					return;
				} 
				else {
					cNo = parseInt(cNo) - 1;
					document.getElementById("custNo").value = cNo;
					alert("삭제가 완료되었습니다.");
				}
			} else {
				alert("취소를 선택하셨습니다.");
			}
		});
		
		// 초기화 버튼
		$("#resetBtn").click(function(){
			$("#allFrm").each(function(){
				/* .each()메서드 : 매개변수로 받은것을 사용해 for in 반복문과 같이
					배열이나 객체의 요소를 검사할 수 있는 메서드 */
				this.reset();
			});
		});
	
		//////////////////////////////////////////////////////////////////////////
		// 행 추가/삭제 관련
		//////////////////////////////////////////////////////////////////////////
		
		// 키 값 row로 테이블의 기본 row값의 html태그 저장
		var row = $("table tbody").html(); 
		$("#detailTable").data("row", row); 
		
		// 행 추가 버튼
		$("#addRow").click(function(){
			$("table tbody").append($("#detailTable").data("row"));
				// row의 키 값으로 저장된 Html값 호출하여 테이블에 추가함
		});
		
		// 행 삭제 버튼
		$("#delRow").click(function(){
			if(confirm("정말로 삭제하시겠습니까?")) { 
				$("#detailTable > tbody > tr:last").remove(); 
				alert("삭제되었습니다.");
			} 
			else { 
				alert("취소되었습니다.");
				return false;
			}
		})
		
		// 선택 행 삭제 버튼
		$("#chkDelRow").click(function(){
			var chkBox = $("input[name='selChk']:checked")
			var chkCnt = chkBox.length;
			
			if (confirm("선택한 행을 삭제하시겠습니까?")){
				for(var i=0; i<chkCnt; i++) {
					chkBox.eq(i).parent().parent().remove();
						// eq() : 선택한 요소 중에서 전달받은 인덱스에 해당하는 요소를 선택
				}
				alert("삭제되었습니다.");
			} 
			else {
				alert("취소되었습니다.");
				return false;
			}
		})
		//////////////////////////////////////////////////////////////////////////
		// /행 추가/삭제 관련													
		//////////////////////////////////////////////////////////////////////////
	
		
	});	
	
	// 체크박스 전체선택/해제
	function selAllChk() {
		if($("#allChk").is(":checked")) {
			$("input[name=selChk]").prop("checked", true);
		}
		else {
			$("input[name=selChk]").prop("checked", false);
		}
	}
	
</script>
</head>
<body>

<div class="container-sm">
	<div class="row">
		<div class="col-4" style="text-align: left">
			<input type="button" value="조회" name="findBtn" id="findBtn"/>
			<input type="button" value="수정" />
			<input type="button" value="삭제" name="deleteBtn" id="deleteBtn"/>
			<input type="button" value="입력" name="insertBtn" id="insertBtn"/>
			<input type="button" value="초기화" name="resetBtn" id="resetBtn"/>
		</div>
		
		<div class="col-4"style="text-align: center">
			<span class="badge badge-secondary" style="font-size: 25px;">고 객 등 록</span>
		</div>
		
		<div class="col-4" style="text-align: right">
			<input type="button" value="현황" onclick="location.href='listCust.do'"/>
		</div>
	</div><br /><br />
	
<form name="allFrm" id="allFrm">
<c:forEach items="${findCust }" var="find" end="0" > 
	<div class="row justify-content-around">
		<div class="col-4">
			<span class="badge badge-info" style="font-size: 17px; width:100px;" >고객번호</span>
			<input type="text" value="${find.custNo }" name="custNo" id="custNo" style="margin-left: 11px;" readonly="readonly" />
		</div>
		
		<div class="col-8" >
			<span class="badge badge-info" style="font-size:17px; width:100px;">분류</span>
			<input type="text" name="custType" id="custType" value="${find.custType }" readonly="readonly"/>
		</div>
	</div><br />
	
	<div>
		<span class="badge badge-info" style="font-size:17px; width:100px;">일자</span>
		<input type="text" name="custRegDate" id="custRegDate" value="${find.custRegDate }" style="margin-left:11px; text-align: center; width:182px;"  />
	</div>
	
	<div>
		<span class="badge badge-info" style="font-size:17px; width:100px; margin-top: 10px;">담당자</span>
		<input type="text" name="custRegPerson" id="custRegPerson" value="${find.custRegPerson }" name="custRegPerson" id="custRegPerson" style="margin-left:11px" />
	</div><br />
	
	<div class="row justify-content-around">
		<div class="col-8">
			<span class="badge badge-info" style="font-size:17px; width:100px;">고객명</span>
			<input type="text" name="custName" id="custName" value="${find.custName }" style="margin-left:11px; width:550px;" />
		</div>
		
		<div class="col-4">	
			<span class="badge badge-info" style="font-size:17px; width:100px;">약명</span>
			<input type="text" name="custNameShort" id="custNameShort" value="${find.custNameShort }" style="margin-left:11px;" />
		</div>
	</div>
	
	<div>
		<span class="badge badge-info" style="font-size:17px; width:100px; margin-top: 10px;">주소</span>
		<input type="text" name="custAddr" id="custAddr" value="${find.custAddr }" style="margin-left:11px; width:550px;" />
	</div>
	
	<div>
		<span class="badge badge-info" style="font-size:17px; width:100px; margin-top: 10px;">홈페이지</span>
		<input type="text" name="custHomepage" id="custHomepage" value="${find.custHomepage }"style="margin-left:11px; width:550px;" />
	</div><br />
	
	<div class="row">
		<div class="col-1">
			<span class="badge badge-info" style="font-size:17px; width:100px; ">전화</span>
		</div>
		
		<div class="col-10">
			<table  id="detailTable" name="detailTable" class="table table-bordered table-sm table-hover" style="text-align:center; margin-left:20px;">
				<thead class="thead-dark">
					<tr>
						<th style="width: 25%">이름/소속</th>
						<th style="width: 25%">전화번호</th>
						<th style="width: 25%">이메일</th>
						<th style="width: 20%">업무</th>
						<th style="width: 5%">
							<input type="checkbox" name="allChk" id="allChk" onClick="selAllChk()"/>
						</th>
					</tr>
				</thead>
				
				<tbody>
				<c:forEach items="${findCust }" var="detail" >
					<tr >
						<td><input type="text" name="manName" id="manName" value="${detail.manName}"/></td>
						<td><input type="text" name="manTel" id="manTel" value="${detail.manTel}"/></td>
						<td><input type="text" name="manEmail" id="manEmail" value="${detail.manEmail }"/></td>
						<td><input type="text" name="manJob" id="manJob" value="${detail.manJob }"/></td>
						<td>
							<input type="checkbox" name="selChk" id="selChk"/>
						</td>
					</tr>
				</c:forEach>
				</tbody>
				<tr>
					<td></td>
				</tr>
			</table>
			
		</div>
		
		<div class="col-1">
			<input type="button" value="선택 삭제" name="chkDelRow" id="chkDelRow" class="btn btn-danger btn-sm" style="width:100px;"/>
			<input type="button" value="1행 삭제" name="delRow" id="delRow" class="btn btn-danger btn-sm" style="width: 100px; margin-top: 5px;"/>
			<input type="button" value="1행 삽입" name="addRow" id="addRow" class="btn btn-success btn-sm" style="width: 100px; margin-top: 5px;"/>
		</div>
		
	</div>
	
	<div class="row">
		<div class="col-1">
			<span class="badge badge-info" style="font-size:17px; width:100px; margin-top: 10px;">내용</span>
		</div>
		<div class="col-11">
			<input type="text" value="${find.custMemo }" style="margin-left:20px; width: 1010px; height:200px; margin-top: 10px;"/>
		</div>
	</div><br />
	
	<div class="row justify-content-around">
		<div class="col-5">
			<span class="badge badge-info" style="font-size: 17px; width:100px;">생성일</span>
			<input type="text" name="custCreateTime" id="custCreateTime" value="${find.custCreateTime }" style="margin-left: 11px; width:300px;" readonly="readonly">
		</div>
		
		<div class="col-7" >
			<span class="badge badge-info" style="font-size:17px; width:100px;">수정일</span>
			<input type="text" name="custUpdateTime" id="custUpdateTime" value="${find.custUpdateTime }"style="margin-left: 11px; width:300px;" readonly="readonly">
		</div>
	</div>
</c:forEach >	
</form>
</div>
</body>
</html>