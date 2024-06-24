<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세 ${board.title }</title>
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<script>
function editComment(commentIdx) {
    var contentElement = document.getElementById('content-' + commentIdx);
    var currentContent = contentElement.innerText;

    var inputElement = document.createElement('input');
    inputElement.type = 'text';
    inputElement.value = currentContent;
    inputElement.id = 'input-' + commentIdx;

    var saveButton = document.createElement('button');
    saveButton.innerText = '저장';
    saveButton.className = 'btn saveBtn';
    saveButton.onclick = function() {
        saveComment(commentIdx);
    };

    contentElement.innerHTML = '';
    contentElement.appendChild(inputElement);
    contentElement.appendChild(saveButton);
}

function saveComment(commentIdx) {
    var inputElement = document.getElementById('input-' + commentIdx);
    var newContent = inputElement.value;

    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'updateComment.do', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function() {

     var response = xhr.responseText;

     var contentElement = document.getElementById('content-' + commentIdx);
     contentElement.innerHTML = newContent;

     inputElement.parentNode.removeChild(inputElement);
     var saveButtonToRemove = document.querySelector('#content-' + commentIdx + ' .saveBtn');
     saveButtonToRemove.parentNode.removeChild(saveButtonToRemove);
 
       
    };
    xhr.send('commentidx=' + commentIdx + '&content=' + encodeURIComponent(newContent));
}

function deleteComment(commentIdx) {
    if (confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'deleteComment.do', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {

         var response = xhr.responseText;
         
         var commentElement = document.getElementById('comment-' + commentIdx);
         commentElement.parentNode.removeChild(commentElement);
         
         
        };
        xhr.send('commentidx=' + commentIdx);
    }
}




</script>
</head>
<body>
<div id="container">
	<h2>게시글 등록</h2>
	<hr>
	<form action="updateBoard.do" method="get">
		<input type="hidden" name="postIdx" value="${board.postidx }">
		<hr  class="top-margin hr">
		<h1>${board.title }</h1>
		<hr class="hr">
	<table class="getBoard" border frame=void>
		<tr>
			<th>카테고리</th>
			<td>
				<c:choose>
                        <c:when test="${board.category == 'free'}">자유</c:when>
                        <c:when test="${board.category == 'med'}">의료</c:when>
                        <c:when test="${board.category == 'feed'}">사료/간식</c:when>
                        <c:when test="${board.category == 'goods'}">용품</c:when>
                        <c:otherwise>자유</c:otherwise>
                </c:choose>
			</td>
			<th>작성자</th>
			<td>
				${board.nickname}
			</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${board.hit }</td>
			<th>작성일</th>
			<td>${board.formattedDate }</td>
		</tr>
		<tr>
			
		</tr>
		<tr>
			<td style="white-space:pre-line" colspan="6" class="content">
				${board.content}
				<c:if test="${not empty board.img}">
				<c:forEach var="board.img" items="${board.img}">
					<img src="${board.img}" alt="${board.img} 이미지" style="max-width:500px;">
				</c:forEach>
				</c:if>
			</td>
		</tr>
	</table>
	</form>
	<p>
	<c:if test="${user.userIdx == board.useridx}">
		<a href="getUpdateBoard.do?postidx=${board.postidx }">수정</a>
		<a class="none">|</a>
		<a href="deleteBoard.do?postidx=${board.postidx }">삭제</a>
		<a class="none">|</a>
	</c:if>  	
		<a href="getBoardList.do"> 목록</a>
	</p>
	
	<div class="center">
	<c:if test="${not empty sessionScope.user }">
		<form action="insertComment.do" method="get" class="width">
			<input type="hidden" name="useridx" class="idInput" value="${user.userIdx}">
			<textarea name="content" rows="4" cols="60" class="commentInput"></textarea>
			<input type="submit" value="등록" class="btn">
			<input type="hidden" name="postidx" value="${board.postidx }">
			<%--<input type="hidden" name="cPage" value="${cPage }"> --%>
		</form>
	</c:if>	
	<c:if test="${not empty sessionScope.hoUser }">
		<form action="insertComment.do" method="get" class="width">
			<input type="hidden" name="hosidx" class="idInput" value="${hoUser.hosIdx}">
			<textarea name="content" rows="4" cols="60" class="commentInput"></textarea>
			<input type="submit" value="등록" class="btn">
			<input type="hidden" name="postidx" value="${board.postidx }">
			<%--<input type="hidden" name="cPage" value="${cPage }"> --%>
		</form>
	</c:if>	
	</div>
	<hr>
	<div class="scroll">
	    <c:forEach var="comment" items="${comments}">
	        <div class="comments" id="comment-${comment.commentidx}">

	            <p>작성자 : ${comment.nickname}${comment.hosname} | 작성일시 : ${comment.formattedCommentDate }
	            <c:if test="${user.userIdx == comment.useridx}">
	                <button type="button" onclick="editComment(${comment.commentidx})" class="btn upBtn">수정</button>
	                <button type="button" onclick="deleteComment(${comment.commentidx})" class="btn delBtn">삭제</button></p>
	            </c:if> 
	            <c:if test="${hoUser.hosIdx == comment.hosidx}">
	           		<button type="button" onclick="editComment(${comment.commentidx})" class="btn upBtn">수정</button>
	                <button type="button" onclick="deleteComment(${comment.commentidx})" class="btn delBtn">삭제</button></p>
	            </c:if> 
	            <p id="content-${comment.commentidx}">${comment.content}</p>
	            <input type="hidden" name="commentidx" value="${comment.commentidx}">
	            <input type="hidden" name="postidx" value="${comment.postidx}">
	        </div>
	        <hr>
	    </c:forEach>
	</div>
</div>
</body>
</html>