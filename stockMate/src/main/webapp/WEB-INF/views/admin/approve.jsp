<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>승인 대기 사용자 리스트</title>
</head>
<body>
<h1>승인 대기 사용자 리스트</h1>
<table border="1">
    <thead>
        <tr>
            <th>사용자 ID</th>
            <th>이메일</th>
            <th>이름</th>
            <th>역할</th>
            <th>전화번호</th>
            <th>사업자등록번호</th>
            <th>회사명</th>
            <th>가입 날짜</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="user" items="${pendingUsers}">
            <tr>
                <td>${user.userId}</td>
                <td>${user.email}</td>
                <td>${user.userName}</td>
                <td>${user.userRole}</td>
                <td>${user.telNumber}</td>
                <td>${user.businessNumber}</td>
                <td>${user.businessName}</td>
                <td>${user.createdAt}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</body>
</html>
