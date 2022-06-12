package ptithcm.entity.tmp;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.*;

import ptithcm.entity.Shift;

@NamedNativeQueries(@NamedNativeQuery(name = "getTimeTableOfEmp", query = "exec sp_get_time_table_of_emp :id_emp, :is_all", resultClass = JobOfShift.class))

@Entity
public class JobOfShift {
	@Id
	@GeneratedValue
	@Column(name = "id_status_shift")
	private String idStatusShift;
	
	@ManyToOne
	@JoinColumn(name="id_shift")
	private Shift shift;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "date")
	private Date date;
	
	@Column(name = "job")
	private String job;

	public String getIdStatusShift() {
		return idStatusShift;
	}

	public void setIdStatusShift(String idStatusShift) {
		this.idStatusShift = idStatusShift;
	}

	public Shift getShift() {
		return shift;
	}

	public void setShift(Shift shift) {
		this.shift = shift;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public JobOfShift(String idStatusShift, Date date, String job) {
		super();
		this.idStatusShift = idStatusShift;
		this.date = date;
		this.job = job;
	}

	public JobOfShift() {
		super();
	}

	public JobOfShift(JobOfShift jobOfShift) {
		this.date = jobOfShift.getDate();
		this.shift = jobOfShift.getShift();
		this.job = jobOfShift.getJob();
		this.idStatusShift = jobOfShift.getIdStatusShift();
	}
	@Override
	public String toString() {
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		return this.shift.getIdShift() + " " + df.format(date) + " " + job;
	}
}
