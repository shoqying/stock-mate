<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카테고리 등록</title>
<link rel="stylesheet" href="<c:url value='/resources/css/registerStyle2.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/toastStyle.css' />">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<script src="<c:url value='/resources/scripts/toast.js' />"></script>
<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const form = document.querySelector("form");
	    const submitButton = document.querySelector("button[type='submit']");
	    const spinner = document.querySelector(".spinner");
	    const parentCategorySelect = document.getElementById("parentCategoryId");
	    const alertMessage = document.getElementById("alert-message");
	
	    // Toast 메시지 표시
	    const toastMessage = "${toastMessage != null ? toastMessage : ''}";
	    const toastType = "${toastType != null ? toastType : ''}";
	    if (toastMessage) {
	        showToast(toastMessage, toastType);
	    }
	
	    // 실시간 입력 검증
	    const categoryNameInput = document.getElementById("categoryName");
	    categoryNameInput.addEventListener("input", function () {
	        const feedback = document.getElementById("name-feedback");
	        if (this.value.length < 2) {
	            feedback.textContent = "카테고리 이름은 최소 2글자 이상이어야 합니다.";
	            this.style.borderColor = "#ff4d4d";
	        } else {
	            feedback.textContent = "";
	            this.style.borderColor = "#28a745";
	        }
	    });
	
	    // 상위 카테고리 선택하지 않을 경우 안내 메시지 표시
	    parentCategorySelect.addEventListener("change", function () {
	        if (!this.value) {
	            alertMessage.style.display = "block";
	        } else {
	            alertMessage.style.display = "none";
	        }
	    });
	
	    // 폼 제출 시 로딩 효과 및 상위 카테고리 검증
	    form.addEventListener("submit", function (event) {
	        if (!parentCategorySelect.value || parentCategorySelect.value === "") {
	            // 상위 카테고리가 선택되지 않은 경우
	            parentCategorySelect.value = null; // parentId를 null로 설정
	        }
	
	        // 카테고리 이름 검증
	        if (categoryNameInput.value.trim().length < 2) {
	            alert("카테고리 이름은 최소 2글자 이상이어야 합니다.");
	            event.preventDefault(); // 폼 제출 중지
	            return;
	        }
	
	        // 로딩 효과
	        submitButton.classList.add("loading");
	        submitButton.textContent = "등록 중...";
	        spinner.style.display = "block";
	    });
	});
</script>
<style>
    #alert-message {
        color: #007bff;
        font-size: 14px;
        margin-top: 10px;
        display: none;
    }
</style>
</head>
<body>
    <!-- 카테고리 리스트 이동 버튼 -->

	<div class="container fade-in">
		<button class="dashboard-btn" onclick="location.href='/dashboard';">대시보드</button>
		<button class="category-link-button" onclick="location.href='/category/list';" >카테고리 리스트</button>
        <h2>카테고리 등록 페이지</h2>

        <form action="/category/register" method="post">
            <!-- 상위 카테고리 선택 -->
            <label for="parentCategoryId">상위 카테고리:</label>
            <select id="parentCategoryId" name="parentId">
                <option value="">-- 상위 카테고리 선택 --</option>
                <c:forEach var="cat" items="${categoryList}">
                    <option value="${cat.categoryId}">${cat.categoryName}</option>
                </c:forEach>
            </select>
            <div id="alert-message">※ 상위 카테고리를 선택하지 않으면 입력한 카테고리가 대분류로 등록됩니다.</div>

            <!-- 카테고리 이름 -->
            <label for="categoryName">카테고리 이름:</label>
            <input type="text" id="categoryName" name="categoryName" required />
            <div id="name-feedback" style="color: #ff4d4d; font-size: 12px;"></div>

            <!-- 숨겨진 사업자 ID -->
            <input type="hidden" id="businessId" name="businessId" value="${sessionScope.businessId}" />

            <!-- 등록 버튼 -->
            <button type="submit" class="primary-button">등록</button>
            <div class="spinner"></div>
        </form>
    </div>
</body>
</html>
