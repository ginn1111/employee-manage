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
	<form class="container__sign-in" style="height: 80%" action="${pageContext.request.contextPath}/j_spring_security_check" method="POST">
		<h2 class="title">Manage your work easier</h2>

		<div class="input-box">
			<input id="username" type="text" class="input" name="username"/> 
			<label for="username">
				<ion-icon name="person-outline"></ion-icon>Your username
			</label>
		</div>
		<div class="input-box">

			<input id="password" type="password" class="input" name="password"/>

			<div class="toggle-password show">
				<ion-icon name="eye-off-outline"></ion-icon>
			</div>
			<div class="toggle-password">
				<ion-icon name="eye-outline"></ion-icon>
			</div>
			<label for="password"> <ion-icon
					name="lock-closed-outline"></ion-icon>Your
				password
			</label>
		</div>
		<input type="submit" class="btn btn--sign-in" value="Continue" />
		<div></div>
</main>
<%@include file="/resources/includes/footer.jsp"%></form>