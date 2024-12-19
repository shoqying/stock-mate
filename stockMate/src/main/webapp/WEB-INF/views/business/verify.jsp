<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비즈니스 인증</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bannerStyle.css' />">
</head>
<body>
    <h1>비즈니스 인증</h1>

	<%-- 에러 메시지 표시 --%>
	<c:if test="${not empty errorMessage}">
	    <div class="error-banner">${errorMessage}</div>
	</c:if>
	
	<%-- 성공 메시지 표시 --%>
	<c:if test="${not empty successMessage}">
		<div class="success-banner">${successMessage}</div>
	</c:if>

    <form action="/business/verify" method="post">
        <label for="businessNumber">사업자 등록 번호:</label>
        <input type="text" id="businessNumber" name="businessNumber" required placeholder="사업자 등록 번호">
        <br><br>
        <label for="businessName">회사명:</label>
        <input type="text" id="businessName" name="businessName" required placeholder="회사 이름">
        <br><br>
        <button type="submit">비즈니스 인증</button>
    </form>
</body>
</html>