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
			<tg:topbar />
		</section>
		<!-- Content -->
		<div class="main__content">
			<div class="employee dash-board">
				<!-- SALARY -->
				<div class="card shifts-register shifts-register--read">
					<span class="title">Salary</span>
					<c:if test="${salaries.size() == 0 }">
						<span style="padding-block: 12px;">Not have any more...</span>
					</c:if>
					<c:if test="${salaries.size() != 0 }">
						<div class="register__header">
							<div class="header__text">Month</div>
							<div class="header__text">Year</div>
							<div class="header__text">Salary</div>
							<div class="header__text">Note</div>
						</div>
						<div class="register__body salary__container custom-scroll-bar">
							<c:forEach items="${salaries}" var="salary" varStatus="i">
								<div class="body__container body__container--${i.index+1} body__container--salaries">
									<div class="body__shift">
										<fmt:formatDate value="${salary.date}" pattern=" MM" />
									</div>
									<div class="body__shift">
										<fmt:formatDate value="${salary.date}" pattern=" yyyy" />
									</div>
									<div class="body__shift">
										<fmt:setLocale value = "vi_VN" scope="session"/>
										<fmt:formatNumber value="${salary.salary}"  type="currency" />
									</div>
									<div class="body__shift">${salary.note}</div>
								</div>
							</c:forEach>
						</div>
					</c:if>
				</div>
				<!-- SALARY END -->

				<!-- EVALUATION ALL -->
				<div id="evaluations"
					class="card shifts-register shifts-register--read">
					<div class="register__title">
						<span class="title">Evaluation</span>
					</div>
					<c:forEach items="${evaluationArray}" var="evaluations"
						varStatus="eArr">
						<div class="shifts-register shifts-register--${eArr.index+1}">
							<div class="register__header">
								<div class="header__text">Week ${eArr.index+1}</div>
								<c:forEach items="${dateOfShift.get(eArr.index)}" var="date">
									<div class="header__text">
										<span>${date[0]}</span> <span>${date[1]}</span>
									</div>
								</c:forEach>
							</div>
							<div class="register__body">
								<c:forEach items="${evaluations}" var="evaluation"
									varStatus="eI">
									<div class="body__container body__container--${eI.index+1}">
										<div class="body__shift">${shifts.get(eI.index).name}</div>
										<c:forEach items="${evaluation}" var="evaItem">
											<c:if test="${evaItem != null}">
												<div class="body__check checked">
													<c:forEach items="${evaItem}" var="e">
														<%-- <c:if test="${e.description == '' }">
															<span>- Chưa đánh giá</span>
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
											<c:if test="${evaItem == null}">
												<div class="body__check"></div>
											</c:if>
										</c:forEach>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- EVALUATION ALL END -->
			</div>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>