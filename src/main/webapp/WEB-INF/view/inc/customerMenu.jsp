<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<!-- 메인 메뉴 -->
	<a href="${pageContext.request.contextPath}/customer/customerIndex">[상품목록]</a>
	<!-- 상품목록 / 상세보기 / 주문 -->
	
	<a href="${pageContext.request.contextPath}/customer/customerInfo">[개인정보]</a>
	<!-- 
		개인정보열람
		비밀번호 수정 : 트랜잭션 pw_history에 비밀번호 입력 + customer 비밀전호 수정 (6개되면 가장 빠른 데이터 삭제)
		폰번호 수정
		회원탈퇴 : outid 입력 + customer 삭제
	-->
	
	<a href="${pageContext.request.contextPath}/customer/addressList">[배송지관리]</a>
	<!-- 베송지목록 / 배송지추가(최대 5개 6번째 입력 시 가장 오래된 배송지 자동삭제) / 삭제  -->
	
	<a href="${pageContext.request.contextPath}/customer/cartList">[장바구니]</a>
	
</div>
