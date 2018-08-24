/**
 * 
 */
package com.ga.util.monitor;

/**
 * @author Tim
 *
 */
public class MonitorOperation {
	
	int id;
	int errCode;
	String implementor;
	String[] params;
	
	/**
	 * @return Returns the errCode.
	 */
	public int getErrCode() {
		return errCode;
	}
	/**
	 * @param errCode The errCode to set.
	 */
	public void setErrCode(int errCode) {
		this.errCode = errCode;
	}
	/**
	 * @return Returns the id.
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id The id to set.
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return Returns the implementor.
	 */
	public String getImplementor() {
		return implementor;
	}
	/**
	 * @param implementor The implementor to set.
	 */
	public void setImplementor(String implementor) {
		this.implementor = implementor;
	}
	/**
	 * @return Returns the params.
	 */
	public String[] getParams() {
		return params;
	}
	/**
	 * @param params The params to set.
	 */
	public void setParams(String[] params) {
		this.params = params;
	}
	/**
	 * @return Returns the testParams.
	 */
	public boolean hasTestParams() {
		return (params != null && params.length != 0);
	}
}
