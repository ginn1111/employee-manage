package ptithcm.entity.tmp;

import javax.persistence.*;

import ptithcm.entity.Employee;

@NamedNativeQuery(
		name = "getEmpCooperateWithLeader",
		query = "exec sp_get_emp_cooperate_with_leader :id_shift, :date, :id_leader, :id_up_task", 
		resultClass = EmpCooperateWithLeader.class
)

@Entity
public class EmpCooperateWithLeader {
	@Id
	@Column(name="id_time_table")
	private int idTimeTable;
	
	@ManyToOne
	@JoinColumn(name="id_emp")
	private Employee employee;

	public EmpCooperateWithLeader() {}
	
	public EmpCooperateWithLeader(int idTimeTable, Employee employee) {
		super();
		this.idTimeTable = idTimeTable;
		this.employee = employee;
	}

	public int getIdTimeTable() {
		return idTimeTable;
	}

	public void setIdTimeTable(int idTimeTable) {
		this.idTimeTable = idTimeTable;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
}
