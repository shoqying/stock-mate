<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>카테고리 목록</title>
	<style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            table-layout: fixed;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            word-break: break-word;
        }

        th {
            background-color: #007BFF;
            color: #fff;
            position: sticky;
            top: 0;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        a {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .low-stock {
            color: red;
            font-weight: bold;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
    </style>
</head>
<body>
    <h1>/views/category/list.jsp</h1>

    <h2>카테고리 목록 정보 출력</h2>

	<table border="1">
	    <thead>
	        <tr>
	            <th>카테고리 ID</th>
	            <th>상위 카테고리 ID</th>
	            <th>카테고리 이름</th>
	            <th>레벨</th>
	            <th>생성 날짜</th>
	            <th>액션</th>
	        </tr>
	    </thead>
	    <tbody>
	        <!-- 계층별로 카테고리를 표시 -->
	        <c:forEach var="category" items="${categories}">
	            <tr>
	                <td>${category.categoryId}</td>
	                <td>${category.parentId != null ? category.parentId : '없음'}</td>
	                <td style="padding-left: ${category.level * 20}px;">
	                    ${category.categoryName}
	                </td>
	                <td>${category.level}</td>
	                <td>${category.createdAt}</td>
	                <td>
	                    <form action="/category/edit" method="get" style="display: inline;">
	                        <input type="hidden" name="categoryId" value="${category.categoryId}" />
	                        <button type="submit">수정</button>
	                    </form>
	                    <form action="/category/delete" method="post" style="display: inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
	                        <input type="hidden" name="categoryId" value="${category.categoryId}" />
	                        <button type="submit">삭제</button>
	                    </form>
	                </td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	
	<a href="/category/register">카테고리 등록</a>
</body>
</html>
