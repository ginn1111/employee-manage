package ptithcm.bean;

import java.util.ArrayList;
import java.util.List;

public class ListChangeEmp {
	private List<ChangeEmp> listChangeEmp;

	public List<ChangeEmp> getListChangeEmp() {
		return listChangeEmp;
	}

	public void setListChangeEmp(List<ChangeEmp> listChangeEmp) {
		this.listChangeEmp = listChangeEmp;
	}
	
	public ListChangeEmp(List<ChangeEmp> listChangeEmp) {
		this.listChangeEmp = listChangeEmp;
	}
	
	public ListChangeEmp() {
		listChangeEmp = new ArrayList<ChangeEmp>();
	}
}
