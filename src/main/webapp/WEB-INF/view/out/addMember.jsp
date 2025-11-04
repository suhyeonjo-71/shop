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
        <div id="msg" style="color: red; text-align: center; margin-bottom: 20px; "></div>
        
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
// 전역 변수로 ID 중복 검사 상태를 저장 (true: 사용 가능, false: 중복 또는 검사 필요)
let isIdCheckedAndAvailable = false;

// 경고 메시지를 #msg 영역에 출력하고 포커스를 이동시키는 함수
function showMsg(message, targetSelector) {
    $('#msg').text(message);
    // 메시지 종류에 따라 색상 설정 (기본은 빨간색)
    $('#msg').css('color', message.includes('사용 가능') ? 'blue' : 'red'); 
    
    // 타겟이 지정되어 있으면 해당 필드로 포커스 이동
    if (targetSelector) {
        $(targetSelector).focus();
    }
}

// #msg 영역의 메시지를 지우는 함수
function clearMsg() {
    $('#msg').text('');
}

// 1. 클라이언트 측 ID 유효성 검사 (빈 값, 형식 등)
function checkIdFormat(id) {
    if(id === '') {
        showMsg('아이디를 입력하세요', '#id');
        return false;
    }
    // 예시: 4자 이상 12자 이하의 영문, 숫자만 허용
    if(!/^[a-zA-Z0-9]{4,12}$/.test(id)) {
        showMsg('아이디는 4~12자의 영문/숫자만 가능합니다', '#id');
        return false;
    }
    clearMsg();
    return true;
}

// 2. 서버 측 ID 중복 검사 (AJAX)
function checkIdDuplicate() {
    let id = $('#id').val().trim();
    isIdCheckedAndAvailable = false; // 검사 시작 시 상태 초기화

    if (!checkIdFormat(id)) {
        return; // 형식 검사 실패 시 (이미 showMsg에서 포커스를 #id로 보냄) 중복 검사 중단
    }

    // AJAX 요청
    $.ajax({
        url: '${pageContext.request.contextPath}/IdCk', // IdCkRestController 매핑 경로
        type: 'GET',
        data: { id: id },
        dataType: 'json',
        async: true,
        success: function(isDuplicate) {
            if (isDuplicate) {
                // 중복이면 경고 메시지 출력 후 포커스를 #id로 이동
                showMsg('이미 사용 중인 아이디입니다', '#id'); 
                isIdCheckedAndAvailable = false;
            } else {
                // 사용 가능하면 성공 메시지 출력
                showMsg('사용 가능한 아이디입니다', null); // 성공 메시지는 포커스를 이동시키지 않음
                isIdCheckedAndAvailable = true;
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            showMsg('아이디 중복 검사 중 오류가 발생했습니다. 다시 시도해주세요.', null);
            console.error("AJAX Error: ", textStatus, errorThrown);
            isIdCheckedAndAvailable = false;
        }
    });
}

// 3. 나머지 필드 유효성 검사
function checkOtherValidation() {
    clearMsg();
    
    let pw = $('#pw').val();
    let pw2 = $('#pw2').val();
    let name = $('#name').val().trim();
    let phone = $('#phone').val().trim();

    // 비밀번호
    if(pw === '') {
        showMsg('비밀번호를 입력하세요', '#pw');
        return false;
    }
    // (이하 비밀번호 유효성 로직... 포커스 이동 포함)
    if(pw2 === '') {
        showMsg('비밀번호 확인을 입력하세요', '#pw2');
        return false;
    }
    if(pw !== pw2) {
        showMsg('비밀번호와 확인이 일치하지 않습니다', '#pw2');
        return false;
    }
    
    // 이름
    if(name === '') {
        showMsg('이름을 입력하세요', '#name');
        return false;
    }
    
    // 전화번호
    if(phone === '') {
        showMsg('전화번호를 입력하세요', '#phone');
        return false;
    }
    if(!/^\d{10,11}$/.test(phone)) { // 간단한 숫자 10~11자리 체크
        showMsg('전화번호는 숫자 10~11자리로 입력하세요', '#phone');
        return false;
    }

    clearMsg();
    return true;
}

$(document).ready(function() {
    // 1. ID 입력 필드 포커스를 잃었을 때 (blur) 이벤트 - ID 유효성 및 중복 검사 실행
    $('#id').on('blur', function() {
        let id = $(this).val().trim();
        
        // 1차: 형식 검사
        if (!checkIdFormat(id)) {
            // checkIdFormat 내부에서 이미 포커스를 #id로 이동시킴
            isIdCheckedAndAvailable = false;
            return; 
        }

        // 2차: 중복 검사 (AJAX)
        checkIdDuplicate();
    });
    
    // 2. ID 입력 필드에 입력이 다시 시작되면 중복 검사 상태 및 메시지 초기화
    $('#id').on('input', function() {
        isIdCheckedAndAvailable = false;
        clearMsg();
    });

    // 3. 회원가입 버튼 클릭 이벤트 - 최종 검증 및 제출
    $('#addMemberBtn').click(function(e) {
        e.preventDefault(); // 기본 폼 제출 방지
        clearMsg();

        // 1. ID 형식 유효성 검사
        if (!checkIdFormat($('#id').val().trim())) {
            // 실패 시 포커스 이동 (checkIdFormat 내부)
            return;
        }

        // 2. 나머지 필드 유효성 검사
        if (!checkOtherValidation()) {
            // 실패 시 포커스 이동 (checkOtherValidation 내부)
            return;
        }

        // 3. ID 중복 검사 최종 상태 확인
        if (!isIdCheckedAndAvailable) {
            // 중복 검사가 안 되었거나 실패했다면 메시지 출력 후 포커스를 #id로 이동
            showMsg('아이디 중복 검사가 필요합니다. 다시 시도하거나 입력 후 다른 곳을 클릭하세요.', '#id');
            // 최종적으로 한번 더 비동기 검사 실행
            checkIdDuplicate(); 
            return;
        }
        
        // 모든 검사 최종 통과: 폼 제출
        $('#addMemberForm').submit();
    });
    
    // 나머지 입력 필드는 입력 시 메시지를 지우도록 설정
    $('#pw, #pw2, #name, #phone').on('input', function() {
        clearMsg();
    });
});
</script>
</html>