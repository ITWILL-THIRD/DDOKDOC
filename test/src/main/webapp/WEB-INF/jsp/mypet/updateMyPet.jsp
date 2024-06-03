<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이펫 수정하기</title>
</head>
<body>
	<div id="container">
		<h1>마이펫 수정</h1>
			<form action="updateMyPet.do" method="post">
			    <input type="hidden" name="petIdx" value="${pet.petIdx}" />
			    <table>
			        <tr>
			            <th>펫종류:</th>
						<td>
					        <select name="animal">
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
			            <td colspan="2"><input type="submit" value="수정" onclick="alert('펫 정보 수정이 완료되었습니다')" /></td>
			        </tr>
			    </table>
			</form>
	</div>
</body>
</html>