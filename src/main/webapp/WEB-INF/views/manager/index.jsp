<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/includes/header.jsp"%>

<div class="container">
	<tg:dialog-message message="${message}" />
	<!-- Navigation -->
	<nav class="navigation active">
		<tg:navigation prefix="manager" link1="./manage.htm"
			link2="./report.htm" uri1="manage" uri2="report" name1="Manage"
			name2="Report" icon1="book-outline" icon2="clipboard-outline" />
	</nav>
	<div class="main active">
		<!-- Tool bar -->

		<section class="topbar">
			<tg:topbar />
		</section>
		<!-- Content -->
		<div class="main__content">
			<div class="dash-board dash-board--manager">
			
				<!-- NOW EMP -->
				<div class="now card">
					<table class="now__emp">
						<tbody class="custom-scroll-bar">
							<c:forEach items="${listTimeTableNow}" var="timeTable">
								<c:if test="${timeTable.employeeAlter != null}">
									<tr
										class="${timeTable.employeeAlter.position.positionName == 'Leader' ? 'leader' : ''} now__emp-item">
										<td>${timeTable.employeeAlter.firstName}
											${timeTable.employeeAlter.lastName}</td>
										<td>${timeTable.employeeAlter.position.positionName}</td>
										<c:set var="tmp" value="${timeTable.employeeAlter.phone}" />
										<c:set var="phone" value="${fn:trim(tmp)}" />
										<td>
											${fn:substring(phone, 0, 3)}
											${fn:substring(phone, 3, 6)}
											${fn:substring(phone, 6, 10)}  
										</td>
									</tr>
								</c:if>
								<c:if test="${timeTable.employeeAlter == null}">
									<tr
										class="${timeTable.employee.position.positionName == 'Leader' ? 'leader' : ''} now__emp-item">
										<td>${timeTable.employee.firstName}
											${timeTable.employee.lastName}</td>
										<td>${timeTable.employee.position.positionName}</td>
										<c:set var="tmp" value="${timeTable.employee.phone}" />
										<c:set var="phone" value="${fn:trim(tmp)}" />
										<td>
											${fn:substring(phone, 0, 3)}
											${fn:substring(phone, 3, 6)}
											${fn:substring(phone, 6, 10)}  
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- NOW EMP END -->

				<!-- DETAILS -->
				<div class="details card">
					<h2 class="details__header">
						Details of tasks
						<hr />
					</h2>
					<ul class="list__detail custom-scroll-bar">
						<c:forEach items="${jobOfEmpToMangerArray}" var="jobOfEmp">
							<li class="item__task">
								<fieldset>
									<legend>
										<span> ${jobOfEmp.get(0).employee.lastName}</span>
									</legend>
									<ul class="list__task">
										<c:forEach items="${jobOfEmp}" var="job">
											<li class="task">${job.job}</li>

										</c:forEach>
									</ul>
								</fieldset>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!-- DETAILS END -->
				
				<!-- TIME TABLE -->
				<div class="table card">
					<div class="utils">
						<h5 class="utils__title">Time table</h5>
						<form class="form--filter" action="manager/index/search.htm">
							<input type="date" name="date-search" value="${dateFilter}"/>
							<button type="submit" class="btn--customize btn-confirm">Filter</button>
						</form>
						<a 
							href="manager/index.htm"
							class="btn--customize btn-add btn--gen-time-table"
							data-control="gen-time-table"
								>
							New TimeTable
						</a>
					</div>
					<form action="manager/getjob.htm" class="get-roles">
						<input type="hidden" name="id_shift" /> 
						<input type="hidden" name="date" />
					</form>
					<div class="content header">
						<span class="date">Date</span> <span class="shift">Shift</span> <span
							class="emp-task">Employees</span>
					</div>
					<div class="content-box custom-scroll-bar">
						<c:forEach items="${timeTableArray}" var="timeTable" varStatus="status">
							<div 
								class="content ${timeTable.get(0).date.toString().compareTo(dateNow) < 0 ? 'disabled' : 
									(timeTable.get(0).shift.timeEnd.toString().compareTo(timeNow) < 0 
										&& timeTable.get(0).date.toString().compareTo(dateNow) == 0 
										? 'disabled' : '')}" 
										
								data-date="${timeTable.get(0).date}"
								data-shift="${timeTable.get(0).shift.idShift}"
							>
								<span class="content__date"> <fmt:formatDate
										value="${timeTable.get(0).date}" pattern="dd/MM/yyyy" />
								</span> <span class="content__shift">${timeTable.get(0).shift.name}</span>
								<span class="content__emps"> 
								<c:forEach items="${timeTable}" var="t">
										
										<c:if test="${t.employeeAlter != null}">
											<span style="color: salmon;">
												${t.employeeAlter.lastName} </span>
										</c:if>
										<c:if test="${t.employeeAlter == null}">
											<span> ${t.employee.lastName} </span>
										</c:if>

									</c:forEach>
								</span>
								<div class="content__action">
									<div class="action-wrapper">
										<div class="action action--change" data-control="change">
											<ion-icon name="refresh-outline"></ion-icon>
										</div>
									</div>
									<div class="action action--evaluate" data-control="evaluate">
										<ion-icon name="pencil-outline"></ion-icon>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- TIME TABLE END-->
			
			</div>
		</div>
		<!-- FROM -->
		<div class="backdrop">
			<dialog class="modal">
			<!-- CHANGE EMP -->
			 <form:form
				action="manager/change-emp.htm" 
				class="form form__change-emp"
				modelAttribute="listChangeEmp" 
				method="POST"
			>
				<h5 class="form__title">Change Employee</h5>
				<span>
					<fmt:formatDate value="${sessionScope.date}" pattern="dd/MM/yyyy"/>
					 - ${sessionScope.shift}
				</span>
				<c:forEach 
					items="${listChangeEmp.listChangeEmp}" 
					var="changeEmp"
					varStatus="status"
				>
					<div class="form__item form__item-change-emp">
						<label> 
							<span>
								${listJobOfEmp.get(status.index).employeeAlter != null 
									? listJobOfEmp.get(status.index).employeeAlter.nameAndPosition
									: listJobOfEmp.get(status.index).employee.nameAndPosition}
							</span>
							<form:input 
								type="hidden"
								path="listChangeEmp[${status.index}].idEmp"
								value="${listJobOfEmp.get(status.index).employee.idEmployee}" 
							/>
							<form:input 
								type="hidden" 
								path="listChangeEmp[${status.index}].id"
								value="${listJobOfEmp.get(status.index).idTimeTable}" 
							/>
							<div class="${listJobOfEmp.get(status.index).works.size() > 0 
										? 'disabled' 
										: ''} select" >
								<c:if test="${listJobOfEmp.get(status.index).employee.position.isFullTime}">
									<form:select 
										items="${listEmp}" 
										itemLabel="fullInfor"
										itemValue="idEmployee"
										path="listChangeEmp[${status.index}].idEmpAlter"
										disabled="${listJobOfEmp.get(status.index).works.size() > 0 
											? true 
											: false}"
									/>
								</c:if>
								<c:if test="${!listJobOfEmp.get(status.index).employee.position.isFullTime}">
									<form:select 
										items="${listEmpPartTime}" 
										itemLabel="fullInfor"
										itemValue="idEmployee"
										path="listChangeEmp[${status.index}].idEmpAlter"
										disabled="${listJobOfEmp.get(status.index).works.size() > 0 
											? true 
											: false}"
									/>
								</c:if>
							</div>
						</label>
					</div>

				</c:forEach>
				<div class="form__item--action">
					<button type="submit" class="btn-confirm btn--customize">
						Confirm</button>
					<button class="btn-cancel btn--customize">Cancel</button>
				</div>
			</form:form>
			<!-- CHANGE EMP END-->
			
			<!-- EVALUATION -->
			<form:form 
				action="manage/evaluation.html" 
				class="form form__evaluate-emp" 
				method="POST" 
				modelAttribute="listEvaluationEmp"
			>
				<h5 class="form__title">Evaluate Employees</h5>
				<span>note: amount equal 0 is delete</span>
				<c:forEach
					items="${listEvaluationEmp.list}"
					var="evaluation"
					varStatus="status"
				>
					<div class="form__item">
						<label> 
								${listJobOfEmp.get(status.index).employeeAlter != null 
									? listJobOfEmp.get(status.index).employeeAlter.nameAndPosition
									: listJobOfEmp.get(status.index).employee.nameAndPosition}
							<form:input 
									type="hidden"
									path="list[${status.index}].idTimeTable"
									value="${listJobOfEmp.get(status.index).idTimeTable}" 
							/>
							<div style="width: 100%; display: flex; align-items: center; justify-content: space-between;">
								<div  class="select">
									<form:select
										items="${listFault}" 
										itemLabel="description"
										itemValue="idFault"
										path="list[${status.index}].idFault"
									/>
								</div>
								<form:input 
									value="1"
									min="0"
									max="10"
									type="number"
									path="list[${status.index}].num"
									style="margin-left: 12px; width: 30%;"
								/>
							</div>
						</label>
					</div>
				</c:forEach>
				<div class="form__item--action">
					<button type="submit" class="btn-confirm btn--customize">
						Confirm</button>
					<button class="btn-cancel btn--customize">Cancel</button>
				</div>
			</form:form>
			<!-- EVALUATION END-->
			
			<!-- NEW TIMETABLE -->
			<form:form
				action="manager/index/new-timetable.htm" 
				class="form form--gen-time-table" 
				method="POST" 
				modelAttribute="dateForNewTimeTable"
			>
				<h5 class="form__title">New Time Table</h5>
				<div class="form__item">
					<label>
						Date for new time table
						<div class="select">
							<form:select path="date" items="${listDateForNewTimeTable}" itemLabel="label" itemValue="date"/>
						</div>
					</label>
				</div>
				 <div class="form__item--action">
					<button type="submit" class="btn-confirm btn--customize">
						Confirm</button>
					<button class="btn-cancel btn--customize">Cancel</button>
				</div>
			</form:form>
			<!-- NEW TIMETABLE END-->
			</dialog>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>