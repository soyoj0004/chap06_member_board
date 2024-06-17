<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 컨텍스트패스(진입점폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardInsertForm.jsp</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    form {
        width: 600px;
        margin: 0;
    }
    div {
        margin-bottom: 10px;
    }
    label {
        display: inline-block;
        width: 50px;
        vertical-align: top;
    }
    input[type="text"], textarea {
        width: calc(100% - 60px);
        padding: 5px;
        border: 1px solid #000;
        box-sizing: border-box;
    }
    textarea {
        height: 100px;
    }
</style>
</head>
<body>

<c:if test="${ not empty sessionScope.member }">
	<h3>게시물 작성</h3>
	<form action="${contextPath }/boardInsertProcess.jsp" method="post">
		<div>
			<label for="title">제목</label>
			<input type="text" id="title" name="title" required>
		</div>
		<div>
			<label for="title">내용</label>
			<input type="text" id="content" name="content" required>
		</div>
		<div>
			<input type="submit" value="저장">
			<input type="reset" value="다시쓰기">
		</div>
	</form>
</c:if>
<c:if test="${empty sessionScope.member }">
	<script>
		alert('회원만 게시물을 작성할 수 있습니다.');
		window.location.href="${contextPath}/loginForm.jsp";
	</script>
</c:if>
</body>
</html>