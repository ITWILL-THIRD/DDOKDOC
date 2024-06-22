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
		<h1>마이펫 수정</h1>
			<form action="updateMyPet.do" method="post" enctype="multipart/form-data">
			    <input type="hidden" name="petIdx" value="${pet.petIdx}" />
			    <input type="hidden" id="errorMessage" value="${errorMessage}" />
			    <table class="tb">
			        <tr>
			            <td>펫종류</td>
			        </tr>	
			        <tr>
			            <td><input class="text" type="text" name="petName" value="${pet.animal}" disabled></td>
			        </tr>	
			        <tr>
			            <td>펫이름</td>
			        </tr>	
			        <tr>    
			            <td><input class="text" type="text" name="petName" value="${pet.petName}"></td>
			        </tr>
			        <tr>
			            <td>펫나이</td>
			        </tr>	
			        <tr>    
			            <td><input class="text" type="number" name="petAge" value="${pet.petAge}" min="0"></td>
			        </tr>
	                <tr>
	                    <td>현재 펫사진</td>
	                </tr>	
			        <tr>    
	                    <td>
	                    	<div class="imageContainer">
							<c:choose>
	                            <c:when test="${not empty pet.petImg}">
	                                <img src="${pet.petImg}" alt="${pet.petName}의 이미지" style="max-width: 150px;">
	                            </c:when>
	                            <c:otherwise>
	                                <p>등록된 펫 사진이 없습니다.</p>
	                            </c:otherwise>
	                        </c:choose>
	                        </div>
	                    </td>
	                </tr>
	                <tr>
	                    <td>새 펫사진</td>
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
			            <td class="center" colspan="2">
			            <input class="btn" type="submit" value="수정" onclick="alert('펫 정보 수정이 완료되었습니다.')" />
			            <button class="btn" type="button" onclick="window.location.href='myPage.do'">취소</button>
			            </td>
			        </tr>
			    </table>
			</form>
	</div>
</body>
</html>