package ptithcm.bean;

import java.util.ArrayList;
import java.util.List;

public class DateShiftArray {
	private List<ArrayList<ArrayList<DateShift>>> array;
	
	public DateShiftArray(List<ArrayList<ArrayList<DateShift>>> array) {
		this.array = array;
	}
	
	public DateShiftArray() {}

	public List<ArrayList<ArrayList<DateShift>>> getArray() {
		return array;
	}

	public void setArray(List<ArrayList<ArrayList<DateShift>>> array) {
		this.array = array;
	}
}
