<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이펫 수정하기</title>
<jsp:include page="../../css/myPetCss.jsp" />
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<script>
	window.onload = function() {
		var errorMessage = "<c:out value='${errorMessage}'/>";
		if (errorMessage){
			alert(errorMessage);
		}
	}
	
	function fileName() {
		var input = document.getElementById('fileUpload');
		var fileName = document.getElementById('fileName');
		var clearBtn = document.getElementById('clearBtn');
		
	    if (input.files.length > 0) {
	        fileName.textContent = input.files[0].name;
	        clearBtn.style.display = 'inline';
	    } else {
	        fileName.textContent = '선택된 파일이 없습니다.';
	        clearBtn.style.display = 'none';
	    }
	}
	
	function clearFileInput() {
	    var fileInput = document.getElementById("fileUpload");
	    fileInput.value = "";
	    document.getElementById('fileName').textContent = '선택된 파일이 없습니다';
	    clearBtn.style.display = 'none';
	}
</script>
</head>
<body>
	<div id="container">
		<h1>마이펫 수정</h1>
			<form action="updateMyPet.do" method="post" enctype="multipart/form-data">
			    <input type="hidden" name="petIdx" value="${pet.petIdx}" />
			    <input type="hidden" id="errorMessage" value="${errorMessage}" />
			    <table>
			        <tr>
			            <th>펫종류</th>
			            <td><input type="text" name="petName" value="${pet.animal}" disabled></td>
			        </tr>	
			        <tr>
			            <th>펫이름</th>
			            <td><input type="text" name="petName" value="${pet.petName}"></td>
			        </tr>
			        <tr>
			            <th>펫나이</th>
			            <td><input type="number" name="petAge" value="${pet.petAge}" min="0"></td>
			        </tr>
	                <tr>
	                    <th>현재 펫사진</th>
	                    <td>
							<c:choose>
	                            <c:when test="${not empty pet.petImg}">
	                                <img src="${pet.petImg}" alt="${pet.petName}의 이미지" style="max-width: 150px;">
	                            </c:when>
	                            <c:otherwise>
	                                <p>등록된 펫 사진이 없습니다.</p>
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	                </tr>
	                <tr>
	                    <th>새 펫사진</th>
	                    <td>
	                    	<label for="fileUpload" class="fileBtn">파일 선택</label>
	                    	<input id="fileUpload" type="file" name="file" onchange="fileName()">
	                    	<span id="fileName">선택된 파일이 없습니다.</span>
	                    	<button id="clearBtn" type="button" class="btn" onclick="clearFileInput()" style="display: none;">삭제</button>
	                    </td>
	                </tr>
			        <tr>
			            <td class="center" colspan="2"><input type="submit" value="수정" onclick="alert('펫 정보 수정이 완료되었습니다.')" />
			            <button type="button" onclick="window.location.href='myPage.do'">취소</button>
			            </td>
			        </tr>
			    </table>
			</form>
	</div>
</body>
</html>