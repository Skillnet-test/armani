package com.ga.util.stresstest.txn;


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
import com.chelseasystems.cr.database.ParametricStatement;
import com.chelseasystems.cr.pos.POSLineItem;
import com.chelseasystems.cr.pos.PaymentTransaction;
import com.chelseasystems.cr.transaction.CommonTransaction;
import com.chelseasystems.cr.util.ObjectStore;
import com.chelseasystems.cs.dataaccess.CMSSQLException;
import com.chelseasystems.cs.pos.CMSCompositePOSTransaction;
import com.chelseasystems.cs.pos.CMSTransactionPosterRMIClient;
import com.chelseasystems.cs.register.CMSRegister;
import com.chelseasystems.cs.store.CMSStore;
import com.ga.util.txn.SimpleBrowserManager;
import com.ga.util.txn.TransactionUtilDAO;
import com.ga.util.txn.TransactionUtilOracleDAO;

/**
 * <p>Title: </p>
 *		Class to run stress test for txn posting.
 *
 * @author Tim
 * @version 1.0
 */
public class TransactionStressTestUtil {
  private CommonTransaction txn;
  private TransactionUtilDAO dao;
  public static IBrowserManager theMgr;
  
  ConfigMgr txnConfig = new ConfigMgr("stresstest.cfg");
  String baseTxnNum = txnConfig.getString("STRESSTEST.BASE_TXNNUM");
  int count = txnConfig.getInt("STRESSTEST.COUNT");

  public TransactionStressTestUtil(String txnResource) throws IOException,
  							ClassNotFoundException,
  							OptionalDataException {
    ObjectInputStream oin = new ObjectInputStream(new FileInputStream(txnResource));
    txn = (CommonTransaction) oin.readObject();
    dao = new TransactionUtilOracleDAO();
  }

  public CommonTransaction getTransaction() {
    return txn;
  }

  public void init() throws SQLException {
    theMgr = new SimpleBrowserManager();
    startClientServices(theMgr);
    dao.init();
  }

  public void start() {
    try {
      System.out.println("POST Initiating .................  ");
      CMSTransactionPosterRMIClient abc = new CMSTransactionPosterRMIClient();
/*      ObjectStore objStore = new ObjectStore("..\\files\\prod\\repository\\STORE");
      CMSStore store = (CMSStore)objStore.read();
      ObjectStore objRegister = new ObjectStore("..\\files\\prod\\repository\\REGISTER");
      CMSRegister register = (CMSRegister)objRegister.read();*/
      String txnNum = baseTxnNum;
      
      boolean hasReturnItems = "true".equalsIgnoreCase(txnConfig.getString("STRESSTEST.HAS_RETURN_ITEMS"));
      
      for(int i =0; i<count; i++){
    	  txnNum = getNextTxnNum(txnNum);
    	  txn.setId(txnNum);
//    	  System.out.println("Posting : "+ txn.getId());
    	  boolean result =  abc.submit((PaymentTransaction)txn);
    	  System.out.println("Posted : "+ txn.getId() + " : " + result);
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

 
  private void updateReturnLineItems(CommonTransaction txn2, String txnNum) {
	  CMSCompositePOSTransaction posTxn = null;
	  POSLineItem[] returnLineItems = null;
	  POSLineItem returnLineItem = null;
	  if(txn2 instanceof CMSCompositePOSTransaction){
		  posTxn = (CMSCompositePOSTransaction)txn2;
		  returnLineItems = posTxn.getReturnLineItemsArray(); 
		  if( returnLineItems != null && returnLineItems.length > 0 ){
			  for(int i=0; i<returnLineItems.length; i++){
				  //returnLineItems[i].getTransaction()
				  System.out.println("Processing return line item");
			  }
		  }
	  }
  }

  private String getNextTxnNum(String txnNum){
	  String nextTxnNum = txnNum.substring(0,txnNum.length() - 4);
	  int startNum = Integer.parseInt(txnNum.substring(txnNum.length() - 4));
	  return nextTxnNum + (startNum + 1);
  }
  
  private String getPreviousTxnNum(String txnNum){
	  String nextTxnNum = txnNum.substring(0,txnNum.length() - 4);
	  int startNum = Integer.parseInt(txnNum.substring(txnNum.length() - 4));
	  return nextTxnNum + (startNum - 1);
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
	  ex.printStackTrace();
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
			String constraint = dao.parseSQLConstraint((SQLException) rootException);
			System.out.println("CONSTRAINT=" + constraint);
			try {
				if (constraint != null && constraint.trim().length() > 0) {
					String constraintDesc = dao.getConstraintDescription(constraint);
					System.out.println("################################################################################");
					System.out.println(constraintDesc);
				}
				System.out.println("################################################################################");
				if (rootException instanceof CMSSQLException) {
					ParametricStatement stmt = ((CMSSQLException) rootException).getParametricStatement();
					if (stmt != null) {
						System.out.println("FAULT AT FOLLOWING STATEMENT:");
						System.out.println(stmt.toString());
					}
				}
				System.out.println();
				rootException.printStackTrace();

				SQLException linkedException = (SQLException) rootException;
				while(true) {
					linkedException = linkedException.getNextException();
					if (linkedException == null)
						break;
					System.out.println();
					linkedException.printStackTrace();
				}
				System.out.println("################################################################################");
			} catch (SQLException ex1) {
				ex1.printStackTrace();
			}
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
			TransactionStressTestUtil txnUtil = new TransactionStressTestUtil(args[0]);

			try {
				txnUtil.init();
			} catch (SQLException ex1) {
				ex1.printStackTrace();
			}
			txnUtil.start();
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
