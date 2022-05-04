package ptithcm.entity;

import javax.persistence.*;

@Entity
@Table(name="Account")
public class Account {
	@Id
	@Column(name="id")
	private String username;
	
	@Column(name="password")
	private String password;
	
	@Column(name="enable")
	private Boolean enable;
	
	@ManyToOne
	@JoinColumn(name="id_role")
	private Role role;

	public final static String DEFAULT_PASSWORD = "123";
	
	public Account() {
		super();
	}

	public Account(String username, String password, Boolean enable, Role role) {
		super();
		this.username = username;
		this.password = password;
		this.enable = enable;
		this.role = role;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnable() {
		return enable;
	}

	public void setEnable(Boolean enable) {
		this.enable = enable;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}
}
