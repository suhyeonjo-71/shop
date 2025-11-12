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
    max-width: 1300px;
    margin: 0 auto;
    padding: 0 10px;
}

/* -------------------- 2. 상단 사용자 정보 영역 -------------------- */
.top-bar {
    padding: 10px 0;
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

/* 제목 */
h1 {
    color: #212529;
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 25px;
    border-bottom: 2px solid #e9ecef;
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
    color: #007bff;
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

/* -------------------- 3. 메뉴 (내비게이션 바) 스타일 -------------------- */
.cust-menu-area {
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
    max-width: 1300px;
    margin: 40px auto;
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
}

/* -------------------- 5. 테이블 (리스트) 스타일 -------------------- */
.data-container {
    margin-top: 20px;
    overflow-x: auto;
}

/* 베스트 상품 테이블 */
.best-goods-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 30px;
    table-layout: fixed;
}

.best-goods-table td {
    padding: 10px;
    text-align: center;
    vertical-align: top;
    border: none;
    height: 250px;
    cursor: pointer; /* 클릭 가능하도록 커서 변경 */
}

/* 베스트 상품 호버 CSS 추가 */
.best-goods-table td:hover {
    background-color: #f8f9fa;
}

/* 베스트 상품 링크 컨테이너 */
.best-goods-table td a {
    text-decoration: none;
    color: inherit;
    display: block;
}

/* 베스트 상품 이름/가격 영역: 내용이 길어도 칸 크기 유지 */
.best-goods-table .goods-info {
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    line-height: 1.4;
    margin-top: 5px;
}

/* 베스트 상품 이미지 컨테이너: 사이즈 고정 */
.best-goods-table .img-box {
    width: 180px;
    height: 180px;
    margin: 0 auto 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    border: none;
    border-radius: 4px;
}

.best-goods-table img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

/* 일반 상품 목록 테이블 */
.goods-list-table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
}

.goods-list-table tr {
    border: none;
}

.goods-list-table td {
    padding: 15px;
    border: none;
    width: 20%;
    vertical-align: top;
    cursor: pointer;
}

.goods-list-table td:hover {
    background-color: #f8f9fa;
}

/* 일반 상품 링크 컨테이너 */
.goods-list-table td a {
    text-decoration: none;
    color: inherit;
    display: block;
}

/* 일반 상품 이미지 컨테이너: 사이즈 고정 */
.goods-list-table .img-box {
    width: 150px;
    height: 150px;
    margin: 0 auto 10px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.goods-list-table img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    border-radius: 4px;
}

/* -------------------- 6. 페이지네이션 스타일 -------------------- */
.pagination {
    text-align: center;
    padding: 20px 0 0;
    margin-top: 30px;
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

.pagination span {
    padding: 8px 12px;
    margin: 0 5px;
    color: white;
    background-color: #007bff;
    border-radius: 4px;
    font-weight: bold;
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
                 <c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
             </div>
        </div>
    </div>

    <div class="content-area">
        <h1>베스트 상품목록</h1>
        <div class="data-container">
        	<table class="best-goods-table">
        		<tr>
        			<c:forEach var="b" items="${bestGoodsList}">
        				<td>
                            <a href="${pageContext.request.contextPath}/customer/goodsOne?goodsCode=${b.goodsCode}">
        					    <div class="img-box">
								    <img
									    src="${pageContext.request.contextPath}/upload/${b.filename}">
							    </div>
							    <div class="goods-info"> ${b.goodsName}<br> ${b.goodsPrice}원
							    </div>
                            </a>
        				</td>
        			</c:forEach>
        		</tr>
        	</table>
        </div>
        
        <h1>상품목록</h1>
        <div class="data-container">
        	<table class="goods-list-table">
        		<tr>
	        		<c:forEach var="m" items="${goodsList}" varStatus="state">
						<td>
                            <a href="${pageContext.request.contextPath}/customer/goodsOne?goodsCode=${m.goodsCode}">
							    <div class="img-box">
								    <img
									    src="${pageContext.request.contextPath}/upload/${m.filename}">
							    </div>
							    <div>
								    <a href="${pageContext.request.contextPath}/customer/goodsOne?goodsCode=${goodsCode}">
								    ${m.goodsName}
								    </a><br> ${m.goodsPrice}원
							    </div>
                            </a>
						</td>
						<c:if test="${state.last == false && state.count % 5 == 0}">
							</tr><tr>
						</c:if>
					</c:forEach>
                    <c:if test="${goodsList.size() % 5 != 0}">
                        <c:forEach begin="${goodsList.size() % 5 + 1}" end="5" step="1">
                            <td></td>
                        </c:forEach>
                    </c:if>
        		</tr>
        	</table>
        </div>
        
        <div class="pagination">
	        <a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=1">처음으로</a>
	
	        <c:if test="${startPage > 1}">
	            <a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${startPage - 10}">이전</a>
	        </c:if>
	
	        <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
	            <c:if test="${currentPage == i}">
	                <span>${i}</span>
	            </c:if>
	            <c:if test="${currentPage != i}">
	                <a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${i}">${i}</a>
	            </c:if>
	  
	        </c:forEach>
	
	        <c:if test="${lastPage != endPage}">
	            <a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${startPage + 10}">다음</a>
	        </c:if>
	
	        <a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${lastPage}">끝으로</a>
	    </div>
        </div> </body>
</html>