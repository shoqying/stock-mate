<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인 페이지</title>
<style>
/* Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #121212;
    color: #ffffff;
    line-height: 1.6;
}

/* Fullscreen Header Section */
.header {
    height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #1e3c72, #2a5298);
    color: #ffffff;
    text-align: center;
    position: relative;
}

.header::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url('resources/css/stockmate.png') no-repeat center center/contain;
    opacity: 0.1;
    z-index: 0;
}

.header h1 {
    font-size: 4rem;
    font-weight: bold;
    margin-bottom: 20px;
    z-index: 1;
}

.header p {
    font-size: 1.5rem;
    margin-top: 10px;
    color: #dcdcdc;
    z-index: 1;
}

/* Navigation */
.nav {
    display: flex;
    justify-content: center;
    padding: 15px 0;
    background: #333333;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.nav a {
    color: #ffffff;
    text-decoration: none;
    margin: 0 15px;
    padding: 10px 20px;
    font-weight: bold;
    border: 2px solid #007BFF;
    border-radius: 5px;
    transition: all 0.3s ease;
    box-shadow: 0 0 10px #007BFF, 0 0 20px #0056b3;
}

.nav a:hover {
    background: #007BFF;
    color: #fff;
    transform: scale(1.1);
    box-shadow: 0 0 15px #007BFF, 0 0 30px #0056b3;
}

/* Content Section */
.content {
    text-align: center;
    padding: 50px 20px;
    background: #1e1e1e;
    border-top: 4px solid #007BFF;
    border-radius: 10px 10px 0 0;
    box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.4);
}

.content h2 {
    color: #007BFF;
    font-size: 2.5rem;
    margin-bottom: 15px;
}



/* Row Layout */
.content .row {
    display: flex;
    justify-content: center;
    gap: 30px;
}

.content .column {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    max-width: 500px;
    overflow: hidden;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.content .column img {
    width: 100%;
    height: 400px;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.content .column img:hover {
    transform: scale(1.1);
}

/* Footer */
.footer {
    background: #333333;
    color: #ffffff;
    padding: 20px 10px;
    text-align: center;
    font-size: 0.9rem;
    box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.3);
}

.footer a {
    color: #007BFF;
    text-decoration: none;
    transition: color 0.3s;
}

.footer a:hover {
    color: #0056b3;
    text-decoration: underline;
}



.map-section {
    display: flex;
    flex-direction: column;
    align-items: center; /* 가운데 정렬 */
    justify-content: center;
    text-align: center;
    height: 60vh;
}

.map-section img {
    max-width: 1050px; /* 이미지 최대 너비 설정 */
    width: 100%; /* 반응형 이미지 크기 */
    height: auto;
    transition: transform 0.3s ease; /* 부드럽게 확대 효과 */
}

.map-section img:hover {
    transform: scale(1.5); /* 이미지 안에서만 확대 */
}

</style>
</head>
<body>
    <!-- Fullscreen Header -->
    <div class="header">
        <h1>Warehouse Management Solutions</h1>
        <p>스마트한 재고 관리와 최적화된 물류 시스템을 제공합니다.</p>
    </div>

    <!-- Navigation -->
    <div class="nav">
        <a href="user/signup">회원가입</a>
        <a href="user/signin">로그인</a>
        <a href="/howtouse">대시보드 사용법</a>
        <a href="/intro">회사소개</a>
        <a href="/location">창고소개</a>
        <a href="/price">임대료</a>
        <a href="/consultation">상담문의</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h1>20년 노하우의 Stock-mate</h1>
      
        <div class="row">
            <div class="column">
                <img src="resources/css/9950253.jpg" alt="Warehouse Exterior">
            </div>
            <div class="column">
                <img src="resources/css/36140.jpg" alt="Warehouse Interior">
            </div>
        </div>
    </div>

   <!-- Map Section -->
    <div class="map-section">
        <h3>회사 약도</h3>
        <img src="resources/css/약도.png" alt="회사 약도">
    </div>

<!-- Additional Contact Info -->
<div class="contact-info" style="text-align: center; margin: 20px 0; color: #ffffff;">
    <h3 style="color: #007BFF;">문의사항</h3>
    <p>대표번호: <strong>031-532-0223</strong></p>
    <p>영업문의: <strong>황성인 센터장 010-5555-6354</strong></p>
    <p style="font-size: 0.9rem;">경기 용인시 처인구 양지면 주북로 105-5</p>
</div>



    <!-- Back Button -->
    <div class="back-button">
        <a href="#">뒤로 돌아가기</a>
    </div>


    <!-- Footer -->
    <div class="footer">
        회사 정보 - 사업자 번호, 연락처 등 유의 사항<br>
        <a href="#">개인정보 처리방침</a> | <a href="#">이용약관</a>
    </div>
</body>
</html>
