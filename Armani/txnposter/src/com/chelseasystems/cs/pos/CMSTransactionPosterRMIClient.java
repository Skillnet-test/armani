package com.chelseasystems.cs.pos;


import com.chelseasystems.cr.appmgr.*;
import com.chelseasystems.cr.config.*;
import com.chelseasystems.cr.logging.*;
import com.chelseasystems.cr.node.IRemoteServerClient;
import com.chelseasystems.cr.node.ICMSComponent;
import com.igray.naming.*;
import java.rmi.*;
import com.chelseasystems.cr.pos.*;

import java.lang.*;
import java.util.*;
import com.chelseasystems.cr.currency.*;
import com.chelseasystems.cr.customer.Customer;
import com.chelseasystems.cr.txnposter.*;
import com.chelseasystems.cs.pos.TransactionSearchString;
import com.chelseasystems.cs.fiscaldocument.FiscalDocumentNumber;
import com.chelseasystems.cs.fiscaldocument.FiscalDocument;


/**
 *
 * <p>Title:CMSTransactionPOSRMIClient </p>
 *
 * <p>Description: This class deal with client-side of an RMI connection
 * for fetching/submitting Transaction object</p>
 *
 * <p>Copyright: Copyright (c) 2005</p>
 *
 * <p>Company: </p>
 *
 * @author
 * @version 1.0
 */
public class CMSTransactionPosterRMIClient extends CMSTransactionPOSRMIClient {

  /** The configuration manager */
  protected ConfigMgr config = null;

  /** The reference to the remote implementation of the service. */
  protected ICMSTransactionPosterRMIServer cmstransactionposServer = null;

  /** The maximum number of times to try to establish a connection to the RMIServerImpl */
  protected int maxTries = 1;

  /**
   * Constructor
   * Set the configuration manager and make sure that the system has a
   * security manager set.
   **/
  public CMSTransactionPosterRMIClient()
      throws DowntimeException {
	  super();
    config = new ConfigMgr("posex.cfg");
    if (System.getSecurityManager() == null)
      System.setSecurityManager(new RMISecurityManager());
    this.init();
  }

  /**
   * This method is used to get the remote object from the registry.
   */
  protected void init()
      throws DowntimeException {
    try {
    	config = new ConfigMgr("posex.cfg");
      this.lookup();
   //   System.out.println("CMSTransactionPOSRMIClient Lookup: Complete");
    } catch (Exception e) {
    	e.printStackTrace();
      LoggingServices.getCurrent().logMsg(getClass().getName(), "init()", "Cannot establish connection to RMI server."
          , "Make sure that the server is registered on the remote server" + " and that the name of the remote server and remote service are"
          + " correct in the update.cfg file.", LoggingServices.MAJOR,
          e);
      throw new DowntimeException(e.getMessage());
    }
  }

  /**
   * This method perform the lookup of remote server.
   * @exception Exception
   */
  public void lookup()
      throws Exception {
    NetworkMgr mgr = new NetworkMgr("network.cfg");
	config = new ConfigMgr("posex.cfg");
    maxTries = mgr.getRetryAttempts();
   /* System.out.println("1 "+mgr.getRMIMasterNode());
    System.out.println("1.2 " + (config==null));
    
    System.out.println("2 "+config.getString("REMOTE_NAME"));
    System.out.println("3 "+mgr.getQuery());*/
    String connect = mgr.getRMIMasterNode() + config.getString("REMOTE_NAME") + mgr.getQuery();
    cmstransactionposServer = (ICMSTransactionPosterRMIServer)NamingService.lookup(connect);
  }

  /**
   * This method returns whether remote server is available or not
   * @return  boolean <true> is component is available
   */
  public boolean isRemoteServerAvailable() {
    try {
      return ((ICMSComponent)this.cmstransactionposServer).isAvailable();
    } catch (Exception ex) {
      return false;
    }
  }

  /**
   * This method submit a CompositePOSTransaction to data store
   * @param paymentTransaction PaymentTransaction
   * @return boolean
   * @throws Exception
   */
  public boolean submit(PaymentTransaction paymentTransaction)
      throws Exception {

    for (int x = 0; x < maxTries; x++) {
      if (cmstransactionposServer == null)
        init();
      try {
        return cmstransactionposServer.submitBroken((PaymentTransaction)paymentTransaction);
      } catch (ConnectException ce) {
        ce.printStackTrace();
        cmstransactionposServer = null;
      } catch (RemoteException ex) {
    	  ex.printStackTrace();
       if(ex.detail != null)
          ex.detail.printStackTrace();
        throw ex;
      } catch (Exception ex) {
        ex.printStackTrace();
        throw new DowntimeException(ex.getMessage());
      }
    }
    throw new DowntimeException("Unable to establish connection to CMSTransactionPOSServices");
  }
}


