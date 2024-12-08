<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<h1>상품 등록</h1>

	<!-- 상품 등록 폼 -->
	<form method="post" action="/product/register">
		
		<!-- 카테고리 선택 필드: 드롭다운으로 categoryId 직접 전달 -->
		<label for="categoryId">카테고리 선택:</label> 
		<select id="categoryId" name="categoryId" required>
			<c:forEach var="cat" items="${categoryList}">
				<option value="${cat.categoryId}">${cat.categoryName}</option>
			</c:forEach>
		</select><br>
		<br>

		<!-- 상품명 필드: autofocus로 페이지 로드 시 자동 포커스 -->
		<label for="name">상품명:</label> 
		<input type="text" id="name" name="name" required autofocus placeholder="예: 무선 마우스" /><br>
		<br>

		<!-- 기본 단위 필드: 예를 들어 '개', '박스' 등을 placeholder -->
		<label for="baseUnit">기본 단위:</label> 
		<input type="text" id="baseUnit" name="baseUnit" required placeholder="예: 개" /><br>
		<br>

		<!-- 세트 크기 필드: number로 입력받고 예시 표시 -->
		<label for="setSize">세트 크기:</label> 
		<input type="number" id="setSize" name="setSize" required placeholder="예: 10 (한 세트 당 10개)" /><br>
		<br>

		<!-- 기본 단가 필드: 숫자/가격에 맞는 placeholder -->
		<label for="price">기본 단가:</label> 
		<input type="number" id="price" name="price" required placeholder="예: 15000" /><br>
		<br>
		
		<!-- 상품 설명 필드: textarea에 placeholder -->
		<label for="description">상품 설명:</label><br>
		<textarea id="description" name="description"
			placeholder="상품에 대한 추가 설명을 입력하세요." rows="5" cols="50"></textarea>
		<br>
		<br>

		<!-- 등록 버튼 -->
		<button type="submit">상품 등록</button>
	</form>
	
</body>
</html>