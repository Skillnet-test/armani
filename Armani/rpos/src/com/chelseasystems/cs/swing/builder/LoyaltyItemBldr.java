/*
 * put your module comment here
 * formatted with JxBeauty (c) johann.langhofer@nextra.at
 */


package com.chelseasystems.cs.swing.builder;

/*
 * @copyright (c) 2001 Chelsea Market Systems LLC
 */
/*
 History:
 +------+------------+-----------+-----------+----------------------------------------------+
 | Ver# | Date       | By        | Defect #  | Description                                  |
 +------+------------+-----------+-----------+----------------------------------------------+
 | 4    | 07-06-2005 | Megha     |   105     | Modified to support MSR + Set Account        |
 +------+------------+-----------+-----------+----------------------------------------------+
 | 3    | 06-15-2005 | Vikram    | 144       | Modified to support MSR                      |
 +------+------------+-----------+-----------+----------------------------------------------+
 | 2    | 05-31-2005 | Megha     | 83        |Loyalty/Enroll: Number format Exception        |
 |      |            |           |           | occurs when alpha-numeric value added.       |
 --------------------------------------------------------------------------------------------
 */
import java.util.*;
import com.chelseasystems.cr.swing.CMSApplet;
import com.chelseasystems.cr.appmgr.*;
import com.chelseasystems.cr.currency.ArmCurrency;
import com.chelseasystems.cr.payment.*;
import com.chelseasystems.cr.pos.PaymentTransaction;
import com.chelseasystems.cs.pos.CMSPaymentTransactionAppModel;
import com.chelseasystems.cs.swing.*;
import com.chelseasystems.cs.msr.*;
import com.chelseasystems.cs.payment.*;
import com.chelseasystems.cs.loyalty.Loyalty;
import com.chelseasystems.cs.employee.CMSEmployee;
import java.text.SimpleDateFormat;
import com.chelseasystems.cs.customer.CMSCustomer;
import com.chelseasystems.cs.loyalty.LoyaltyHelper;
import com.chelseasystems.cs.swing.menu.MenuConst;
import com.chelseasystems.cs.util.IsDigit;
import javax.swing.SwingUtilities;


/**
 */
public class LoyaltyItemBldr implements IObjectBuilder {
  private IObjectBuilderManager theBldrMgr;
  private CMSApplet applet;
  private IApplicationManager theAppMgr;
  private String accountNum = null;
  private Loyalty theLoyalty = new Loyalty();
  private CMSMSR cmsMSR = null;

  /**
   */
  public LoyaltyItemBldr() {
  }

  /**
   * @param theBldrMgr
   * @param theAppMgr
   */
  public void init(IObjectBuilderManager theBldrMgr, IApplicationManager theAppMgr) {
    this.theBldrMgr = theBldrMgr;
    this.theAppMgr = theAppMgr;
    this.accountNum = "";
  }

  /**
   */
  public void cleanup() {
    cmsMSR.release();
    this.accountNum = "";
  }

  /**
   * @param theCommand
   * @param theEvent
   */
  public void EditAreaEvent(String theCommand, Object theEvent) {
    if (theCommand.equals("LOYALTY_ITEM")) {
      processSwipe((String)theEvent);
      //return;
    }
    if (theCommand.equals("ACCOUNT")) {
      boolean val = processAccount((String)theEvent);
    }
    if (completeAttributes()) {
      CMSEmployee theOpr = (CMSEmployee)theAppMgr.getStateObject("OPERATOR");
      theAppMgr.showMenu(MenuConst.ADD_ITEM_MENU, theOpr, null);
      theBldrMgr.processObject(applet, "LOYALTY_ITEM", theLoyalty, this);
      theLoyalty = null;
    }
  }

  /**
   * @param Command
   * @param applet
   * @param initValue
   */
  public void build(String Command, CMSApplet applet, Object initValue) {
    resetAttributes();
    this.applet = applet;
    theAppMgr.setSingleEditArea(applet.res.getString(
        "Swipe loyalty card or press 'Enter' for manual entry."), "LOYALTY_ITEM");
    theAppMgr.setEditAreaFocus();
    System.out.println("loyalty card builder getting instance of CMSMSR...");
    CMSMSR cmsMSR = CMSMSR.getInstance();
    cmsMSR.registerCreditCardBuilder(this);
    cmsMSR.activate();
  }

  /**
   * @param input
   */
  public void processSwipe(String input) {
    if (input == null || input.length() == 0
        || (getLoyaltyCardInfo(input) && processAccount(accountNum))) {
      completeAttributes();
      return;
    }
    //    if (getLoyaltyCardInfo(accountNum)) {
    //
    //      // Check to see if the loyalty Card number already exists
    //      try {
    //        theLoyalty = LoyaltyHelper.getLoyalty(theAppMgr, accountNum);
    //        if (theLoyalty == null) {
    //          return;
    //        }
    //        else {
    //          completeAttributes();
    //        }
    //        theBldrMgr.processObject(applet, "LOYALTY_ITEM", theLoyalty, this);
    //        return;
    //
    //      }
    //      catch (Exception e) {
    //        e.printStackTrace();
    //      }
    //
    //    }
    // the card is expired or unreadable
    // theBldrMgr.processObject(applet, "LOYALTY_ITEM", null, this);
    return;
  }

