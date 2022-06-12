package ptithcm.entity.tmp;

import java.util.Calendar;
import java.util.Date;

import javax.persistence.*;

@NamedNativeQueries(@NamedNativeQuery(name = "getStartYear", query = "select * from v_get_year_start", resultClass = Year.class))

@Entity
public class Year {
	@Id
	@Column(name = "year_start")
	private Integer year;

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Year(Integer year) {
		super();
		this.year = year;
	}

	public Year() {
	}
	public static Integer getYearNow() {
		Date dateNow = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateNow);
		return cal.get(Calendar.YEAR);
	}
	
}
