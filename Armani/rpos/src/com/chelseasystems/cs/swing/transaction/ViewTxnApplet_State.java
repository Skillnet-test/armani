/*
 * put your module comment here
 * formatted with JxBeauty (c) johann.langhofer@nextra.at
 */


package com.chelseasystems.cs.swing.transaction;

import com.chelseasystems.cr.appmgr.*;
import com.chelseasystems.cr.appmgr.state.*;
import com.chelseasystems.cs.swing.menu.MenuConst;


/**
 * Comments generated by AppBuilder. Do not modify.
 * 0. com.chelseasystems.cs.swing.transaction.TxnDetailApplet
 * 1. com.chelseasystems.cs.swing.transaction.TxnListApplet
 * 2. com.chelseasystems.cs.swing.login.InitialLoginApplet
 * 3. com.chelseasystems.cs.swing.customer.CustomerListApplet
 * 4. com.chelseasystems.cs.swing.menu.PosMenuApplet
 */
public class ViewTxnApplet_State {

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int CANCEL(IApplicationManager theAppMgr)
      throws StateException {
    if(theAppMgr.getGlobalObject("EOD_COMPLETE")!=null)
    {
      return 6;
    }
    if (theAppMgr.getStateObject("OPERATOR") == null) {
      theAppMgr.goHome();
      return -1;
    }
    return 4;
  }

  /**
   * This button is not actually on the screen, but when a Txn search
   * returns multiple results, the GUI needs a way to goto the next screen.
   */
  public int OK(IApplicationManager theAppMgr)
      throws StateException {
    return 0;
  }

  /**
   * This button is not actually on the screen, but when a Txn search
   * returns a transaction, the GUI needs a way to goto the next screen.
   */
  public int OK_LIST(IApplicationManager theAppMgr)
      throws StateException {
    return 1;
  }

  /**
   * This button is not actually on the screen.
   */
  public int CUST_LIST(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
    //      return  3;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int PREV(IApplicationManager theAppMgr)
      throws StateException {
    theAppMgr.goBack();
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int ALL(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /*public int CONSULTANT (IApplicationManager theAppMgr) throws StateException {
   return  -1;
   }*/
  public int ASSOCIATE(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int CUSTOMER(IApplicationManager theAppMgr)
      throws StateException {
    theAppMgr.addStateObject("ARM_DIRECTED_FROM", "VIEW_TXN_APPLET");
    theAppMgr.addStateObject("ARM_DIRECT_TO", "VIEW_TXN_APPLET");
    theAppMgr.addStateObject("ARM_CUST_REQUIRED", "TRUE");
    return 3;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int DISCOUNT(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int OPERATOR(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int PAYMENT(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int TRANSACTION(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int TENDER(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int SEND_SALE(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int CASHIER(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int ITEM_DETAILS(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int OTHER(IApplicationManager theAppMgr)
      throws StateException {
    // System.out.println("other");
    return 5;
  }

  public int FISCAL_SEARCH(IApplicationManager theAppMgr)
      throws StateException {
    return -1;
  }
}