  /**
   * @return
   */
  private boolean completeAttributes() {
    // didn't swipe, get account number for payment type
    if (theLoyalty == null) {
      theAppMgr.setSingleEditArea(applet.res.getString("Enter account number."), "ACCOUNT");
      return (false);
    }
    // manual override only if in re-entry mode
    PaymentTransaction aTxn = (PaymentTransaction)theAppMgr.getStateObject("TXN_POS");
    /*Commented for Armani
     if (thePayment != null & thePayment instanceof Amex) {
     if (cid == null) {
     theAppMgr.setSingleEditArea(applet.res.getString("Enter CID."), "CID");
     return (false);
     }
     }*/
    return (true);
  }

  /**
   */
  private void resetAttributes() {
    theLoyalty = null;
    accountNum = null;
  }

  /**
   */
  private void populateLoyaltyCard() {
    CMSEmployee cmsEmployee = (CMSEmployee)theAppMgr.getStateObject("OPERATOR");
    Date currDate = new Date();
    try {
      SimpleDateFormat df = com.chelseasystems.cs.util.DateFormatUtil.getLocalDateFormat();
      df.setLenient(false);
      String date = df.format(currDate);
      currDate = df.parse(date);
    } catch (Exception e) {}
    //lc.setLoyaltyNumber(loyaltyNumber);
    theLoyalty.setStoreType(LoyaltyBinRangeUtil.CardType);
    theLoyalty.setIssuedBy(cmsEmployee.getExternalID());
    theLoyalty.setIssueDate(currDate);
    theLoyalty.setCurrBalance(0);
    theLoyalty.setLifeTimeBalance(0);
    theLoyalty.setStatus(true);
    //loyaltyNew.setCustomerID(cmsCust.getId());
    theLoyalty.setCustomer((CMSCustomer)theAppMgr.getStateObject("CUSTOMER_LOOKUP"));
    return;
  }

  /**
   * put your documentation comment here
   * @param theEvent
   * @return
   */
  private boolean processAccount(String theEvent) {
    CMSEmployee theOpr = (CMSEmployee)theAppMgr.getStateObject("OPERATOR");
    accountNum = (String)(theEvent);
    boolean reply = true;
    IsDigit digitCheck = new IsDigit();
    if (!digitCheck.isDigit(accountNum)) {
      theAppMgr.showErrorDlg(applet.res.getString("The account number is invalid."));
      SwingUtilities.invokeLater(new Runnable() {
        public void run() {
					theAppMgr.setSingleEditArea(applet.res
							.getString("Swipe loyalty card or press 'Enter' for manual entry."), "LOYALTY_ITEM");
        }
      });
      return false;
    }
    // Check to see if the loyaltyNum already exists.
    try {
      theLoyalty = LoyaltyHelper.getLoyalty(theAppMgr, accountNum);
      if (theLoyalty == null) {
				theAppMgr.showErrorDlg(CMSApplet.res.getString("The LoyaltyCard doesn't exist"));
        SwingUtilities.invokeLater(new Runnable() {
              public void run() {
                theAppMgr.setSingleEditArea(CMSApplet.res.getString(
                    "Swipe loyalty card or press 'Enter' for manual entry."), "LOYALTY_ITEM");
          }
        });
        return false;
      } else if (theLoyalty != null && theLoyalty.getStatus() == false) {
				theAppMgr.showErrorDlg(CMSApplet.res.getString("The LoyaltyCard is inactive"));
        theLoyalty = null;
        SwingUtilities.invokeLater(new Runnable() {
              public void run() {
                theAppMgr.setSingleEditArea(CMSApplet.res.getString(
                    "Swipe loyalty card or press 'Enter' for manual entry."), "LOYALTY_ITEM");
              }
            });
        return false;
      }
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
    return true;
  }

  /**
   * put your documentation comment here
   * @param accountNum
   */
  public void setAccountNum(String accountNum) {
    this.accountNum = new IsDigit().filterToGetDigits(accountNum);
  }

  /**
   * put your documentation comment here
   * @param inputStr
   * @return
   */
  public boolean getLoyaltyCardInfo(String inputStr) {
    if (this.cmsMSR instanceof NonJavaPOSMSR) {
      if (!(((NonJavaPOSMSR)cmsMSR).extractDataToBuilder(inputStr))) {
        theAppMgr.setSingleEditArea(applet.res.getString(
            "Swipe loyalty card or press 'Enter' for manual entry."), "LOYALTY_ITEM");
        theAppMgr.setEditAreaFocus();
        theAppMgr.showErrorDlg(applet.res.getString("Error reading data from MSR."));
        return (false);
      }
    }
    return (true);
  }

  /**
   * @return
   */
  public String getAccountNum() {
    return (accountNum);
  }

  /**
   * put your documentation comment here
   * @param cmsMSR
   */
  public void setCMSMSR(CMSMSR cmsMSR) {
    this.cmsMSR = cmsMSR;
  }
}

