<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
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
            justify-content: center;
            align-items: center;
        }

        .login-box {
            width: 400px;
            background: #FFFFFF;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }

        .login-box img {
            width: 80px;
            margin-bottom: 20px;
        }

        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .login-box button {
            width: 100%;
            padding: 10px;
            background-color: #0169A6;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .login-box button:hover {
            background-color: #005b90;
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
            color: #0169A6;
        }

        .links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-box">
            <!-- <img src="about_us_icon.png" alt="About Us"> -->
            <form action="loginProcess.jsp" method="post">
                <input type="text" name="email" placeholder="이메일" required>
                <input type="password" name="password" placeholder="비밀번호" required>
                <button type="submit">로그인하기</button>
            </form>
            <div class="links">
                <a href="/member/join">회원가입</a>
                <a href="/member/findPassword">비밀번호 찾기</a>
            </div>
            <div class="footer">
                회사 정보 - 사업자 번호, 연락처 등 추가 정보
            </div>
        </div>
    </div>
</body>
</html>