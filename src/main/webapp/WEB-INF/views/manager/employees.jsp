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
				<!-- EMPLOYEES -->
				<div id="employees" class="card manage manage--employees">
					<div class="manage__header">
						<h5 class="header__title">Employees</h5>
						<form 
							action="manager/manage/employees/search.htm"
							method="POST"
							class="search-box">
                                    <ion-icon
                                        name="search-outline"
                                        class="search__icon"
                                    ></ion-icon>
                                    <input
                                    	required="required"
                                    	name="data"
                                        type="text"
                                        placeholder="name..."
                                    />
                                </form>
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
							<c:if test="${isShow}">
								<div style="padding-top: 24px">
									<a class='btn--customize btn-confirm' href="manager/manage/employees/${employees.size()}.htm?load-more">
										Load more...
									</a>
								</div>
							</c:if>
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
								<div class="select ${btnTitle == 'Add' ? '' : 'disabled'}">
									<form:select 
										items="${listPosition}" 
										itemLabel="nameAndIsFullTime" 
										itemValue="idPosition" 
										path="position.idPosition" 
										disabled="${btnTitle == 'Add' ? false : true}"
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
					</dialog>
				</div>
			</section>
		</div>
	</div>
</div>
<%@include file="/resources/includes/footer.jsp"%>