<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 등록</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bannerStyle.css' />">
</head>
<body>
	<h1>비즈니스 등록</h1>
	
	<%-- 에러 메시지 표시 --%>
	<c:if test="${not empty errorMessage}">
	    <div class="error-banner">${errorMessage}</div>
	</c:if>
	
	<%-- 성공 메시지 표시 --%>
	<c:if test="${not empty successMessage}">
		<div class="success-banner">${successMessage}</div>
	</c:if>

    <!-- 비즈니스 등록 폼 -->
    <form method="post" action="/business/register">
        
		<!-- 사업자 등록 번호 -->
		<div>
		    <label for="businessNumber">사업자 등록 번호:</label>
		    <input type="text" 
		           id="businessNumber" 
		           name="businessNumber" 
		           placeholder="사업자 등록 번호 (예: 123-45-67890)" 
		           required 
		           autofocus 
		           pattern="^\d{3}-\d{2}-\d{5}$" 
		           title="사업자 등록 번호는 '123-45-67890' 형식이어야 합니다."
		           style="width: 250px;">
		</div>
		<br>

        <!-- 회사 이름 -->
        <div>
            <label for="businessName">회사 이름:</label>
            <input type="text" id="businessName" name="businessName" placeholder="회사 이름" required>
        </div>
        <br>

        <!-- 등록 버튼 -->
        <div>
            <button type="submit">비즈니스 등록</button>
        </div>
        
    </form>

</body>
</html>