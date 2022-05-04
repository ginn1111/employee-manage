package ptithcm.entity;

import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

//@NamedNativeQueries(@NamedNativeQuery(name = "getShiftNow", query = "exec sp_get_shift_now", resultClass = Shift.class))
@NamedNativeQueries(@NamedNativeQuery(name = "getShiftNow", query = "select * from v_get_shift_now", resultClass = Shift.class))

@Entity
@Table(name = "Shift")
public class Shift {
	@Id
	@GeneratedValue
	@Column(name = "id_shift")
	private int idShift;
	
	@Column(name = "name")
	private String name;

	@DateTimeFormat(pattern = "HH:mm")
	@Column(name = "time_start")
	private Time timeStart;

	@DateTimeFormat(pattern = "HH:mm")
	@Column(name = "time_end")
	private Time timeEnd;
	
	@Column(name = "basic_salary")
	private Double salary;
	
	@Column(name="num_of_emp")
	private int numOfEmp;
	
	@Column(name="deleted")
	private Boolean deleted;
	
	@OneToMany(mappedBy = "shift", fetch = FetchType.EAGER)
	private Collection<TimeTable> timeTables;

	private static final DateFormat df = new SimpleDateFormat("HH:mm");

	public Shift() {
	}
	
	public Shift(Integer idShift) {
		this.idShift = idShift;
	}

	public Shift(String name, String timeStart, String timeEnd, Double salary, int numOfEmp) throws ParseException {
		super();
		this.name = name;
		this.salary = salary;
		this.numOfEmp = numOfEmp;
		this.deleted = false;
		this.setTimeStart(timeStart);
		this.setTimeStart(timeEnd);
	}

	public Shift(int idShift, String name, String timeStart, String timeEnd, Double salary) throws ParseException {
		super();
		this.idShift = idShift;
		this.name = name;
		this.salary = salary;
		this.setTimeStart(timeStart);
		this.setTimeStart(timeEnd);
	}

	public Shift(int idShift) {
		super();
		this.idShift = idShift;
	}
	
	public Collection<TimeTable> getTimeTables() {
		return timeTables;
	}

	public void setTimeTables(Collection<TimeTable> timeTables) {
		this.timeTables = timeTables;
	}

	public int getNumOfEmp() {
		return numOfEmp;
	}

	public void setNumOfEmp(int numOfEmp) {
		this.numOfEmp = numOfEmp;
	}
	
	public int getIdShift() {
		return idShift;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}

	public void setIdShift(int idShift) {
		this.idShift = idShift;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Time getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(String timeStr) throws ParseException {
		Time timeStart = new Time(df.parse(timeStr).getTime());
		this.timeStart = timeStart;
	}

	public Time getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(String timeStr) throws ParseException {
		Time timeEnd = new Time(df.parse(timeStr).getTime());
		this.timeEnd = timeEnd;
	}

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}
	
	public Boolean checkValidateTime() {
		return this.timeStart.compareTo(timeEnd) < 0;
	}
	
	@Override
	public String toString() {
		return this.name + " " + this.salary + " " + this.timeStart;
	}
}
