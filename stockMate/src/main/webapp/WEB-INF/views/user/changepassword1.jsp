<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 확인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #fff;
            margin: 0 15%;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
        }
        .back-button {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            width: 100%;
            margin-bottom: 20px;
        }
        .back-button a {
            text-decoration: none;
            font-size: 18px;
            color: #007BFF;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        .back-button a:hover {
            text-decoration: underline;
        }
        .back-button svg {
            margin-right: 5px;
            fill: #007BFF;
        }
        h1 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }
        input {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            width: 80%;
            padding: 10px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .footer {
            background-color: #222;
            color: #ccc;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <!-- Container -->
    <div class="container">
        <div class="back-button">
            <a href="/dashboard">
                <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24">
                    <path d="M0 0h24v24H0z" fill="none"/>
                    <path d="M15.41 7.41L14 6l-6 6 6 6 1.41-1.41L10.83 12z"/>
                </svg>
                뒤로 가기
            </a>
        </div>
        <h1>비밀번호를 입력하세요</h1>
        <form method="post">
            <input type="password" name="password" placeholder="비밀번호" required>
            <button type="submit">내 정보 수정하기</button>
        </form>
    </div>

    <!-- Footer -->
    <div class="footer">
        회사 정보 - 사업자 번호, 연락처 등 유의 내용
    </div>
</body>
</html>
