<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출고 메인</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
    /* 전체 페이지 스타일 */
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        color: #333;
    }

    h1 {
        font-size: 36px;
        font-weight: 700;
        color: #2c3e50;
        text-align: center;
        margin-top: 40px;
    }

    a {
        display: inline-block;
        padding: 12px 25px;
        margin: 20px;
        font-size: 18px;
        color: #fff;
        background-color: #3498db;
        text-decoration: none;
        border-radius: 6px;
        transition: background-color 0.3s ease;
    }

    a:hover {
        background-color: #2980b9;
    }

    form {
        margin-bottom: 40px;
    }

    input[type="submit"] {
        padding: 12px 25px;
        background-color: #3498db;
        color: white;
        font-size: 16px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
        background-color: #2980b9;
    }

    /* 테이블 스타일 */
    table {
        width: 90%;
        max-width: 1200px;
        margin-bottom: 40px;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        border-radius: 6px;
        overflow: hidden;
    }

    th, td {
        padding: 12px;
        text-align: center;
        border: 1px solid #ddd;
        font-size: 14px;
    }

    th {
        background-color: #3498db;
        color: white;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #ecf0f1;
    }

    /* 구분선 */
    hr {
        width: 90%;
        max-width: 1200px;
        margin-top: 40px;
        margin-bottom: 40px;
        border: 0;
        border-top: 1px solid #ddd;
    }

    /* 작은 화면에서 더 나은 보기 */
    @media (max-width: 768px) {
        h1 {
            font-size: 28px;
        }

        table {
            width: 100%;
            font-size: 12px;
        }

        a {
            font-size: 16px;
        }

        th, td {
            padding: 10px;
        }

        input[type="submit"] {
            font-size: 14px;
            padding: 10px 20px;
        }
    }
</style>
</head>
<body>

<h1>출고 메인</h1>

<a href="/shipment/history">출고 내역</a>
<a href="/shipment/scan">실시간 출고</a>
<a href="/dashboard">대쉬보드</a>
<form action="/shipment/insert1" method="POST">
    <input type="submit" value="새로고침">
</form>

<!-- 오늘 출고 리스트 -->
<h2>오늘 출고 리스트</h2>
<table border="1">
    <tr>
        <th>출고 번호</th>
        <th>입고 출고</th>
        <th>출고 일자</th>
        <th>출고 상태</th>
        <th>제품 번호</th>
        <th>제품명</th>
        <th>옵션명</th>
        <th>출고 수량</th>
        <th>수량 단위</th>
        <th>작업 메모</th>
    </tr>
    <c:forEach var="vo" items="${ShipmentList}">
        <tr>
            <td>${vo.receivingShipmentNo}</td>
            <td>${vo.transactionType}</td>
            <td><fmt:formatDate value="${vo.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td>
                <c:choose>
                    <c:when test="${vo.status == 'PENDING'}">대기중</c:when>
                    <c:when test="${vo.status == 'COMPLETED'}">완료됨</c:when>
                    <c:otherwise>${vo.status}</c:otherwise>
                </c:choose>
            </td>
            <td>${vo.productId}</td>
            <td>${vo.productName}</td>
            <td>${vo.productDescription}</td>
            <td>${vo.changeQuantity}</td>
            <td>${vo.transactionUnit}</td>
            <td>${vo.memo}</td>
        </tr>
    </c:forEach>
</table>

<!-- 어제 출고 리스트 -->
<h2>어제 출고 리스트</h2>
<table border="1">
    <tr>
        <th>출고 번호</th>
        <th>입고 출고</th>
        <th>출고 일자</th>
        <th>출고 상태</th>
        <th>제품 번호</th>
        <th>제품명</th>
        <th>옵션명</th>
        <th>출고 수량</th>
        <th>수량 단위</th>
        <th>작업 메모</th>
    </tr>
    <c:forEach var="vo" items="${YesterdayShipmentList}">
        <tr>
            <td>${vo.receivingShipmentNO}</td>
            <td>${vo.transactionType}</td>
            <td><fmt:formatDate value="${vo.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td>
                <c:choose>
                    <c:when test="${vo.status == 'PENDING'}">대기중</c:when>
                    <c:when test="${vo.status == 'COMPLETED'}">완료됨</c:when>
                    <c:otherwise>${vo.status}</c:otherwise>
                </c:choose>
            </td>
            <td>${vo.productId}</td>
            <td>${vo.productName}</td>
            <td>${vo.productDescription}</td>
            <td>${vo.changeQuantity}</td>
            <td>${vo.transactionUnit}</td>
            <td>${vo.memo}</td>
        </tr>
    </c:forEach>
</table>

<!-- 그저께 출고 리스트 -->
<h2>그저께 출고 리스트</h2>
<table border="1">
    <tr>
        <th>출고 번호</th>
        <th>입고 출고</th>
        <th>출고 일자</th>
        <th>출고 상태</th>
        <th>제품 번호</th>
        <th>제품명</th>
        <th>옵션명</th>
        <th>출고 수량</th>
        <th>수량 단위</th>
        <th>작업 메모</th>
    </tr>
    <c:forEach var="vo" items="${TDBYShipmentList}">
        <tr>
            <td>${vo.receivingShipmentNO}</td>
            <td>${vo.transactionType}</td>
            <td><fmt:formatDate value="${vo.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td>
                <c:choose>
                    <c:when test="${vo.status == 'PENDING'}">대기중</c:when>
                    <c:when test="${vo.status == 'COMPLETED'}">완료됨</c:when>
                    <c:otherwise>${vo.status}</c:otherwise>
                </c:choose>
            </td>
            <td>${vo.productId}</td>
            <td>${vo.productName}</td>
            <td>${vo.productDescription}</td>
            <td>${vo.changeQuantity}</td>
            <td>${vo.transactionUnit}</td>
            <td>${vo.memo}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
