package ptithcm.bean;

import java.util.List;

public class ListEmpDelete {
	private List<String> list;

	public ListEmpDelete(List<String> list) {
		super();
		this.list = list;
	}
	
	public ListEmpDelete() {}

	public List<String> getList() {
		return list;
	}

	public void setList(List<String> list) {
		this.list = list;
	}
	
}
