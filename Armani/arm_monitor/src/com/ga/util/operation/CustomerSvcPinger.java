package com.ga.util.operation;

import java.util.StringTokenizer;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.chelseasystems.cr.appmgr.ClientServices;
import com.chelseasystems.cr.appmgr.IBrowserManager;
import com.chelseasystems.cr.config.ConfigMgr;
import com.chelseasystems.cs.customer.CMSCustomer;
import com.chelseasystems.cs.customer.CMSCustomerHelper;
import com.ga.util.appmgr.SimpleBrowserManager;
import com.ga.util.monitor.IMonitor;

/**
 * Class to ping the customer service and retrieve a customer. This is basically to verify 
 * if the appserver is up and running and if an end-to-end connection exists b/w monitor-appserver-DB. 
 *
 * @author Tim
 * @version 1.0
 */
public class CustomerSvcPinger implements IMonitor {

	private static IBrowserManager theMgr;

	static Logger logger = Logger.getLogger("com.ga.util.operation.CustomerSvcPinger");

	public CustomerSvcPinger() {

	}

	private void init() {
		theMgr = new SimpleBrowserManager();
		startClientServices(theMgr);
	}

	private void startClientServices(IBrowserManager theMgr) {
		String services[] = getClientServices();
		if (services == null) {
			logger.info("The files needed to begin this mode are not configured properly." + " See setup guide.");
			return;
		}
		String sConfigFile = System.getProperty("USER_CONFIG");
		ConfigMgr mgr = new ConfigMgr(sConfigFile);
		for (int x = 0; x < services.length; x++) {
			try {
				logger.info("*** Starting ClientService: " + services[x]);
				Object obj = mgr.getObject(services[x]);
				ClientServices client = (ClientServices) obj;
				client.setDownTimeMgr(theMgr);
				client.setBrowserMgr(theMgr);
				theMgr.addGlobalObject(services[x], obj);
				client.init(true);
			} catch (Exception ex) {
				logger.error("ERROR start()->" + ex);
				ex.printStackTrace();
			}
		}

		return;
	}

	private String[] getClientServices() {
		Vector<String> vServices = new Vector<String>();
		try {
			String sConfigFile = System.getProperty("USER_CONFIG");
			ConfigMgr mgr = new ConfigMgr(sConfigFile);
			String list = mgr.getString("SERVICES_LIST");
			String sClass;
			for (StringTokenizer tokenizer = new StringTokenizer(list, ","); 
				tokenizer.hasMoreElements(); vServices.addElement(sClass)) {
				sClass = (String) tokenizer.nextElement();
			}

			String sResult[] = new String[vServices.size()];
			vServices.copyInto(sResult);
			return sResult;
		} catch (Exception ex) {
			logger.error("ERROR getClientServices()->" + ex);
			ex.printStackTrace();
		}
		return null;
	}

	public int runTest(int errCode) {
		return runTest(errCode, new String[] { "1234" });
	}

	public int runTest(int errCode, String[] params) {

		init();
		String custId = "1234";
		//		System.out.println(" Customer = " + params[0]);
		if (params.length > 0) {
			custId = params[0];
		}

		try {
			CMSCustomer customer = CMSCustomerHelper.findById(theMgr, custId);
			if (customer != null) {
				logger.info("Cust: " + customer.getFirstName() + " " + customer.getLastName() + " id = "
						+ customer.getAccountNum() + " " + customer.toString());
				logger.info("Customer service is running fine...");
				return 0;
			}
		} catch (Exception e) {
			logger.error(" Unable to retrieve customer from CUSTOMER_SRVC");
			logger.debug(e.getMessage(), e);
			return errCode;
		}

		return 0;
	}

}
