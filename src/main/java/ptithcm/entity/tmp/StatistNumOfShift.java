package ptithcm.entity.tmp;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

@NamedNativeQuery(name="statistNumOfShift", query="sp_statist_num_of_shift :month, :year", resultClass = StatistNumOfShift.class)

@Entity
public class StatistNumOfShift {
	@Id
	@Column(name="id_statist_num_of_shift")
	private String id;
	
	@Column(name="id_emp")
	private String idEmployee;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	@Column(name="num_of_shift")
	private Integer numOfShift;
	
	@Column(name="name")
	private String nameOfShift;

	public StatistNumOfShift() {}
	
	public StatistNumOfShift(String id, String idEmployee, String firstName, String lastName, Integer numOfShift,
			String nameOfShift) {
		super();
		this.id = id;
		this.idEmployee = idEmployee;
		this.firstName = firstName;
		this.lastName = lastName;
		this.numOfShift = numOfShift;
		this.nameOfShift = nameOfShift;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIdEmployee() {
		return idEmployee;
	}

	public void setIdEmployee(String idEmployee) {
		this.idEmployee = idEmployee;
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

	public String getNameOfShift() {
		return nameOfShift;
	}

	public void setNameOfShift(String nameOfShift) {
		this.nameOfShift = nameOfShift;
	}
	
	@Override
	public String toString() {
		return this.idEmployee + " " + this.lastName + " " + this.numOfShift + " " + this.numOfShift;
	}
	
}
