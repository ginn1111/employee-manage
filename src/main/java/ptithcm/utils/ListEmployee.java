package ptithcm.utils;

import java.util.ArrayList;
import java.util.List;

import ptithcm.entity.Employee;

public class ListEmployee {
	private static List<Employee> instance;
	public static List<Employee> getInstance() {
		if(instance == null) {
			instance = new ArrayList<Employee>();
		}
		return instance;
	}
}
