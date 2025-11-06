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
	<h1>배송지관리</h1>
	<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
	
	<div>
		<a href="#{pageContext.request.contextPath}/customer/addAddress">배송지 추가</a> 
		<!-- 최대 5개까지 / 6개 입력 시 가장 오래된 데이터 삭제 -->
	</div>
</body>
</html>