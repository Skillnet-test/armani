package com.chelseasystems.cs.pos;


import java.rmi.*;
import com.igray.naming.*;
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
 * <p>Title: ICMSTransactionPOSRMIServer</p>
 *
 * <p>Description: Defines the customer services that are available remotely via RMI.</p>
 *
 * <p>Copyright: Copyright (c) 2005</p>
 *
 * <p>Company: </p>
 *
 * @author
 * @version 1.0
 */
public interface ICMSTransactionPosterRMIServer extends Remote, IPing {

  /**
   * This method is used to submit a CompositePOSTransaction to data store
   * @param paymentTransaction PaymentTransaction
   * @return boolean
   * @throws RemoteException
   */
  public boolean submitBroken(PaymentTransaction paymentTransaction)
  throws RemoteException;

  
}

