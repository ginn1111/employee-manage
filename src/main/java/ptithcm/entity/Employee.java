package ptithcm.entity;

import java.util.Collection;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

import ptithcm.utils.MyUtils;

@Entity
@Table(name = "Employee")
public class Employee {
	@Id
	@Column(name = "id_emp")
	private String idEmployee;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	@Column(name = "active")
	private Boolean active;

	@Column(name = "phone")
	private String phone;

	@ManyToOne
	@JoinColumn(name = "id_position")
	private Position position;

	@Column(name = "address")
	private String address;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "birthday")
	private Date birthday;

	@OneToMany(mappedBy = "employee", fetch = FetchType.EAGER)
	private Collection<TimeTable> timeTables;
	
	@OneToOne
	@JoinColumn(name="id_emp")
	private Account account;

	public Employee(String idEmployee, String firstName, String lastName, Boolean active, String phone) {
		super();
		this.idEmployee = idEmployee;
		this.firstName = firstName;
		this.lastName = lastName;
		this.active = active;
		this.phone = phone;
	}

	public Employee(String idEmployee, String lastName) {
		super();
		this.idEmployee = idEmployee;
		this.lastName = lastName;
	}

	public Employee(String idEmployee) {
		super();
		this.idEmployee = idEmployee;
	}

	public Employee() {
		super();
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public Collection<TimeTable> getTimeTables() {
		return timeTables;
	}

	public void setTimeTables(Collection<TimeTable> timeTables) {
		this.timeTables = timeTables;
	}

	public String getIdEmployee() {
		return idEmployee;
	}

	public void setIdEmployee(String idEmployee) {
		this.idEmployee = idEmployee;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Position getPosition() {
		return position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}

	public String getNameAndPosition() {
		return this.lastName + (this.position != null ? " - " + this.position.getPositionName() : "");
	}

	public String getFullName() {
		return this.firstName + " " + this.lastName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public void setAttribute() {
		if (this.phone.isBlank()) {
			phone = null;
		}
		if (this.address.isBlank()) {
			address = null;
		}
		this.firstName = MyUtils.formatString(this.firstName);
		this.lastName = MyUtils.formatString(this.lastName);
	}

	public void setAccountForEmp() {
		this.account.setUsername(this.idEmployee);
		this.account.setPassword(MyUtils.passwordEncoder.encode(Account.DEFAULT_PASSWORD));
		this.account.setEnable(true);
	}
	
	public Boolean validatePhone() {
		if (phone == null)
			return true;
		phone = phone.trim();
		String phoneTmp = "";
		for (int i = 0; i < phone.length(); i++) {
			if (phone.charAt(i) == ' ')
				continue;
			phoneTmp += phone.charAt(i);
		}
		phone = phoneTmp;
		Pattern pattern = Pattern.compile("^([0]\\d{2}[- .]?)\\d{3}[- .]?\\d{4}$");
		Matcher matcher = pattern.matcher(this.phone);
		return matcher.matches();
	}
}
