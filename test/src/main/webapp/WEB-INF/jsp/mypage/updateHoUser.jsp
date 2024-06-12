<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원정보수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function updatePwd(frm) {
	const hosIdx = frm.hosIdx.value;
	location.href = "updateHoPwd.do?hosIdx=" + hosIdx;
}

function hoUserUpdate_ok(frm) {
	return confirm("수정하시겠습니까?")
}


	//평일 점심시간 없음 처리
	//$('#toggleWeekdayLunch')버튼 클릭 시, true은 input 요소 none(안보이는 상태)
	//false는 input 요소 block(보이는 상태)
	var WeekdayToggled = true;
	$('#toggleWeekdayLunch').on('click', function(){
		if (WeekdayToggled) {
			$('#tdWeekday').css({
	            'display': 'none'
			});
		} else {
         $('#tdWeekday').css({
         	'display': 'inline-block'
         });
		}
		WeekdayToggled = !WeekdayToggled;
	});

	//토요일 점심시간 없음 처리
	//$('#toggleSatLunch')버튼 클릭 시, true은 input 요소 none(안보이는 상태)
	//false는 input 요소 block(보이는 상태)
	var SatToggled = true;
	$('#toggleSatLunch').on('click', function(){
		if (SatToggled) {
			$('#tdsatLunch').css({
	            'display': 'none'
			});
		} else {
         $('#tdsatLunch').css({
         	'display': 'inline-block'
         });
		}
		SatToggled = !SatToggled;
	});
	
	//일요일 점심시간 없음 처리
	//$('#toggleSunLunch')버튼 클릭 시, true은 input 요소 none(안보이는 상태)
	//false는 input 요소 block(보이는 상태)
	var SunToggled = true;
	$('#toggleSunLunch').on('click', function(){
		if (SunToggled) {
			$('#spanSunLunch').css({
	            'display': 'none'
			});
		} else {
         $('#spanSunLunch').css({
         	'display': 'inline-block'
         });
		}
		SunToggled = !SunToggled;
	});

	//일요일 휴무 처리
	document.getElementById('toggleSunOff').addEventListener('click', function(){
		var tdSun = document.getElementById('sun');
		var inputs = tdSun.getElementsByTagName('input');
	
		if (tdSun.style.display === 'none') {
			tdSun.style.display = 'block';
			//하위 input 요소 표시
			for (var i = 0; i < inputs.length; i++) {
				inputs[i].style = '';
			}
		} else {
			//하위 input 요소 숨김
			tdSun.style.display = 'none';
			for (var i = 0; i < inputs.length; i++) {
				inputs[i].style.display = 'none';
			}
		}
	});



//카카오 지도 API 사용
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}
</script>
</head>
<body>
<h1>병원정보수정</h1>
${hoUser }
<form name="hoUserUpdateForm" action="updateHoUser.do" method="post">
	<table>
		<tr>
			<td>병원아이디</td>
			<td>
				<input type="text" name="hosId" value="${hoUser.hosId }" readonly>
			</td>
		</tr>
		<tr>
			<td>병원비번</td>
			<td>
				<input type="text" name="hosPw" value="${hoUser.hosPw }" readonly>
			</td>
			<td>
			<input type="button" value="비밀번호 변경" onclick="updatePwd(document.hoUserUpdateForm)">
			</td>
		</tr>
		<tr>
			<td>병원이름</td>
			<td>
				<input type="text" name="hosName" value="${hoUser.hosName }">
			</td>
		</tr>
		<tr>
			<td>병원 연락처</td>
			<td>
				<input type="text" name="hosPhone" value="${hoUser.hosPhone }">
			</td>
		</tr>
		<tr>
			<td>분류</td>
			<td>
				<input type="text" name="animal" value="${hoUser.animal }" readonly>
			</td>
		</tr>
		<tr>
			<td>평점</td>
			<td>
				<input type="text" name="score" value="${hoUser.score }" readonly>
			</td>
		</tr>
		<tr>
		<th>주소</th>
		<td>
			<input type="text" id="sample4_postcode" title="우편번호" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="sample4_roadAddress" name="roadAddressName" title="도로명주소" placeholder="도로명주소" value="${hoUser.roadAddressName }">
			<input type="text" id="sample4_jibunAddress" name="addressName" title="지번주소" placeholder="지번주소" value="${hoUser.addressName }"><br>
			<input type="text" id="sample4_detailAddress" name="detailAddress" title="상세주소" placeholder="상세주소" value="${hoUser.detailAddress }">
			<input type="text" id="sample4_extraAddress" title="참고항목" placeholder="참고항목">
			<span id="guide" style="color:#999;display:none"></span>
		</td>
		</tr>
