package ptithcm.entity.tmp;

import java.util.Date;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

import ptithcm.entity.Shift;
import ptithcm.entity.UpTasks;

@NamedNativeQuery(name = "getJobForLeader", query = "exec sp_get_job_for_leader :id_leader, :is_all", resultClass = JobForLeader.class)

@Entity
public class JobForLeader {
	@Id
	@Column(name = "id_job_for_leader")
	private String id;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "date")
	private Date date;

	@ManyToOne
	@JoinColumn(name = "id_shift")
	private Shift shift;

	@Column(name = "job")
	private String job;

	@ManyToOne
	@JoinColumn(name = "id_up_task")
	private UpTasks upTasks;

	public JobForLeader() {
	}

	public JobForLeader(String id, Date date, Shift shift, String job, UpTasks upTasks) {
		super();
		this.id = id;
		this.date = date;
		this.shift = shift;
		this.job = job;
		this.upTasks = upTasks;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Shift getShift() {
		return shift;
	}

	public void setShift(Shift shift) {
		this.shift = shift;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public UpTasks getUpTasks() {
		return upTasks;
	}

	public void setUpTasks(UpTasks upTasks) {
		this.upTasks = upTasks;
	}

	@Override
	public String toString() {
		return this.shift.getName() + " " + this.date + " " + this.job;
	}
}
