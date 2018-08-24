package com.ga.util.stresstest.customer;


import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.OptionalDataException;
import java.rmi.RemoteException;
import java.sql.SQLException;
import java.util.StringTokenizer;
import java.util.Vector;

import com.chelseasystems.cr.appmgr.ClientServices;
import com.chelseasystems.cr.appmgr.IBrowserManager;
import com.chelseasystems.cr.config.ConfigMgr;
import com.chelseasystems.cs.customer.CMSCustomer;
import com.chelseasystems.cs.customer.CMSCustomerHelper;
import com.chelseasystems.cs.pos.CMSTransactionPosterRMIClient;
import com.ga.util.txn.SimpleBrowserManager;

/**
 * <p>Title: </p>
 *		Class to run stress test for customer posting.
 *
 * @author Tim
 * @version 1.0
 */
public class CustomerStressTestUtil {
  private CMSCustomer cust;
  private CMSCustomer baseCust = null;
  public static IBrowserManager theMgr;
  
  private ConfigMgr custConfig = new ConfigMgr("stresstest.cfg");
  private String baseCustId = custConfig.getString("STRESSTEST.CUSTOMER.BASEID");
  private int count = custConfig.getInt("STRESSTEST.CUSTOMER.COUNT");

  public CustomerStressTestUtil(String txnResource) throws IOException,
  							ClassNotFoundException,
  							OptionalDataException {
    ObjectInputStream oin = new ObjectInputStream(new FileInputStream(txnResource));
    baseCust = (CMSCustomer) oin.readObject();
  }

  public void init() throws SQLException {
    theMgr = new SimpleBrowserManager();
    startClientServices(theMgr);
  }

  public void start() {
    try {
      System.out.println("Cust POST Starting .................  ");
      for(int i = 0; i<count; i++){
    	  cust = (CMSCustomer)baseCust.clone();
    	  cust.setFirstName(cust.getFirstName() +  "_" + (baseCustId  + i));
    	  cust.setLastName(cust.getLastName() +  "_" + (baseCustId  + i));
    	  cust.setNew();
    	  CMSCustomer resultCust =  CMSCustomerHelper.submit(theMgr, cust);
    	  System.out.println("Saved cust : "+ resultCust);
    	  try{
    		  Thread.sleep(2000);
    	  }catch (Exception e) {
    		  System.out.println("Sleep interrupted");
		}
      }
    } catch (RemoteException ex) {
      handleRemoteException(ex);
    } catch (Throwable ex) {
      handleThrowable(ex);
    }
    System.exit(0);
  }

  public void startClientServices(IBrowserManager theMgr)
  {
          String services[] = getClientServices();
          if(services == null) {
                  System.out.println("The files needed to start this mode are not configured properly." +
                  		" See setup guide.");
                  return;
          }
          String sConfigFile = System.getProperty("USER_CONFIG");
          ConfigMgr mgr = new ConfigMgr(sConfigFile);
          for(int x = 0; x < services.length; x++){
              try {
                      Object obj = mgr.getObject(services[x]);
                      ClientServices client = (ClientServices)obj;
                      client.setDownTimeMgr(theMgr);
                      client.setBrowserMgr(theMgr);
                      theMgr.addGlobalObject(services[x], obj);
                      client.init(true);
              } catch(Exception ex) {
                      System.out.println("ERROR start()->" + ex);
                      ex.printStackTrace();
              }
          }
          return;
  }

  private String[] getClientServices() {
          Vector vServices = new Vector();
          try {
                  String sConfigFile = System.getProperty("USER_CONFIG");
                  ConfigMgr mgr = new ConfigMgr(sConfigFile);
                  String list = mgr.getString("SERVICES_LIST");
                  String sClass;
                  for(StringTokenizer tokenizer = new StringTokenizer(list, ","); tokenizer.hasMoreElements(); vServices.addElement(sClass))
                          sClass = (String)tokenizer.nextElement();

                  String sResult[] = new String[vServices.size()];
                  vServices.copyInto(sResult);
                  return sResult;
          } catch(Exception ex) {
                  System.out.println("ERROR getClientServices()->" + ex);
                  ex.printStackTrace();
          }
          return null;
  }

  /**
   * @param ex
   */
  private void handleThrowable(Throwable ex) {
  	System.out.println("################################################################################");
        System.out.println("ERROR: "+ex.getMessage());
        System.out.println("################################################################################");
        ex.printStackTrace();
  }

  /**
   * @param ex
   */
  private void handleRemoteException(RemoteException ex) {
  	//System.out.println("################################################################################");
        Throwable rootException = ex;
        if (ex.detail != null) {
          if(ex.detail instanceof RemoteException && ((RemoteException)ex.detail).detail != null) {
            rootException = ((RemoteException)ex.detail).detail;
          } else {
            rootException = ex.detail;
          }
        }
        System.out.println("Exception class = "+rootException.getClass().getName());
        if (rootException instanceof SQLException) {
        	System.out.println("################################################################################");
            System.out.println("SQL EXCEPTION: ");
            ex.printStackTrace();
            System.out.println("################################################################################");
        }
        else {
          System.out.println("################################################################################");
          System.out.println("NON-STANDARD EXCEPTION: ");
          ex.printStackTrace();
          System.out.println("################################################################################");
        }
  }
  
  	
   public static void main(String[] args) {
		try {
			CustomerStressTestUtil custUtil = new CustomerStressTestUtil(args[0]);

			try {
				custUtil.init();
			} catch (SQLException ex1) {
				ex1.printStackTrace();
			}
			custUtil.start();
		} catch (FileNotFoundException ex) {
			//System.out.println("ERROR: Could not find file : "+args[0]);
			ex.printStackTrace();
		} catch (OptionalDataException ex) {
			ex.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		} catch (ClassNotFoundException ex) {
			ex.printStackTrace();
		} catch (ClassCastException ex) {
			ex.printStackTrace();
		}
	}

}
