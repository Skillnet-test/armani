package com.ga.util.txn;


import com.chelseasystems.cr.transaction.CommonTransaction;
import java.io.ObjectInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.OptionalDataException;
import com.chelseasystems.cs.txnposter.CMSTxnPosterHelper;
import com.chelseasystems.cr.config.ConfigMgr;
import com.chelseasystems.cr.appmgr.ClientServices;
import java.util.Vector;
import java.util.StringTokenizer;
import com.chelseasystems.cr.appmgr.IBrowserManager;
import com.chelseasystems.cr.pos.TransactionPOSServices;
import com.chelseasystems.cs.pos.CMSTransactionPosterRMIClient;
import com.chelseasystems.cr.pos.PaymentTransaction;
import java.rmi.RemoteException;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import com.chelseasystems.cs.dataaccess.CMSSQLException;
import com.chelseasystems.cr.database.ParametricStatement;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2006</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class TransactionPosterUtil {
  private CommonTransaction txn;
  private TransactionUtilDAO dao;
  public static IBrowserManager theMgr;


  public TransactionPosterUtil(String txnResource) throws IOException, ClassNotFoundException, OptionalDataException {
    ObjectInputStream oin = new ObjectInputStream(new FileInputStream(txnResource));
    txn = (CommonTransaction) oin.readObject();
    dao = new TransactionUtilOracleDAO();
  }

  public static void main(String[] args) {
    try {
      TransactionPosterUtil txnUtil = new TransactionPosterUtil(args[0]);

      /*System.out.println();
      System.out.println("TRANSACTION OBJECT LOADED");
      System.out.println("TRANSACTION CLASS : "+txnUtil.getTransaction().getClass().getName());
      System.out.println("TRANSACTION TYPE : "+txnUtil.getTransaction().getTransactionType());
*/
      try {
        txnUtil.init();
      } catch (SQLException ex1) {
        ex1.printStackTrace();
        /** @todo Handle this exception */
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
      /** @todo Handle this exception */
    } catch (ClassCastException ex) {
      ex.printStackTrace();
    }
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
      System.out.println("POSTING... : "+txn);
  //    System.out.println("TransactionPOSServices..getCurrent()="+TransactionPOSServices.getCurrent());
      CMSTransactionPosterRMIClient abc = new CMSTransactionPosterRMIClient();
      boolean result =  abc.submit((PaymentTransaction)txn);
      System.out.println("RESULT3: "+result);
    } catch (RemoteException ex) {
      //System.out.println("################################################################################");
      Throwable rootException = ex;
      if (ex.detail != null) {
        if(ex.detail instanceof RemoteException && ((RemoteException)ex.detail).detail != null)
          rootException = ((RemoteException)ex.detail).detail;
        else
          rootException = ex.detail;
      }
      System.out.println("Exception class = "+rootException.getClass().getName());
      if(rootException instanceof SQLException) {
        String constraint = dao.parseSQLConstraint((SQLException) rootException);
        System.out.println("CONSTRAINT=" + constraint);
        try {
          if(constraint != null && constraint.trim().length() > 0) {
            String constraintDesc = dao.getConstraintDescription(constraint);
            System.out.println("################################################################################");
            System.out.println(constraintDesc);
          }
          System.out.println("################################################################################");
          if(rootException instanceof CMSSQLException) {
            ParametricStatement stmt = ((CMSSQLException)rootException).getParametricStatement();
            if(stmt != null) {
              System.out.println("FAULT AT FOLLOWING STATEMENT:");
              System.out.println(stmt.toString());
            }
          }
          System.out.println();
          rootException.printStackTrace();

          //if(rootException instanceof SQLException) {
            SQLException linkedException = (SQLException)rootException;
            while (true) {
              linkedException = linkedException.getNextException();
              if(linkedException == null)
                break;
              System.out.println();
              linkedException.printStackTrace();
            }
          //}
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
    } catch (Throwable ex) {
      System.out.println("################################################################################");
      System.out.println("ERROR: "+ex.getMessage());
      System.out.println("################################################################################");
      ex.printStackTrace();
    }
    System.exit(0);
  }


  public void startClientServices(IBrowserManager theMgr)
  {
          String services[] = getClientServices();
          if(services == null)
          {
//                  System.out.println("The files needed to began this mode are not configured properly. See setup guide.");
                  return;
          }
          String sConfigFile = System.getProperty("USER_CONFIG");
          ConfigMgr mgr = new ConfigMgr(sConfigFile);
          for(int x = 0; x < services.length; x++)
                  try
                  {
  //                        System.out.println("*** Starting ClientService: " + services[x]);
                          Object obj = mgr.getObject(services[x]);
                          ClientServices client = (ClientServices)obj;
                          client.setDownTimeMgr(theMgr);
                          client.setBrowserMgr(theMgr);
                          theMgr.addGlobalObject(services[x], obj);
                          client.init(true);
                  }
                  catch(Exception ex)
                  {
                          System.out.println("ERROR start()->" + ex);
                          ex.printStackTrace();
                  }

          return;
  }

  private String[] getClientServices()
  {
          Vector vServices = new Vector();
          try
          {
                  String sConfigFile = System.getProperty("USER_CONFIG");
                  ConfigMgr mgr = new ConfigMgr(sConfigFile);
                  String list = mgr.getString("SERVICES_LIST");
                  String sClass;
                  for(StringTokenizer tokenizer = new StringTokenizer(list, ","); tokenizer.hasMoreElements(); vServices.addElement(sClass))
                          sClass = (String)tokenizer.nextElement();

                  String sResult[] = new String[vServices.size()];
                  vServices.copyInto(sResult);
                  return sResult;
          }
          catch(Exception ex)
          {
                  System.out.println("ERROR getClientServices()->" + ex);
                  ex.printStackTrace();
          }
          return null;
  }

}
