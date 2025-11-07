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

.customer-menu-area { /* emp-menu-area 대신 customer-menu-area 사용 */
    width: 100%;
    background-color: #f8f9fa;
    border-top: 1px solid #dee2e6;
    border-bottom: 2px solid #007bff;
}

.customer-menu-area .inner-wrapper > div {
    display: flex;
    justify-content: center;
}

.customer-menu-area a {
    text-decoration: none;
    padding: 15px 20px;
    color: #495057;
    font-weight: 600;
    transition: all 0.3s ease;
    font-size: 15px;
    border-bottom: 3px solid transparent;
}

.customer-menu-area a:hover {
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

/* -------------------- 4. 테이블 (리스트) 스타일 (empList와 동일) -------------------- */
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
    color: #343a40;
    font-weight: 600;
    border-bottom: 2px solid #adb5bd;
}

/* 테이블 바디 행 호버 효과 */
.data-table tbody tr:hover {
    background-color: #e9ecef;
}

/* 테이블의 마지막 행 하단 테두리 제거 */
.data-table tbody tr:last-child td {
    border-bottom: 1px solid #dee2e6;
}

/* *** empList.jsp의 비활성화 상태용 CSS를 재활용하여 버튼 비활성 시 사용할 수 있음 *** */
.data-table td .inactive {
    color: #6c757d; /* 짙은 회색 (Bootstrap Secondary Color) */
    font-weight: 400; /* 일반 굵기로 변경하여 비활성화 강조 */
}

.data-table td .inactive:hover {
    color: #495057; /* 호버 시 조금 더 진한 회색 */
}

/* 주소 추가 버튼 스타일 */
.add-btn { /* empList.jsp의 .add-button과 동일 */
    display: inline-block;
    padding: 8px 15px;
    margin-bottom: 15px;
    background-color: #007bff;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-weight: bold;
    transition: background-color 0.3s;
}

.add-btn:hover {
    background-color: #0056b3;
}

/* ---------------------------------------------------- */


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
        
        <div class="customer-menu-area"> 
            <div class="inner-wrapper">
                <c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
            </div>
        </div>
    </div>

    <div class="content-area">
        <h1>배송지 관리</h1> 
        <a href="${pageContext.request.contextPath}/customer/addAddress" class="add-btn">배송지 추가</a> 
        
        <div class="data-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>addressCode</th>
                        <th>address</th> 
                        <th>createdate</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${addressList}">
                        <tr>
                            <td>${a.addressCode}</td>
                            <td>${a.address}</td>
                            <td>${a.createdate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
        </div>
    </div>
</body>
</html>