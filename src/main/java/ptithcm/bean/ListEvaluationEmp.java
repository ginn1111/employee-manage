package ptithcm.bean;

import java.util.List;

public class ListEvaluationEmp {
	List<EvaluationEmp> list;
	
	public ListEvaluationEmp(List<EvaluationEmp> list) {
		this.list = list;
	}
	
	public ListEvaluationEmp() {}

	public List<EvaluationEmp> getList() {
		return list;
	}

	public void setList(List<EvaluationEmp> list) {
		this.list = list;
	}
}
