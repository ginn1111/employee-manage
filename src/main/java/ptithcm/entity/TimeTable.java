package ptithcm.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

@NamedNativeQueries({
		@NamedNativeQuery(
				name = "getEmpOfShiftNow", 
				query = "exec sp_get_emp_of_shift_now :id_shift", 
				resultClass = TimeTable.class
		),
		@NamedNativeQuery(
				name = "getAllTimeTable", 
				query = "exec sp_get_all_time_table", 
				resultClass = TimeTable.class
		),
		@NamedNativeQuery(
				name = "getAllTimeTableFilterByNameOfEmp", 
				query = "exec sp_get_all_time_table_filter_by_name :nameOfEmp", 
				resultClass = TimeTable.class
		),
		@NamedNativeQuery(
				name = "getAllTimeTableFilterByDate", 
				query = "exec sp_get_all_time_table_filter_by_date :date", 
				resultClass = TimeTable.class
		),
		@NamedNativeQuery(
				name = "insertTimeTableForFulltimeEmp", 
				query = "exec sp_insert_fulltime_emp :date", 
				resultClass = TimeTable.class
		)
})

@Entity
@Table(name = "TimeTable")
public class TimeTable {
	@Id
	@GeneratedValue
	@Column(name = "id_time_table")
	private int idTimeTable;

	@ManyToOne
	@JoinColumn(name="id_shift")
	private Shift shift;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "date")
	private Date date;

	@ManyToOne
	@JoinColumn(name = "id_emp")
	private Employee employee;

	@ManyToOne
	@JoinColumn(name = "id_emp_alter")
	private Employee employeeAlter;
	
	@OneToMany(mappedBy = "timeTable", fetch = FetchType.EAGER)
	private Collection<Evaluate> evaluates;

	@Column(name = "description")
	private String description;
	
	@OneToMany(mappedBy = "timeTable", fetch = FetchType.EAGER)
	private Collection<Work> works;

	public TimeTable(Shift shift, Date date, Employee employee) {
		super();
		this.shift = shift;
		this.date = date;
		this.employee = employee;
	}
	
	public TimeTable(TimeTable timeTable) {
		this.idTimeTable = timeTable.getIdTimeTable();
		this.date = timeTable.getDate();
		this.description = timeTable.getDescription();
		this.employee = timeTable.getEmployee();
		this.employeeAlter = timeTable.employeeAlter;
		this.shift = timeTable.getShift();
	}
	
	public TimeTable(int idTimeTable) {
		super();
		this.idTimeTable = idTimeTable;
	}

	public TimeTable(int idTimeTable, Employee employee, Shift shift, Date date, Employee employeeAlter) {
		this.idTimeTable = idTimeTable;
		this.date = date;
		this.shift = shift;
		this.employee = employee;
		this.employeeAlter = employeeAlter;
	}
	
	public TimeTable(Employee employee, Shift shift, Date date, Employee employeeAlter) {
		this.date = date;
		this.shift = shift;
		this.employee = employee;
		this.employeeAlter = employeeAlter;
	}
	
	public TimeTable(Employee employee, Date date, Employee employeeAlter) {
		this.date = date;
		this.employee = employee;
		this.employeeAlter = employeeAlter;
	}

	public TimeTable() {
	}

	public Collection<Evaluate> getEvaluates() {
		return evaluates;
	}
	
	public void setEvaluates(Collection<Evaluate> evaluates) {
		this.evaluates = evaluates;
	}
	
	public Employee getEmployeeAlter() {
		return employeeAlter;
	}

	public void setEmployeeAlter(Employee employeeAlter) {
		this.employeeAlter = employeeAlter;
	}

	public Shift getShift() {
		return shift;
	}

	public Collection<Work> getWorks() {
		return this.works;
	}
	
	public void setWorks(Collection<Work> works) {
		this.works = works;
	}
	
	public void setShift(Shift shift) {
		this.shift = shift;
	}

	public int getIdTimeTable() {
		return idTimeTable;
	}

	public void setIdTimeTable(int idTimeTable) {
		this.idTimeTable = idTimeTable;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

//	@Override
//	public String toString() {
//		return this.shift.getName() + " " + this.date + " " + this.employee.getLastName() + " "
//				+ this.employee.getPosition().getPositionName() + " " + this.employee.getPhone();
//	}
}
