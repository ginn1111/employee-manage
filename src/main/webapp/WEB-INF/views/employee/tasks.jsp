<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/includes/header.jsp"%>
<div class="container">
	<!-- Navigation -->
	<nav class="navigation active">
		<tg:navigation prefix="employee" link1="./tasks.htm"
			link2="./salary.htm" uri1="tasks" uri2="salary" name1="Tasks"
			name2="Earn" icon1="today-outline" icon2="cash-outline"/>
	</nav>
	<div class="main active">
		<!-- Tool bar -->

		<section class="topbar">
			<tg:topbar role="employee" />
		</section>
		<!-- Content -->
		<div class="main__content">
			<div class="employee dash-board">
				<!-- EVALUATION -->
				<div class="card shifts-register shifts-register--read">
					<div class="register__title">
						<span class="title">Evaluation</span> <a
							href="employee/salary.htm#evaluations"
							class="btn--customize btn-confirm">All</a>
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
						<c:forEach items="${evaluationArray}" var="evaluations" varStatus="status">
							<div class="body__container body__container--${status.index+1}">
								<div class="body__shift">${shifts.get(status.index).name}</div>
								<c:forEach items="${evaluations}" var="evaluation">
									<c:if test="${evaluation != null}">
										<div class="body__check checked">
											<c:forEach items="${evaluation}" var="e">
												<%-- <c:if test="${e.description == '' }">
													<span></span>
												</c:if> --%>
												<c:if test="${e.description != '' }">
													<c:if test="${e.num != 1}">
														<span>- ${e.description} x ${e.num }</span>
													</c:if>
													<c:if test="${e.num == 1}">
														<span>- ${e.description}</span>
													</c:if>
												</c:if>

											</c:forEach>
										</div>
									</c:if>
									<c:if test="${evaluation == null}">
										<div class="body__check"></div>
									</c:if>

								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- EVALUATION END -->
				<!-- TASK AND TIME TABLE -->
				<div id="tasks-all"
					class="card shifts-register shifts-register--read">
					<div class="register__title">
						<span class="title">Task And TimeTable</span>
					</div>
					<c:forEach items="${jobArray}" var="tt" varStatus="i">
						<div class="shifts-register shifts-register--${i.index+1}">
							<div class="register__header">
								<div class="header__text">Week ${i.index+1}</div>
								<c:forEach items="${dateOfShift.get(i.index)}" var="date">
									<div class="header__text">
										<span>${date[0]}</span> <span>${date[1]}</span>
									</div>
								</c:forEach>
							</div>
							<div class="register__body">
								<c:forEach items="${tt}" var="jobs" varStatus="jobsIndex">
									<div
										class="body__container body__container--${jobsIndex.index+1}">

										<div class="body__shift">${shifts.get(jobsIndex.index).name}</div>
										<c:forEach items="${jobs}" var="job">
											<c:if test="${job != null}">
												<div class="body__check checked">
													<c:forEach items="${job}" var="item">
														<c:if test="${item.job != ''}">
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
					</c:forEach>
				</div>
				<!-- TASK AND TIME TABLE END-->
			</div>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>