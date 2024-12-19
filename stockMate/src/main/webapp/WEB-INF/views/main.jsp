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

/* 모달 기본 스타일 */
.modal {
    display: none; /* 숨김 처리 */
    position: fixed;
    top: 60%; /* 화면 상단에서 20% 아래에 표시 */
    left: 50%;
    transform: translate(-50%, -20%);
    z-index: 1000;
    background-color: rgba(0, 0, 0, 0.8);
    width: 100%;
    height: 100%;
    z-index: 999; /* 모달 뒤 배경 */
    box-shadow: 0 8px 20px 8px rgba(0, 0, 0, 0.4); /* 전체적으로 그림자 효과 추가 */
     
}

/* 모달 내용 */
.modal-content {
    background-color: #f9f9f9; /* 밝고 부드러운 배경색 */
    color: #1a1a1a; /* 어두운 텍스트 색상 */
     border: 4px solid #007BFF; /* 파란색 테두리 */
    margin: auto;
    padding: 30px; /* 더 넉넉한 내부 여백 */
    border-radius: 16px; /* 더 둥근 모서리 */
    width: 40%; /* 적절한 크기 */
    max-width: 600px; /* 최대 너비 제한 */
    position: relative;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25); /* 부드러운 그림자 효과 */
    modal-overlay: rgba(0, 0, 0, 0.6)
    animation: fadeIn 0.3s ease; /* 팝업 열리는 애니메이션 */
    transition: all 0.3s ease; /* 부드러운 상태 전환 */
}



/* 닫기 버튼 */
.close {
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 24px;
    font-weight: bold;
    color: #333333;
    cursor: pointer;
}

.close:hover {
    color: red;
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
        <a href="https://map.naver.com/p/search/%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EC%9A%A9%EC%9D%B8%EC%8B%9C%20%EC%B2%98%EC%9D%B8%EA%B5%AC%20%EC%96%91%EC%A7%80%EB%A9%B4%20%EC%A3%BC%EB%B6%81%EB%A1%9C%20103-1/address/14164717.7610606,4473895.3924035,%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EC%9A%A9%EC%9D%B8%EC%8B%9C%20%EC%B2%98%EC%9D%B8%EA%B5%AC%20%EC%96%91%EC%A7%80%EB%A9%B4%20%EC%A3%BC%EB%B6%81%EB%A1%9C%20103-1,new?searchType=address&isCorrectAnswer=true&c=15.00,0,0,0,dh" target="_blank">오시는 길</a>
    </div>

    <!-- Footer -->
    <div class="footer">
        <a href="javascript:void(0);" onclick="showTerms();">이용약관</a> | 
        <a href="javascript:void(0);" onclick="showPrivacyPolicy();">개인정보취급방침</a>
    </div>

    <!-- '이용약관' 모달 -->
    <div id="termsModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal();">&times;</span>
            <h2>용인창고 이용약관</h2>
            <p>
                제 1조 총칙<br>
                이 약관은 stock-mate(이하 "회사")가 제공하는 모든 서비스의 이용조건 및 절차, 기타 필요한 사항을 규정함을 목적으로 합니다.
            </p>
            <p>
                제 2조 약관의 효력과 변경<br>
                (1) 이 약관은 본 사이트에 공지함으로써 효력을 발휘합니다.<br>
                (2) 회사는 필요 시 약관을 변경할 수 있으며, 변경된 약관은 사이트에 게시하거나 기타 방법으로 공지합니다.
            </p>
        </div>
    </div>

    <!-- '개인정보취급방침' 모달 -->
    <div id="privacyModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closePrivacyModal();">&times;</span>
            <h2>개인정보취급방침</h2>
            <p>
                안성창고 회원의 개인 정보 보호를 매우 중요시하며, <br>
                <strong>[정보통신망 이용 촉진 등에 관한 법률]</strong>을 준수하고 있습니다.<br>
                고객님의 개인 정보 보호를 위해 최선을 다하겠습니다.
            </p>
            <p>
                1. 개인정보의 수집 및 이용 목적<br>
                (주)안성물류터미널(http://www.namsa.kr)은 고객의 정보보호에 대한 <br>
                이용자의 개별적인 요구를 존중하며 관련법을 준수하기 위해 노력합니다.
            </p>
            <p>
                - 본 방침은 2020년 10월 19일부터 시행됩니다.
            </p>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        function showTerms() {
            document.getElementById("termsModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("termsModal").style.display = "none";
        }

        function showPrivacyPolicy() {
            document.getElementById("privacyModal").style.display = "block";
        }

        function closePrivacyModal() {
            document.getElementById("privacyModal").style.display = "none";
        }
    </script>
</body>
</html>
