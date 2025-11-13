<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* -------------------- 1. 기본 설정 및 레이아웃 (noticeList.jsp와 유사) -------------------- */
body {
    background-color: #f8f9fa; /* */
    color: #343a40; /* */
    margin: 0;
    padding: 0;
    line-height: 1.6;
    min-height: 100vh; /* */
}

/* 상단 영역 전체 고정 */
.header-fixed-container {
    width: 100%;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* */
    position: sticky;
    top: 0;
    z-index: 1000; /* */
}

/* 컨텐츠를 중앙에 모으는 내부 래퍼 */
.inner-wrapper {
    width: 90%;
    max-width: 1300px; /* */
    margin: 0 auto;
    padding: 0 10px; /* */
}

/* -------------------- 2. 상단 사용자 정보 및 메뉴 영역 (noticeList.jsp와 유사) -------------------- */

.top-bar {
    padding: 10px 0; /* */
    display: flex; /* */
    justify-content: flex-end;
    align-items: center; /* */
}

.user-info {
    display: flex; /* */
    align-items: center;
    font-size: 14px; /* */
}

.logout-btn {
    text-decoration: none;
    padding: 6px 12px;
    margin-left: 15px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px; /* */
    font-weight: bold; /* */
    transition: background-color 0.3s ease;
}

.logout-btn:hover {
    background-color: #0056b3; /* */
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

/* -------------------- 3. 컨텐츠 영역 및 제목 (noticeList.jsp와 유사) -------------------- */
.content-area {
    width: 90%; /* */
    max-width: 1300px; /* */
    margin: 40px auto;
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px; /* */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05); /* */
}

h1 {
    color: #212529;
    font-size: 26px;
    font-weight: 700; /* */
    margin-bottom: 25px;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 10px; /* */
}

/* -------------------- 4. 테이블 (리스트) 스타일 (noticeList.jsp와 유사) -------------------- */
.data-container {
    margin-top: 20px; 
    overflow-x: auto; /* */
}

.data-table {
    width: 100%; 
    border-collapse: collapse; /* */
    text-align: left;
    margin-bottom: 20px;
    font-size: 15px; 
    /* table-layout: fixed; 장바구니는 내용 길이에 따라 조정되도록 fixed 제거 */
}

.data-table th,
.data-table td {
    padding: 12px 15px;
    border: 1px solid #dee2e6; /* */
}

/* 테이블 헤더 */
.data-table thead tr {
    background-color: #f2f2f2;
    text-align: center;
    font-weight: bold; /* */
}

/* 테이블 바디 행 */
.data-table tbody tr:hover {
    background-color: #e9f5ff; /* */
}

.data-table td:nth-child(1), /* 선택 */
.data-table td:nth-child(4), /* cartQuantity */
.data-table td:nth-child(6) { /* soldout */
    text-align: center;
}

/* 주문하기 버튼 스타일 */
.order-button {
    display: block;
    width: 150px;
    padding: 10px;
    margin: 20px auto 0;
    background-color: #007bff; /* 녹색 계열로 변경 */
    color: white;
    border: none;
    border-radius: 4px;
    font-weight: bold;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.order-button:hover {
    background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="header-fixed-container">
        <div class="top-bar inner-wrapper">
            <div class="user-info">
                <span>${loginCustomer.customerName}님 반갑습니다.
                </span> <a href="${pageContext.request.contextPath}/emp/empLogout" class="logout-btn">로그아웃</a> </div>
        </div>
        
        <div class="customer-menu-area"> 
            <div class="inner-wrapper">
                <c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import> </div>
        </div>
    </div>
    
    <div class="content-area">
		<h1>장바구니 목록</h1>
		
		<div class="data-container">
			<form method="get" action="${pageContext.request.contextPath}/customer/addOrders">
				<table class="data-table">
					<thead>
						<tr>
							<th>선택</th>
							<th>goodsName</th>
							<th>goodsPrice</th>
							<th>cartQuantity</th>
							<th>totalPrice</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="m" items="${list}">
							<tr>
								<td>
									<c:if test="${m.soldout == 'soldout'}">
										soldout
									</c:if>
									<c:if test="${m.soldout != 'soldout'}">
										<input type="checkbox" name="cartCodeList" value="${m.cartCode}"> 
									</c:if>
								</td>
								<td>${m.goodsName}</td>
								<td>${m.goodsPrice}</td>
								<td>${m.cartQuantity}</td>
								<td>${m.totalPrice}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button type="submit" class="order-button">주문하기</button> 
			</form>
		</div>
	</div>
</body>
</html>