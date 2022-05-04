package ptithcm.entity.tmp;

import java.util.Date;

import javax.persistence.*;

import ptithcm.entity.Employee;


@Entity
@Table(name="TimeTable")
public class TimeTableAndEmployee {
	@Id
	@GeneratedValue
	@Column(name="id_time_table")
	private int idTimeTable;
	
	@Column(name="id_shift")
	private int idShift;
	
	@Temporal(TemporalType.DATE)
	@Column(name="date")
	private Date date;
	
	@ManyToOne
	@JoinColumn(name="id_emp")
	private Employee employee;
	
	@ManyToOne
	@JoinColumn(name="id_emp_alter")
	private Employee employeeAlter;
	
	@Column(name="description")
	private String description;
	
	public TimeTableAndEmployee(int idTimeTable, int idShift, Date date, String description) {
		super();
		this.idTimeTable = idTimeTable;
		this.idShift = idShift;
		this.date = date;
		this.description = description;
	}
	
	public TimeTableAndEmployee(int idShift, Date date, String description) {
		super();
		this.idShift = idShift;
		this.date = date;
		this.description = description;
	}
	
	public TimeTableAndEmployee() {}

	public int getIdTimeTable() {
		return idTimeTable;
	}

	public void setIdTimeTable(int idTimeTable) {
		this.idTimeTable = idTimeTable;
	}

	public int getIdShift() {
		return idShift;
	}

	public void setIdShift(int idShift) {
		this.idShift = idShift;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Employee getEmployeeAlter() {
		return employeeAlter;
	}

	public void setEmployeeAlter(Employee employeeAlter) {
		this.employeeAlter = employeeAlter;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Override
	public String toString() {
		return this.idShift + " " + this.date + " " + this.employee.getLastName() + " " + this.employee.getPosition().getPositionName(); 
	}
}
