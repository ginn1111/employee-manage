<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/includes/header.jsp"%>
<style type="text/css">
main.sign-in {
	background-image: url("imgs/cool-background.png");
}
</style>
<tg:dialog-message message="${message}" />
<main class="sign-in">
	<form class="container__sign-in" style="-height: 80%" action="${pageContext.request.contextPath}/j_spring_security_check" method="POST">
		<h2 class="title">Manage your work easier</h2>

		<div class="input-box">
			<input type="text" class="input" name="username"/> <span style="-width: 85px"><ion-icon
					name="person-outline"></ion-icon>Your username</span>
		</div>
		<div class="input-box">

			<input type="password" class="input" name="password"/>

			<div class="toggle-password show">
				<ion-icon name="eye-off-outline"></ion-icon>
			</div>
			<div class="toggle-password">
				<ion-icon name="eye-outline"></ion-icon>
			</div>
			<span style="-width: 130px"> <ion-icon
					name="lock-closed-outline"></ion-icon> <ion-icon></ion-icon>Your
				password
			</span>
		</div>
		<input type="submit" class="btn btn--sign-in" value="Continue" />
		<div></div>
</main>
<%@include file="/resources/includes/footer.jsp"%></form>