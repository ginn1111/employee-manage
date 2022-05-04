package ptithcm.bean;

public class ChangeEmp {
	private int id;
	private String idEmp;
	private String idEmpAlter;
	
	public ChangeEmp(int id, String idEmp, String idEmpAlter) {
		super();
		this.setIdEmpAlter(idEmpAlter);
		this.id = id;
		this.idEmp = idEmp;
	}
	
	public ChangeEmp() {}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getIdEmp() {
		return idEmp;
	}
	public void setIdEmp(String idEmp) {
		this.idEmp = idEmp;
	}

	public String getIdEmpAlter() {
		return idEmpAlter;
	}

	public void setIdEmpAlter(String idEmpAlter) {
		this.idEmpAlter = idEmpAlter;
	}
}
