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

/* 폼 컨테이너 (로그인 폼과 유사, 중앙 정렬 박스) */
#addEmpForm {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 380px; /* 적절한 너비 */
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

/* 첫 번째 td (라벨) 너비 조정 */
table tr td:first-child {
    width: 110px;
    font-weight: 600;
    color: #343a40;
}

/* 입력 필드 컨테이너 조정 */
table tr td:last-child {
    padding-left: 10px;
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

/* 활성화/비활성화 라디오 버튼 그룹 */
/* 라벨을 사용하여 클릭 영역 확장 및 간격 조정 */
td input[type="radio"] {
    margin-right: 5px;
}
td input[type="radio"] + label {
    margin-right: 15px;
    cursor: pointer;
}


/* -------------------- 3. 추가 버튼 스타일 -------------------- */
#addEmpBtn {
    width: 100%;
    padding: 12px;
    background-color: #007bff; 
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 17px;
    margin-top: 15px;
    transition: background-color 0.3s ease;
    font-weight: bold;
}

#addEmpBtn:hover {
    background-color: #0056b3;
}
</style>
</head>
<body>
	<form action="${pageContext.request.contextPath}/emp/addEmp" method="post" id="addEmpForm">
        <h1>사원추가</h1>
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
				<td>활성화</td>
				<td>
                    <input type="radio" name="active" id="active1" value="1"><label for="active1">활성화</label>
                    <input type="radio" name="active" id="active0" value="0"><label for="active0">비활성화</label>
                </td>
			</tr>
		</table>
		<button type="button" id="addEmpBtn">추가</button>
	</form>
</body>

<script>
$(document).ready(()=> {
    $('#addEmpBtn').click(()=> {
        let id = $('#id').val();
        let pw = $('#pw').val();
        let pw2 = $('#pw2').val();
        let name = $('#name').val();
        let active = $('input[name="active"]:checked').val();
        
        if(id === ''){
            alert('아이디를 입력하세요');
            return;
        }
        if(pw === ''){
            alert('비밀번호 입력하세요');
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
        if(name === ''){
            alert('이름을 입력하세요');
            return;
        }
        if(active === undefined){
            alert('활성화 여부를 선택하세요');
            return;
        }
        
        $('#addEmpForm').submit();
    });
});
</script>
</html>