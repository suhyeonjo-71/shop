<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* addGoods.jsp에서 복사된 스타일 시작 */
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
#addNoticeForm {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 8px; /* */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 380px; /* 적절한 너비 */
    /* 기존 user-info와 empMenu가 폼 외부에 있어 중앙 정렬을 위해 body 스타일을 flex로 변경하고,
       폼만 중앙에 오도록 처리. user-info와 empMenu의 레이아웃 조정이 필요하면 body 스타일 수정 필요 */
}

.user-info {
    position: absolute; /* 절대 위치로 상단에 배치 시도 */
    top: 0;
    right: 0;
    padding: 10px;
    background-color: #e9ecef;
    width: 100%;
    text-align: right;
    box-sizing: border-box;
    display: none; /* 현재 페이지는 폼 중앙 정렬을 위해 잠시 숨김 처리 */
}

/* 제목 스타일 */
h1 {
    text-align: center;
    color: #212529;
    margin-bottom: 25px;
    font-size: 26px;
    font-weight: bold; /* */
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 15px;
}

/* -------------------- 2. 테이블 및 입력 필드 스타일 -------------------- */
table {
    width: 100%;
    margin-bottom: 20px; /* */
    border-collapse: collapse;
}

table tr {
    border-bottom: 1px solid #eee; /* */
}

table tr:last-child {
    border-bottom: none;
}

table td {
    padding: 12px 0;
    font-size: 15px;
    color: #555; /* */
}

/* 첫 번째 td (라벨) 너비 조정 */
table tr td:first-child {
    width: 110px;
    font-weight: 600; /* */
    color: #343a40;
}

/* 입력 필드 컨테이너 조정 */
table tr td:last-child {
    padding-left: 10px; /* */
}

/* 입력 필드 */
input[type="text"],
textarea { /* textarea 추가 */
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
    transition: border-color 0.3s; /* */
}

input[type="text"]:focus,
textarea:focus { /* textarea 추가 */
    border-color: #007bff; /* 포커스 시 파란색 강조 */
    outline: none;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.2); /* */
}

/* -------------------- 3. 버튼 스타일 -------------------- */
#addNoticeBtn { /* 버튼 ID를 'addNoticeBtn'으로 변경하고 스타일 적용 */
    width: 100%;
    padding: 12px;
    background-color: #007bff; 
    color: white; /* */
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 17px;
    margin-top: 15px;
    transition: background-color 0.3s ease;
    font-weight: bold; /* */
}

#addNoticeBtn:hover {
    background-color: #0056b3;
}
/* addGoods.jsp에서 복사된 스타일 끝 */
</style>
</head>
<body>
    <form action="${pageContext.request.contextPath}/emp/addNotice" method="post" id="addNoticeForm">
		<h1>공지추가</h1>
		<table>
			<tr>
				<td>noticeTitle</td>
				<td><input type="text" name="title" id="title"></td>
			</tr>
			<tr>
				<td>noticeContent</td>
				<td><textarea cols="50" rows="5" name="content" id="content"></textarea></td>
			</tr>
			<tr>
				<td>empCode</td>
				<td><input type="text" name="empCode" id="empCode" value="${loginEmp.empCode}" readonly></td>
			</tr>
		</table>
		<button type="button" id="addNoticeBtn">추가</button>
	</form>
</body>

<script>
$(document).ready(()=> {
    // 버튼 ID를 'addNoticeBtn'으로 변경
    $('#addNoticeBtn').click(()=> {
        let title = $('#title').val();
        let content = $('#content').val();
        let empCode = $('#empCode').val(); // empCode 추가

        // title 유효성 검사
        if(title === ''){
            alert('공지 제목을 입력하세요'); // alert 메시지 수정
            $('#title').focus();
            return;
        }
        
        // content 유효성 검사
        if(content === ''){
            alert('공지 내용을 입력하세요'); // alert 메시지 수정
            $('#content').focus();
            return;
        }

        // empCode 유효성 검사 (필요에 따라 추가)
        if(empCode === ''){
            alert('사원 코드를 입력하세요'); // alert 메시지 수정
            $('#empCode').focus();
            return;
        }
        
        // 유효성 검사 통과 후 폼 전송
        $('#addNoticeForm').submit(); //
    });
});
</script>
</html>