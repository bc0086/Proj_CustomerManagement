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
<title>고 객 조 회</title>
<style>
	input[type=text] {
		text-align: center;
	}
</style>
<link rel="stylesheet" href="${contextPath }/resources/css/bootstrap.min.css">
<script src="${contextPath }/resources/js/jquery-3.5.1.min.js"></script>
<script src="${contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${contextPath }/resources/marioizquierdo-jquery.serializeJSON-62c1f45/jquery.serializejson.js"></script>
<script>
	$(function(){
		// 조회 버튼
		$("#findBtn").click(function(){
			if($("#searchCustNo").val()=='' 
					&& $("#searchCustName").val()=='' 
					&& $("#searchCustNameShort").val()=='') {
				alert("조회하실 고객의 정보 중 1가지를 입력하세요.");
				$("#searchCustNo").focus();
				return false;
			}
			if($("#searchCustNo").val() != '' && $("#searchCustName").val() != '') {
				alert("정확성을 위해서 고객의 정보 중 1가지만 입력하세요.");
				return false;
			}
			if($("#searchCustNo").val() != '' && $("#searchCustNameShort").val() != '') {
				alert("정확성을 위해서 고객의 정보 중 1가지만 입력하세요.");
				return false;
			}
			if($("#searchCustName").val() != '' && $("#searchCustNameShort").val() != '') {
				alert("정확성을 위해서 고객의 정보 중 1가지만 입력하세요.");
				return false;
			}
			else {
				$("#searchFrm").attr("action","findCust.do").attr("method","get").submit();
				alert("조회 완료");
			}
		});
		
		
		// 수정 버튼
		$("#updateBtn").on("click", function(){
			if(confirm("주의 : 수정하시겠습니까?")) {
				var allFrm = $("#allFrm").serializeJSON(); // 한줄만 생성됨
				var info =[]; // 수동으로 배열생성
				
				$("#detailTbody tr").each(function(index, item) { // 행만큼 반복수행
					var infoObj = {}; // Objext 생성
					
					infoObj.custNo = $("#custNo").val();
					infoObj.manName = $(this).find("input").eq(0).val();
					infoObj.manTel = $(this).find("input").eq(1).val();
					infoObj.manEmail = $(this).find("input").eq(2).val();
					infoObj.manJob = $(this).find("input").eq(3).val();
					infoObj.selChk = $(this).find("input").eq(4).val();
					info.push(infoObj);
				});
				
				allFrm.info = info;
				console.log("updateCust", allFrm); // 일단 콘솔에서 확인
				
				$.ajax({
					type:"get",
					url:"updateCust.do",
					data: allFrm, // {} jsonObject type
					dataType:"json",
					contentType:"application/json; charset=utf-8",
					success:function(data) {
						console.log("updateCust-callback", data);
					},
					error:function(request, status, error) {
						console.log(request, status, error);
					}
				});
				alert("수정 완료");
				return flase;
			}
			else {
				alert("수정 취소");
				return false;
			}
		});
		
		
		// 삭제 버튼
		$("#deleteBtn").click(function(){
			if(confirm("주의 : 삭제하시겠습니까?")) {
				$.ajax({
					type:"get",
					url:"deleteCust.do",
					data:$("#allFrm").serialize(),
					dataType:"json",
					success : function(data) {
						if(data == 0) {
							alert("삭제 실패");
						}
						else {
							alert("삭제 성공");
							location.href="infoCust.do";
						}
					},
					error: function(){
						alert("서버통신 오류");
					}
				});
			}
			else {
				alert("삭제 취소");
				return false;
			}
		});
		
		
		// 삭제 시 고객번호 감소하는 기능
		/* 	if(confirm("주의 : 삭제를 하시겠습니까?")) {
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
			} 
			else {
				alert("취소를 선택하셨습니다.");
			} */
		
		
		// 초기화 버튼
		$("#resetBtn").click(function(){
			$("#searchFrm").each(function(){ 
				/* .each()메서드 : 매개변수로 받은것을 사용해 for in 반복문과 같이
					배열이나 객체의 요소를 검사할 수 있는 메서드 */
				this.reset();
			});
		});
	
		//////////////////////////////////////////////////////////////////////////
		// 행 추가/삭제 관련
		//////////////////////////////////////////////////////////////////////////
		
		// 행 추가 사전작업 : addCust에서와는 달리 데이터가 입력된 상태이기 때문에 .html 사용 불가
		var rowItem = "<tr>"
		rowItem += "<td><input type='text' name='manName' id='manName' /></td>"
		rowItem += "<td><input type='text' name='manTel' id='manTel' /></td>"
		rowItem += "<td><input type='text' name='manEmail' id='manEmail' /></td>"
		rowItem += "<td><input type='text' name='manJob' id='manJob' /></td>"
		rowItem += "<td><input type='checkbox' name='selChk' id='selChk'/></td>"
		rowItem += "</tr>"
		
		// 행 추가 버튼
		$("#addRow").click(function(){
			$('#detailTable').append(rowItem);
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
					//chkBox.eq(i).parent().parent().remove(); -> closet()이랑 같은 효과
					chkBox.eq(i).closet().remove();
						// eq() : 선택한 요소 중에서 전달받은 인덱스에 해당하는 요소를 선택
				}
				alert("삭제되었습니다.");
			} 
			else {
				alert("취소되었습니다.");
				return false;
			}
		})
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
<!-- 상단공통 -->
	<div class="row">
		<div class="col-4" style="text-align: left">
			<input type="button" value="조회" name="findBtn" id="findBtn" class="btn btn-warning btn-sm"/>
			<input type="button" value="수정" name="updateBtn" id="updateBtn" class="btn btn-warning btn-sm"/>
			<input type="button" value="삭제" name="deleteBtn" id="deleteBtn" class="btn btn-warning btn-sm"/>			
			<input type="button" value="초기화" name="resetBtn" id="resetBtn" class="btn btn-warning btn-sm"/>
		</div>
		
		<div class="col-4"style="text-align: center">
			<span class="badge badge-secondary" style="font-size: 25px;">고 객 조 회</span>
		</div>
		
		<div class="col-4" style="text-align: right">
			<input type="button" value="고객현황" onclick="location.href='listCust.do'" class="btn btn-default btn-sm"/>/
			<input type="button" value="고객등록" onclick="location.href='addCust.do'" class="btn btn-default btn-sm"/>
		</div>
	</div><br /><br />
	
