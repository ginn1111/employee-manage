package ptithcm.entity.tmp;

import java.util.Date;

import javax.persistence.*;

@NamedNativeQueries(
		@NamedNativeQuery(
				name = "getEvaluation"
				, query = "exec sp_get_evaluation :id_emp, :is_all"
				, resultClass = EvaluateTmp.class
				)
		)

@Entity
public class EvaluateTmp {
	@Id
	@Column(name = "id")
	private String id;

	@Column(name = "id_shift")
	private int idShift;

	@Temporal(TemporalType.DATE)
	@Column(name = "date")
	private Date date;

	@Column(name = "description")
	private String description;

	@Column(name="num")
	private Integer num;
	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public EvaluateTmp(String id, int idShift, Date date, String description) {
		super();
		this.id = id;
		this.idShift = idShift;
		this.date = date;
		this.description = description;
	}
	
	public EvaluateTmp(EvaluateTmp evaluate) {
		this.id = evaluate.getId();
		this.idShift = evaluate.getIdShift();
		this.date = evaluate.getDate();
		this.description = evaluate.getDescription();
		this.num = evaluate.getNum();
	}

	public EvaluateTmp() {
		super();
	}
	@Override
	public String toString() {
		return this.idShift + " " + this.date + " " + this.description + " " + (this.num != null? this.num : 1);
	}
}
