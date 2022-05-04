package ptithcm.bean;

import java.util.List;

public class ListTaskDelete {
	private List<Integer> list;

	public ListTaskDelete(List<Integer> list) {
		super();
		this.list = list;
	}

	public ListTaskDelete() {
		super();
	}

	public List<Integer> getList() {
		return list;
	}

	public void setList(List<Integer> list) {
		this.list = list;
	}
}
