package ptithcm.bean;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class DateShift {
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date date;
	private int shift;
	private Boolean isCheck;
	
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getShift() {
		return shift;
	}
	public void setShift(int shift) {
		this.shift = shift;
	}
	public DateShift(Date date, int shift) {
		super();
		this.date = date;
		this.shift = shift;
	}
	
	public Boolean getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(Boolean isCheck) {
		this.isCheck = isCheck;
	}
	public DateShift() {}
	@Override
	public String toString() {
		return date + " " + shift  + " " + isCheck;
	}
}
