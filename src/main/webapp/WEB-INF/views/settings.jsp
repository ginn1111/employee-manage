
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/includes/header.jsp"%>
<div class="container">
	<tg:dialog-message message="${message}" />
	<!-- Navigation -->
	<nav class="navigation active">
		<c:if test="${userInfo.account.role.roleName == 'Manager' }">
			<tg:navigation prefix="manager" link1="./manage.htm"
				link2="./report.htm" uri1="manage" uri2="report" name1="Manage"
				name2="Report" icon1="book-outline" icon2="clipboard-outline" />
		</c:if>
		
		<c:if test="${userInfo.account.role.roleName != 'Manager' }">
			<tg:navigation prefix="${userInfo.account.role.roleName.toLowerCase()}" link1="./tasks.htm"
				link2="./salary.htm" uri1="tasks" uri2="salary" name1="Tasks"
				name2="Earn" icon1="today-outline" icon2="cash-outline" />
		</c:if>
		
	</nav>
	<div class="main active">
		<!-- Tool bar -->

		<section class="topbar">
			<tg:topbar />
		</section>
		<!-- Content -->
		<div class="main__content">
			<div class="dash-board">
				<div class="card">
					<div class="manage__header">
						<h5 class="header__title">Update soon...</h5>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>