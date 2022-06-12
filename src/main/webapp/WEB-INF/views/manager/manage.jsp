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
							<span>Percent (%)</span><span>Description</span>
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
								<label class="table__item table__item--shifts"
									data-control="shifts">
									<form:checkbox value="${allOfShift.get(status.index).idShift}"
										path="list[${status.index}]" />
									<span>${allOfShift.get(status.index).name}</span> 
									<span> <fmt:formatDate
											value="${allOfShift.get(status.index).timeStart}" pattern="HH:mm" />
									</span> 
									<span> <fmt:formatDate
											value="${allOfShift.get(status.index).timeEnd}" pattern="HH:mm" />
									</span>
									<span>
										<fmt:setLocale value = "vi_VN" scope="session"/>
										<fmt:formatNumber value="${allOfShift.get(status.index).salary}"  type="currency" />
									</span> 
									<span>${allOfShift.get(status.index).numOfEmp}</span>
									<a
										href="manager/manage/shifts/${allOfShift.get(status.index).idShift}.htm#shifts">
										<span class="table__item--edit"> <ion-icon
												name="pencil-outline"></ion-icon>
									</span>
									</a> <span class="table__item--delete"> <ion-icon
											name="trash-outline"></ion-icon>
									</span>
								</label>
							</c:forEach>
						</form:form>
					</div>
				</div>
				<!-- SHIFTS END -->

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
									type="number"
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
									onclick="${btnTitle == 'Update' ? 'return false;' : '' }"
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

					</dialog>
				</div>
			</section>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>