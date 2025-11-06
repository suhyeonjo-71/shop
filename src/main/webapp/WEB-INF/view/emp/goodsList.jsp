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
	<h1>상품관리</h1>
	
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
	
	<a href="${pageContext.request.contextPath}/emp/addGoods">상품추가</a>
	
	<table>
		<tr>
			<td>goodsCode</td>
			<td>goodsName</td>
			<td>goodsPrice</td>
			<td>soldout</td>
			<td>empCode</td>
			<td>pointRate</td>
			<td>createdate</td>
		</tr>
		
		<c:forEach car="g" items="${goodsList}">
			<tr>
				<td>${g.goodsCode}</td>
				<td>${g.goodsName}</td>
				<td>${g.goodsPrice}</td>
				<td>${g.soldout}</td>
				<td>${g.empCode}</td>
				<td>${g.pointRate}</td>
				<td>${g.createdate}</td>
			</tr>
		</c:forEach>
		
		
	</table>
</body>
</html>