<!-- 조회목록창 -->
	<h3 style="text-align: center;">찾으실 고객 정보를 입력해주세요</h3>
<form name="searchFrm" id="searchFrm">
	<div><!-- 한 페이지에 id는 한 개만.... -->
		<span class="badge badge-primary" style="font-size: 17px; width:100px;" >고객번호</span>
		<input type="text" name="searchCustNo" id="searchCustNo" style="margin-left: 11px;"/>
	</div>

	<div class="row justify-content-around">
		<div class="col-8">
			<span class="badge badge-primary" style="font-size:17px; width:100px; margin-top: 10px;">고객명</span>
			<input type="text" name="searchCustName" id="searchCustName" style="margin-left:11px; width:550px;" />
		</div>
		
		<div class="col-4">	
			<span class="badge badge-primary" style="font-size:17px; width:100px; margin-top: 10px;">약명</span>
			<input type="text" name="searchCustNameShort" id="searchCustNameShort" style="margin-left:11px;" />
		</div>	
	</div><br /><br /><br /><br />
</form>	

<!-- 조회결과창 -->
<form name="allFrm" id="allFrm">
<c:choose>
	<c:when test="${not empty findCust}">
		<c:forEach items="${findCust }" var="find" end="0" >
			<div style="text-align: center">
				<span class="badge badge-secondary" style="font-size: 25px;">조 회 결 과</span>
			</div><br />
			
			<div class="row justify-content-around">
				<div class="col-4">
					<span class="badge badge-info" style="font-size: 17px; width:100px;" >고객번호</span>
					<input type="text" value="${find.custNo }" name="custNo" id="custNo" style="margin-left: 11px;" />
				</div>
				
				<div class="col-8" >
					<span class="badge badge-info" style="font-size:17px; width:100px;">분류</span>
					<select name="custType" id="custType" style="margin-left: 11px; width: 70px;">
						<option value="전체">전체</option>
						<option value="영업">영업</option>
						<option value="운영">운영</option>
						<option value="해지">해지</option>
						<option value="수행">수행</option>
						<option value="협력">협력</option>
					</select>
				</div>
			</div><br />
			
			<div>
				<span class="badge badge-info" style="font-size:17px; width:100px;">일자</span>
				<input type="date" name="custRegDate" id="custRegDate" value="${find.custRegDate }" style="margin-left:11px; text-align: center; width:182px;"  />
			</div>
			
			<div>
				<span class="badge badge-info" style="font-size:17px; width:100px; margin-top: 10px;">담당자</span>
				<input type="text" name="custRegPerson" id="custRegPerson" value="${find.custRegPerson }" style="margin-left:11px" />
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
				<input type="text" name="custHomepage" id="custHomepage" value="${find.custHomepage }" style="margin-left:11px; width:550px;" />
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
						
						<tbody id="detailTbody" name="detailTbody">
						<c:forEach items="${findCust }" var="detail" >
							<tr id="detailTr" name="detailTr">
								<td><input type="text" name="manName" id="manName" value="${detail.manName }" /></td>
								<td><input type="text" name="manTel" id="manTel" value="${detail.manTel }"/></td>
								<td><input type="text" name="manEmail" id="manEmail" value="${detail.manEmail }" /></td>
								<td><input type="text" name="manJob" id="manJob" value="${detail.manJob }" /></td>
								<td>
									<input type="checkbox" name="selChk" id="selChk"/>
								</td>
							</tr>
						</c:forEach>
						</tbody>
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
					<input type="text" name="custMemo" id="custMemo" value="${find.custMemo }" style="margin-left:20px; width: 1010px; height:200px; margin-top: 10px;"/>
				</div>
			</div><br />
			
			<div class="row justify-content-around">
				<div class="col-5">
					<span class="badge badge-info" style="font-size: 17px; width:100px;">생성일</span>
					<input type="text" name="custCreateTime" id="custCreateTime" value="${find.custCreateTime }" style="margin-left: 11px; width:300px;" readonly="readonly">
				</div>
				
				<div class="col-7" >
					<span class="badge badge-info" style="font-size:17px; width:100px;">수정일</span>
					<input type="text" name="custUpdateTime" id="custUpdateTime" value="${find.custUpdateTime }" style="margin-left: 11px; width:300px;" readonly="readonly">
				</div>
			</div><br /><br /><br />
		</c:forEach>
	</c:when>
	
	<c:when test="${empty findCust}">
	 	<p style="text-align: center">
			<img src="${contextPath }/resources/images/data_none.png">
		</p>
	</c:when>
</c:choose>
</form>
</div>
</body>
</html>