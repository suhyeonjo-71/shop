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
    background-color: #f8f9fa; /* 배경색 통일 */
    color: #343a40;
    margin: 0;
    padding: 0;
    line-height: 1.6;
    min-height: 100vh;
    display: flex; /* 폼을 중앙에 배치하기 위함 */
    justify-content: center;
    align-items: center;
}

/* 폼 컨테이너 (중앙 정렬 박스) */
#addMemberForm {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 400px; /* 적당한 너비 */
}

/* 제목 스타일 */
h1 {
    text-align: center;
    color: #212529;
    margin-bottom: 25px;
    font-size: 26px;
    font-weight: bold;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 15px;
}

/* -------------------- 2. 테이블 및 입력 필드 스타일 -------------------- */
table {
    width: 100%;
    margin-bottom: 20px;
    border-collapse: collapse;
}

table tr {
    border-bottom: 1px solid #eee;
}

table tr:last-child {
    border-bottom: none;
}

table td {
    padding: 12px 0;
    font-size: 15px;
    color: #555;
}

/* 첫 번째 td (라벨) 스타일 */
table tr td:first-child {
    width: 120px;
    font-weight: 600;
    color: #343a40;
}

/* 입력 필드 */
input[type="text"],
input[type="password"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box; 
    transition: border-color 0.3s;
}

input[type="text"]:focus,
input[type="password"]:focus {
    border-color: #007bff; /* 포커스 시 파란색 강조 */
    outline: none;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
}

/* -------------------- 3. 버튼 스타일 -------------------- */
.submit-btn {
    width: 100%;
    padding: 12px;
    background-color: #007bff; /* 파란색 버튼 (메인 포인트) */
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 17px;
    margin-top: 15px;
    transition: background-color 0.3s ease;
    font-weight: bold;
}

.submit-btn:hover {
    background-color: #0056b3;
}
</style>
</head>
<body>
	<form id="addMemberForm" action="${pageContext.request.contextPath}/out/addMember" method="post">
		<h1>회원가입</h1>
        
        <table>
            <tr>
                <td>아이디</td>
                <td><input type="text" name="id" id="id"></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="pw" id="pw"></td>
            </tr>
            <tr>
                <td>비밀번호 확인</td>
                <td><input type="password" name="pw2" id="pw2"></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><input type="text" name="name" id="name"></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td><input type="text" name="phone" id="phone"></td>
            </tr>
        </table>

		<button type="button" id="addMemberBtn" class="submit-btn">회원가입</button>
	</form>
</body>


<script>
$(document).ready(function() {
    $('#addMemberBtn').click(function() {
        // 입력 필드에서 ID 속성을 사용하여 값을 가져옴
        let id = $('#id').val();
        let pw = $('#pw').val();
        let pw2 = $('#pw2').val(); // pw2 값도 정확히 가져옴
        let name = $('#name').val();
        let phone = $('#phone').val();

        if(id === '') {
            alert('아이디를 입력하세요');
            $('#id').focus();
            return;
        }
        
        if(pw === '') {
            alert('비밀번호를 입력하세요');
            $('#pw').focus();
            return;
        }
        if(pw2 === '') {
            alert('비밀번호 확인을 입력하세요');
            $('#pw2').focus();
            return;
        }
        if(pw !== pw2) {
            alert('비밀번호와 확인이 일치하지 않습니다');
            $('#pw2').focus();
            return;
        }
        
        if(name === '') {
            alert('이름을 입력하세요');
            $('#name').focus();
            return;
        }
        if(phone === '') {
            alert('전화번호를 입력하세요');
            $('#phone').focus();
            return;
        }
        if(!/^\d+$/.test(phone)) {
            alert('전화번호는 숫자만 입력하세요');
            $('#phone').focus();
            return;
        }

        $('#addMemberForm').submit();
    });
});
</script>
</html>