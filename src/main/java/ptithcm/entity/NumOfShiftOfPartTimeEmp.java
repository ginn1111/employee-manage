package ptithcm.entity;

import javax.persistence.*;
@NamedNativeQueries(
		@NamedNativeQuery(name="getNumOfShiftOfPartTimeEmp", query="exec sp_get_num_of_shift_of_all_emp_part_time", resultClass = NumOfShiftOfPartTimeEmp.class))

@Entity
public class NumOfShiftOfPartTimeEmp {
	@Id
	@Column(name="id_emp")
	private String idEmp;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	@Column(name="num_of_shift")
	private Integer numOfShift;

	public String getIdEmp() {
		return idEmp;
	}

	public void setIdEmp(String idEmp) {
		this.idEmp = idEmp;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Integer getNumOfShift() {
		return numOfShift;
	}

	public void setNumOfShift(Integer numOfShift) {
		this.numOfShift = numOfShift;
	}

	public NumOfShiftOfPartTimeEmp(String idEmp, String firstName, String lastName, Integer numOfShift) {
		super();
		this.idEmp = idEmp;
		this.firstName = firstName;
		this.lastName = lastName;
		this.numOfShift = numOfShift;
	}
	
	public NumOfShiftOfPartTimeEmp() {}
	
	@Override
	public String toString() {
		return this.firstName + " " + this.lastName + " " + this.numOfShift;
	}
}
