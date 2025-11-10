<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop - 개인정보 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
/* customerInfo.jsp 및 noticeOne.jsp의 CSS 스타일을 복사하여 적용합니다. 
    기존 레이아웃 및 버튼 스타일을 재활용합니다.
*/

/* -------------------- 1. 기본 설정 및 레이아웃 -------------------- */
body {
    background-color: #f8f9fa;
    color: #343a40; /* cite: 5, 38 */
    margin: 0;
    padding: 0;
    line-height: 1.6;
    min-height: 100vh; /* cite: 6, 39 */
} 

/* 상단 영역 전체 고정 */
.header-fixed-container {
    width: 100%;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* cite: 7, 40 */
    position: sticky;
    top: 0;
    z-index: 1000; /* cite: 8, 41 */
} 

/* 컨텐츠를 중앙에 모으는 내부 래퍼 */
.inner-wrapper {
    width: 90%;
    max-width: 1100px; /* cite: 42 */
    margin: 0 auto;
    padding: 0 10px; /* cite: 9, 42 */
}

/* -------------------- 2. 상단 사용자 정보 및 메뉴 영역 -------------------- */

.top-bar {
    padding: 10px 0;
    display: flex; /* cite: 10, 43 */
    justify-content: flex-end;
    align-items: center;
}

.user-info {
    display: flex;
    align-items: center; /* cite: 11, 44 */
    font-size: 14px;
} 

/* 로그아웃 버튼 CSS */
.logout-btn { 
    text-decoration: none;
    padding: 6px 12px; /* cite: 45 */
    margin-left: 15px;
    background-color: #007bff;
    color: white; /* cite: 12, 45 */
    border: none;
    border-radius: 4px;
    font-weight: bold; /* cite: 46 */
    transition: background-color 0.3s ease;
}

.logout-btn:hover {
    background-color: #0056b3; /* cite: 13, 47 */
}

/* 고객 메뉴 영역 */
.customer-menu-area { 
    width: 100%;
    background-color: #f8f9fa;
    border-top: 1px solid #dee2e6;
    border-bottom: 2px solid #007bff; /* cite: 14, 49 */
} 

/* 메뉴 링크 스타일 추가 */
.customer-menu-area .inner-wrapper > div {
    display: flex;
    justify-content: center; /* cite: 15, 50 */
} 

.customer-menu-area a { 
    text-decoration: none;
    padding: 15px 20px;
    color: #495057;
    font-weight: 600; /* cite: 51 */
    transition: all 0.3s ease;
    font-size: 15px; /* cite: 16, 51 */
    border-bottom: 3px solid transparent; /* cite: 52 */
}

.customer-menu-area a:hover {
    color: #007bff;
    border-bottom: 3px solid #007bff; /* cite: 17, 53 */
} 


/* -------------------- 3. 중앙 컨텐츠 영역 및 제목 -------------------- */
.content-area {
    width: 90%;
    max-width: 1100px; /* cite: 18, 54 */
    margin: 40px auto; /* cite: 18, 54 */
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05); /* cite: 19, 55 */
} 

h1 {
    color: #212529;
    font-size: 26px; /* cite: 56 */
    font-weight: 700;
    margin-bottom: 25px;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 10px; /* cite: 20, 57 */
} 

/* 4. 개인정보 수정 테이블 스타일 (notice-detail-table 재활용) */
.info-detail-table {
    width: 100%;
    border-collapse: collapse; /* cite: 58 */
    text-align: left;
    margin-top: 20px;
    font-size: 15px; /* cite: 21, 58 */
}

.info-detail-table th,
.info-detail-table td {
    padding: 12px 15px;
    border: 1px solid #dee2e6; /* cite: 22, 59 */
    vertical-align: top;
} 

.info-detail-table th {
    width: 150px;
    background-color: #f2f2f2;
    text-align: center; /* cite: 23, 60 */
    font-weight: bold;
} 

/* 입력 필드 크기 조정 (필요 시) */
.info-detail-table input[type="text"],
.info-detail-table input[type="password"] {
    width: 80%; /* 테이블 셀 안에 적절한 너비 설정 */
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

/* 5. 액션 버튼 스타일 (noticeOne.jsp에서 사용된 스타일) */
.action-button {
    display: inline-block;
    padding: 8px 15px; /* cite: 25, 61 */
    margin-left: 10px; /* cite: 25, 61 */
    background-color: #6c757d; 
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-weight: bold; /* cite: 62 */
    transition: background-color 0.3s;
    border: none; /* cite: 26, 62 */
    box-sizing: border-box; 
    cursor: pointer;
    font-size: 14px; /* cite: 27, 63 */
    line-height: 1.42857; /* cite: 28, 63 */
}

/* `<button>` 태그를 위한 추가 설정 */
.action-button[type="submit"], /* 수정된 부분: type="submit"도 포함 */
.action-button[type="button"] { 
    padding: 8px 15px;
    margin-left: 10px; /* cite: 29, 64 */
    display: inline-block;
}

.action-button:hover {
    background-color: #5a6268; /* cite: 65 */
}

/* 수정 버튼 스타일 */
.modify-button {
    background-color: #007bff; /* cite: 30, 66 */
}

.modify-button:hover {
    background-color: #0056b3; /* cite: 30, 67 */
}

/* 추가: 포인트 정보에 볼드체 적용 */
.point-info strong {
    font-weight: bold;
    color: #007bff; /* cite: 70 */
}
</style>
</head>
<body>
    
    <div class="header-fixed-container">
        <div class="top-bar inner-wrapper">
            <div class="user-info">
                <span> 
                    ${sessionScope.loginCustomer.customerName}님 반갑습니다. 
                    (<span class="point-info">point: <strong>${sessionScope.loginCustomer.point}</strong></span>) </span>
                <a href="${pageContext.request.contextPath}/customer/customerLogout" class="logout-btn">로그아웃</a> </div>
        </div>
      
        <div class="customer-menu-area"> 
             <div class="inner-wrapper">
                <c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import> </div>
        </div>
    </div>
    
    <div class="content-area">
		<h1>개인정보 수정</h1>
		
        <form action="${pageContext.request.contextPath}/customer/modifyCustomer" method="post">
            <table class="info-detail-table">
                <tr>
                    <th>아이디</th>
                    <td><input type="text" id="customerId" name="customerId" value="${customer.customerId}" readonly></td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="password" id="customerPw" name="customerPw" value="${customer.customerPw}"></td>
                </tr>
                <tr>
                    <th>비밀번호 확인</th>
                    <td><input type="password" id="customerPw2" name="customerPw2" value="${customer.customerPw}"></td>
                </tr>
           
                <tr>
                    <th>이름</th>
                    <td><input type="text" id="customerName" name="customerName" value="${customer.customerName}" readonly></td> </tr>
                <tr>
                    <th>전화번호</th>
                    <td><input type="text" id="customerPhone" name="customerPhone" value="${customer.customerPhone}"></td> </tr>
            </table>
            
            <div style="margin-top: 20px; text-align: right;">
                <button type="submit" class="action-button modify-button">수정하기</button> </div>
        </form>
        
	</div>
    </body>
</html>