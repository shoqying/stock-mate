<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 등록</title>
<link rel="stylesheet" href="<c:url value='/resources/css/registerStyle.css' />">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- Popper.js와 Bootstrap JS 제거 또는 필요시 유지 -->
<!-- 불필요한 Bootstrap CSS 제거했으므로 Bootstrap JS도 제거 가능. 
     단, 모달 기능 등을 직접 구현해야 한다면 JS 로직 수정 필요 -->
</head>
<body>
    <div class="container">
      <button class="dashboard-btn" onclick="location.href='/dashboard';">대시보드로 돌아가기</button>
        <h1>재고 등록</h1>
        <form id="stockForm" method="post" action="/stock/register">
            <!-- 창고 정보 영역 -->
            <label for="warehouseSelect">창고 선택</label>
            <select id="warehouseSelect" name="warehouseId" required>
                <option value="">창고 목록을 불러오는 중...</option>
            </select>

            <!-- 상품 정보 영역 -->
            <label for="productSelect">상품 선택</label>
            <select id="productSelect" required>
                <option value="">상품 목록을 불러오는 중...</option>
            </select>
            <!-- 선택된 상품 표시 (읽기 전용) -->
            <input type="text" id="selectedProduct" placeholder="선택된 상품이 표시됩니다" readonly>
            <input type="hidden" id="selectedProductId" name="productId">

            <!-- 수량 입력 -->
            <label for="quantity">초기 수량</label>
            <input type="number" id="quantity" name="quantity" min="1" required>

            <!-- 제출 버튼 -->
            <button type="submit" class="primary-button">재고 등록</button>
        </form>
    </div>

<script>
$(document).ready(function() {
    loadWarehouses();
    loadProducts(); // 페이지 로드 시 상품 목록 로딩
});

// 창고 목록 로딩 함수
function loadWarehouses() {
    $.ajax({
        url: '/api/stock/warehouses',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            const warehouseSelect = $('#warehouseSelect');
            warehouseSelect.empty();
            warehouseSelect.append('<option value="">창고를 선택하세요</option>');
            
            if (data && Array.isArray(data) && data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    const warehouse = data[i];
                    warehouseSelect.append('<option value="' + warehouse.warehouseId + '">' + warehouse.warehouseName + '</option>');
                }
            } else {
                warehouseSelect.append('<option value="">창고 없음</option>');
            }
        },
        error: function(xhr, status, error) {
            console.error('창고 정보를 불러오는 중 오류:', error);
            const warehouseSelect = $('#warehouseSelect');
            warehouseSelect.empty();
            warehouseSelect.append('<option value="">창고 불러오기 실패</option>');
        }
    });
}

// 상품 목록 로딩 함수
function loadProducts() {
    $.ajax({
        url: "/api/stock/products",
        type: "GET",
        dataType: "json",
        success: function(data) {
            const productSelect = $("#productSelect");
            productSelect.empty();
            productSelect.append('<option value="">상품을 선택하세요</option>');
            
            if (data && Array.isArray(data) && data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    const product = data[i];
                    const productId = product.productId || "";
                    const productName = product.productName || "N/A";
                    productSelect.append('<option value="' + productId + '">' + productName + '</option>');
                }
            } else {
                productSelect.append('<option value="">상품 없음</option>');
            }
        },
        error: function(xhr, status, error) {
            console.error("상품 정보를 불러오는 데 실패했습니다:", error);
            const productSelect = $("#productSelect");
            productSelect.empty();
            productSelect.append('<option value="">상품 불러오기 실패</option>');
        }
    });
}

// 상품 선택 시 표시
$(document).on("change", "#productSelect", function() {
    const selectedOption = $("#productSelect option:selected");
    const productId = selectedOption.val();
    const productName = selectedOption.text();

    if (productId) {
        $("#selectedProduct").val(productName);
        $("#selectedProductId").val(productId);
    } else {
        $("#selectedProduct").val('');
        $("#selectedProductId").val('');
    }
});
</script>
</body>
</html>
