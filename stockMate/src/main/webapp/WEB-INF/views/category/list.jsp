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
    <h1>카테고리 목록</h1>

    <table border="1">
        <thead>
            <tr>
                <th>카테고리 이름</th>
                <th>상위 카테고리</th>
                <th>계층</th>
                <th>생성 날짜</th>
                <th>액션</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="category" items="${categories}">
                <!-- 상위 카테고리 -->
                <c:if test="${category.parentId == null}">
                    <tr>
                        <td>${category.categoryName}</td>
                        <td>없음</td>
                        <td>대분류</td>
                        <td><fmt:formatDate value="${category.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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

                    <!-- 하위 카테고리 -->
                    <c:forEach var="subCategory" items="${categories}">
                        <c:if test="${subCategory.parentId == category.categoryId}">
                            <tr>
                                <td style="padding-left: 20px;">└ ${subCategory.categoryName}</td>
                                <td>${category.categoryName}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${subCategory.level == 2}">중분류</c:when>
                                        <c:when test="${subCategory.level == 3}">소분류</c:when>
                                        <c:otherwise>소분류${subCategory.level - 3}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${subCategory.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                <td>
                                    <form action="/category/edit" method="get" style="display: inline;">
                                        <input type="hidden" name="categoryId" value="${subCategory.categoryId}" />
                                        <button type="submit">수정</button>
                                    </form>
                                    <form action="/category/delete" method="post" style="display: inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                        <input type="hidden" name="categoryId" value="${subCategory.categoryId}" />
                                        <button type="submit">삭제</button>
                                    </form>
                                </td>
                            </tr>

                            <!-- 하위의 하위 카테고리 -->
                            <c:forEach var="childCategory" items="${categories}">
                                <c:if test="${childCategory.parentId == subCategory.categoryId}">
                                    <tr>
                                        <td style="padding-left: 40px;">└ ${childCategory.categoryName}</td>
                                        <td>${subCategory.categoryName}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${childCategory.level == 3}">소분류</c:when>
                                                <c:otherwise>소분류${childCategory.level - 3}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><fmt:formatDate value="${childCategory.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                        <td>
                                            <form action="/category/edit" method="get" style="display: inline;">
                                                <input type="hidden" name="categoryId" value="${childCategory.categoryId}" />
                                                <button type="submit">수정</button>
                                            </form>
                                            <form action="/category/delete" method="post" style="display: inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                                <input type="hidden" name="categoryId" value="${childCategory.categoryId}" />
                                                <button type="submit">삭제</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </tbody>
    </table>
    <a href="/category/register">카테고리 등록</a>
</body>
</html>
