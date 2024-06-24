<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이펫 등록하기</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/myPetCss.jsp" />
<jsp:include page="../common/navigation.jsp"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
	window.onload = function() {
		var errorMessage = "<c:out value='${errorMessage}'/>";
		if (errorMessage){
			alert(errorMessage);
		}
	
		var fileInput = document.getElementById("file");
		var clearBtn = document.getElementById("clearBtn");
	
		fileInput.addEventListener("change", function() {
			if (fileInput.value) {
				clearBtn.style.display = "inline-block";
			} else {
				clearBtn.style.display = "none";
			}
		});
	}
	
	function submitAlert(event) { // 폼 제출 전에 alert 창 표시
		event.preventDefault();
		alert('펫 등록이 완료되었습니다.');
		event.target.submit();
	}
	
	function clearFileInput() {
	    var fileInput = document.getElementById("file");
	    fileInput.value = "";
	    var clearBtn = document.getElementById("clearBtn");
	    clearBtn.style.display = "none"; // 파일 삭제 시 버튼 숨기기
	}
</script>
</head>
<body>
	<div id="container">
		<h1>마이펫 등록</h1>
		<form action="insertMyPet.do" method="post" enctype="multipart/form-data" onsubmit="submitAlert(event)">
		<input type="hidden" id="errorMessage" value="${errorMessage}" />		
			<table class="tb">
				<tr>
					<td>펫종류</td>
				</tr>
				<tr>	
					<td>
				        <select class="select" name="animal" required>
				        	<option value="" disabled selected>선택해주세요.</option>
				            <optgroup label="포유류">
				                <option value="개">개</option>
				                <option value="고양이">고양이</option>
				                <option value="토끼">토끼</option>
				                <option value="기니피그">기니피그</option>
				            </optgroup>
				            <optgroup label="설치류">
				                <option value="햄스터">햄스터</option>
				                <option value="다람쥐">다람쥐</option>
				            </optgroup>
				            <optgroup label="조류">
				                <option value="앵무새">앵무새</option>
				                <option value="카나리아">카나리아</option>
				            </optgroup>
				            <optgroup label="어류">
				                <option value="베타">베타</option>
				                <option value="구피">구피</option>
				            </optgroup>
				            <optgroup label="파충류">
				                <option value="도마뱀">도마뱀</option>
				                <option value="거북이">거북이</option>
				            </optgroup>
				            <optgroup label="기타">
				                <option value="기타">그 외</option>
				            </optgroup>
				        </select>
					</td>
				</tr>
				<tr>
					<td>펫이름</td>
				</tr>
				<tr>	
					<td><input class="text" type="text" name="petName" required></td>
				</tr>
				<tr>
					<td>펫나이</td>
				</tr>
				<tr>	
					<td><input class="text" type="number" name="petAge" min="0" required></td>
				</tr>
				<tr>
                    <td>펫사진</td>
                </tr>
                <tr>    
                    <td>
                    	<div class="fileContainer">
	                    	<input class="text" id="file" type="file" name="file">
	                    	<button class="clearBtn" id="clearBtn" type="button" onclick="clearFileInput()" style="display: none">삭제</button>
	                    </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input class="btn" type="submit"  value="등록">
                        <button class="btn" type="button" onclick="window.location.href='myPage.do'">취소</button>
                    </td>
                </tr>
			</table>
		</form>
	</div>
</body>
</html>
