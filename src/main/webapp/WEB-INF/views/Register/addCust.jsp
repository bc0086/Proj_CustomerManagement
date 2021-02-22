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
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/marioizquierdo-jquery.serializeJSON-62c1f45/jquery.serializejson.js"></script>

<script>
	$(function(){
		// 입력 버튼
		$("#insertBtn").on("click", function(){
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
				else { // 동적생성된 행 때문에 수동으로 배열을 만들어야 한다.
					var allFrm = $("#allFrm").serializeJSON(); // 한 줄만 생성됨
					var info = []; // 배열 생성					
					
					$("#detailTbody tr").each(function(index, item) { // 행만큼 반복수행
						var infoObj = {}; // Object 생성
						
						infoObj.custNo = $("#custNo").val();
						infoObj.manName = $(this).find("input").eq(0).val();
						infoObj.manTel = $(this).find("input").eq(1).val();
						infoObj.manEmail = $(this).find("input").eq(2).val();
						infoObj.manJob = $(this).find("input").eq(3).val();
						infoObj.selChk = $(this).find("input").eq(4).val();
						info.push(infoObj);
					});
					allFrm.info = info;
					console.log("insertCust", allFrm); // 일단 콘솔에서 확인
					
					// ajax로 비동기 처리하기
					$.ajax({
						type:"get",
						url:"insertCust.do",
						data: allFrm, // {} jsonObject type
						dataType:"json",
						contentType:"application/json; charset=utf-8",
						success:function(data){
							console.log("insertCust-callback",data);
						},
						error:function(request, status, error) {
							console.log(request, status, error);
						}
					});
					
					alert("입력 성공");
					
					// 입력완료 후 -> 페이지 이동하기
					location.href="addCust.do";
					
					// 입력완료 후 -> 고객번호 증가시키기
					var cNo = document.getElementById("custNo").value;
					cNo = parseInt(cNo) + 1;
					document.getElementById("custNo").value = cNo;
					
					/////////////////////////////////////////////////////////////
					// 성공확인 메세지 -> ajax쓰면 안먹힌다.
					if(getParameterByName("result")>0) {
						console.log("result :", getParameterByName("result"));
						alert("입력이 완료되었습니다.");
					};
					/////////////////////////////////////////////////////////////
				}
			} // /유효성 검사 
			else {
				alert("취소를 선택하셨습니다.");
			}
		})
		
		
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
		
		// 행 추가 사전작업 : 키 값 row로 테이블의 기본 row값의 html태그 저장
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
					//chkBox.eq(i).parent().parent().remove();//.cloest("부모엘리먼트선택자")
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
		//////////////////////////////////////////////////////////////////////////
		// /행 추가/삭제 관련													
		//////////////////////////////////////////////////////////////////////////
	});	
	
	// 파라미터값 리턴
		function getParameterByName(name) {
		    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		            results = regex.exec(location.search);
		    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
		}
	
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
<form name="allFrm" id="allFrm">	
<div class="container-sm">
	<div class="row">
		<div class="col-4" style="text-align: left">
			<input type="button" value="입력" name="insertBtn" id="insertBtn"/>
			<input type="button" value="초기화" name="resetBtn" id="resetBtn"/>
		</div>
		
		<div class="col-4"style="text-align: center">
			<span class="badge badge-secondary" style="font-size: 25px;">고 객 등 록</span>
		</div>
		
		<div class="col-4" style="text-align: right">
			<input type="button" value="고객현황" onclick="location.href='listCust.do'"/>
			<input type="button" value="고객조회" onclick="location.href='infoCust.do'"/>
		</div>
	</div><br /><br />
	

	<div class="row justify-content-around">
		<div class="col-4">
			<span class="badge badge-info" style="font-size: 17px; width:100px;" >고객번호</span>
			<input type="text" value="${nextNo }" name="custNo" id="custNo" style="margin-left: 11px;" readonly="readonly" />
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
		<input type="date" name="custRegDate" id="custRegDate" style="margin-left:11px; text-align: center; width:182px;"  />
	</div>
	
	<div>
		<span class="badge badge-info" style="font-size:17px; width:100px; margin-top: 10px;">담당자</span>
		<input type="text" name="custRegPerson" id="custRegPerson" style="margin-left:11px" />
	</div><br />
	
	<div class="row justify-content-around">
		<div class="col-8">
			<span class="badge badge-info" style="font-size:17px; width:100px;">고객명</span>
			<input type="text" name="custName" id="custName" style="margin-left:11px; width:550px;" />
		</div>
		
		<div class="col-4">	
			<span class="badge badge-info" style="font-size:17px; width:100px;">약명</span>
			<input type="text" name="custNameShort" id="custNameShort" style="margin-left:11px;" />
		</div>
	</div>
	
	<div>
		<span class="badge badge-info" style="font-size:17px; width:100px; margin-top: 10px;">주소</span>
		<input type="text" name="custAddr" id="custAddr" style="margin-left:11px; width:550px;" />
	</div>
	
	<div>
		<span class="badge badge-info" style="font-size:17px; width:100px; margin-top: 10px;">홈페이지</span>
		<input type="text" name="custHomepage" id="custHomepage" style="margin-left:11px; width:550px;" />
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
				
					<tr id="detailTr" name="detailTr">
						<td><input type="text" name="manName" id="manName" /></td>
						<td><input type="text" name="manTel" id="manTel" /></td>
						<td><input type="text" name="manEmail" id="manEmail" /></td>
						<td><input type="text" name="manJob" id="manJob" /></td>
						<td>
							<input type="checkbox" name="selChk" id="selChk"/>
						</td>
					</tr>
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
			<input type="text" name="custMemo" id="custMemo" style="margin-left:20px; width: 1010px; height:200px; margin-top: 10px;"/>
		</div>
	</div><br />
	
	<div class="row justify-content-around">
		<div class="col-5">
			<span class="badge badge-info" style="font-size: 17px; width:100px;">생성일</span>
			<input type="text" name="custCreateTime" id="custCreateTime" style="margin-left: 11px; width:300px;" readonly="readonly">
		</div>
		
		<div class="col-7" >
			<span class="badge badge-info" style="font-size:17px; width:100px;">수정일</span>
			<input type="text" name="custUpdateTime" id="custUpdateTime" style="margin-left: 11px; width:300px;" readonly="readonly">
		</div>
	</div>
</div>
</form>
</body>
</html>