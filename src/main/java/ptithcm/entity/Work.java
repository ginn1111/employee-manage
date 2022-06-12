package ptithcm.entity;

import javax.persistence.*;

@Entity
@Table(name="Work")
public class Work {
	@Id
	@GeneratedValue
	@Column(name="id_work")
	private int idWork;
	
	@ManyToOne
	@JoinColumn(name="id_time_table")
	private TimeTable timeTable;
	
	public TimeTable getTimeTable() {
		return timeTable;
	}

	public void setTimeTable(TimeTable timeTable) {
		this.timeTable = timeTable;
	}

	@ManyToOne
	@JoinColumn(name="id_up_task")
	private UpTasks upTasks;
	
	public Work() {
		super();
	}

	public Work(Integer idWork) {
		this.idWork = idWork;
	}
	
	public int getIdWork() {
		return idWork;
	}

	public void setIdWork(int idWork) {
		this.idWork = idWork;
	}

	public UpTasks getUpTasks() {
		return upTasks;
	}

	public void setUpTasks(UpTasks upTasks) {
		this.upTasks = upTasks;
	}
}
