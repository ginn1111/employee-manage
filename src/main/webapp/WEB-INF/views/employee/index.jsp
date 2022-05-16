<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/includes/header.jsp"%>
<div class="container">
	<!-- Navigation -->
	<nav class="navigation active">
		<tg:navigation prefix="employee" link1="./tasks.htm"
			link2="./salary.htm" uri1="tasks" uri2="salary" name1="Tasks"
			name2="Earn" icon1="today-outline" icon2="cash-outline" />
	</nav>
	<div class="main active">
		<!-- Tool bar -->

		<section class="topbar">
			<tg:topbar />
		</section>
		<!-- Content -->
		<div class="main__content">
			<div class="employee dash-board">
			
			<!-- SHIFT AND TASK NOW -->
				<div class="card shifts-register shifts-register--read">
					<div class="register__title">
						<span class="title">Task And TimeTable Now</span> <a
							href="employee/tasks.htm#tasks-all"
							class="btn--customize btn-confirm"> All </a>
					</div>
					<div class="register__header">
						<div class="header__text">Week now</div>
						<c:forEach items="${dateOfShiftNow}" var="date">
							<div class="header__text">
								<span>${date[0]}</span> <span>${date[1]}</span>
							</div>
						</c:forEach>
					</div>
					<div class="register__body">
						<c:forEach items="${jobArray}" var="jobs" varStatus="jobsIndex">
							<div
								class="body__container body__container--${jobsIndex.index + 1}">
								<div class="body__shift">${shifts.get(jobsIndex.index).name}</div>
								<c:forEach items="${jobs}" var="job">
									<c:if test="${job != null}">
										<div class="body__check checked">
											<c:forEach items="${job}" var="item">
												<c:if test="${item.job != '' }">
													<span>- ${item.job}</span>
												</c:if>
											</c:forEach>
										</div>
									</c:if>
									<c:if test="${job == null}">
										<div class="body__check"></div>
									</c:if>
								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- SHIFT AND TASK NOW END-->
				
				<!-- REGISTER SHFIT -->
				<form:form action="employee/register-shift.htm"
					modelAttribute="dateShiftArray" class="card register__container">
					<div class="register__title">
						<span class="title">Register Shift</span>
						<div class="title__action">
							<button disabled="disabled"
								class="btn--customize btn-confirm apply-for-all">Apply
								for all</button>

							<button type="submit" disabled="disabled"
								class="btn--customize btn-confirm get-time-table">
								Confirm</button>
							<button disabled="disabled"
								class="btn--customize btn-cancel reset-time-table">
								Reset</button>
						</div>
					</div>
					<c:forEach items="${timeTable}" var="week" varStatus="weekStatus">
						<div
							class="shifts-register shifts-register--${weekStatus.index+1}">
							<div class="register__header">
								<div class="header__text">Week ${weekStatus.index+1}</div>
								<c:forEach items="${dateOfShift.get(weekStatus.index)}"
									var="date">
									<div class="header__text">
										<span>${date[0]}</span> <span>${date[1]}</span>
									</div>
								</c:forEach>
							</div>

							<div class="register__body">
								<c:forEach items="${week}" var="shift" varStatus="shiftStatus">
									<div
										class="body__container body__container--${shiftStatus.index+1}">

										<div class="body__shift">${shifts.get(shiftStatus.index).name}</div>
										<c:forEach items="${shift}" var="day" varStatus="dayStatus">
											<c:if test="${day.status}">
												<div data-shift="${day.idShift}" data-date="${day.date}"
													class="body__check disabled"></div>
											</c:if>
											<c:if test="${!day.status}">
												<div class="body__check">
													<form:checkbox
														path="array[${weekStatus.index}][${shiftStatus.index}][${dayStatus.index}].isCheck" />
													<form:input type="hidden"
														path="array[${weekStatus.index}][${shiftStatus.index}][${dayStatus.index}].date" />
													<form:input type="hidden"
														path="array[${weekStatus.index}][${shiftStatus.index}][${dayStatus.index}].shift" />
												</div>
											</c:if>
										</c:forEach>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
				</form:form>
			</div>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>