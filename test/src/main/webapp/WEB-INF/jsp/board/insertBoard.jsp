<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록</title>
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/insertBoard.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<script>
function validateForm() {
    var title = document.forms["insertForm"]["title"].value;
    var content = document.forms["insertForm"]["content"].value;
    
    if (title == null || title.trim() == "") {
        alert("제목을 입력해주세요");
        return false;
    }
    if (content == null || content.trim() == "") {
        alert("내용을 입력해주세요");
        return false;
    }
    return true;
}

function displayFileName() {
    const fileInput = document.getElementById('file');
    const fileNameDisplay = document.getElementById('file-name');
    if (fileInput.files.length > 0) {
        fileNameDisplay.textContent = fileInput.files[0].name;
    } else {
        fileNameDisplay.textContent = '선택된 파일 없음';
    }
}

function clearFileInput() {
    const fileInput = document.getElementById('file');
    const fileNameDisplay = document.getElementById('file-name');
    fileInput.value = '';
    fileNameDisplay.textContent = '선택된 파일 없음';
}
// function clearFileInput() {
//     var fileInput = document.getElementById("file");
//     fileInput.value = "";
// }

</script>
</head>
<body>

<div id="container">
	<h2>새글 등록</h2>
	<hr>
	<form name="insertForm" action="insertBoard.do" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
	<table class="insertBoard">
		<tr>
			<th>카테고리</th>
			<td>
			    <select id="category" name="category">
			        <option value="free">자유</option>
			        <option value="med">의료</option>
			        <option value="feed">사료/간식</option>
			        <option value="goods">용품</option>
    			</select>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title" style="width: 95%"  class="border-none">
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<input type="hidden" name="useridx" value="${user.userIdx}">
				${user.nickname}
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="content" rows="13" cols="60" class="border-none" style="width: 100%"></textarea>
			</td>
		</tr>
		<tr>
			<th>사진 첨부</th>
			<td>
				<div class="file-input-wrapper">
			        <input type="file" id="file" name="file" onchange="displayFileName()">
			        <label for="file" class="file-input-label">파일 선택</label>
			        <span class="file-name" id="file-name">선택된 파일 없음</span>
			    </div>
<!-- 				<input type="file" id="file" name="file"> -->
				<button type="button" onclick="clearFileInput()" class="delBtn">삭제</button>
			</td>
		</tr>
<!-- 		<tr> -->
<!-- 			<td colspan="2" class="center"> -->
<!-- 				<input type="submit" value="등록" class="btn"> -->
<!-- 			</td> -->
<!-- 		</tr> -->
	</table>
	<input type="submit" class="btn" value="등록">
	<input type="reset" class="resetBtn" value="초기화">
	<input type="button" class="resetBtn" value="취소"
	onclick="javascript:location.href='../board/getBoardList.do'">
	</form>
</div>

</body>
</html>














