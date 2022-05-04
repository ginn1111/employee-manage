<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/includes/header.jsp"%>
<div class="container">
	<!-- Navigation -->
	<nav class="navigation active">
		<tg:navigation prefix="leader" link1="./tasks.htm"
			link2="./salary.htm" uri1="tasks" uri2="salary" name1="Tasks"
			name2="Earn" icon1="today-outline" icon2="cash-outline" />
	</nav>
	<div class="main active">
		<!-- Tool bar -->

		<section class="topbar">
			<tg:topbar role="employee" />
		</section>
		<!-- Content -->
		<div class="main__content">
			<div class="dash-board">
				<!-- TASK ASSIGNMENT -->
				<div class="card register__container">
					<div class="register__title">
						<span class="title">Tasks Assignment</span>
					</div>
					<c:forEach items="${jobForLeaderArray}" var="jobForLeaders"
						varStatus="status">
						<div class="shifts-register assignment shifts-register--${status.index+1}">
							<div class="register__header">
								<div class="header__text">Week ${status.index+1}</div>
								<c:forEach items="${dateOfShift.get(status.index)}" var="date">
									<div class="header__text">
										<span>${date[0]}</span> <span>${date[1]}</span>
									</div>
								</c:forEach>
							</div>
							<div class="register__body">
								<c:forEach items="${jobForLeaders}" var="jobs"
									varStatus="jobsIndex">
									<div
										class="body__container body__container--${jobsIndex.index+1}">

										<div class="body__shift">${shifts.get(jobsIndex.index).name}</div>
										<c:forEach items="${jobs}" var="job" varStatus="status">
											<c:choose>
												<c:when test="${job == null}">
													<div class="body__check"></div>
												</c:when>

												<c:when test="${job.get(0).job.length() == 0}">
													<div class="body__check checked"></div>
												</c:when>

												<c:when test="${job != null}">
													<div
														class="body__check 
															${job.get(0).date.toString().compareTo(dateNow) < 0 ? 'disabled' :
															(shifts.get(jobsIndex.index).timeEnd.toString().compareTo(timeNow) < 0 &&
																job.get(0).date.toString().compareTo(dateNow) == 0
															? 'disabled' : '')}"
													>
														<c:forEach items="${job}" var="item">
															<div class="body__tasks">
																<span class="task__title">${item.job}</span> <a
																	href="leader/get-emp-cooperate-with-leader.htm?date=${item.date}&id-shift=${item.shift.idShift}&id-uptask=${item.upTasks.idUpTask}&route=tasks"
																	class="btn--customize btn-confirm btn--task">
																	${item.upTasks.works.size()} </a>
															</div>
														</c:forEach>
													</div>
												</c:when>
											</c:choose>
										</c:forEach>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
				</div>
					<!-- TASK ASSIGNMENT END -->
					<div class="backdrop">
					<dialog class="modal">
					<form:form 
						modelAttribute="work"
						class="form form--assignment"
						action="leader/insert-work.htm"
					>
						<h5 class="form__title">Task assignment</h5>
						<div class="form__item">
							<c:forEach items="${listEmpOfWork}" var="empOfWork">
								<c:set var="emp" value="${ empOfWork.timeTable.employee}" />
								<c:set var="empAlter" value="${ empOfWork.timeTable.employeeAlter}" />
								<span class="btn--customize btn-confirm item__emp">
									<a 	href="leader/delete-work/${empOfWork.idWork}.htm"
										class="item__emp--delete">
										<ion-icon name="close-outline"></ion-icon>
									</a>
									${empAlter != null ? empAlter.nameAndPosition : emp.nameAndPosition }
								</span>
							</c:forEach>
						</div>
						<div class="form__item">
							<label>Employees
								<div class="select">
									<form:select 
										path="timeTable.idTimeTable" 
										items="${listEmpCooperateWithLeader}" 
										itemLabel="employee.nameAndPosition" 
										itemValue="idTimeTable" 
									/>
								</div>
							</label>
						</div>
						<div class="form__item--action">
							<button type="submit" class="btn-confirm btn--customize">
								Add</button>
							<button class="btn-cancel btn--customize">Cancel</button>
						</div>
					</form:form>
					</dialog>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>