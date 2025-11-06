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

/* 상단 영역 전체 고정 (empIndex와 동일) */
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

/* -------------------- 2. 상단 사용자 정보 및 메뉴 영역 (empIndex와 동일) -------------------- */

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

/* -------------------- 3. 컨텐츠 영역 및 제목 -------------------- */
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

/* -------------------- 4. 테이블 (리스트) 스타일 -------------------- */
.data-container {
    margin-top: 20px;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
    margin-bottom: 20px;
    font-size: 15px;
}

.data-table th,
.data-table td {
    padding: 12px 15px;
    border: 1px solid #dee2e6;
}

/* 테이블 헤더 */
.data-table thead tr {
    background-color: #f2f2f2;
    text-align: center;
    font-weight: bold;
}

/* 테이블 바디 행 */
.data-table tbody tr:hover {
    background-color: #e9f5ff;
}

/* -------------------- 5. 페이지네이션 스타일 -------------------- */
.pagination {
    text-align: center;
    padding: 10px 0;
}

.pagination a {
    text-decoration: none;
    padding: 8px 12px;
    margin: 0 5px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    color: #007bff;
    font-weight: 600;
    transition: background-color 0.3s;
}

.pagination a:hover {
    background-color: #e9f5ff;
}

.pagination span { /* 현재 페이지 번호 스타일 */
    padding: 8px 12px;
    margin: 0 5px;
    color: white;
    background-color: #007bff;
    border-radius: 4px;
    font-weight: bold;
}

/* --- 카테고리 메뉴 스타일 --- */
.category-menu {
    border-bottom: 2px solid #dee2e6; /* 전체 메뉴 바 */
    margin-bottom: 20px;
    display: flex; /* 메뉴 아이템 정렬 */
}

.category-menu a {
    text-decoration: none;
    padding: 10px 15px;
    color: #495057;
    font-weight: 600;
    transition: all 0.3s ease;
    border-bottom: 3px solid transparent; /* 기본 밑줄 투명 */
    margin-bottom: -2px; /* border-bottom을 겹치지 않게 하기 위해 */
}

.category-menu a:hover {
    color: #007bff;
}

.category-menu .active {
    color: #007bff;
    border-bottom: 3px solid #007bff; /* 활성화된 탭의 밑줄 */
}
</style>
</head>
<body>
    <div class="header-fixed-container">
        <div class="top-bar inner-wrapper">
            <div class="user-info">
                <span>탈퇴ID관리</span> 
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
        <h1>탈퇴ID관리</h1> 
        
        <div class="category-menu">
            <a href="${pageContext.request.contextPath}/customer/outidList" 
               class="${empty param.memo ? 'active' : ''}">전체</a>
            <a href="${pageContext.request.contextPath}/customer/outidList?memo=회원탈퇴" 
               class="${param.memo eq '회원탈퇴' ? 'active' : ''}">회원탈퇴</a>
            <a href="${pageContext.request.contextPath}/customer/outidList?memo=강제탈퇴" 
               class="${param.memo eq '강제탈퇴' ? 'active' : ''}">강제탈퇴</a>
        </div>

        
        <div class="data-container"> 
            <table class="data-table"> 
                <thead>
                    <tr>
                        <th>id</th>
                        <th>createdate</th>
                        <th>memo</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${outidList}">
                        <tr>
                            <td>${o.id}</td>
                            <td>${o.createdate}</td>
                            <td>${o.memo}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="pagination"> 
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/customer/outidList?currentPage=${currentPage-1}&memo=${param.memo}">이전</a>
                </c:if>
                
                <span>${currentPage}</span> 
                
                <c:if test="${currentPage < lastPage}">
                    <a href="${pageContext.request.contextPath}/customer/outidList?currentPage=${currentPage+1}&memo=${param.memo}">다음</a>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>