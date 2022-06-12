package ptithcm.bean;

import java.util.Date;

public class DateShiftForUpTask {
	private Date date;
	private Integer shift;
	
	public DateShiftForUpTask(Date date, Integer shift) {
		super();
		this.date = date;
		this.shift = shift;
	}

	public DateShiftForUpTask() {
		super();
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getShift() {
		return shift;
	}

	public void setShift(Integer shift) {
		this.shift = shift;
	}
}
