package ptithcm.bean;

public class EvaluationEmp {
	private int idTimeTable;
	private Integer idFault;
	private int num;
	
	public EvaluationEmp() {
		super();
	}
	public EvaluationEmp(int idTimeTable, Integer idFault, int num) {
		super();
		this.idTimeTable = idTimeTable;
		this.idFault = idFault;
		this.num = num;
	}
	public int getIdTimeTable() {
		return idTimeTable;
	}
	public void setIdTimeTable(int idTimeTable) {
		this.idTimeTable = idTimeTable;
	}
		public Integer getIdFault() {
		return idFault;
	}
	public void setIdFault(Integer idFault) {
		this.idFault = idFault;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
}
