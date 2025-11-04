<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* -------------------- 1. 기본 설정 및 레이아웃 -------------------- */
body {
    background-color: #f8f9fa;
    color: #343a40;
    margin: 0;
    padding: 0;
    line-height: 1.6;
    min-height: 100vh;
}

/* 상단 영역 전체 고정을 위한 컨테이너 */
.header-fixed-container {
    width: 100%;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
}

/* 컨텐츠를 중앙에 모으는 내부 래퍼 (최대 너비 설정) */
.inner-wrapper {
    width: 90%;
    max-width: 1100px;
    margin: 0 auto;
    padding: 0 10px;
}

/* -------------------- 2. 상단 사용자 정보 영역 -------------------- */
.top-bar {
    padding: 10px 0;
    display: flex;
    justify-content: flex-end; /* 사용자 정보 우측 정렬 */
    align-items: center;
}

/* 제목은 컨텐츠 내부로 이동 */
h1 {
    color: #212529;
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 25px;
    border-bottom: 2px solid #e9ecef; /* 제목 아래 구분선 추가 */
    padding-bottom: 10px;
}

/* 사용자 정보 및 로그아웃 영역 */
.user-info {
    display: flex;
    align-items: center;
    font-size: 14px;
}
/* 포인트 정보 강조 */
.user-info span strong {
    color: #007bff; /* 포인트 컬러 */
}

/* 로그아웃 버튼 */
.logout-btn {
    text-decoration: none;
    padding: 6px 12px;
    margin-left: 15px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

.logout-btn:hover {
    background-color: #0056b3;
}

/* -------------------- 3. 메뉴 (내비게이션 바) 스타일 (고객 메뉴가 있다면 여기에 정의) -------------------- */
.cust-menu-area { /* emp 대신 cust 클래스 사용 */
    width: 100%;
    background-color: #f8f9fa;
    border-top: 1px solid #dee2e6;
    border-bottom: 2px solid #007bff;
}

.cust-menu-area .inner-wrapper > div {
    display: flex;
    justify-content: center; 
}

/* 메뉴 링크 스타일 */
.cust-menu-area a {
    text-decoration: none;
    padding: 15px 20px;
    color: #495057;
    font-weight: 600;
    transition: all 0.3s ease;
    font-size: 15px;
    border-bottom: 3px solid transparent;
}

/* 메뉴 링크 호버/액티브 스타일 */
.cust-menu-area a:hover {
    color: #007bff;
    border-bottom: 3px solid #007bff;
}

/* -------------------- 4. 컨텐츠가 들어갈 공간 -------------------- */
.content-area {
    width: 90%;
    max-width: 1100px;
    margin: 40px auto;
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
}
</style>
</head>
<body>
    <div class="header-fixed-container">
        <div class="top-bar inner-wrapper">
            <div class="user-info">
                <span>
                    ${sessionScope.loginCustomer.customerName}님 반갑습니다.
                    (point : <strong>${sessionScope.loginCustomer.point}</strong>)
                </span>
                <a href="${pageContext.request.contextPath}/customer/customerLogout" class="logout-btn">로그아웃</a>
            </div>
        </div>
        
        <div class="cust-menu-area">
             <div class="inner-wrapper">
                <p style="margin: 0; padding: 15px; color: #adb5bd;">[고객 메뉴 위치]</p> 
             </div>
        </div>
    </div>

    <div class="content-area">
        <h1>customerIndex</h1>
        <p>고객 메인 페이지입니다. 이용 가능한 서비스는 상단 또는 하단 메뉴를 참조하세요.</p>
    </div>
</body>
</html>