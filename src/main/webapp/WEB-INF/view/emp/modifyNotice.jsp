<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop - 공지 수정</title>
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

/* 상단 영역 전체 고정 */
.header-fixed-container {
    width: 100%;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); 
    position: sticky;
    top: 0;
    z-index: 1000;
}

/* 컨텐츠를 중앙에 모으는 내부 래퍼 */
.inner-wrapper {
    width: 90%;
    max-width: 1100px;
    margin: 0 auto;
    padding: 0 10px;
}

/* -------------------- 2. 상단 사용자 정보 및 메뉴 영역 -------------------- */

.top-bar {
    padding: 10px 0;
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

.user-info {
    display: flex;
    align-items: center;
    font-size: 14px;
}

/* 로그아웃 버튼 CSS */
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

.emp-menu-area {
    width: 100%;
    background-color: #f8f9fa;
    border-top: 1px solid #dee2e6;
    border-bottom: 2px solid #007bff;
}

/* 메뉴 링크 스타일 */
.emp-menu-area .inner-wrapper > div {
    display: flex;
    justify-content: center;
}

.emp-menu-area a { 
    text-decoration: none;
    padding: 15px 20px;
    color: #495057;
    font-weight: 600;
    transition: all 0.3s ease;
    font-size: 15px;
    border-bottom: 3px solid transparent;
}

.emp-menu-area a:hover {
    color: #007bff;
    border-bottom: 3px solid #007bff;
}

/* -------------------- 3. 중앙 컨텐츠 영역 및 제목 -------------------- */
.content-area {
    width: 90%;
    max-width: 1100px;
    margin: 40px auto;
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
}

h1 {
    color: #212529;
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 25px;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 10px;
}

/* 4. 수정 폼 테이블 스타일 (notice-detail-table 스타일 활용) */
.notice-form-table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
    margin-top: 20px;
    font-size: 15px;
}

.notice-form-table td {
    padding: 12px 15px;
    border: 1px solid #dee2e6;
    vertical-align: top;
}

.notice-form-table tr td:first-child { /* 레이블 컬럼 */
    width: 150px;
    background-color: #f2f2f2;
    text-align: center;
    font-weight: bold;
}

/* 입력 필드 스타일 */
.notice-form-table input[type="text"],
.notice-form-table textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box; 
    resize: vertical; 
}


/* 5. 액션 버튼 스타일 (링크와 버튼 크기 통일) */
.action-button {
    display: inline-block;
    padding: 8px 15px;
    margin-left: 10px;
    background-color: #6c757d; 
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-weight: bold;
    transition: background-color 0.3s;
    border: none; 
    box-sizing: border-box; 
    cursor: pointer;
    font-size: 14px;
    line-height: 1.42857; 
}

/* `<button>` 태그를 위한 추가 설정 */
.action-button[type="submit"] { 
    padding: 8px 15px;
    margin-left: 10px;
    display: inline-block;
}

.action-button:hover {
    background-color: #5a6268;
}

.primary-button { /* 수정 완료 버튼에 사용할 파란색 */
    background-color: #007bff;
}

.primary-button:hover {
    background-color: #0056b3;
}

.secondary-button { /* 취소 버튼에 사용할 회색 */
    background-color: #6c757d;
}

.secondary-button:hover {
    background-color: #5a6268;
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
        <form action="${pageContext.request.contextPath}/emp/modifyNotice" method="post">
            <h1>공지 수정</h1>
		    
		    <table class="notice-form-table">
			    <tr>
				    <td>공지 제목</td>
				    <td>
					    <input type="text" name="noticeTitle" value="${notice.noticeTitle}" required>
				    </td>
			    </tr>
			    <tr>
				    <td>공지 내용</td>
				    <td>
					    <textarea name="noticeContent" rows="6" cols="50" required>${notice.noticeContent}</textarea>
				    </td>
			    </tr>
		    </table>

		    <input type="hidden" name="noticeCode" value="${notice.noticeCode}">

            <div style="margin-top: 20px; text-align: right;">
                <a href="${pageContext.request.contextPath}/emp/noticeOne?noticeCode=${notice.noticeCode}" class="action-button secondary-button">취소</a>
                <button type="submit" class="action-button primary-button">수정 완료</button>
            </div>
            
	    </form>
	</div>
</body>
</html>