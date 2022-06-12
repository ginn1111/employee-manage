package ptithcm.bean;


import ptithcm.entity.tmp.Year;

public class MonthYear {
	private Month month;
	private Year year;
	
	public MonthYear(Month month, Year year) {
		super();
		this.month = month;
		this.year = year;
	}
	public MonthYear() {
		super();
		int monthNow = Month.getMonthNow();
		this.month = new Month(Month.getNameOfMonths().get(monthNow), monthNow);
		this.year = new Year(Year.getYearNow());
	}
	public Month getMonth() {
		return month;
	}
	public void setMonth(Month month) {
		this.month = month;
	}
	public Year getYear() {
		return year;
	}
	public void setYear(Year year) {
		this.year = year;
	}
	
	
}
