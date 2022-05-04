package ptithcm.entity;

import java.util.Date;

import javax.persistence.*;

@NamedNativeQueries(@NamedNativeQuery(name="computeSalary", query = "exec sp_compute_salary :month, :year", resultClass = Salary.class))

@Entity
@Table(name="Salary")
public class Salary {
	@Id
	@GeneratedValue
	@Column(name="id_salary")
	private int idSalary;
	
	@Temporal(TemporalType.DATE)
	@Column(name="date")
	private Date date;
	
	@Column(name="salary")
	private Double salary;
	
	@Column(name="note")
	private String note;
	
	@ManyToOne
	@JoinColumn(name="id_emp")
	private Employee employee;

	public Salary() {
		super();
	}

	public int getIdSalary() {
		return idSalary;
	}

	public void setIdSalary(int idSalary) {
		this.idSalary = idSalary;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
}
