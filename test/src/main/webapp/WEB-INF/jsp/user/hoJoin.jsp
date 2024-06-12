<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>병원 회원가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	function check_pwd(frm) {
		var pwd = frm.hosPw.value;
		var checkPwd = frm.pwdCheck.value;
		
		if(pwd != checkPwd) {
			alert("비밀번호가 일치하지 않습니다.");
			frm.pwdCheck.value="";
			return false;
		}
		return true;
	}
	
	var isCheckDup = false;
	
	function checkDup(frm) {
		var checkDup = frm.hosId.value;
		if (checkDup.trim().length == 0) {
			alert("아이디를 입력해주세요");
			return false;
		}
		var hosId = $('#hosId').val();
		$.ajax({
			url:'hosId.do',
			type:'POST',
			data: JSON.stringify ({ "hosId" : $("#hosId").val() }),
// 			data: JSON.stringify(vo),
			contentType: "application/json",
			dataType: "json",
			success:function(data){
				if (data == 1){
// 					$('#email').val(1);
					alert("이미 사용중인 아이디입니다.");
					isCheckDup = false;
					
				} else if (data == 0){
// 					$('#email').val(0);
					alert("사용 가능한 아이디입니다.");
					isCheckDup = true;
					
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
	            alert("Ajax 처리 실패:\n" +
	                      "jqXHR.readyState: " + jqXHR.readyState + "\n" +
	                      "textStatus: " + textStatus + "\n" +
	                      "errorThrown: " + errorThrown);
	         }
		});
	};
	
	function oninputPhone(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
	}
	
	var isCheckDup = false;
	
	function hosJoin_ok(frm) {
			
			console.log(document.forms[0]);
			let firstForm = document.forms[0];
			console.log(firstForm.elements);
			
			for (let htmlObj of firstForm.elements) {
				if (htmlObj.value.trim() == "") {
					console.log(htmlObj);
					if (htmlObj.getAttribute("title") == "상세주소") continue;
					if (htmlObj.getAttribute("title") == "참고항목") continue;
					if (htmlObj.getAttribute("title") == "병원 사진") continue;
					if (htmlObj.getAttribute("name") == "lunchOff") continue;
					if (htmlObj.getAttribute("name") == "satLunchOff") continue;
					if (htmlObj.getAttribute("name") == "sunDayOff") continue;
					if (htmlObj.getAttribute("name") == "sunLunchOff") continue;
					if(htmlObj.title == "사업자 등록증") {
						alert(htmlObj.title + " 업로드 하세요");
						htmlObj.focus();
					} else {
						alert(htmlObj.title + " 입력하세요");
						htmlObj.focus();
					}
					return;
				}
			}
			
			if(!isCheckDup) {
				alert("아이디 중복체크를 먼저 해주세요.");
				return;
			}
			//병원 회원 가입 및 시간(0~23) 유효성 검사
			frm.action="hoJoin.do";
			
			//alert($('#openTimeStr').val());
			frm.submit();
		}
	
	window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const msg = urlParams.get('msg');
        if (msg === 'fail') {
            alert('회원가입 실패했습니다.');
        } else if (msg === 'fileError') {
        	alert('파일 업로드 중 오류가 발생했습니다.\n다시 시도하세요!');
        } else if (msg === 'noFile') {
        	alert('업로드된 파일이 없습니다.\n다시 시도하세요!');
        } 
    }
	
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
<h1>병원회원가입</h1>
<form method="post" enctype="multipart/form-data">
<table border="">
	<tr>
		<th>아이디</th>
		<td>
			<input type="text" id="hosId" title="아아디" name="hosId" value="${hospitalVO.hosId }">
			<input type="button" value="중복확인" onclick="checkDup(this.form)"/>
		</td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" title="비밀번호" name="hosPw" value="${hospitalVO.hosPw }"></td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td><input type="password" title="비밀번호 확인" name="pwdCheck" value="${hospitalVO.hosPw }" onblur="check_pwd(this.form)"></td>
	</tr>
	<tr>
		<th>병원명</th>
		<td><input type="text" title="병원명" name="hosName" value="${hospitalVO.hosName }"></td>
	</tr>
	<tr>
