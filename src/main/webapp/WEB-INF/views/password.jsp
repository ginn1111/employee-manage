
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/includes/header.jsp"%>
<div class="container">
	<tg:dialog-message message="${message}" />
	<!-- Navigation -->
	<nav class="navigation active">
		<c:if test="${role == 'Manager' }">
			<tg:navigation prefix="manager" link1="./manage.htm"
				link2="./report.htm" uri1="manage" uri2="report" name1="Manage"
				name2="Report" icon1="book-outline" icon2="clipboard-outline" />
		</c:if>
		
		<c:if test="${role != 'Manager' }">
			<tg:navigation prefix="employee" link1="./tasks.htm"
				link2="./salary.htm" uri1="tasks" uri2="salary" name1="Tasks"
				name2="Earn" icon1="today-outline" icon2="cash-outline" />
		</c:if>
		
	</nav>
	<div class="main active">
		<!-- Tool bar -->

		<section class="topbar">
			<tg:topbar role="${role}" />
		</section>
		<!-- Content -->
		<div class="main__content">
			<div class="dash-board">
				<div class="card">
					<div class="manage__header">
						<h5 class="header__title">Password</h5>
					</div>
					<form 
						class="form form--password"
						action="password.htm" 
						method="POST"
					>
						<div class="form__item form__item--password">
							<label>
								Old password
								<input name="old-password" type="password" placeholder="old password..."/>
							</label>
							<label>
								New password
								<input name="new-password" type="password" placeholder="new password..."/>
							</label>
						</div>
						<div class="form__item--action">
							<button type="submit" class="btn-confirm btn--customize">Change</button>
							<button type="reset" class="btn--warning btn--customize">Reset</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>