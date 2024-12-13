<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 리스트</title>
<script>
    // 정렬 상태를 저장할 변수 (초기값은 내림차순으로 설정)
    let sortOrder = '${param.sortOrder != null ? param.sortOrder : "desc"}';

    // 수량 클릭 시 정렬을 변경
    function sortByStock() {
        // 정렬 순서를 변경
        sortOrder = (sortOrder === 'desc') ? 'asc' : 'desc';
        
        // URL에 sortOrder 파라미터를 추가하여 페이지를 갱신
        let currentUrl = "<c:url value='/stock/list' />";
        let params = new URLSearchParams(window.location.search);
        
        // 기존 파라미터들을 포함시키고 sortOrder 파라미터 추가
        params.set('sortOrder', sortOrder);

        // 다른 파라미터들을 그대로 유지하면서 새 URL로 리다이렉트
        window.location.href = currentUrl + "?" + params.toString();
    }
</script>
</head>

<body>
    <h1>재고 리스트</h1>
    
    <!-- 필터링 폼 -->
    <form action="<c:url value='/stock/list' />" method="get">
        <label for="warehouseId">창고명:</label>
        <select name="warehouseId" id="warehouseId">
            <option value="">-- 선택 --</option>
            <c:forEach var="warehouse" items="${warehouseList}">
                <option value="${warehouse.warehouseId}" 
                    <c:if test="${warehouse.warehouseId == param.warehouseId}">selected</c:if>
                >${warehouse.warehouseName}</option> <!-- warehouseName으로 표시 -->
            </c:forEach>
        </select>

        <label for="categoryName">카테고리명:</label>
        <select name="categoryName" id="categoryName">
            <option value="">-- 선택 --</option>
            <c:forEach var="category" items="${categoryList}">
                <option value="${category.categoryName}" 
                    <c:if test="${category.categoryName == param.categoryName}">selected</c:if>
                >${category.categoryName}</option>
            </c:forEach>
        </select>

        <label for="minStock">최소 수량:</label>
        <input type="number" name="minStock" id="minStock" value="${param.minStock != null ? param.minStock : 0}" />

        <label for="maxStock">최대 수량:</label>
        <input type="number" name="maxStock" id="maxStock" value="${param.maxStock != null ? param.maxStock : 1000}" />

        <button type="submit">검색</button>
    </form>

    <!-- 재고 리스트 테이블 -->
    <table border="1">
        <thead>
            <tr>
                <th>상품명</th>
                <th>창고명</th>
                <th>카테고리명</th>
                <th><a href="javascript:void(0);" onclick="sortByStock()">재고 수량</a></th>
                <th>상태정보</th>
                <th>마지막 수정일</th>
                <th>비고</th>
            </tr>
        </thead>
        <tbody>
        <!-- 재고 목록을 출력 -->
        <c:forEach var="stock" items="${stockList}">
            <tr>
                <td>
                    <!-- 상품명은 ProductVO의 name 속성을 사용 -->
                    <a href="<c:url value='/product/detail/${stock.product.productId}'/>">${stock.product.name}</a> <!-- 상품명 링크 추가 -->
                </td>
                <td>${stock.warehouseName}</td> <!-- warehouseName으로 표시 -->
                <td>${stock.categoryName}</td>
                <td>
                    <c:if test="${stock.availableStock < 10}">
                        <span style="color: red;">${stock.availableStock}</span> <!-- 수량이 부족하면 빨간색으로 표시 -->
                    </c:if>
                    <c:if test="${stock.availableStock >= 10}">${stock.availableStock}</c:if>
                </td>
                <td>${stock.statusInfo}</td>
                <td>${stock.updatedAt}</td>
                <td>${stock.description}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    
    <!-- 주문하기 버튼 (재고가 부족한 경우만) -->
    <c:forEach var="stock" items="${stockList}">
        <c:if test="${stock.availableStock < 10}">
            <form action="<c:url value='/order/register' />" method="post">
                <input type="hidden" name="stockId" value="${stock.stockId}" />
                <button type="submit">주문하기</button>
            </form>
        </c:if>
    </c:forEach>

</body>
</html>