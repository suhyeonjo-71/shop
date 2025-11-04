<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* -------------------- 1. 기본 설정 및 레이아웃 -------------------- */
body {
    background-color: #f8f9fa; /* 밝은 배경색 통일 */
    color: #343a40;
    margin: 0;
    padding: 0;
    line-height: 1.6;
    min-height: 100vh;
    display: flex; /* 컨테이너 중앙 정렬 */
    justify-content: center;
    align-items: center;
}

/* 메인 컨테이너 (로그인, 사원 추가 폼과 유사한 스타일) */
.main-container {
    background-color: #fff;
    padding: 40px 50px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    width: 300px; /* 적당한 너비 */
    text-align: center;
}

/* -------------------- 2. 제목 스타일 -------------------- */
h1 {
    margin-bottom: 30px;
    font-size: 30px;
    font-weight: bold;
}

/* -------------------- 3. 로그인 버튼 스타일 -------------------- */
.login-link {
    display: block; /* 블록 요소로 만들어 너비를 차지하게 함 */
    text-decoration: none;
    padding: 12px 20px;
    margin-top: 20px;
    background-color: #007bff; /* 포인트 컬러 */
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 17px;
    transition: background-color 0.3s ease;
    font-weight: bold;
}

.login-link:hover {
    background-color: #0056b3; /* 호버 시 어두운 계열 */
}
</style>
</head>
<body>
    <div class="main-container">
        <h1>home</h1>
        <div>
            <a href="${pageContext.request.contextPath}/out/login" class="login-link">로그인</a>	
        </div>
    </div>
</body>
</html>