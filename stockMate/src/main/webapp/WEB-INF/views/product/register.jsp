<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록</title>
    <link rel="stylesheet" href="/resources/css/productRegister.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="form-container">
        <h1 class="page-title">상품 등록</h1>
        <form method="post" action="/product/register">
            <!-- 카테고리 선택 필드 -->
            <div class="form-group category-group">
                <label for="categoryId">카테고리 선택</label>
                <select id="categoryId" name="categoryId" required>
                    <option value="">-- 카테고리 선택 --</option>
                    <c:forEach var="cat" items="${categoryList}">
                        <option value="${cat.categoryId}">${cat.categoryName}</option>
                    </c:forEach>
                </select>
                <button type="button" class="secondary-button" onclick="window.location.href='/category/register';">
                    새로운 카테고리 등록
                </button>
            </div>
            
            <!-- 상품명 -->
            <div class="form-group">
                <label for="name">상품명</label>
                <input type="text" id="name" name="name" required placeholder="예: 무선 마우스">
            </div>
            
            <!-- 바코드 -->
            <div class="form-group barcode-group">
                <label for="barcode">바코드</label>
                <div class="barcode-container">
                    <input type="text" id="barcode" name="barcode" placeholder="예: 1234567890123" pattern="\d{13}">
                    <button type="button" id="generateBarcode" class="secondary-button">자동 생성</button>
                </div>
            </div>
            
            <!-- 기본 단위 -->
            <div class="form-group">
                <label for="baseUnit">기본 단위</label>
                <input type="text" id="baseUnit" name="baseUnit" required placeholder="예: 박스">
            </div>
            
            <!-- 세트 크기 -->
            <div class="form-group">
                <label for="setSize">세트 크기</label>
                <input type="number" id="setSize" name="setSize" required placeholder="예: 10 (한 세트 당 10개)">
            </div>
            
            <!-- 기본 단가 -->
            <div class="form-group">
                <label for="price">기본 단가</label>
                <input type="number" id="price" name="price" required placeholder="예: 15000">
            </div>
            
            <!-- 상품 설명 -->
            <div class="form-group">
                <label for="description">상품 설명</label>
                <textarea id="description" name="description" rows="4" placeholder="상품에 대한 추가 설명을 입력하세요."></textarea>
            </div>
            
            <!-- 등록 버튼 -->
            <button type="submit" class="primary-button">상품 등록</button>
        </form>
    </div>
    <script>
	    function generateEAN13Barcode() {
	        // 880으로 시작하는 국가 코드 고정
	        const countryCode = [8, 8, 0];
	
	        // 나머지 9자리 랜덤 숫자 생성 (총 12자리 중 앞 3자리는 고정)
	        const randomDigits = Array.from({ length: 9 }, () => Math.floor(Math.random() * 10));
	
	        // 체크디지트 계산 (880 + 9자리 랜덤 숫자)
	        const digits = countryCode.concat(randomDigits);
	        const checkDigit = calculateCheckDigit(digits);
	
	        // 최종 바코드 생성 (12자리 + 체크디지트)
	        return digits.join('') + checkDigit;
	    }
	
	    function calculateCheckDigit(digits) {
	        let sum = 0;
	
	        digits.forEach((digit, index) => {
	            // 홀수 자리는 1배, 짝수 자리는 3배 가중치
	            const weight = index % 2 === 0 ? 1 : 3;
	            sum += digit * weight;
	        });
	
	        // 10의 배수에서 총합을 뺀 값으로 체크디지트를 계산
	        const remainder = sum % 10;
	        return remainder === 0 ? 0 : 10 - remainder;
	    }
	
	    document.getElementById('generateBarcode').addEventListener('click', function () {
	        const randomBarcode = generateEAN13Barcode();
	        document.getElementById('barcode').value = randomBarcode;
	    });
	</script>
</body>
</html>
