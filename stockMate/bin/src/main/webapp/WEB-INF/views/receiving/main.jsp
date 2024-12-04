<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<h1>입고 메인</h1>

<table border="1">
	<tr>
		<th>입고 번호</th>
		<th>오늘 입고될 시간</th>
		<th>제품 번호</th>
		<th>제품명</th>
		<th>옵션명</th>
		<th>입고 수량</th>
		<th>작업메모</th>
		<th>공급사 회사 이름</th>
	</tr>
	<c:forEach var="vo" items="${todayReceivingList}">
	<tr>
		<td>${vo.receivingNo }</td>
		<td>${vo.receivingDate }</td>
		<td>${vo.productNO }</td>
		<td>${vo.productName }</td>
		<td>${vo.optionName }</td>
		<td>${vo.receivingQty }</td>
		<td>${vo.workMemo }</td>
		<td>${vo.supplierName }</td>
	</tr>
	</c:forEach>
</table>

<table border="1">
	<tr>
		<th>입고 번호</th>
		<th>어제 입고된 시간</th>
		<th>제품 번호</th>
		<th>제품명</th>
		<th>옵션명</th>
		<th>입고 수량</th>
		<th>작업메모</th>
		<th>공급사 회사 이름</th>
	</tr>
	<c:forEach var="vo" items="${todayReceivingList}">
	<tr>
		<td>${vo.receivingNo }</td>
		<td>${vo.receivingDate }</td>
		<td>${vo.productNO }</td>
		<td>${vo.productName }</td>
		<td>${vo.optionName }</td>
		<td>${vo.receivingQty }</td>
		<td>${vo.workMemo }</td>
		<td>${vo.supplierName }</td>
	</tr>
	</c:forEach>
</table>

</body>
</html>