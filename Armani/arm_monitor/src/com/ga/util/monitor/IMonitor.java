package com.ga.util.monitor;

/**
 * All monitoring tests should implement this interface so that 
 * the tests can be added dynamically from config file.
 * 
 * @author Tim
 */
public interface IMonitor {
	
	/**
	 * Run the test and return the specified error code if there is an error.
	 * @param errCode
	 * @return 0 - if successful, else errCode
	 */
	public int runTest(int errCode);
	
	/**
	 * Run the test with the params and return the specified error code if there is an error.
	 * @param errCode
	 * @param params
	 * @return
	 */
	public int runTest(int errCode, String[] params);
}
