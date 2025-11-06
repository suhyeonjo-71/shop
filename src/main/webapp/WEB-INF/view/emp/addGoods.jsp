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
	<h1>addGoods</h1>
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
	
	<!-- 파일업로드 기능 추가 -->
	<form enctype="multipart/form-data" action="${pageContext.request.contextPath}/emp/addGoods" method="post">
		<table>
			<tr>
				<td>goodsName</td>
				<td><input type="text" name="goodsName" id="goodsName"> </td>
			</tr>
			<tr>
				<td>goodsPrice</td>
				<td><input type="number" name="goodsPrice" id="goodsPrice"></td>
			</tr>
			<tr>
				<td>pointRate</td>
				<td><input type="text" name="pointRate" id="pointRate"></td>
			</tr>
			<tr>
				<td>goodsImg</td>
				<td><input type="file" name="goodsImg" id="goodsImg"></td>
			</tr>
		</table>
		<button type="submit">상품등록</button>
	</form>
</body>
</html>