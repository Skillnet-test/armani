package com.chelseasystems.cs.pos;


import com.chelseasystems.cr.appmgr.DowntimeException;
import com.chelseasystems.cr.config.*;
import com.chelseasystems.cr.logging.*;
import com.chelseasystems.cr.node.*;
import com.igray.naming.*;
import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.util.*;
import com.chelseasystems.cr.pos.*;
import java.lang.*;
import java.util.*;
import com.chelseasystems.cr.currency.ArmCurrency;
import com.chelseasystems.cr.currency.CurrencyException;
import com.chelseasystems.cr.customer.Customer;
import com.chelseasystems.cr.txnposter.*;
import com.chelseasystems.cs.pos.TransactionSearchString;
import com.chelseasystems.cs.fiscaldocument.FiscalDocumentNumber;
import com.chelseasystems.cs.fiscaldocument.FiscalDocument;


/**
 *
 * <p>Title: CMSTransactionPOSRMIServerImpl</p>
 *
 * <p>Description: This is the server side of the RMI connection used for
 * fetching/submitting information.  This class delgates all method calls to
 * the object referenced by the return value from
 * CMSTransactionPOSServices.getCurrent(). </p>
 *
 * <p>Copyright: Copyright (c) 2005</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class CMSTransactionPosterRMIServerImpl extends CMSComponent implements ICMSTransactionPosterRMIServer {

  /**
   * Constructor
   * @param props Properties
   * @throws RemoteException
   */
  public CMSTransactionPosterRMIServerImpl(Properties props)
      throws RemoteException {
    super(props);
    setImpl();
    init();
  }

  /**
   * This method sets the current implementation
   **/
  private void setImpl() {
    Object obj = getConfigManager().getObject("SERVER_IMPL");
    if (null == obj) {
      LoggingServices.getCurrent().logMsg(getClass().getName(), "setImpl()", "Could not instantiate SERVER_IMPL."
          , "Make sure pos.cfg contains SERVER_IMPL", LoggingServices.MAJOR);
    }
    CMSTransactionPosterJDBCServices.setCurrent((CMSTransactionPosterJDBCServices)obj);
  }

  /**
   * This method is used to bind remote object
   */
  private void init() {
    System.out.println("Binding to RMIRegistry...");
    String theName = getConfigManager().getString("REMOTE_NAME");
    if (null != theName) {
      bind(theName, this);
    } else {
      LoggingServices.getCurrent().logMsg(getClass().getName(), "init()", "Could not find name to bind to in registry."
          , "Make sure pos.cfg contains a RMIREGISTRY entry.", LoggingServices.MAJOR);
    }
  }

  /**
   * This method is used to receives callback when the config file changes
   * @param aKey String[]
   */
  protected void configEvent(String[] aKey) {}

  /**
   * This method is used by DowntimeManager to determine when this object is
   * available. Just because this process is up doesn't mean that the clients
   * can come up. Make sure that the database is available.
   * @return boolean
   * @throws RemoteException
   */
  public boolean ping()
      throws RemoteException {
    return true;
  }
  /**
   * This method is used to submit a CompositePOSTransaction to data store
   * @param paymentTransaction PaymentTransaction
   * @return boolean
   * @throws RemoteException
   */
  public boolean submitBroken(PaymentTransaction paymentTransaction)
      throws RemoteException {
	  System.out.println(">>>>>>>>>>>>>>>>>>CMSTransactionPosterRMIServerImpl submitBroken" );
    long start = getStartTime();
    try {
      if (!isAvailable())
        throw new ConnectException("Service is not available");
      incConnection();
      return (boolean)((CMSTransactionPosterJDBCServices)CMSTransactionPosterJDBCServices.getCurrent()).submitBroken(paymentTransaction);
    } catch (Exception e) {
      throw new RemoteException(e.getMessage(), e);
    } finally {
      addPerformance("submitBroken", start);
      decConnection();
    }
  }
  
}


