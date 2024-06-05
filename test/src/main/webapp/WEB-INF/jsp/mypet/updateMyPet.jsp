<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이펫 수정하기</title>
<script>
	window.onload = function(){
		var errorMessage = "<c:out value='${errorMessage}'/>";
		if (errorMessage){
			alert(errorMessage);
		}
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
			            <th>펫종류:</th>
						<td>
					        <select name="animal">
					        	<option value="" disabled selected>선택해주세요</option>
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
			            <th>펫이름:</th>
			            <td><input type="text" name="petName" value="${pet.petName}"></td>
			        </tr>
			        <tr>
			            <th>펫나이:</th>
			            <td><input type="number" name="petAge" value="${pet.petAge}"></td>
			        </tr>
	                <tr>
	                    <th>현재 펫사진:</th>
	                    <td>
							<c:choose>
	                            <c:when test="${not empty pet.petImg}">
	                                <img src="${pet.petImg}" alt="${pet.petName}의 이미지" style="max-width: 150px;">
	                            </c:when>
	                            <c:otherwise>
	                                <p>등록된 펫 사진이 없습니다</p>
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	                </tr>
	                <tr>
	                    <th>새 펫사진:</th>
	                    <td><input type="file" name="file"></td>
	                </tr>
			        <tr>
			            <td colspan="2"><input type="submit" value="수정" onclick="alert('펫 정보 수정이 완료되었습니다')" />
			            <button type="button" onclick="window.location.href='myPage.do'">취소</button>
			            </td>
			        </tr>
			    </table>
			</form>
	</div>
</body>
</html>