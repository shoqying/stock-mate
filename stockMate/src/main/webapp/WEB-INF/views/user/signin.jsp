<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<style>
/* Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Roboto', Arial, sans-serif;
    background: linear-gradient(135deg, #6a11cb, #2575fc);
    color: #333333;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.login-container {
    background: #ffffff;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
    width: 400px;
}

.login-container h2 {
    font-size: 24px;
    margin-bottom: 20px;
    color: #6a11cb;
    text-align: center;
}

.login-container form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.login-container input {
    padding: 12px;
    border: 1px solid #cccccc;
    border-radius: 8px;
    font-size: 14px;
}

.login-container button {
    padding: 12px;
    background-color: #6a11cb;
    color: #ffffff;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.login-container button:hover {
    background-color: #2575fc;
}

.links {
    margin-top: 15px;
    text-align: center;
}

.links a {
    color: #6a11cb;
    text-decoration: none;
    font-size: 14px;
    margin: 0 10px;
}

.links a:hover {
    text-decoration: underline;
}

.footer {
    margin-top: 20px;
    font-size: 12px;
    color: #777777;
    text-align: center;
}
</style>
</head>
<body>
    <div class="login-container">
        <h2>로그인</h2>
        <form action="/user/login" method="post">
            <input type="email" name="email" placeholder="이메일" required>
            <input type="password" name="password" placeholder="비밀번호" required>
            <button type="submit">로그인</button>
        </form>
        <div class="links">
            <a href="/user/signup">회원가입</a>
            <a href="/user/findpassword">비밀번호 찾기</a>
        </div>
        <div class="footer">© 2024 회사 정보 - 사업자 번호, 연락처 등</div>
    </div>
</body>
</html>
