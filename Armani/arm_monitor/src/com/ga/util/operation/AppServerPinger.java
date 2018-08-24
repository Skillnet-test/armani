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
public class AppServerPinger implements IMonitor {

	static Logger logger = Logger.getLogger("com.ga.util.operation.AppServerPinger");
	
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
		ConfigMgr nwCfg = new ConfigMgr("network.cfg");
		String appServerHostAddr = nwCfg.getString("APPLICATION_NODE").split(":")[0];
		System.out.println(appServerHostAddr);
		if(appServerHostAddr == null){
			return errCode;
		}
				
		try {			
			InetAddress address = InetAddress.getByName(appServerHostAddr);
			System.out.println(address.getHostAddress());
			if(address.isReachable(2000)){
				logger.info(" AppServer Host : " + address.getHostAddress() + " is reachable");
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
