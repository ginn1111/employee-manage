package ptithcm.bean;

import java.util.List;

public class RegisterTimeTable {
	private String idEmployee;
	private List<DateShift> dateShifts;
	public String getIdEmployee() {
		return idEmployee;
	}
	public void setIdEmployee(String idEmployee) {
		this.idEmployee = idEmployee;
	}
	public List<DateShift> getDateShifts() {
		return dateShifts;
	}
	public void setDataShifts(List<DateShift> dateShifts) {
		this.dateShifts = dateShifts;
	}
	public RegisterTimeTable(String idEmployee, List<DateShift> dateShifts) {
		super();
		this.idEmployee = idEmployee;
		this.dateShifts = dateShifts;
	}
	public RegisterTimeTable() {}
}
