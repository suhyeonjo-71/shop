<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop - 공지사항 상세</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
/* -------------------- 1. 기본 설정 및 레이아웃 -------------------- */
body {
    background-color: #f8f9fa; /* [cite: 3] */
    color: #343a40; /* [cite: 4] */
    margin: 0;
    padding: 0;
    line-height: 1.6;
    min-height: 100vh;
}

/* 상단 영역 전체 고정 (empIndex와 동일) */
.header-fixed-container {
    width: 100%;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* [cite: 6] */
    position: sticky;
    top: 0;
    z-index: 1000;
}

/* 컨텐츠를 중앙에 모으는 내부 래퍼 */
.inner-wrapper {
    width: 90%;
    max-width: 1100px; /* [cite: 8] */
    margin: 0 auto;
    padding: 0 10px; /* [cite: 9] */
}

/* -------------------- 2. 상단 사용자 정보 및 메뉴 영역 -------------------- */

.top-bar {
    padding: 10px 0; /* [cite: 10] */
    display: flex; /* [cite: 10] */
    justify-content: flex-end;
    align-items: center;
}

.user-info {
    display: flex; /* [cite: 11] */
    align-items: center;
    font-size: 14px;
}

.logout-btn {
    text-decoration: none;
    padding: 6px 12px;
    margin-left: 15px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px; /* [cite: 13] */
    font-weight: bold; /* [cite: 13] */
    transition: background-color 0.3s ease;
}

.logout-btn:hover {
    background-color: #0056b3; /* [cite: 14] */
}

.emp-menu-area {
    width: 100%;
    background-color: #f8f9fa;
    border-top: 1px solid #dee2e6;
    border-bottom: 2px solid #007bff; /* [cite: 16] */
}

.emp-menu-area .inner-wrapper > div {
    display: flex; /* [cite: 16] */
    justify-content: center;
}

/* -------------------- 3. 컨텐츠 영역 및 제목 -------------------- */
.content-area {
    width: 90%;
    max-width: 1100px; /* [cite: 21] */
    margin: 40px auto;
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px; /* [cite: 22] */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05); /* [cite: 22] */
}

h1 {
    color: #212529;
    font-size: 26px;
    font-weight: 700; /* [cite: 23] */
    margin-bottom: 25px;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 10px;
}

/* 4. 공지 상세 테이블 스타일 (noticeList의 data-table 스타일 활용 및 수정) */
.notice-detail-table {
    width: 100%;
    border-collapse: collapse; /* [cite: 26] */
    text-align: left;
    margin-top: 20px;
    font-size: 15px; /* [cite: 27] */
}

.notice-detail-table th,
.notice-detail-table td {
    padding: 12px 15px; /* [cite: 28] */
    border: 1px solid #dee2e6; /* [cite: 28] */
    vertical-align: top;
}

.notice-detail-table th {
    width: 150px;
    background-color: #f2f2f2; /* [cite: 29] */
    text-align: center;
    font-weight: bold;
}

.notice-content-row td {
    min-height: 100px; /* 내용 영역을 넓게 확보 */
    white-space: pre-wrap; /* 내용 포맷 유지 */
}
</style>
</head>
<body>
    
    <div class="header-fixed-container">
        <div class="top-bar inner-wrapper">
            <div class="user-info">
                <span>${loginEmp.empName}님 반갑습니다.</span>
                <a href="${pageContext.request.contextPath}/emp/empLogout" class="logout-btn">로그아웃</a>
            </div>
        </div>
        
        <div class="emp-menu-area"> 
             <div class="inner-wrapper">
                <c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
             </div>
        </div>
    </div>
    
    <div class="content-area">
		<h1>공지사항 상세 내용</h1>
		
        <table class="notice-detail-table">
            <tr>
                <th>공지 제목 (noticeIitle)</th>
                <td>${noticeTitle}</td>
            </tr>
            <tr class="notice-content-row">
                <th>공지 내용 (noticeContent)</th>
                <td>${noticeContent}</td>
            </tr>
            <tr>
                <th>작성 직원 번호 (empNo)</th>
                <td>${empNo}</td>
            </tr>
        </table>
        
        <div style="margin-top: 20px; text-align: right;">
             <a href="${pageContext.request.contextPath}/emp/noticeList" class="add-button">목록으로 돌아가기</a>
        </div>
        
	</div>
</body>
</html>