package org.np.stoman.persistence;

// Generated 17 Oct, 2010 12:55:11 PM by Hibernate Tools 3.2.2.GA

import java.util.Set;

/**
 * Materials generated by hbm2java
 */
public class Materials implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7481348609711418886L;
	private int materialId;
	private String name;
	private int sensitivity;
	private int importance;

	public Materials() {
	}

	public Materials(int materialId, String name, int sensitivity,
			int importance) {
		this.materialId = materialId;
		this.name = name;
		this.sensitivity = sensitivity;
		this.importance = importance;
	}

	public Materials(int materialId, String name, int sensitivity,
			int importance,
			Set<VendorMaterialArchives> vendorMaterialArchiveses,
			Set<VendorMaterials> vendorMaterialses) {
		this.materialId = materialId;
		this.name = name;
		this.sensitivity = sensitivity;
		this.importance = importance;

	}

	public int getMaterialId() {
		return this.materialId;
	}

	public void setMaterialId(int materialId) {
		this.materialId = materialId;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getSensitivity() {
		return this.sensitivity;
	}

	public void setSensitivity(int sensitivity) {
		this.sensitivity = sensitivity;
	}

	public int getImportance() {
		return this.importance;
	}

	public void setImportance(int importance) {
		this.importance = importance;
	}

}
