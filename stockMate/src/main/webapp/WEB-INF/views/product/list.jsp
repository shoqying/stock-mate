<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product List</title>
<style>
.error-banner {
    width: 100%;
    background-color: #FCE4E4;
    color: #D32F2F;
    text-align: center;
    padding: 10px 0;
    font-size: 14px;
    font-weight: 500;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1000;
    border-bottom: 1px solid #F5C6C6;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.success-banner {
    width: 100%;
    background-color: #E6F4EA;
    color: #2E7D32;
    text-align: center;
    padding: 10px 0;
    font-size: 14px;
    font-weight: 500;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1000;
    border-bottom: 1px solid #C8E6C9;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
    body {
        font-family: Arial, sans-serif;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
    }
    th {
        background-color: #f4f4f4;
    }
    tr:hover {
        background-color: #f9f9f9;
    }
    a, button {
        color: #007BFF;
        text-decoration: none;
    }
    a:hover, button:hover {
        text-decoration: underline;
    }
</style>
<script>
	function generateQRCode(productId, isJsonQRCode) {
	    fetch(`/api/qrcode/generate`, {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json',
	        },
	        body: JSON.stringify({ productId: productId, isJsonQRCode: isJsonQRCode })
	    })
	    .then(response => response.text()) // 서버의 응답을 텍스트로 처리
	    .then(message => {
	        alert(message); // 성공 또는 실패 메시지 표시
	        location.reload(); // 페이지 새로고침
	    })
	    .catch(error => {
	        alert('QR 코드 생성 실패: ' + error.message);
	    });
	}
</script>
</head>
<body>
    <h1>Product List</h1>
    <!-- 성공 메시지 출력 -->
    <c:if test="${not empty successMessage}">
        <div class="success-banner">
            ${successMessage}
        </div>
    </c:if>

    <!-- 에러 메시지 출력 -->
    <c:if test="${not empty errorMessage}">
        <div class="error-banner">
            ${errorMessage}
        </div>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Name</th>
                <th>Barcode</th>
                <th>QR Code</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="product" items="${products}">
                <tr>
                    <td>${product.productId}</td>
                    <td>${product.name}</td>
                    <td>${product.barcode}</td>
                    <td>
                        <c:choose>
			                <c:when test="${product.qrCode == null || product.qrCode.qrCodePath == null}">
			                    <button onclick="generateQRCode(${product.productId}, true)">Generate JSON QR</button>
			                    <button onclick="generateQRCode(${product.productId}, false)">Generate Detail QR</button>
			                </c:when>
                            <c:otherwise>
                                <!-- 다운로드 버튼만 표시 -->
                                <a href="/api/qrcode/download?qrCodePath=${product.qrCode.qrCodePath}" target="_blank">Download QR</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>