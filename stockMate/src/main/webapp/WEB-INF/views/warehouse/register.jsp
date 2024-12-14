<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>창고 등록</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/warehouseStyle.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/toastStyle.css' />">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.querySelector("form");
            form.addEventListener("submit", function (event) {
                event.preventDefault(); // 기본 제출 동작 방지

                const formData = new FormData(form);
                const warehouseData = {};
                formData.forEach((value, key) => {
                    warehouseData[key] = value;
                });

                fetch("${pageContext.request.contextPath}/warehouse/register", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify(warehouseData),
                })
                    .then((response) => response.json())
                    .then((data) => {
                        if (data.success) {
                            showToast(data.message, "success");
                        } else {
                            showToast(data.message, "error");
                        }
                    })
                    .catch((error) => {
                        showToast("서버 요청 중 오류가 발생했습니다.", "error");
                        console.error("Error:", error);
                    });
            });
        });

        // Toast 메시지 표시 함수
        function showToast(message, type) {
            const toast = document.createElement("div");
            toast.className = `toast ${type}`;
            toast.textContent = message;
            document.body.appendChild(toast);
            setTimeout(() => {
                toast.style.opacity = 1;
            }, 100);
            setTimeout(() => {
                toast.style.opacity = 0;
                setTimeout(() => {
                    document.body.removeChild(toast);
                }, 500);
            }, 3000);
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>창고 등록</h1>
        <form>
            <!-- 사용자 ID와 비즈니스 ID -->
            <input type="hidden" name="userId" value="${userId}">
            <input type="hidden" name="businessId" value="${businessId}">

            <label for="warehouseName">창고명</label>
            <input type="text" name="warehouseName" placeholder="창고명을 입력해주세요." required />

            <label for="location">창고 주소</label>
            <input type="text" name="location" placeholder="주소를 입력해주세요." required />

            <button type="submit">등록</button>
        </form>
    </div>
</body>
</html>
