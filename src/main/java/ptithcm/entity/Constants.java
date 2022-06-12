package ptithcm.entity;

import java.util.Date;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="Constants")
public class Constants {
	@Id
	@Column(name="date_start")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date dateStart;

	public Date getDateStart() {
		return dateStart;
	}

	public void setDateStart(Date dateStart) {
		this.dateStart = dateStart;
	}
	
	public Constants(Date dateStart) {
		super();
		this.dateStart = dateStart;
	}

	public Constants() {}
}
