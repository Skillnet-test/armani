/*
 * put your module comment here
 * formatted with JxBeauty (c) johann.langhofer@nextra.at
 */


package com.ga.cs.swing.report.assocreport;

import com.chelseasystems.cr.appmgr.*;
import com.chelseasystems.cr.appmgr.state.*;


/**
 * Comments generated by AppBuilder. Do not modify.
 */
public class AssociateReportApplet_State {

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int CANCEL(IApplicationManager theAppMgr)
      throws StateException {
    theAppMgr.goHome();
    return -1;
  }

  /**
   * put your documentation comment here
   * @param theAppMgr
   * @return
   * @exception StateException
   */
  public int OK(IApplicationManager theAppMgr)
      throws StateException {
    //
    // put state logic here
    //
    throw new StateException("State change not implemented->OK");
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
  public int PRINT(IApplicationManager theAppMgr)
      throws StateException {
    //
    // put state logic here
    //
    return -1;
  }
}

