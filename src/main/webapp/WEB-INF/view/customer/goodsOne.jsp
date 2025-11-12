<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop - goodsOne</title>
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

/* 상단 영역 전체 고정 (Sticky Header) */
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

/* 고객 메뉴 영역 */
.customer-menu-area {
    width: 100%;
    background-color: #f8f9fa;
    border-top: 1px solid #dee2e6;
    border-bottom: 2px solid #007bff;
}

/* 메뉴 링크 스타일 */
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

/* 추가: 포인트 정보에 볼드체 적용 */
.point-info strong {
    font-weight: bold;
    color: #007bff;
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

/* -------------------- 4. 상품 상세 레이아웃 ---------------------- */
.goods-detail-container {
    display: flex;
    gap: 30px; /* 이미지와 상세 정보 사이 간격 */
}

.goods-image-area {
    flex: 0 0 400px; /* 이미지 영역 너비 고정 */
    max-width: 40%;
}

.goods-image-area img {
    width: 100%;
    height: auto;
    border: 1px solid #eee;
    border-radius: 4px;
}

.goods-info-area {
    flex-grow: 1;
}

/* 상품 정보 테이블 스타일 */
.goods-info-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

.goods-info-table td,
.goods-info-table th {
    padding: 12px 0;
    text-align: left;
}

.goods-info-table th {
    width: 120px;
    color: #6c757d;
}

/* -------------------- 5. 액션 버튼 스타일 -------------------- */
.action-button {
    padding: 10px 20px;
    margin-top: 20px;
    margin-right: 10px;
    border: none;
    border-radius: 4px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
}

#cartBtn {
    background-color: #6c757d; 
    color: white;
}

#cartBtn:hover {
    background-color: #5a6268;
}

#orderBtn {
    background-color: #007bff;
    color: white;
}

#orderBtn:hover {
    background-color: #0056b3;
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
		<h1>goodsOne</h1>
        
        <div class="goods-detail-container">
            
            <div class="goods-image-area">
                <img src="${pageContext.request.contextPath}/upload/${goods.filename}" alt="${goods.goodsName}">
            </div>
            
            <div class="goods-info-area">
                
                <form id="myForm">
                    <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
                    <input type="hidden" name="goodsCode" value="${goods.goodsCode}">
                    
                    <table class="goods-info-table">
                        <tr>
                            <th>상품명</th>
                            <td>${goods.goodsName}</td>
                        </tr>
                        <tr>
                            <th>가격</th>
                            <td><strong>${goods.goodsPrice}</strong>원</td> </tr>
                        <tr>
                            <th>재고</th>
                            <td>${goods.soldout}</td>
                        </tr>
                        <tr>
                            <th>포인트 적립률</th>
                            <td>${goods.pointRate}</td>
                        </tr>
                        <tr>
                            <th>수량</th>
                            <td>
                                <select name="cartQuantity"> 
                                	<c:forEach var="n" begin="1" end="10">
                                        <option value="${n}">${n}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </table>
                    
                    <button id="cartBtn" type="button" class="action-button">장바구니</button> 
                    <button id="orderBtn" type="button" class="action-button">바로구매</button>
                </form>
            </div>
        </div>
    </div>
    
    <script>
	    $('#cartBtn').click(function(){
			$('#myForm').attr('method', 'post');
			$('#myForm').attr('action', $('#contextPath').val()+'/customer/addCart');
			$('#myForm').submit();
		});
		
		$('#orderBtn').click(function() {
			$('#myForm').attr('method', 'post');
			$('#myForm').attr('action', $('#contextPath').val() + "/customer/addOrders");
			alert('orderBtn: ' + $('#myForm').attr('method') + ',' + $('#myForm').attr('action')); // orders 화면
			$('#myForm').submit();
		});
    </script>
</body>
</html>