package ptithcm.entity.tmp;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;
@NamedNativeQueries({
	@NamedNativeQuery(
			name="getStatusTimeTable",
			query="exec sp_get_status_time_table :id_emp",
			resultClass=StatusOfShift.class
		)
})

@Entity
public class StatusOfShift {
	@Id
	@Column(name="id_status_shift")
	private String idStatusShift;
	
	@Column(name="id_shift")
	private int idShift;
	
	@Column(name="date")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date date;
	
	@Column(name = "status")
	private boolean status;
	
	public StatusOfShift() {}
	
	public int getIdShift() {
		return idShift;
	}
	public void setId_shift(int idShift) {
		this.idShift = idShift;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return idShift + " " + date + " " + status;
	}
	
}
