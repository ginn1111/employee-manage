package ptithcm.entity;

import javax.persistence.*;

@Entity
@Table(name="Evaluate")
public class Evaluate {
	@Id
	@GeneratedValue
	@Column(name="id_evaluate")
	private int idEvaluate;
	
	@Column(name="id_manager")
	private String idManager;
	
	@ManyToOne
	@JoinColumn(name="id_fault")
	private Fault fault;
	
	@ManyToOne
	@JoinColumn(name="id_time_table")
	private TimeTable timeTable;
	
	@Column(name="num")
	private int num;
	
	public Evaluate() {
		super();
	}

	public Evaluate(int idEvaluate, String idManager, Fault fault, TimeTable timeTable, int num) {
		super();
		this.idEvaluate = idEvaluate;
		this.idManager = idManager;
		this.fault = fault;
		this.timeTable = timeTable;
		this.num = num;
	}
	
	public Evaluate(String idManager, Fault fault, TimeTable timeTable, int num) {
		super();
		this.idManager = idManager;
		this.fault = fault;
		this.timeTable = timeTable;
		this.num = num;
	}

	public Evaluate(int idEvaluate, String idManager) {
		super();
		this.idEvaluate = idEvaluate;
		this.idManager = idManager;
	}
	
	public Evaluate(int idEvaluate) {
		super();
		this.idEvaluate = idEvaluate;
	}
	
	public Evaluate(Integer idFault, Integer num) {
		super();
		this.fault = new Fault();
		this.fault.setIdFault(idFault);
		this.num = num;
	}

	public int getIdEvaluate() {
		return idEvaluate;
	}

	public void setIdEvaluate(int idEvaluate) {
		this.idEvaluate = idEvaluate;
	}

	public TimeTable getTimeTable() {
		return timeTable;
	}

	public void setTimeTable(TimeTable timeTable) {
		this.timeTable = timeTable;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getIdManager() {
		return idManager;
	}

	public void setIdManager(String idManager) {
		this.idManager = idManager;
	}

	public Fault getFault() {
		return fault;
	}

	public void setFault(Fault fault) {
		this.fault = fault;
	}
}
