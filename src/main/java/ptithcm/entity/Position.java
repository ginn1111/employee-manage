package ptithcm.entity;

import java.util.Collection;

import javax.persistence.*;

import ptithcm.utils.MyUtils;

@Entity
@Table(name="Position")
public class Position {
	@Id
	@GeneratedValue
	@Column(name="id_position")
	private Integer idPosition;
	
	@Column(name="position_name")
	private String positionName;
	
	@Column(name="coefficient")
	private Double coefficient;
	
	@Column(name="is_fulltime")
	private Boolean isFullTime;
	
	@Column(name="description")
	private String description;
	
	@Column(name="deleted")
	private Boolean deleted;
	
	@OneToMany(mappedBy = "position", fetch = FetchType.EAGER)
	private Collection<Employee> employees;

	public Position(Integer idPosition, String positionName, Double coefficient, Boolean isFullTime) {
		super();
		this.idPosition = idPosition;
		this.positionName = positionName;
		this.coefficient = coefficient;
		this.isFullTime = isFullTime;
	}
	
	public Position(Integer idPosition, String positionName) {
		super();
		this.idPosition = idPosition;
		this.positionName = positionName;
	}

	public Position() {
		super();
	}
	
	public Collection<Employee> getEmployees() {
		return employees;
	}

	public void setEmployees(Collection<Employee> employees) {
		this.employees = employees;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}

	public Integer getIdPosition() {
		return idPosition;
	}

	public void setIdPosition(Integer idPosition) {
		this.idPosition = idPosition;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public Double getCoefficient() {
		return coefficient;
	}

	public void setCoefficient(Double coefficient) {
		this.coefficient = coefficient;
	}

	public Boolean getIsFullTime() {
		return isFullTime;
	}

	public void setIsFullTime(Boolean isFullTime) {
		this.isFullTime = isFullTime;
	}
	
	public void setAttribute() {
		if(this.description.isBlank()) this.description = null;
		this.positionName = MyUtils.formatString(this.positionName);
	}

	public String getNameAndIsFullTime() {
		if(isFullTime == null) return positionName;
		return positionName + " - " + (isFullTime ? "Full-time" : "Part-time");
	}
}
