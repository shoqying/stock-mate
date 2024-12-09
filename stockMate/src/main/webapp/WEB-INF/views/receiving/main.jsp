<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 메인</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<h1>입고 메인</h1>

<a href="/receiving/history">입고 내역</a>

<%-- ${ReceivingList } --%>
<%-- ${YesterdayReceivingList } --%>
<%-- ${TDBYReceivingList } --%>


<!-- 오늘 입고 리스트 -->
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
		<th>작업 메모</th>
		<th>공급사 회사 이름</th>
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
		<td>${vo.memo }</td>
		<td>${vo.companyName }</td>
	</tr>
	</c:forEach>
</table>


<!-- 어제 입고 리스트 -->
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
		<th>작업 메모</th>
		<th>공급사 회사 이름</th>
	</tr>
	<c:forEach var="vo" items="${YesterdayReceivingList }">
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
		<td>${vo.memo }</td>
		<td>${vo.companyName }</td>
	</tr>
	</c:forEach>
</table>



<!-- 그저께 입고 리스트 -->
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
		<th>작업 메모</th>
		<th>공급사 회사 이름</th>
	</tr>
	<c:forEach var="vo" items="${TDBYReceivingList }">
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
		<td>${vo.memo }</td>
		<td>${vo.companyName }</td>
	</tr>
	</c:forEach>
</table>



</body>
</html>