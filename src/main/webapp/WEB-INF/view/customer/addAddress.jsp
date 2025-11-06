<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* -------------------- 1. 기본 설정 및 레이아웃 (모니터 정중앙 배치) -------------------- */
body {
    background-color: #f8f9fa; /* 배경색 통일 */
    color: #343a40;
    margin: 0;
    padding: 0;
    line-height: 1.6;
    /* 폼 컨테이너를 화면 중앙에 오도록 하기 위한 핵심 설정 */
    min-height: 100vh; /* 화면의 전체 높이를 사용 */
    display: flex; 
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
}

/* 폼 컨테이너 (화면 중앙에 배치될 박스) */
#addAddressForm {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 8px; /* */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 500px; 
    /* 정렬을 위해 추가된 margin 제거 (body의 flexbox가 처리) */
    margin: 0; 
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

/* -------------------- 2. 입력 필드 스타일 -------------------- */
.address-input-group {
    margin-bottom: 20px;
}

.address-input-group input[type="text"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box; /* */
    transition: border-color 0.3s;
    margin-bottom: 10px;
}

.address-input-group input[type="text"]:focus {
    border-color: #007bff; /* 포커스 시 파란색 강조 */
    outline: none;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.2); /* */
}

/* 📬 우편번호 그룹 스타일 (가로 정렬 유지) */
.postcode-group {
    display: flex;
    margin-bottom: 10px;
    gap: 10px; /* 필드와 버튼 사이 간격 */
}

#sample4_postcode {
    flex-grow: 1; /* 남은 공간을 모두 차지하도록 설정 */
    margin-bottom: 0 !important;
}

.address-input-group input[type="button"] {
    /* 우편번호 찾기 버튼 스타일 */
    padding: 10px;
    background-color: #6c757d; 
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 15px;
    margin-left: 0;
    flex-shrink: 0; /* 버튼 크기가 줄어들지 않도록 설정 */
    transition: background-color 0.3s ease;
    font-weight: bold;
}

.address-input-group input[type="button"]:hover {
    background-color: #5a6268;
}

#guide {
    display: block !important;
    margin-bottom: 10px;
    font-size: 14px;
    padding-left: 5px;
}

/* -------------------- 3. 버튼 스타일 -------------------- */
#addAddressBtn {
    width: 100%;
    padding: 12px;
    background-color: #007bff; 
    color: white;
    border: none; /* */
    border-radius: 4px;
    cursor: pointer;
    font-size: 17px;
    margin-top: 15px;
    transition: background-color 0.3s ease;
    font-weight: bold; /* */
}

#addAddressBtn:hover {
    background-color: #0056b3;
}

hr {
    display: none; /* hr 태그 숨김 */
}
</style>
</head>

<body>
	<form method="post" action="${pageContext.request.contextPath}/customer/addAddress" id="addAddressForm">
        <h1>배송지추가</h1>
		
		<div class="address-input-group">
            <div class="postcode-group">
                <input type="text" name="address" id="sample4_postcode" placeholder="우편번호">
                <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
            </div>
            
			<input type="text" name="address" id="sample4_roadAddress" placeholder="도로명주소">
			<input type="text" name="address" id="sample4_jibunAddress" placeholder="지번주소">
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" name="address" id="sample4_detailAddress" placeholder="상세주소">
			<input type="text" name="address" id="sample4_extraAddress" placeholder="참고항목">
		</div>
		<button type="submit" id="addAddressBtn">배송지추가</button>
	</form>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 다음 우편번호 API 스크립트는 변경되지 않았습니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var roadAddr = data.roadAddress;
                var extraRoadAddr = ''; 

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';
                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</html>