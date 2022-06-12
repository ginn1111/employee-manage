<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/includes/header.jsp"%>
<div class="container">
	<tg:dialog-message message="${message}" />
	<!-- Navigation -->
	<nav class="navigation active">
		<tg:navigation prefix="manager" link1="./manage.htm"
			link2="./report.htm" link3="./employees.htm" link4="./tasks.htm"
			uri1="manage" uri2="report" uri3="employees" uri4="tasks"
			name1="Manage" name2="Report" name3="Employees" name4="Tasks"
			icon1="book-outline" icon2="clipboard-outline" icon3="person-outline" icon4="flask-outline" 
		/>
	</nav>
	<div class="main active">
		<!-- Tool bar -->

		<section class="topbar">
			<tg:topbar />
		</section>
		<!-- Content -->
		<div class="main__content">
			<section class="manage__container tasks">

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
						<button type="submit" class="btn--customize btn-confirm tasks">Load</button>
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
						action="${link}#uptasks"
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