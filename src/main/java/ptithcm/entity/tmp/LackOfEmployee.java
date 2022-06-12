package ptithcm.entity.tmp;

import java.util.Date;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

@NamedNativeQuery(name = "getLackOfEmp", query = "exec sp_get_lack_of_emp :date", resultClass = LackOfEmployee.class)

@Entity
public class LackOfEmployee {
	@Id
	@Column(name = "id_lack_of_emp")
	private String idLackOfEmp;

	@Column(name="name")
	private String nameOfShift;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "date")
	private Date date;

	@Column(name = "amount")
	private Integer amount;

	public LackOfEmployee() {
		super();
	}

	public LackOfEmployee(String idLackOfEmp, String nameOfShift, Date date, Integer amount) {
		super();
		this.idLackOfEmp = idLackOfEmp;
		this.nameOfShift = nameOfShift;
		this.date = date;
		this.amount = amount;
	}

	public String getIdLackOfEmp() {
		return idLackOfEmp;
	}

	public void setIdLackOfEmp(String idLackOfEmp) {
		this.idLackOfEmp = idLackOfEmp;
	}

	public String getNameOfShift() {
		return nameOfShift;
	}

	public void setNameOfShift(String nameOfShift) {
		this.nameOfShift = nameOfShift;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}
}
