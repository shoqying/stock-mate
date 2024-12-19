<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
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
    color: #ffffff;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.signup-container {
    background: #ffffff;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
    width: 400px;
    text-align: center;
}

.signup-container h2 {
    color: #6a11cb;
    font-size: 24px;
    margin-bottom: 20px;
}

.signup-container input,
.signup-container select {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
}

.signup-container button {
    width: 100%;
    padding: 12px;
    margin-top: 20px;
    background-color: #6a11cb;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.signup-container button:hover {
    background-color: #2575fc;
}

.footer {
    margin-top: 15px;
    font-size: 12px;
    color: #666666;
}
</style>
</head>
<body>
    <div class="signup-container">
        <h2>회원가입</h2>
        <form action="/user/signup" method="post">
            <input type="email" name="email" placeholder="이메일" required>
            <input type="password" name="password" placeholder="비밀번호" required>
            <input type="text" name="username" placeholder="이름" required>
            <input type="tel" name="phone" placeholder="전화번호" required>
            <select name="role" required>
                <option value="" disabled selected>역할 선택</option>
                <option value="ADMIN">관리자</option>
                <option value="MANAGER">매니저</option>
                <option value="STAFF">직원</option>
            </select>
            <button type="submit">가입하기</button>
        </form>
        <div class="footer">© 2024 회사 정보 - 사업자 번호, 연락처 등</div>
    </div>
</body>
</html>
