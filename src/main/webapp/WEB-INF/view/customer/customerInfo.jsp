<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop - 개인정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
/* noticeOne.jsp의 CSS 스타일을 그대로 복사하여 사용합니다. */

/* -------------------- 1. 기본 설정 및 레이아웃 -------------------- */
body {
    background-color: #f8f9fa;
    color: #343a40; /* cite: 35 */
    margin: 0;
    padding: 0;
    line-height: 1.6;
    min-height: 100vh;
} /* cite: 36 */

/* 상단 영역 전체 고정 */
.header-fixed-container {
    width: 100%;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* cite: 37 */
    position: sticky;
    top: 0;
    z-index: 1000;
} /* cite: 38 */

/* 컨텐츠를 중앙에 모으는 내부 래퍼 */
.inner-wrapper {
    width: 90%;
    max-width: 1100px;
    margin: 0 auto;
    padding: 0 10px; /* cite: 39 */
}

/* -------------------- 2. 상단 사용자 정보 및 메뉴 영역 -------------------- */

.top-bar {
    padding: 10px 0;
    display: flex; /* cite: 40 */
    justify-content: flex-end;
    align-items: center;
}

.user-info {
    display: flex;
    align-items: center;
    font-size: 14px;
} /* cite: 41 */

/* 로그아웃 버튼 CSS */
.logout-btn { 
    text-decoration: none;
    padding: 6px 12px;
    margin-left: 15px;
    background-color: #007bff;
    color: white; /* cite: 42 */
    border: none;
    border-radius: 4px;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

.logout-btn:hover {
    background-color: #0056b3; /* cite: 43 */
}

/* 고객 메뉴 영역은 필요에 따라 구조를 맞춥니다. */
.customer-menu-area { /* 이름을 변경하여 사용 */
    width: 100%;
    background-color: #f8f9fa;
    border-top: 1px solid #dee2e6;
    border-bottom: 2px solid #007bff;
} /* cite: 44 */

/* 메뉴 링크 스타일 추가 */
.customer-menu-area .inner-wrapper > div {
    display: flex;
    justify-content: center;
} /* cite: 45 */

.customer-menu-area a { 
    text-decoration: none;
    padding: 15px 20px;
    color: #495057;
    font-weight: 600;
    transition: all 0.3s ease;
    font-size: 15px; /* cite: 46 */
    border-bottom: 3px solid transparent;
}

.customer-menu-area a:hover {
    color: #007bff;
    border-bottom: 3px solid #007bff;
} /* cite: 47 */


/* -------------------- 3. 중앙 컨텐츠 영역 및 제목 -------------------- */
.content-area {
    width: 90%;
    max-width: 1100px;
    margin: 40px auto; /* cite: 48 */
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
} /* cite: 49 */

h1 {
    color: #212529;
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 25px;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 10px;
} /* cite: 50 */

/* 4. 개인정보 상세 테이블 스타일 (notice-detail-table 재활용) */
.info-detail-table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
    margin-top: 20px;
    font-size: 15px; /* cite: 51 */
}

.info-detail-table th,
.info-detail-table td {
    padding: 12px 15px;
    border: 1px solid #dee2e6;
    vertical-align: top;
} /* cite: 52 */

.info-detail-table th {
    width: 150px;
    background-color: #f2f2f2;
    text-align: center;
    font-weight: bold;
} /* cite: 53 */

/* 5. 액션 버튼 스타일 (noticeOne.jsp에서 사용된 스타일) */
.action-button {
    display: inline-block;
    padding: 8px 15px;
    margin-left: 10px; /* cite: 55 */
    background-color: #6c757d; 
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-weight: bold;
    transition: background-color 0.3s;
    border: none; /* cite: 56 */
    box-sizing: border-box; 
    cursor: pointer;
    font-size: 14px; /* cite: 57 */
    line-height: 1.42857; /* cite: 58 */
}

/* `<button>` 태그를 위한 추가 설정 */
.action-button[type="button"] { 
    padding: 8px 15px;
    margin-left: 10px; /* cite: 59 */
    display: inline-block;
}

.action-button:hover {
    background-color: #5a6268;
}

/* 수정 버튼 스타일 (noticeOne.jsp에서 목록 버튼에 사용된 스타일을 적용) */
.modify-button {
    background-color: #007bff; /* cite: 60 */
}

.modify-button:hover {
    background-color: #0056b3; /* cite: 60 */
}

/* 탈퇴 버튼 스타일 (noticeOne.jsp에서 삭제 버튼에 사용된 스타일을 적용) */
.remove-button {
    background-color: #dc3545; /* cite: 61 */
}

.remove-button:hover {
    background-color: #c82333; /* cite: 61 */
}

/* 추가: 포인트 정보에 볼드체 적용 */
.point-info strong {
    font-weight: bold;
    color: #007bff; /* 포인트를 강조하기 위해 색상 추가 */
}

</style>
</head>
<body>
    
    <div class="header-fixed-container">
        <div class="top-bar inner-wrapper">
            <div class="user-info">
                <span> 
                    ${sessionScope.loginCustomer.customerName}님 반갑습니다. 
                    (<span class="point-info">point: <strong>${sessionScope.loginCustomer.point}</strong></span>)
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
		<h1>개인정보</h1>
		
        <table class="info-detail-table">
            <tr>
                <th>아이디</th>
                <td>${customer.customerId}</td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>${customer.customerPw}</td>
            </tr>
            <tr>
                <th>이름</th>
                <td>${customer.customerName}</td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>${customer.customerPhone}</td>
            </tr>
        </table>
        
        <div style="margin-top: 20px;
            text-align: right;">
             <a href="${pageContext.request.contextPath}/customer/modifyCustomer?customerId=${customer.customerId}" 
             class="action-button modify-button">수정</a>
             <a href="${pageContext.request.contextPath}/customer/removeCustomer?customerId=${customer.customerId}" 
             class="action-button remove-button"">탈퇴</a>
        </div>
        
	</div>
</body>

<script>
	$(function() {
	    $('.remove-button').on('click', function(e) {
	        if (!confirm('정말 탈퇴하시겠습니까? 탈퇴 후에는 복구할 수 없습니다.')) {
	            e.preventDefault(); // 링크 이동 중단
	        }
	    });
	});
</script>
</html>