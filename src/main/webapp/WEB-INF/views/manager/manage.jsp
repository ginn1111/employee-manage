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
			<section class="manage__container">

				<!-- FAULTS -->
				<div id="faults" class="card manage">
					<div class="manage__header">
						<h5 class="header__title">Faults</h5>
						<div class="header__controller">
							<a href="manager/manage/faults.htm?new#faults"
								class="btn--customize btn-add" 
								data-control="faults"
							>
								Add
							</a>
							<button class="btn--customize btn-remove btn-remove-faults" disabled>Remove</button>
						</div>
					</div>
					<div class="manage__table">
						<div class="table__head table__head--faults">
							<span>Percent</span><span>Description</span>
						</div>
						<form:form class="table__body custom-scroll-bar form-faults"
							action="manager/manage/faults.htm?delete#faults" method="POST"
							modelAttribute="listFaultDel">
							<c:forEach items="${listFaultDel.list}" varStatus="status">
								<div class="table__item table__item--faults"
									data-control="faults">
									<form:checkbox
										value="${faults.get(status.index).idFault}"
										path="list[${status.index}]" />
									<span>${faults.get(status.index).percentOfSalary}</span> 
									<span>${faults.get(status.index).description}</span>
									<a
										href="manager/manage/faults/${faults.get(status.index).idFault}.htm#faults">
										<span class="table__item--edit"> <ion-icon
												name="pencil-outline"></ion-icon>
									</span>
									</a> <span class="table__item--delete"> <ion-icon
											name="trash-outline"></ion-icon>
									</span>
								</div>
							</c:forEach>
						</form:form>
					</div>
				</div>
				<!-- FAULTS END -->

				<!-- SHIFTS -->
				<div id="shifts" class="card manage">
					<div class="manage__header">
						<h5 class="header__title">Shifts</h5>
						<div class="header__controller">
							<a href="manager/manage/shifts.htm?new#shifts"
								class="btn--customize btn-add" data-control="shifts">Add</a>
							<button class="btn--customize btn-remove btn-remove-shifts" disabled>
								Remove</button>
						</div>
					</div>
					<div class="manage__table">
						<div class="table__head">
							<span>Shift</span><span>Time start</span><span>Time end</span><span>Salary</span><span>Num
								Of Emp</span>
						</div>
						<form:form class="table__body custom-scroll-bar form-shifts"
							action="manager/manage/shifts.htm?delete#shifts" method="POST"
							modelAttribute="listShiftDel">
							<c:forEach items="${listShiftDel.list}" varStatus="status">
								<div class="table__item table__item--shifts"
									data-control="shifts">
									<form:checkbox value="${shifts.get(status.index).idShift}"
										path="list[${status.index}]" />
									<span>${shifts.get(status.index).name}</span> 
									<span> <fmt:formatDate
											value="${shifts.get(status.index).timeStart}" pattern="HH:mm" />
									</span> 
									<span> <fmt:formatDate
											value="${shifts.get(status.index).timeEnd}" pattern="HH:mm" />
									</span>
								<%-- 	<span>${shifts.get(status.index).timeStart}</span>
									<span>${shifts.get(status.index).timeEnd}</span> --%>
									<span>${shifts.get(status.index).salary}</span> <span>${shifts.get(status.index).numOfEmp}</span>
									<a
										href="manager/manage/shifts/${shifts.get(status.index).idShift}.htm#shifts">
										<span class="table__item--edit"> <ion-icon
												name="pencil-outline"></ion-icon>
									</span>
									</a> <span class="table__item--delete"> <ion-icon
											name="trash-outline"></ion-icon>
									</span>
								</div>
							</c:forEach>
						</form:form>
					</div>
				</div>
				<!-- SHIFTS END -->

				<!-- TASKS -->
				<div id="tasks" class="card manage  manage--tasks">
					<div class="manage__header">
						<h5 class="header__title">Tasks</h5>
						<div class="header__controller">
							<a href="manager/manage/tasks.htm?new#tasks"
								class="btn--customize btn-add" 
								data-control="tasks"
							>
								Add
							</a>
							<button class="btn--customize btn-remove btn-remove-tasks" disabled>Remove</button>
						</div>
					</div>
					<div class="manage__table">
						<div class="table__head table__head--tasks">
							<span class="head__job">Job</span><span class="head__des">Description</span>
						</div>
						<form:form class="table__body custom-scroll-bar form-tasks"
							action="manager/manage/tasks.htm?delete#tasks" method="POST"
							modelAttribute="listTaskDel">
							<c:forEach items="${listTaskDel.list}" varStatus="status">
								<div class="table__item table__item--tasks"
									data-control="tasks">
									<form:checkbox
										value="${tasks.get(status.index).idTask}"
										path="list[${status.index}]" />
									<span>${tasks.get(status.index).job}</span> 
									<span>${tasks.get(status.index).description}</span>
									<a
										href="manager/manage/tasks/${tasks.get(status.index).idTask}.htm#tasks">
										<span class="table__item--edit"> <ion-icon
												name="pencil-outline"></ion-icon>
									</span>
									</a> <span class="table__item--delete"> <ion-icon
											name="trash-outline"></ion-icon>
									</span>
								</div>
							</c:forEach>
						</form:form>
						
					</div>
				</div>
				<!-- TASKS END -->

				<!-- TASKS FOR SHIFT -->
				<div id="uptasks" class="card manage  manage--uptasks">
					<div class="manage__header">
						<h5 class="header__title">Tasks for shift</h5>

						<div class="header__controller">
							<a href="manager/manage/uptasks.htm?new#uptasks"
								class="btn--customize btn-add" 
								data-control="uptasks"
							>
								Add
							</a>
							<button class="btn--customize btn-remove btn-remove-uptasks" disabled>Remove</button>
						</div>
					</div>
					<form:form 
						action="manager/manage/get-uptasks.htm#uptasks" 
						class="manage__time"
						modelAttribute="dateShiftForUpTask"
					>
						<label class="time__date"> Date 
							<form:input path="date" type="date" id="datepicker"/>
						</label> 
						<label class="time__shift"> Shift 
							<div class="select">
								<form:select path="shift" items="${shifts}" itemLabel="name" itemValue="idShift"/>
							</div>
						</label>
						<button type="submit" class="btn--customize btn-confirm">Load</button>
					</form:form>
					<div class="manage__table">
						<div class="table__head table__head--uptasks"">
							<span class="head__job">Job</span><span class="head__des">Description</span>
						</div>
						<form:form 
							class="table__body custom-scroll-bar form-uptasks"
							action="manager/manage/uptasks.htm?delete#uptasks"
							method="POST"
							modelAttribute="listUpTaskDel"
						>
							<c:forEach items="${listUpTaskDel.list}" varStatus="status">
								<div class="table__item table__item--uptasks"
									data-control="uptasks"
								>
									<form:checkbox
										value="${upTasks.get(status.index).idUpTask}"
										path="list[${status.index}]" />
									<span>${upTasks.get(status.index).task.job}</span> 
									<span>${upTasks.get(status.index).task.description}</span>
									<span class="table__item--delete"> 
										<ion-icon name="trash-outline"></ion-icon>
									</span>
								</div>
							</c:forEach>
						</form:form>
					</div>
				</div>
				<!-- TASK FOR SHIFTS END -->

				<!-- POSITIONS -->
				<div id="positions" class="card manage manage--positions">
					<div class="manage__header">
						<h5 class="header__title">Positions</h5>
						<div class="header__controller">
							<a href="manager/manage/positions.htm?new#positions"
								class="btn--customize btn-add" 
								data-control="positions"
							>
								Add
							</a>
							<button class="btn--customize btn-remove btn-remove-positions" disabled>Remove</button>
						</div>
					</div>
					<div class="manage__table">
						<div class="table__head">
							<span>Position</span><span>Coefficient</span><span>Full Time</span><span>Description</span>
						</div>
						<form:form class="table__body custom-scroll-bar form-positions"
							action="manager/manage/positions.htm?delete#positions" method="POST"
							modelAttribute="listPositionDel">
							<c:forEach items="${listPositionDel.list}" varStatus="status">
								<div class="table__item table__item--positions"
									data-control="positions">
									<form:checkbox
										value="${positions.get(status.index).idPosition}"
										path="list[${status.index}]" />
									<span>${positions.get(status.index).positionName}</span> <span>${positions.get(status.index).coefficient}</span>
									<span>${positions.get(status.index).isFullTime ? 'Yes' : 'No'}</span>
									<span>${positions.get(status.index).description}</span>
									<a
										href="manager/manage/positions/${positions.get(status.index).idPosition}.htm#positions">
										<span class="table__item--edit"> <ion-icon
												name="pencil-outline"></ion-icon>
									</span>
									</a> <span class="table__item--delete"> <ion-icon
											name="trash-outline"></ion-icon>
									</span>
								</div>
							</c:forEach>
						</form:form>
					</div>
				</div>
				<!-- POSITIONS END -->

				<!-- EMPLOYEES -->
				<div id="employees" class="card manage manage--employees">
					<div class="manage__header">
						<h5 class="header__title">Employees</h5>
						<div class="header__controller">
							<a href="manager/manage/employees.htm?new#employees"
								class="btn--customize btn-add" 
								data-control="employees"
							>
								Add
							</a>
							<button class="btn--customize btn-remove btn-remove-employees" disabled>Remove</button>
						</div>
					</div>
					<div class="manage__table">
						<div class="table__head">
							<span>ID</span><span>Name</span><span>Position</span><span>Gender</span><span>Address</span><span>Phone</span>
						</div>
						<form:form class="table__body custom-scroll-bar form-employees"
							action="manager/manage/employees.htm?delete#employees" method="POST"
							modelAttribute="listEmpDel">
							<c:forEach items="${listEmpDel.list}" varStatus="status">
								<div class="table__item table__item--employees"
									data-control="employees">
									<form:checkbox
										value="${employees.get(status.index).idEmployee}"
										path="list[${status.index}]" />
									<span>${employees.get(status.index).idEmployee}</span> 
									<span>${employees.get(status.index).fullName}</span> 
									<span>${employees.get(status.index).position.nameAndIsFullTime}</span>
									<span>${employees.get(status.index).gender == 1 ? 'Nam'
											: employees.get(status.index).gender == 0 ? 'Nữ' : 'Khác'}</span>
									<span>${employees.get(status.index).address}</span>
									<c:set var="tmp" value="${employees.get(status.index).phone}" />
									<c:set var="phone" value="${fn:trim(tmp)}" />
									<span>
										${fn:substring(phone, 0, 3)}
										${fn:substring(phone, 3, 6)}
										${fn:substring(phone, 6, 10)}  
									</span>
									<a
										href="manager/manage/employees/${employees.get(status.index).idEmployee}.htm?edit#employees">
										<span class="table__item--edit"> 
											<ion-icon name="pencil-outline"></ion-icon>
										</span>
									</a> 
									<a
										href="manager/manage/employees/${employees.get(status.index).idEmployee}.htm?change-password#employees">
										<span class="table__item--change-password" data-control="change-password">
											<ion-icon name="key"></ion-icon>
										</span>
									</a> 
									
									<span class="table__item--delete"> <ion-icon
											name="trash-outline"></ion-icon>
									</span>
								</div>
							</c:forEach>
						</form:form>
					</div>
				</div>
				<!-- EMPLOYEES END -->
				
				<!-- CONFIRM DIALOG -->
				<dialog class="dialog">
					<h5 class="dialog__title">Notify</h5>
					<span class="dialog__message">Are you sure about that?</span>
					<div class="dialog__control">
						<button class="btn--customize btn-confirm btn--warning">Delete</button>
						<button class="btn--customize btn-cancel btn--safe">Cancel</button>
					</div>
				</dialog>
				<div class="backdrop">
					<dialog class="modal"> 
					
					<!-- CHANGE PASSWORD FOR EMP -->
					<form class="form form--change-password" action="manager/manage/employees/change-password.htm#employees" method="POST">
						<h5 class="form__title">Change password</h5>
						<div class="form__item">
							<label>
								${employee.idEmployee} - ${employee.fullNameAndPosition}
							</label>
						</div>
						<div class="form__item">
							<label>
								New password
								<input class="form__input" name="new-password" type="password" placeholder="new password..."/>
							</label>
						</div>
						<div class="form__item--action">
							<button type="submit" class="btn-confirm btn--customize">Change</button>
							<button type="reset" class="btn-cancel btn--customize">Cancel</button>
						</div>
					</form>
					<!-- CHANGE PASSWORD FOR EMP END-->
					
					<!-- FORM EMPLOYEES -->
					<form:form 
						class="form form--employees"
						action="${link}#employees"
						method="POST" 
						modelAttribute="employee"
					>
						<h5 class="form__title">Employee</h5>
						<form:input type="hidden" path="idEmployee" />
						<form:input type="hidden" path="active" value="${employee.active != null ? employee.active : true }"/>
						<div class="form__item form__item--employee">
							<label>First Name 
								<form:input 
									path="firstName"
									class="form__input"
									placeholder="first name..." 
									required="required"
								/>
							</label>
							<label>Last Name 
								<form:input 
									path="lastName"
									class="form__input"
									placeholder="last name..." 
									required="required"
								/>
							</label>
						</div>
						
						<div class="form__item">
							<label>Position
								<div class="select">
									<form:select 
										items="${listPosition}" 
										itemLabel="nameAndIsFullTime" 
										itemValue="idPosition" 
										path="position.idPosition" 
									/>
								</div>
							</label>
						</div>
						<div class="form__item form__item--employee">
							<label>Phone
								<form:input 
									path="phone"
									class="form__input"
									placeholder="phone..." />
							</label>
							<label>Gender
								<div class="select">
									<form:select 
										items="${listGender}" 
										itemLabel="label" 
										itemValue="value" 
										path="gender" 
									/>
								</div>
							</label>
						</div>
						<div class="form__item form__item--employee">
							<label>Birthday
								<form:input
									type="date"
									path="birthday"
									class="form__input"
									format="yyyy-MM-dd"
								/>
							</label>
							<label>Role
								<div class="select ${btnTitle == 'Add' ? '' : 'disabled'}">
									<form:select 
										disabled="${btnTitle == 'Add' ? false : true}"
										items="${listRole}" 
										itemLabel="roleName" 
										itemValue="idRole" 
										path="account.role.idRole" 
									/>
								</div>
							</label>
						</div>
						<div class="form__item">
							<label>Address
								<form:textarea 
									path="address"
									class="form__input"
									placeholder="addess..." 
									rows="3"
								/>
							</label>
						</div>
						<div class="form__item--action">
							<button type="submit" class="btn-confirm btn--customize">${btnTitle}</button>
							<button type="reset" class="btn-cancel btn--customize">Cancel</button>
						</div>
					</form:form>
					<!-- FORM EMPLOYEES END-->

					<!-- FORM SHIFTS --> 
					<form:form class="form form--shifts"
						action="${link}#shifts"
						method="POST" 
						modelAttribute="shift"
					>
						<h5 class="form__title">shift</h5>
						<form:input type="hidden" path="idShift" />
						<div class="form__item">
							<label>Shift 
								<form:input 
									class="form__input" 
									type="text"
									path="name" 
									placeholder="shift..." 
									required="required"
								/>
							</label>
						</div>
						<div class="form__item">
							<label>Time start 
								<form:input
									class="form__input form__input--time-start" 
									type="time"
									path="timeStart"
									required="required" 
								/>
							</label>
						</div>
						<div class="form__item">
							<label>Time end 
								<form:input
									class="form__input form__input--time-end" 
									type="time"
									path="timeEnd" 
									required="required" 
								/>
							</label>
						</div>
						<div class="form__item">
							<label>Salary 
								<form:input 
									class="form__input" 
									type="text"
									placeholder="salary..." 
									path="salary" 
									required="required"
								/>
							</label>
						</div>
						<div class="form__item">
							<label>Num Of Emp 
								<form:input 
									class="form__input"
									type="number" 
									min="1" 
									max="5" 
									placeholder="num of employee..."
									path="numOfEmp" 
									required="required" 
								/>
							</label>
						</div>
						<div class="form__item">
							<form:input 
								class="form__input"
								type="hidden" 
								path="deleted" 
								value="${shift.deleted != null ? shift.deleted : false}"
							/>
						</div>
						<div class="form__item--action">
							<button type="submit" class="btn-confirm btn--customize">${btnTitle}</button>
							<button class="btn-cancel btn--customize">Cancel</button>
						</div>
					</form:form> 
					<!-- FORM SHIFTS END--> 
					
					<!-- FROM FAULTS -->
					<form:form 
						class="form form--faults"
						action="${link}#faults"
						method="POST" 
						modelAttribute="fault"
					>
						<h5 class="form__title">Fault</h5>
						<form:input type="hidden" path="idFault" />
						<div class="form__item">
							<label>Percent of salary (%) 
								<form:input 
									path="percentOfSalary"
									class="form__input"
									type="number"
									step="10"
									value="${fault.percentOfSalary != null ? fault.percentOfSalary : 100}" 
									placeholder="percent..." />
							</label>
						</div>
						<div class="form__item">
							<label>Description 
								<form:textarea 
									class="form__input"
									path="description"
									cols="20"
									rows="6" 
									placeholder="description..."/>
							</label>
						</div>
						<form:input 
							type="hidden" 
							path="deleted" 
							value="${fault.deleted != null ? fault.deleted : false}"
						/>
						<div class="form__item--action">
							<button type="submit" class="btn-confirm btn--customize">${btnTitle}</button>
							<button type="reset" class="btn-cancel btn--customize">Cancel</button>
						</div>
					</form:form>
					<!-- FROM FAULTS END-->
			
					<!-- FORM POSITIONS -->
					<form:form 
						class="form form--positions"
						action="${link}#positions" 
						modelAttribute="position" 
						method="POST"
					>
						<h5 class="form__title">Position</h5>
						<form:input type="hidden" path="idPosition" />
						<div class="form__item">
							<label>Position 
								<form:input 
									path="positionName" 
									class="form__input" 
									type="text"
									placeholder="position..." 
									required="required"
								/>
							</label>
						</div>
						<div class="form__item">
							<label>Coefficient 
								<form:input 
									class="form__input"
									type="number" 
									min="1" 
									max="5" 
									step="0.1"
									placeholder="coefficient..." 
									path="coefficient"
									value="${position.coefficient != null ? position.coefficient : 1}"
									required="required"
								/>
							</label> 
							<label class="form__input-checkbox">
								<p>Full time</p> 
								<form:checkbox 
									class="form__input" 
									path="isFullTime"
								/>
							</label>
						</div>
						<div class="form__item">
							<label>Description 
								<form:textarea 
									class="form__input" 
									path="description"
									id="" cols="20" rows="6" 
									placeholder="description..."
								/>
							</label>
						</div>
						<form:input 
							type="hidden" 
							path="deleted"
							value="${position.deleted != null ? position.deleted : false }"
						 />
						<div class="form__item--action">
							<button type="submit" class="btn-confirm btn--customize">${btnTitle}</button>
							<button type="reset" class="btn-cancel btn--customize">Cancel</button>
						</div>
					</form:form>
					<!-- FORM POSITIONS END-->

					<!-- FORM TASKS -->
					<form:form 
						class="form form--tasks"
						action="${link}#tasks"
						method="POST" 
						modelAttribute="task"
					>
						<h5 class="form__title">Fault</h5>
						<form:input type="hidden" path="idTask" />
						<form:input 
							type="hidden" 
							path="deleted" 
							value="${task.deleted != null ? task.deleted : false}" 
						/>
						<form:input 
							type="hidden" 
							path="idManager" 
							value="${pageContext.request.userPrincipal.name}"
						/>
						<div class="form__item">
							<label>Job
								<form:input 
									required="required"
									path="job"
									class="form__input"
									placeholder="job..."
								/>
							</label>
						</div>
						<div class="form__item">
							<label>Description 
								<form:textarea 
									class="form__input"
									path="description"
									rows="6" 
									required="required"
									placeholder="description..."
								/>
							</label>
						</div>
						<div class="form__item--action">
							<button type="submit" class="btn-confirm btn--customize">${btnTitle}</button>
							<button type="reset" class="btn-cancel btn--customize">Cancel</button>
						</div>
					</form:form>
					<!-- FORM TASKS END-->
					
					<!-- FORM TASKS FOR SHIFTS -->
					<form:form 
						class="form form--uptasks"
						action="${link}"
						modelAttribute="tasksForShift"
					>
						<h5 class="form__title">Task For Shift</h5>
						<form:input type="hidden" path="idManager" value="${pageContext.request.userPrincipal.name}" />
						<div class="form__item form__item--tasks-for-shift">
							<label class="time__date"> Date 
								<form:input 
									path="date" 
									type="date"
								/>
							</label> 
							<label class="time__shift"> Shift 
								<div class="select">
									<form:select 
										path="idShift" 
										items="${shifts}" 
										itemLabel="name" 
										itemValue="idShift"
									/>
								</div>
							</label>
						</div>
						<div class="form__item">
							<label>Task
								<div class="select">
									<form:select items="${tasks}" path="task.idTask" itemLabel="job" itemValue="idTask"/>
								</div>
							</label>
						</div>
						<div class="form__item--action">
							<button type="submit" class="btn-confirm btn--customize">${btnTitle}</button>
							<button class="btn-cancel btn--customize">Cancel</button>
						</div>
					</form:form>
					</dialog>
				</div>
			</section>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>