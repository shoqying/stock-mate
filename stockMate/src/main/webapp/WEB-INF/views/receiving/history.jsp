<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 내역</title>
</head>
<body>

<h1>입고 내역 페이지 입니다</h1>

<!-- 기간별 검색 및 키워드 검색 폼 -->
<form action="/receiving/history" method="get" onsubmit="return validateForm()">
    <label for="startDate">시작 날짜:</label>
    <input type="date" id="startDate" name="startDate" value="${param.startDate}">
    
    <label for="endDate">종료 날짜:</label>
    <input type="date" id="endDate" name="endDate" value="${param.endDate}">
    
    <label for="keyword">키워드:</label>
    <input type="text" id="keyword" name="keyword" value="${param.keyword}">
    
    <button type="submit">검색</button>


<!-- 입고 내역 히스토리 -->
<table border="1">
	<tr>
		<th>입고 번호</th>
		<th>입고 출고</th>
		<th>입고 일자</th>
		<th>입고 상태</th>
		<th>제품 번호</th>
		<th>제품명</th>
		<th>옵션명</th>
		<th>입고 수량</th>
		<th>수량 단위</th>
		<th>제품 단가</th>
		<th>작업 메모</th>
		<th>공급사 회사 이름</th>
		<th>공급사 회사 사업자번호</th>		
	</tr>
	<c:forEach var="vo" items="${ReceivingList }">
	<tr>
		<td>${vo.receivingShipmentNo }</td>
		<td>${vo.transactionType }</td>
		<td><fmt:formatDate value="${vo.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
		<td>${vo.status }</td>
		<td>${vo.productId }</td>
		<td>${vo.name }</td>
		<td>${vo.description }</td>
		<td>${vo.changeQuantity }</td>
		<td>${vo.transactionUnit }</td>
		<td>${vo.price }</td>
		<td>${vo.memo }</td>
		<td>${vo.companyName }</td>
		<td>${vo.businessNumber }</td>
	</tr>
	</c:forEach>
</table>

</form>

<c:choose>
    <c:when test="${empty ReceivingList}">
        검색 결과가 없습니다.
    </c:when>
</c:choose>

</body>
</html>