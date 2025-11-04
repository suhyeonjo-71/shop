<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script><script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* 기본 초기화 및 body 스타일 */
body {
    font-family: 'Malgun Gothic', 'Dotum', sans-serif; /* 한국어 폰트 추가 */
    background-color: #f4f4f9;
    display: flex;
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center;   /* 세로 중앙 정렬 */
    min-height: 100vh;      /* 전체 뷰포트 높이 사용 */
    margin: 0;
}

/* 로그인 영역 메인 컨테이너 */
#loginForm {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    width: 300px; /* 고정 너비 설정 */
}

/* 제목 스타일 */
h1 {
    text-align: center;
    color: #333;
    margin-bottom: 25px;
    font-size: 26px;
    font-weight: bold;
}

/* 입력 필드를 위한 테이블 */
table {
    width: 100%;
    margin-bottom: 20px;
    border-collapse: collapse;
}

table tr {
    border-bottom: 1px solid #eee; /* 줄 간 구분선 */
}

table tr:last-child {
    border-bottom: none;
}

table td {
    padding: 12px 0;
    font-size: 15px;
    color: #555;
}

/* 입력 필드 */
input[type="text"],
input[type="password"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box; 
    margin-left: 10px;
    transition: border-color 0.3s;
}

input[type="text"]:focus,
input[type="password"]:focus {
    border-color: #007bff; /* 포커스 시 파란색 강조 */
    outline: none;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
}

/* 로그인 버튼 */
#loginBtn {
    width: 100%;
    padding: 12px;
    background-color: #007bff; /* 파란색으로 변경 */
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 17px;
    margin-top: 15px;
    transition: background-color 0.3s ease;
    font-weight: bold;
}

#loginBtn:hover {
    background-color: #0056b3; /* 호버 시 더 어두운 파란색 */
}

/* 라디오 버튼 (customer/emp) 스타일 */
.customerOrEmpSel {
    margin-right: 5px;
}

/* 라디오 버튼 컨테이너 */
#loginForm > div > div:nth-child(2) {
    text-align: center;
    padding: 10px 0;
    margin-top: 15px;
    margin-bottom: 10px;
    font-size: 14px;
    color: #555;
    border-top: 1px solid #eee;
}

/* 회원가입 링크 */
a[href] {
    display: block;
    text-align: center;
    margin-top: 10px;
    color: #6c757d; /* 회색 텍스트 */
    text-decoration: none;
    font-size: 14px;
}

a[href]:hover {
    text-decoration: underline;
    color: #007bff; /* 호버 시 파란색 */
}
</style>
</head>
<body>
	
	<form action="${pageContext.request.contextPath}/out/login" method="post" id="loginForm">
		<div>
			<h1>login</h1>
			<c:if test="${not empty errorMsg}">
			    <div style="color:red; text-align:center; margin-bottom:10px;">
			        ${errorMsg}
			    </div>
			</c:if>
			<div>
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="id" id="id"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pw" id="pw"></td>
					</tr>
				</table>
				<button type="button" id="loginBtn">로그인</button>
			</div>
			<div>
				<input type="radio" name="customerOrEmpSel" class="customerOrEmpSel" value="customer" checked>customer
				<input type="radio" name="customerOrEmpSel" class="customerOrEmpSel" value="emp">emp
			</div>
			<a href="${pageContext.request.contextPath}/out/addMember">회원가입</a>
		</div>
	</form>
</body>

<script>
    $(document).ready(()=> {
    	$('#loginBtn').click(()=> {
    		let id = $('#id').val();
    		let pw = $('#pw').val();
    		
    		if(id === '') {
    			alert('아이디를 입력하세요');
    			return;
    		}
    		
    		if(pw === '') {
    			alert('비밀번호를 입력하세요');                 
    			return;
    		}
    		
    		$('#loginForm').submit();
    	});
    });
</script>

</html>   