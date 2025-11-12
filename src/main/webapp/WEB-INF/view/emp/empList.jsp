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
    max-width: 1300px;
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
    max-width: 1300px;
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
    overflow-x: auto;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
    margin-bottom: 20px;
    font-size: 15px;
    table-layout: fixed;
}

.data-table th,
.data-table td {
    padding: 12px 15px;
    border: 1px solid #dee2e6;
    overflow: hidden; 
    white-space: nowrap;
    text-overflow: ellipsis;
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

/* 활성화/비활성화 링크 스타일 */
.data-table td a {
    text-decoration: none;
    color: #007bff; /* 기본 활성화 상태 색상 */
    font-weight: 600;
    transition: color 0.2s;
}

.data-table td a:hover {
    color: #0056b3;
}

/* *** 추가된 CSS: 비활성화 상태일 때 회색으로 변경 *** */
.data-table td .inactive {
    color: #6c757d; /* 짙은 회색 (Bootstrap Secondary Color) */
    font-weight: 400; /* 일반 굵기로 변경하여 비활성화 강조 */
}

.data-table td .inactive:hover {
    color: #495057; /* 호버 시 조금 더 진한 회색 */
}

/* 사원 추가 버튼 스타일 */
.add-button {
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

.add-button:hover {
    background-color: #0056b3;
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
        <h1>사원관리</h1>
        
        <div class="data-container">
            <a href="${pageContext.request.contextPath}/emp/addEmp" class="add-button">사원추가</a>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>empCode</th>
                        <th>Id</th>
                        <th>Name</th>
                        <th>createdate</th>
                        <th style="width: 150px; text-align: center;">활성화/비활성화</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="e" items="${empList}">
                        <tr>
                            <td>${e.empCode}</td>
                            <td>${e.empId}</td>
                            <td>${e.empName}</td>
                            <td>${e.createdate}</td>
                            <td style="text-align: center;">
                                <a href="${pageContext.request.contextPath}/emp/modifyEmpActive?empCode=${e.empCode}&currentActive=${e.active}&currentPage=${currentPage}"
                                	class="${e.active == 0 ? 'inactive' : ''}">
                                    ${e.active == 1 ? '활성화' : '비활성화'}
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="pagination">
                <a href="${pageContext.request.contextPath}/emp/empList?currentPage=1">처음</a>
                
                <c:if test="${startPage > 1}">
					<a href="${pageContext.request.contextPath}/emp/empList?currentPage=${startPage-10}">이전</a>
				</c:if>
				
				<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
					<c:if test="${currentPage == i}">
						<span>${i}</span>
					</c:if>
					<c:if test="${currentPage != i}">
						<a href="${pageContext.request.contextPath}/emp/empList?currentPage=${i}">${i}</a>
					</c:if>
				</c:forEach>
				
				<c:if test="${startPage < lastPage}">
					<a href="${pageContext.request.contextPath}/emp/empList?currentPage=${startPage+10}">다음</a>
				</c:if>
                
                <a href="${pageContext.request.contextPath}/emp/empList?currentPage=${lastPage}">끝</a>
            </div>
        </div>
    </div>
</body>
</html>