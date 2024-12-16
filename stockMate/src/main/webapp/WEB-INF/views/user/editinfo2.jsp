<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 수정</title>
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
            margin-bottom: 30px;
            font-size: 24px;
            color: #333;
        }
        .form-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            width: 100%;
        }
        .form-group {
            flex: 0 0 calc(50% - 10px);
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .form-group label {
            font-size: 16px;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 18px;
            box-sizing: border-box;
        }
        button {
            margin-top: 30px;
            width: 100%;
            padding: 15px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
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
        <!-- 뒤로가기 버튼 -->
        <div class="back-button">
            <a href="/dashboard">
                <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24">
                    <path d="M0 0h24v24H0z" fill="none"/>
                    <path d="M15.41 7.41L14 6l-6 6 6 6 1.41-1.41L10.83 12z"/>
                </svg>
                뒤로 가기
            </a>
        </div>

        <!-- 제목 -->
        <!-- 회원정보 수정 폼 -->
        <h1>회원정보 수정</h1>
<form action="/user/updateInfo2" method="post">
    <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" id="email" name="email" 
               value="${userVO.email}" placeholder="이메일을 입력하세요" required>
    </div>
    <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="name" name="name" 
               value="${userVO.name}" placeholder="이름을 입력하세요" required>
    </div>
    <div class="form-group">
        <label for="telNumber">전화번호</label>
        <input type="tel" id="telNumber" name="telNumber" 
               value="${userVO.telNumber}" placeholder="전화번호를 입력하세요" required>
    </div>
    <button type="submit">내 정보 수정하기</button>
</form>       
       
       
     

    <!-- Footer -->
    <div class="footer">
        회사 정보 - 사업자 번호, 연락처 등 유의 내용
    </div>
</body>
</html>
