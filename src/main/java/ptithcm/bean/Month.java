package ptithcm.bean;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class Month {
	private String description;
	private Integer month;
	public static Map<Integer, String> getNameOfMonths() {
		Map<Integer, String> monthKey = new HashMap<Integer, String>();
		monthKey.put(1, "January");
		monthKey.put(2, "February");
		monthKey.put(3, "March");
		monthKey.put(4, "April");
		monthKey.put(5, "May");
		monthKey.put(6, "Jun");
		monthKey.put(7, "July");
		monthKey.put(8, "August");
		monthKey.put(9, "September");
		monthKey.put(10, "October");
		monthKey.put(11, "November");
		monthKey.put(12, "December");
		return monthKey;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	public Month(String description, Integer month) {
		super();
		this.description = description;
		this.month = month;
	}
	public Month() {
		super();
	}
	public static Integer getMonthNow() {
		Date dateNow = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateNow);
		return cal.get(Calendar.MONTH) + 1;
	}
}
