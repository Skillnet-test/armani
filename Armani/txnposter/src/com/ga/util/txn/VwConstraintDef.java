package com.ga.util.txn;

public class VwConstraintDef {
	String consType;
	String consName;
	String mainTable;
	String refTable;
	String table1;
	String col1;
	public String getCol1() {
		return col1;
	}
	public void setCol1(String col1) {
		this.col1 = col1;
	}
	public String getConsName() {
		return consName;
	}
	public void setConsName(String consName) {
		this.consName = consName;
	}
	public String getConsType() {
		return consType;
	}
	public void setConsType(String consType) {
		this.consType = consType;
	}
	public String getMainTable() {
		return mainTable;
	}
	public void setMainTable(String mainTable) {
		this.mainTable = mainTable;
	}
	public String getRefTable() {
		return refTable;
	}
	public void setRefTable(String refTable) {
		this.refTable = refTable;
	}
	public String getTable1() {
		return table1;
	}
	public void setTable1(String table1) {
		this.table1 = table1;
	}
}
