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
#addGoodsForm {
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
input[type="number"],
input[type="file"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
    transition: border-color 0.3s;
}

input[type="text"]:focus,
input[type="number"]:focus,
input[type="file"]:focus {
    border-color: #007bff; /* 포커스 시 파란색 강조 */
    outline: none;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
}


/* -------------------- 3. 버튼 스타일 -------------------- */
#addGoodsBtn {
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

#addGoodsBtn:hover {
    background-color: #0056b3;
}
</style>
</head>
<body>
	<form enctype="multipart/form-data" action="${pageContext.request.contextPath}/emp/addGoods" method="post" id="addGoodsForm">
		<h1>상품 등록</h1>
		<table>
			<tr>
				<td>상품 이름</td>
				<td><input type="text" name="goodsName" id="goodsName"> </td>
			</tr>
			<tr>
				<td>상품 가격</td>
				<td><input type="number" name="goodsPrice" id="goodsPrice"></td>
			</tr>
			<tr>
				<td>포인트 적립률</td>
				<td><input type="text" name="pointRate" id="pointRate"></td>
			</tr>
			<tr>
				<td>상품 이미지</td>
				<td><input type="file" name="goodsImg" id="goodsImg"></td>
			</tr>
		</table>
		<button type="button" id="addGoodsBtn">상품 등록</button>
	</form>
</body>

<script>
$(document).ready(()=> {
    $('#addGoodsBtn').click(()=> {
        let goodsName = $('#goodsName').val();
        let goodsPrice = $('#goodsPrice').val();
        let pointRate = $('#pointRate').val();
        let goodsImg = $('#goodsImg').val();

        if(goodsName === ''){
            alert('상품 이름을 입력하세요');
            $('#goodsName').focus();
            return;
        }
        
        // 상품 가격이 숫자인지, 0보다 큰지 확인
        if(goodsPrice === '' || isNaN(goodsPrice) || parseFloat(goodsPrice) <= 0){
            alert('유효한 상품 가격을 입력하세요 (0보다 커야 합니다)');
            $('#goodsPrice').focus();
            return;
        }
        
        // 포인트 적립률이 숫자인지, 0 이상인지 확인
        if(pointRate === '' || isNaN(pointRate) || parseFloat(pointRate) < 0){
            alert('유효한 포인트 적립률을 입력하세요 (0 이상이어야 합니다)');
            $('#pointRate').focus();
            return;
        }
        
        if(goodsImg === ''){
            alert('상품 이미지를 선택하세요');
            return;
        }
        
        // 추가적인 이미지 파일 확장자 검사 로직 등을 여기에 추가할 수 있습니다.
        
        $('#addGoodsForm').submit();
    });
});
</script>
</html>