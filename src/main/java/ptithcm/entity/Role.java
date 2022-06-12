package ptithcm.entity;

import javax.persistence.*;

@Entity
@Table(name="Role")
public class Role {
	@Id
	@GeneratedValue
	@Column(name="id_role")
	private int idRole;
	
	@Column(name="role_name")
	private String roleName;
	
//	@OneToMany(mappedBy = "role", fetch = FetchType.EAGER)
//	private List<Account> account;

	public int getIdRole() {
		return idRole;
	}

	public void setIdRole(int idRole) {
		this.idRole = idRole;
	}

	public Role() {
		super();
	}

	public Role(int idRole, String roleName) {
		super();
		this.idRole = idRole;
		this.roleName = roleName;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

//	public List<Account> getAccount() {
//		return account;
//	}
//
//	public void setAccount(List<Account> account) {
//		this.account = account;
//	}
}
