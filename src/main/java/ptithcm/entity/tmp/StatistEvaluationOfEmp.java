package ptithcm.entity.tmp;

import java.util.Date;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

@NamedNativeQuery(name="statistEvaluationOfEmp", query = "sp_statist_evaluation_of_emp :month, :year", resultClass = StatistEvaluationOfEmp.class)

@Entity
public class StatistEvaluationOfEmp {
	@Id
	@Column(name="id_statist_evaluation_of_emp")
	private String idStatistEvaluationOfEmp;
	
	@Column(name="id_emp")
	private String idEmployee;
	
	@Column(name="num")
	private Integer num;
	
	@Column(name="description")
	private String description;
	
	@Column(name="name")
	private String nameOfShift;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name="date")
	private Date date;

	public String getIdStatistEvaluationOfEmp() {
		return idStatistEvaluationOfEmp;
	}

	public void setIdStatistEvaluationOfEmp(String idStatistEvaluationOfEmp) {
		this.idStatistEvaluationOfEmp = idStatistEvaluationOfEmp;
	}

	public String getIdEmployee() {
		return idEmployee;
	}

	public void setIdEmployee(String idEmployee) {
		this.idEmployee = idEmployee;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getNameOfShift() {
		return nameOfShift;
	}

	public void setNameOfShift(String nameOfShift) {
		this.nameOfShift = nameOfShift;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public StatistEvaluationOfEmp(String idStatistEvaluationOfEmp, String idEmployee, Integer num, String description,
			String nameOfShift, Date date) {
		super();
		this.idStatistEvaluationOfEmp = idStatistEvaluationOfEmp;
		this.idEmployee = idEmployee;
		this.num = num;
		this.description = description;
		this.nameOfShift = nameOfShift;
		this.date = date;
	}
	
	public StatistEvaluationOfEmp() {}
	
	@Override
	public String toString() {
		return this.idEmployee + " " + this.nameOfShift + " " + this.date + " " + this.description + " " + this.num;
	}
}
