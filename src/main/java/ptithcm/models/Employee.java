package ptithcm.models;

import javax.persistence.*;

@Entity
@Table(name="Employee")
public class Employee {
	@Id
	@Column(name="id_emp")
	private String idEmp;
	@Column(name="first_name")
	private String firstName;
	@Column(name="last_name")
	private String lastName;
	@Column(name="is_leave")
	private Boolean isLeave;
	@Column(name="id_role")
	private int idRole;
	@Column(name="phone")
	private String phone;
	
	public Employee() {}

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

	public Boolean getIsLeave() {
		return isLeave;
	}

	public void setIsLeave(Boolean isLeave) {
		this.isLeave = isLeave;
	}

	public int getIdRole() {
		return idRole;
	}

	public void setIdRole(int idRole) {
		this.idRole = idRole;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
}
