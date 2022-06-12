package ptithcm.bean;

import java.beans.JavaBean;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@JavaBean
public class DateForNewTimeTable {
	private Date date;
	private String label;
	private final static DateFormat df = new SimpleDateFormat("dd-MM-yyyy");

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public DateForNewTimeTable() {}
	
	public DateForNewTimeTable(Date date) {
		this.date = date;
		this.label = df.format(date);
	}
}
