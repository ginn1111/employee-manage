package ptithcm.entity.tmp;

import javax.persistence.*;

import ptithcm.entity.Employee;

@NamedNativeQueries(@NamedNativeQuery(name = "getJobOfEmpToManager", query = "exec sp_get_job_of_emp_to_manager :date, :id_shift", resultClass = JobOfEmpToManager.class))

@Entity
public class JobOfEmpToManager {
	@Id
	@GeneratedValue
	@Column(name = "id")
	private String id;

	@Column(name = "job")
	private String job;

	@ManyToOne
	@JoinColumn(name = "id_emp")
	private Employee employee;

	public JobOfEmpToManager() {
	}

	public JobOfEmpToManager(String id, String job, Employee employee, Employee employeeAlter) {
		super();
		this.id = id;
		this.job = job;
		this.employee = employee;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	@Override
	public String toString() {
		return this.employee.getLastName() + " " + this.job;
	}
}
