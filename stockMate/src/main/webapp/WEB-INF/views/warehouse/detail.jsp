<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>창고 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/warehouseDetailStyle.css' />">
</head>
<body>
    <div class="container">
        <h1>창고 상세 정보</h1>
        <table>
            <tr>
                <th>창고 이름</th>
                <td>${warehouse.warehouseName}</td>
            </tr>
            <tr>
                <th>창고 지역</th>
                <td>${warehouse.region}</td>
            </tr>
            <tr>
                <th>상세 주소</th>
                <td>${warehouse.location}</td>
            </tr>
            <tr>
                <th>회사명</th>
                <td>${warehouse.businessName}</td>
            </tr>
            <tr>
                <th>관리자명</th>
                <td>${warehouse.managerName}</td>
            </tr>
            <tr>
                <th>창고 용량</th>
                <td>${warehouse.capacity}</td>
            </tr>
            <tr>
                <th>상세 설명</th>
                <td>${warehouse.warehouseDescription}</td>
            </tr>
            <tr>
                <th>상태</th>
                <td>${warehouse.status}</td>
            </tr>
            <tr>
                <th>등록 날짜</th>
                <td>${warehouse.createdAt}</td>
            </tr>
            <tr>
                <th>수정 날짜</th>
                <td>${warehouse.updatedAt}</td>
            </tr>
        </table>
        <button onclick="location.href='/warehouse/list'">목록으로 돌아가기</button>
    </div>
</body>
</html>
