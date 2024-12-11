<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 목록</title>
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
            <!-- categories 리스트를 반복하여 테이블로 출력 -->
            <c:forEach var="category" items="${categories}">
                <tr>
                    <td>${category.categoryId}</td>
                    <td>${category.parentId != null ? category.parentId : '없음'}</td>
                    <td>${category.categoryName}</td>
                    <td>${category.level == 1 ? '대분류' : '소분류'}</td>
                    <td>${category.createdAt}</td>
                    <td>
                        <!-- 수정 버튼 -->
                        <form action="/category/edit" method="get" style="display: inline;">
                            <input type="hidden" name="categoryId" value="${category.categoryId}" />
                            <button type="submit">수정</button>
                        </form>
                        <!-- 삭제 버튼 -->
                        <form action="/category/delete" method="post" style="display: inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <input type="hidden" name="categoryId" value="${category.categoryId}" />
                            <button type="submit">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- 카테고리 등록 링크 -->
    <a href="/category/register">카테고리 등록</a>
</body>
</html>
