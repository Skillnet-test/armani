/**
 * 
 */
package com.ga.util.operation;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

import org.apache.log4j.Logger;

import com.chelseasystems.cr.config.ConfigMgr;
import com.ga.util.monitor.IMonitor;

/**
 * @author Tim
 *
 */
public class DBServerPinger implements IMonitor {

	static Logger logger = Logger.getLogger("com.ga.util.operation.DBServerPinger");
	
	/* (non-Javadoc)
	 * @see com.ga.util.monitor.IMonitor#runTest(int)
	 */
	public int runTest(int errCode) {		
		return runTest(errCode, null);
	}

	/* (non-Javadoc)
	 * @see com.ga.util.monitor.IMonitor#runTest(int, java.lang.String[])
	 */
	public int runTest(int errCode, String[] params) {
		ConfigMgr nwCfg = new ConfigMgr("jdbc.cfg");
		String dbServerHostAddr = nwCfg.getString("DB_IP");
		if(dbServerHostAddr == null){
			return errCode;
		}

		try {
			InetAddress address = InetAddress.getByName(dbServerHostAddr);
			if(address.isReachable(2000)){
				logger.info(" DB Host : " + address.getHostAddress() + " is reachable");
				return 0;
			} else {
				return errCode;
			}
		}catch (UnknownHostException e) {
			e.printStackTrace();
			logger.debug(e.getMessage(),e);
			return errCode;
		} catch(IOException e){
			e.printStackTrace();
			logger.debug(e.getMessage(),e);
			return errCode;
		} catch(Exception e){
			e.printStackTrace();
			logger.debug(e.getMessage(),e);
			return errCode;
		}

	}

}
