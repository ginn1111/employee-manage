
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/includes/header.jsp"%>
<div class="container">
	<tg:dialog-message message="${message}" />
	<!-- Navigation -->
<nav class="navigation active">
		<tg:navigation prefix="manager" link1="./manage.htm"
			link2="./report.htm" uri1="manage" uri2="report" name1="Manage"
			name2="Report" icon1="book-outline" icon2="clipboard-outline"/>
	</nav>
	<div class="main active">
		<!-- Tool bar -->

		<section class="topbar">
			<tg:topbar role="manager" />
		</section>
		<!-- Content -->
		<div class="main__content">
			<div class="report">
				<!-- LACK OF EMPS -->
				<div class="table card table--report">
					<div class="utils">
						<h5 class="utils__title">Lack of employees</h5>
						<form class="form--filter" action="manager/report/search.htm">
							<input type="date" name="date-search" value="${dateFilter}"/>
							<button type="submit" class="btn--customize btn-confirm">Filter</button>
						</form>
					</div>
					<!-- <div class="full">
                                <span>TimeTable is full!</span>
                            </div> -->
					<div class="content content--report header">
						<span class="date">Date</span> 
						<span class="shift">Shift</span>  
						<span class="amount">Amount</span>
					</div>
					<div class="content-box custom-scroll-bar">
						<c:forEach items="${lackOfEmps}" var="i">
							<div class="content content--report">
								<span class="content__date">
									<fmt:formatDate value="${i.date}" pattern="dd/MM/yyyy" />
								</span> 
								<span class="content__shift">${i.nameOfShift}</span>
								<div class="content__amount">
									<span>${i.amount}</span>
								</div>
								
							</div>
						
						</c:forEach>
					</div>
				</div>
				<!-- LACK OF EMPS END -->

				<!-- REPORT SALARY -->
				<div class="table card table--salaries">
					<div class="utils">
						<div class="utils__container">
							<h5 class="utils__title">Employees's salary of month</h5>
							<a href="manager/report/compute-salary.htm"
									class="btn--customize btn--safe"
								>
								Compute
							</a>
						</div>
						<form:form 
							action="manager/report/get-salary.htm" 
							class="manage__time manage__time--salaries"
							modelAttribute="monthYear"
						>
							<label> Month
								<div class="select">
									<form:select items="${listMonth}" path="month.month" itemLabel="description" itemValue="month" />
								</div>
							</label>
							<label> Year
								<div class="select">
									<form:select items="${listYear}" path="year.year" itemLabel="year" itemValue="year" />
								</div>
							</label>
							
							<button type="submit" class="btn--customize btn-confirm">Load</button>
						</form:form>
					</div>
					<form action="./" class="get-roles"></form>
					<div class="content content--report header">
						<span>Employee</span> <span>Salary</span> <span>Note</span>
					</div>
					<div class="content-box custom-scroll-bar">
						<c:forEach items="${salaries}" var="salary" varStatus="status">
							<div class="content content--salary table__item table__item--salaries" data-control="salaries">
								<span>${salary.employee.fullName}</span> 
								<span>
									<fmt:setLocale value = "vi_VN" scope="session"/>
									<fmt:formatNumber value="${salary.salary}"  type="currency" />
								</span> 
								<span class="content__note"> ${salary.note} </span>
								<a
									href="manager/report/${salary.idSalary}.htm">
									<span class="table__item--edit"> <ion-icon
											name="pencil-outline"></ion-icon>
									</span>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- REPORT SALARY END -->
				<div class="backdrop">
					<dialog class="modal"> 
						<form:form 
							class="form form--salaries"
							action="manager/report/salary.htm?edit"
							modelAttribute="salary"
						>
							<h5 class="form__title">Salaries</h5>
							<form:input type="hidden" path="idSalary" />
							<form:input type="hidden" path="employee.idEmployee" />
							<form:input type="hidden" path="date" />
							<div class="form__item">
								<label>
									Name of employee
									<form:input class="form__input" path="employee.fullName" readonly="true"/>
								</label>
							</div>
							<div class="form__item">
								<label>
									Salary
									<form:input class="form__input" path="salary" readonly="true"/>
								</label>
							</div>
							<div class="form__item">
								<label>
									Note
									<form:textarea class="form__input" path="note" rows="6" />
								</label>
							</div>
							<div class="form__item--action">
								<button type="submit" class="btn-confirm btn--customize">Update</button>
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