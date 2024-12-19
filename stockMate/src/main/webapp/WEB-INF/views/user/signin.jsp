<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bannerStyle.css' />">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #F2F2F2;
        }
        .container {
            width: 100%;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .login-box {
            width: 400px;
            background: #FFFFFF;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
        }
        .login-box input[type="email"], .login-box input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .login-box button {
            width: 100%;
            padding: 12px;
            background-color: #007AFF;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }
        .login-box button:hover {
            background-color: #005BBB;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            color: #666666;
            font-size: 12px;
        }
        .links {
            margin-top: 10px;
            display: flex;
            justify-content: space-between;
        }
        .links a {
            font-size: 14px;
            text-decoration: none;
            color: #007AFF;
        }
        .links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
		<%-- 에러 메시지 표시 --%>
		<c:if test="${not empty errorMessage}">
		    <div class="error-banner">${errorMessage}</div>
		</c:if>
		
		<%-- 성공 메시지 표시 --%>
		<c:if test="${not empty successMessage}">
			<div class="success-banner">${successMessage}</div>
		</c:if>

        <div class="login-box">
            <form id="loginForm" method="post">
                <!-- 이메일 필드 -->
                <input type="email" name="email" placeholder="이메일" required="required" autofocus="autofocus" aria-label="이메일 입력 필드" autocomplete="email">

                <!-- 비밀번호 필드 -->
                <input type="password" name="password" placeholder="비밀번호" required aria-label="비밀번호 입력 필드" autocomplete="current-password">

                <!-- 로그인 버튼 -->
                <button type="submit" aria-label="로그인 버튼">로그인</button>
            </form>
            <div class="links">
                <a href="/user/signup">회원가입</a>
                <a href="/user/findPassword">비밀번호 찾기</a>
            </div>
            <div class="footer">회사 정보 - 사업자 번호, 연락처 등 추가 정보</div>
        </div>
    </div>
</body>
</html>