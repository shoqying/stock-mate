<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 내역</title>
 <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* 타이틀 스타일 */
        h1 {
            text-align: center;
            margin-top: 30px;
            color: #2c3e50;
            font-size: 36px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        h1 a {
            text-decoration: none;
            color: #3498db;
            font-size: 20px;
            display: block;
            margin-top: 10px;
            text-align: center;
        }
        
        a {
            display: inline-block;
            padding: 10px 20px;
            margin: 20px 0;
            font-size: 16px;
            color: #fff;
            background-color: #3498db;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        h1 a:hover {
            color: #2980b9;
        }

        /* 검색 폼 스타일 */
        form {
            width: 80%;
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            margin-right: 10px;
            font-size: 14px;
        }

        input[type="date"],
        input[type="text"] {
            padding: 8px;
            margin-right: 20px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 180px;
        }

        button {
            padding: 8px 15px;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #2980b9;
        }

        /* 테이블 스타일 */
        table {
            width: 90%;
            margin: 40px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
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

        /* 결과가 없을 경우 메시지 스타일 */
        .no-results {
            text-align: center;
            font-size: 18px;
            color: #e74c3c;
            margin-top: 30px;
        }

        /* 반응형 스타일 */
        @media (max-width: 768px) {
            form {
                width: 95%;
            }

            table {
                width: 100%;
            }

            th, td {
                font-size: 12px;
            }

            label {
                font-size: 12px;
            }

            input[type="date"], input[type="text"] {
                font-size: 12px;
                padding: 6px;
                width: 150px;
            }

            button {
                font-size: 12px;
                padding: 6px 12px;
            }
        }
    </style>
</head>
<body>

<h1>입고 내역</h1>
<a href="/receiving/main">입고 메인</a>

<!-- 기간별 검색 및 키워드 검색 폼 -->
<form action="/receiving/history" method="get" onsubmit="return validateForm()" id="searchForm">
    <label for="startDate">시작 날짜:</label>
    <input type="date" id="startDate" name="startDate" value="${param.startDate}">
    
    <label for="endDate">종료 날짜:</label>
    <input type="date" id="endDate" name="endDate" value="${param.endDate}">
    
    <label for="keyword">키워드:</label>
    <input type="text" id="keyword" name="keyword" value="${param.keyword}">
    
    <button type="submit">검색</button>
    <button type="button" onclick="resetForm()">초기화</button>
    <script>
    // 폼 초기화 함수
    function resetForm() {
        document.getElementById('searchForm').reset(); // 폼의 모든 입력값을 초기화
        // 날짜 input 초기화 (브라우저에서 기본값으로 설정됨)
        document.getElementById('startDate').value = '';
        document.getElementById('endDate').value = '';
    }
	</script>
    


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