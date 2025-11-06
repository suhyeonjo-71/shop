<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* -------------------- 1. 기본 설정 및 레이아웃 (addEmp.jsp 참고) -------------------- */
body {
    background-color: #f8f9fa; /* 배경색 통일 */
    color: #343a40;
    margin: 0;
    padding: 0;
    line-height: 1.6;
    min-height: 100vh;
    display: flex;
    justify-content: center; /* 폼을 중앙에 배치하기 위함 */
    align-items: center; /* 폼을 중앙에 배치하기 위함 */
}

/* 폼 컨테이너 (addEmpForm 유사 스타일) */
#removeCustomerForm {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 380px; /* 적절한 너비 */
}

/* 제목 스타일 (h1) */
h1 {
    text-align: center;
    color: #212529;
    margin-bottom: 25px;
    font-size: 26px;
    font-weight: bold;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 15px;
}

/* -------------------- 2. 테이블 및 입력 필드 스타일 (addEmp.jsp 참고) -------------------- */
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

/* 입력 필드 및 텍스트 영역 */
input[type="text"],
textarea { /* textarea 추가 */
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
    transition: border-color 0.3s;
}

input[type="text"]:focus,
textarea:focus {
    border-color: #007bff; /* 포커스 시 파란색 강조 */
    outline: none;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
}

textarea {
    resize: vertical; /* 수직으로만 크기 조정 가능 */
    min-height: 100px; /* 적당한 최소 높이 설정 */
}

/* 읽기 전용 필드 스타일 (필요시) */
input[readonly] {
    background-color: #e9ecef;
    color: #6c757d;
}

/* -------------------- 3. 버튼 스타일 (addEmpBtn 유사 스타일) -------------------- */
button[type="submit"] {
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

button[type="submit"]:hover {
    background-color: #0056b3;
}
</style>
</head>
<body>
    <form action="${pageContext.request.contextPath}/customer/removeCustomerByEmp" method="post" id="removeCustomerForm">
        <h1>강제탈퇴</h1>
        <table>
            <tr>
                <td>customerId</td>
                <td>
                    <input type="text" name="customerId" id="customerId" value="${customerId}" readonly>
                </td>
            </tr>
            <tr>
                <td>memo</td>
                <td>
                    <textarea name="memo" id="memo"></textarea>
                </td>
            </tr>
        </table>
        <button type="submit">탈퇴</button>
    </form>
</body>
</html>