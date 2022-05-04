package ptithcm.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.*;

@Entity
@Table(name="UpTasks")
public class UpTasks {
	@Id
	@GeneratedValue
	@Column(name="id_up_task")
	private Integer idUpTask;
	
	@Column(name="id_shift")
	private Integer idShift;
	
	@Temporal(TemporalType.DATE)
	@Column(name="date")
	private Date date;
	
	@ManyToOne
	@JoinColumn(name="id_task")
	private Task task;
	
	@Column(name="id_manager")
	private String idManager;
	
	@OneToMany(mappedBy = "upTasks", fetch = FetchType.EAGER)
	private Collection<Work> works;
	
	public UpTasks() {
		super();
	}
	
	public UpTasks(Integer idUpTask) {
		super();
		this.idUpTask = idUpTask;
	}

	public UpTasks(int idUpTask, int idShift, Date date, Task task, String idManager) {
		super();
		this.idUpTask = idUpTask;
		this.idShift = idShift;
		this.date = date;
		this.task = task;
		this.idManager = idManager;
		
	}
	
	public UpTasks(int idUpTask, int idShift, Date date) {
		super();
		this.idUpTask = idUpTask;
		this.idShift = idShift;
		this.date = date;
		
	}

	public int getIdUpTask() {
		return idUpTask;
	}

	public void setIdUpTask(int idUpTask) {
		this.idUpTask = idUpTask;
	}

	public Integer getIdShift() {
		return idShift;
	}

	public void setIdShift(Integer idShift) {
		this.idShift = idShift;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Task getTask() {
		return task;
	}

	public void setTask(Task task) {
		this.task = task;
	}

	public String getIdManager() {
		return idManager;
	}

	public void setIdManager(String idManager) {
		this.idManager = idManager;
	}

	public Collection<Work> getWorks() {
		return works;
	}

	public void setWorks(Collection<Work> works) {
		this.works = works;
	}
}
