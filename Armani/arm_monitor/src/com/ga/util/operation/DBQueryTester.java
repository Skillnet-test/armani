/**
 * 
 */
package com.ga.util.operation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import com.chelseasystems.cr.config.ConfigMgr;
import com.ga.util.monitor.IMonitor;

/**
 * @author Tim
 *
 */
public class DBQueryTester implements IMonitor {
	
	private final String DRIVER_NAME = "DRIVER";
	private final String URL_NAME = "URL";
	private final String USER_NAME = "USER_NAME";
	private final String USER_PASSWORD = "PASSWORD";
	
	static Logger logger = Logger.getLogger("com.ga.util.operation.DBQueryTester");
	
	/* (non-Javadoc)
	 * @see com.ga.util.monitor.IMonitor#runTest(int)
	 */
	public int runTest(int errCode) {
		final String Query = "SELECT * FROM AS_ITM WHERE ROWNUM < 5";
		return runTest(errCode, new String[]{Query});
	}

	/* (non-Javadoc)
	 * @see com.ga.util.monitor.IMonitor#runTest(int, java.lang.String[])
	 */
	public int runTest(int errCode, String[] params) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		 try {
			   conn = getConnection();
//			   System.out.println("CheckDbService   ="+conn);
			   stmt = conn.createStatement();
			   rs = stmt.executeQuery(params[0]);
			   logger.info("Executed query : " + params[0]);
			   while (rs.next()){
			  	 logger.info(rs.getString(1));
			   }
			   
			  
		 }catch (Exception e) {
				logger.error("Got exception while accessing the db for query " + params[0]);
				logger.debug(e.getMessage(),e);
				
				return errCode;

		 }finally {
				try {
					stmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					logger.debug(e.getMessage(),e);
				}
		 
	 }
			return 0;
	}
	
	private Connection getConnection() throws Exception {
		ConfigMgr cfg = new ConfigMgr("jdbc.cfg");
		String driver = cfg.getString(DRIVER_NAME);
		String url = cfg.getString(URL_NAME);
		String username = cfg.getString(USER_NAME);
		String password = cfg.getString(USER_PASSWORD);
		Class.forName(driver);
		return DriverManager.getConnection(url, username, password);
	}

}
