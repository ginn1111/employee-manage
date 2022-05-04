package ptithcm.entity;

import java.util.Collection;

import javax.persistence.*;

@Entity
@Table(name="Fault")
public class Fault {
	@Id
	@GeneratedValue
	@Column(name="id_fault")
	private Integer idFault;
	
	@Column(name="description")
	private String description;
	
	@Column(name="percent_of_salary")
	private Double percentOfSalary;
	
	@Column(name="deleted")
	private Boolean deleted;

	@OneToMany(mappedBy = "fault", fetch = FetchType.EAGER)
	private Collection<Evaluate> evaluates; 
	
	
//	@OneToMany(mappedBy = "fault", fetch = FetchType.EAGER)
//	private Collection<Evaluate> evaluates;

	public Fault(Integer idFault, String description, Double percentOfSalary) {
		super();
		this.idFault = idFault;
		this.description = description;
		this.percentOfSalary = percentOfSalary;
	}
	
	public Fault(Integer idFault, String description) {
		this.idFault = idFault;
		this.description = description;
	}

	public Fault() {
		super();
	}
	
	public Collection<Evaluate> getEvaluates() {
		return evaluates;
	}

	public void setEvaluates(Collection<Evaluate> evaluates) {
		this.evaluates = evaluates;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}

	public Fault(Integer idFault) {
		super();
		this.idFault = idFault;
	}

	public Integer getIdFault() {
		return idFault;
	}

	public void setIdFault(Integer idFault) {
		this.idFault = idFault;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getPercentOfSalary() {
		return percentOfSalary;
	}

	public void setPercentOfSalary(Double percentOfSalary) {
		this.percentOfSalary = percentOfSalary;
	}

//	public Collection<Evaluate> getEvaluates() {
//		return evaluates;
//	}
//
//	public void setEvaluates(Collection<Evaluate> evaluates) {
//		this.evaluates = evaluates;
//	}

}
