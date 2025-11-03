<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>회원가입</h1>
	<form id="addMemberForm" action="${pageContext.request.contextPath}/out/addMember" method="post">
		아이디 : <input type="text" name="id"><br>
		비밀번호 : <input type="password" name="pw"><br>
		비밀번호 확인: <input type="password" name="pw2"><br>
		이름 : <input type="text" name="name"><br>
		전화번호 : <input type="text" name="phone"><br>
		<button type="addMemberBtn">회원가입</button>
	</form>
</body>


<script>
$(document).ready(function() {
    $('#addMemberBtn').click(function() {
        let id = $('#id').val();
        let pw = $('#pw').val();
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