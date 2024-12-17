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

.content p {
    font-size: 1.2rem;
    color: #bbbbbb;
    line-height: 1.8;
    margin-bottom: 30px;
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

.map-section{
margin: 0 auto;
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
        <a href="/consultation">상담문의</a>
        <a href="/intro">회사소개</a>
        <a href="/location">창고소개</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h2>20년 노하우의 지산그룹이 만든 안성창고</h2>
        <p>긍정 마인드를 통해 끊임없이 새로운 변화를 추구하고 있습니다</p>


<p> 걸림돌을 디딤돌로 긍정의 끝은 무한한 가능성!</p>
<p>지산그룹은 지난 1999년 창립 이후 오늘에 이르기까지 물류센터 개발, 운영 등 물류분야와 국내 PC업계 최초의 스마트 팩토리 구현 등
축적된 기술력과 차별화된 경영전략 및 인적구성으로 최고의 서비스를 제공해 왔습니다.
특히 건설전문가 집단의 역량을 살려 폭 넓은 지식과 경험을 바탕으로 분야별 전문 인력으로 구성되어 설계, 생산, 조립, 건설사업관리,
프로젝트관리 등 부동산 개발의 전 분양에 걸쳐 자부심을 가지며 국내 최고의 물류센터와 PC개발 전문기업으로 앞서 나아가고 있습니다.
어떠한 난관도 불가능한 것이 없다는 긍정 마인드를 통해 끊임없이 새로운 변화를 추구하는 지산그룹은 고객 여러분과 함께 하겠습니다.</p>





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