<!-- 		<tr> -->
<!-- 		<th rowspan="3">운영시간</th> -->
<!-- 		<td>주중<br> -->
<%-- 			운영시간 <input type="time" title="주중 시작시간" id="openTimeStr" name="openTimeStr" value="${hoUser.openTime }">  --%>
<%-- 				~ <input type="time" title="주중 마감시간" name="closeTimeStr" value="${hoUser.closeTime }"><br> --%>
<%-- 			점심시간 <input type="time" title="주중 점심 시작시간" name="lunchTimeStr" value="${hoUser.lunchTime }">  --%>
<%-- 				~ <input type="time" title="주중 점심 마감시간" name="endLunchTimeStr" value="${hoUser.endLunchTime }"><br> --%>
<!-- 		</td> -->
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>토요일<br> -->
<%-- 			운영시간 <input type="time" title="토요일 시작시간" name="satOpenTimeStr" value="${hoUser.satOpenTime }">  --%>
<%-- 				~ <input type="time" title="토요일 마감시간" name="satCloseTimeStr" value="${hoUser.satCloseTime }"><br> --%>
<%-- 			점심시간 <input type="time" title="토요일 점심 시작시간" name="satLunchTimeStr" value="${hoUser.satLunchTime }">  --%>
<%-- 				~ <input type="time" title="토요일 점심 마감시간" name="satEndLunchTimeStr" value="${hoUser.satEndLunchTime }"><br> --%>
<!-- 		</td> -->
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>일요일<br> -->
<%-- 			운영시간 <input type="time" title="일요일 시작시간" name="sunOpenTimeStr" value="${hoUser.sunOpenTime}">  --%>
<%-- 				~ <input type="time" title="일요일 마감시간" name="sunCloseTimeStr" value="${hoUser.sunOpenTime}"><br> --%>
<%-- 			점심시간 <input type="time" title="일요일 점심 시작시간" name="sunLunchTimeStr" value="${hoUser.sunLunchTime}">  --%>
<%-- 				~ <input type="time" title="일요일 점심 마감시간" name="sunEndLunchTimeStr" value="${hoUser.sunEndLunchTime}"><br> --%>
<!-- 		</td> -->
<!-- 	</tr> -->
<!-- 	<tr> -->
<%-- 		<td><input type="hidden" name="hosIdx" value="${hoUser.hosIdx }"></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td> -->
<!-- 			<input type="submit" value="병원정보수정" onclick="hoUserUpdate_ok(this.form)"> -->
<!-- 		</td> -->
<!-- 	</tr> -->
<!-- 		점심시간 없음/주말 휴무 처리 -->
		<tr>
		<th rowspan="8">운영시간</th>
		<td>
			평일 : <input type="checkbox" id="toggleWeekdayLunch" name="lunchOff" value="Y">점심 없음<br>
		</td>
	</tr>
	<tr>
		<td>
			진료시간 <input type="time" title="주중 시작시간" name="openTimeStr" value="${hoUser.openTime }"> 
				~ <input type="time" title="주중 마감시간" name="closeTimeStr" value="${hoUser.closeTime }">
		</td>
	</tr>
	<tr>
		<td id="tdWeekday">
			점심시간 <input type="time" title="주중 점심 시작시간" name="lunchTimeStr" value="${hoUser.lunchTime }"> 
				~ <input type="time" title="주중 점심 마감시간" name="endLunchTimeStr" value="${hoUser.endLunchTime }">
		</td>
	</tr>
	<tr>
		<td>
			토요일 : <input type="checkbox" id="toggleSatLunch" name="satLunchOff" value="Y">점심 없음 <br>
		</td>
	</tr>
	<tr>
		<td id="tdsatLunch">
			진료시간 <input type="time" title="토요일 시작시간" name="satOpenTimeStr" value="${hoUser.satOpenTime }"> 
				~ <input type="time" title="토요일 마감시간" name="satCloseTimeStr" value="${hoUser.satCloseTime }">
		</td>
	</tr>
	<tr>
		<td>
			점심시간 <input type="time" title="토요일 점심 시작시간" name="satLunchTimeStr" value="${hoUser.satLunchTime }"> 
				~ <input type="time" title="토요일 점심 마감시간" name="satEndLunchTimeStr" value="${hoUser.satEndLunchTime }">
		</td>
	</tr>
	<tr>
		<td>
			일요일 : <input type="checkbox" id="toggleSunOff" name="sunDayOff" value="Y">휴무 
				<input type="checkbox" id="toggleSunLunch" name="sunLunchOff" value="Y">점심 없음 <br>
		</td>
	</tr>
	<tr>
		<td id="sun">
			진료시간 <input type="time" title="일요일 시작시간" name="sunOpenTimeStr" value="${hoUser.sunOpenTime}"> 
				~ <input type="time" title="일요일 마감시간" name="sunCloseTimeStr" value="${hoUser.sunOpenTime}"><br>
			<span id="spanSunLunch">
			점심시간 <input type="time" class="lunch" title="일요일 점심 시작시간" name="sunLunchTimeStr" value="${hoUser.sunLunchTime}"> 
				~ <input type="time" class="lunch" title="일요일 점심 마감시간" name="sunEndLunchTimeStr" value="${hoUser.sunEndLunchTime}"><br>
			</span>
	</td>
	</tr>
	<tr>
		<td><input type="hidden" name="hosIdx" value="${hoUser.hosIdx }"></td>
	</tr>
	<tr>
		<td>
			<input type="submit" value="병원정보수정" onclick="hoUserUpdate_ok(this.form)">
		</td>
	</tr>
		</table>
	</form>
</body>
</html>