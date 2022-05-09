package ptithcm.bean;

public class Gender {
	private Integer value;
	private String label;
	
	public Gender(Integer value, String label) {
		super();
		this.value = value;
		this.label = label;
	}
	
	public Gender() {}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}
}