<!-- 		지번 입력하여 시도,시도군 분리하여 insert 처리 -->
		<th>주소</th>
		<td>
			<input type="text" id="sample4_postcode" title="우편번호" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="sample4_roadAddress" name="roadAddressName" title="도로명주소" placeholder="도로명주소">
			<input type="text" id="sample4_jibunAddress" name="addressName" title="지번주소" placeholder="지번주소"><br>
			<input type="text" id="sample4_detailAddress" name="detailAddress" title="상세주소" placeholder="상세주소">
			<input type="text" id="sample4_extraAddress" title="참고항목" placeholder="참고항목">
			<span id="guide" style="color:#999;display:none"></span>
		</td>
	</tr>
	<tr>
<!-- 		점심시간 없음/주말 휴무 처리 -->
		<th rowspan="8">진료시간</th>
		<td>
			평일 : <input type="checkbox" id="toggleWeekdayLunch" name="lunchOff" value="Y">점심 없음<br>
		</td>
	</tr>
	<tr>
		<td>
			진료 <input type="time" title="주중 시작시간" name="openTimeStr" value="00:00"> 
				~ <input type="time" title="주중 마감시간" name="closeTimeStr" value="00:00">
		</td>
	</tr>
	<tr>
		<td id="tdWeekday">
			점심 <input type="time" title="주중 점심 시작시간" name="lunchTimeStr" value="00:00"> 
				~ <input type="time" title="주중 점심 마감시간" name="endLunchTimeStr" value="00:00">
		</td>
	</tr>
	<tr>
		<td>
			토요일 : <input type="checkbox" id="toggleSatLunch" name="satLunchOff" value="Y">점심 없음 <br>
		</td>
	</tr>
	<tr>
		<td>
			진료 <input type="time" title="토요일 시작시간" name="satOpenTimeStr" value="00:00"> 
				~ <input type="time" title="토요일 마감시간" name="satCloseTimeStr" value="00:00">
		</td>
	</tr>
	<tr>
		<td id="tdsatLunch">
			점심 <input type="time" title="토요일 점심 시작시간" name="satLunchTimeStr" value="00:00"> 
				~ <input type="time" title="토요일 점심 마감시간" name="satEndLunchTimeStr" value="00:00">
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
			진료 <input type="time" title="일요일 시작시간" name="sunOpenTimeStr" value="00:00"> 
				~ <input type="time" title="일요일 마감시간" name="sunCloseTimeStr" value="00:00"><br>
			<span id="spanSunLunch">
			점심 <input type="time" class="lunch" title="일요일 점심 시작시간" name="sunLunchTimeStr" value="00:00"> 
				~ <input type="time" class="lunch" title="일요일 점심 마감시간" name="sunEndLunchTimeStr" value="00:00"><br>
			</span>
<script>
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
</script>
		</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td><input type="tel" title="전화번호" name="hosPhone" value="${hospitalVO.hosPhone }" oninput="oninputPhone(this)"></td>
	</tr>
	<tr>
		<th>병원 외/내부사진</th>
		<td><input type="file" title="병원 사진" name="hosImgStr" multiple="multiple"></td>
	</tr>
	<tr>
		<th>사업자 등록증</th>
		<td><input type="file" title="사업자 등록증" name="certificateImgStr"></td>
	</tr>
	<tr>
		<th>분류(일반/특수병원)</th>
		<td><input type="text" title="병원 분류" name="animal" value="${hospitalVO.animal}" placeholder="일반 또는 특수 작성"></td>
	</tr>
	
	<tr>
		<td colspan="2">
			<input class="loginbtn" type="button" value="회원가입" onclick="hosJoin_ok(this.form)">
			<input type="reset" value="초기화">
		</td>
	</tr>
	<tr>
		<td colspan="2"><a href="login.do">로그인으로 이동</a></td>
	</tr>
	
</table>
</form>


</body>
</html>