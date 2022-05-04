package ptithcm.entity;

import java.util.Collection;

import javax.persistence.*;

@Entity
@Table(name="Task")
public class Task {
	@Id
	@GeneratedValue
	@Column(name="id_task")
	private int idTask;
	
	@Column(name="job")
	private String job;
	
	@Column(name="description")
	private String description;
	
	@Column(name="id_manager")
	private String idManager;
	
	@Column(name="deleted")
	private Boolean deleted;
	
	@OneToMany(mappedBy = "task", fetch = FetchType.EAGER)
	private Collection<UpTasks> upTasks;
	
	public Task() {
		super();
	}

	public Task(int idTask, String job, String description, String idManager) {
		super();
		this.idTask = idTask;
		this.job = job;
		this.description = description;
		this.idManager = idManager;
	}

	public Collection<UpTasks> getUpTasks() {
		return upTasks;
	}

	public void setUpTasks(Collection<UpTasks> upTasks) {
		this.upTasks = upTasks;
	}

	public int getIdTask() {
		return idTask;
	}

	public void setIdTask(int idTask) {
		this.idTask = idTask;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIdManager() {
		return idManager;
	}

	public void setIdManager(String idManager) {
		this.idManager = idManager;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}
}
