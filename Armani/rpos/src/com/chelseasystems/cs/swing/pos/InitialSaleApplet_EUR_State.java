/*
 * put your module comment here
 * formatted with JxBeauty (c) johann.langhofer@nextra.at
 */

package com.chelseasystems.cs.swing.pos;

/*
 History:
 +------+------------+-----------+-----------+----------------------------------------------+
 | Ver# | Date       | By        | Defect #  | Description                                  |
 +------+------------+-----------+-----------+----------------------------------------------+
 | 8    | 06-07-2005 | Vikram    | 65, 66    |Transfer Associate and Customer between sale /|
 |      |            |           |           |Pre-Sale / Consignment                        |
 --------------------------------------------------------------------------------------------
 | 7    | 05-12-2005 | Vikram    | N/A       | Reward Discount Specification                |
 +------+------------+-----------+-----------+----------------------------------------------+
 | 6    | 04-14-2005 | Khyati    | N/A       |Consignment - Specification                   |
 +------+------------+-----------+-----------+----------------------------------------------+
 | 5    | 04-12-2005 | Bawa      | N/A       |Tender - Modified , PreSales-- Specification  |
 +------+------------+-----------+-----------+----------------------------------------------+
 | 4    | 04-1-2005  | Khyati    | N/A       |Send Sale specification. Enforce Add customer |
 +------+------------+-----------+-----------+----------------------------------------------+
 | 4    | 04-1-2005  | Khyati    | N/A       |Send Sale specification. Enforce Add customer |
 +------+------------+-----------+-----------+----------------------------------------------+
 | 3    | 02-08-2005 | Anand     | N/A       |1.Modification to add new menu and related    |
 |      |            |           |           |  menu functionality.                         |
 --------------------------------------------------------------------------------------------
 | 2    | 01-28-2005 | Bawa      | N/A       |1.Modification to add functionality to        |
 |      |            |           |           |  menus                                       |
 --------------------------------------------------------------------------------------------
 */
import com.chelseasystems.cr.appmgr.*;
import com.chelseasystems.cr.appmgr.state.*;
import com.chelseasystems.cs.pos.CMSCompositePOSTransaction;
import com.chelseasystems.cs.store.CMSStore;
import com.chelseasystems.cs.employee.CMSEmployee;
import com.chelseasystems.cs.tax.*;
import java.util.ResourceBundle;
import com.chelseasystems.cr.util.ResourceManager;
import com.chelseasystems.cr.rules.BusinessRuleException;
import com.chelseasystems.cr.pos.CompositePOSTransaction;
import com.chelseasystems.cs.tax.vat.VATUtilities;
import com.chelseasystems.cs.pos.CMSTransactionPOSHelper;
import com.chelseasystems.cr.swing.CMSApplet;

/**
 * Comments generated by AppBuilder. Do not modify.
 * 0. com.chelseasystems.cs.swing.pos.PaymentApplet
 * 1. com.chelseasystems.cs.swing.pos.CustSaleApplet
 * 2. com.chelseasystems.cs.swing.pos.IdentifyConsultantApplet
 * 3. com.chelseasystems.cs.swing.returns.InitialReturnApplet
 * 4. com.chelseasystems.cs.swing.login.InitialLoginApplet
 * 5. com.chelseasystems.cs.swing.pos.ShippingHeaderApplet
 * 6. com.chelseasystems.cs.swing.menu.PosMenuApplet
 *
 */
public class InitialSaleApplet_EUR_State {
	ResourceBundle res = ResourceManager.getResourceBundle();

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int ITEM_DETAILS(IApplicationManager theAppMgr) throws StateException {
		if (theAppMgr.getStateObject("InitialSale_POSLineItem") == null)
			return -1;
		return 7;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MOD_QTY(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MOD_PRICE(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MARK_AMT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MARK_PCT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int DEL_ITEM(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int RETURN_ITEM(IApplicationManager theAppMgr) throws StateException {
		CMSCompositePOSTransaction theTxn = (CMSCompositePOSTransaction) theAppMgr.getStateObject("TXN_POS");
		CMSEmployee opr = (CMSEmployee) theTxn.getTheOperator();
		if (theAppMgr.getStateObject("TXN_MODE") != null) {
			int iMode = ((Integer) CMSApplet.theAppMgr.getStateObject("TXN_MODE")).intValue();
			if (iMode == InitialSaleApplet_EUR.NO_SALE_MODE || iMode == InitialSaleApplet_EUR.NO_RETURN_MODE) {
				return -1;
			}

		}
		return 3;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int LAYAWAY(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int DISCOUNT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int BY_PRICE_DISCOUNT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int TOTAL(IApplicationManager theAppMgr) throws StateException {
		CMSCompositePOSTransaction theTxn = (CMSCompositePOSTransaction) theAppMgr.getStateObject("TXN_POS");
		if (theTxn.getLineItemsArray().length > 0) {
			try {
				VATUtilities.applyVAT(theAppMgr, theTxn, (CMSStore) theTxn.getStore(), (CMSStore) theTxn.getStore(), theTxn.getProcessDate());
				return 0;
			} catch (Exception ex) {
				theAppMgr.showExceptionDlg(ex);
			}
			return -1;
		} else {
			ResourceBundle res = ResourceManager.getResourceBundle();
			theAppMgr.showErrorDlg(res.getString("You cannot proceed to payments until a line item has been added."));
			return -1;
		}
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int TAX_EXEMPT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int REMOVE_TAX_EXEMPT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SUSPEND(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int CHANGE_ASSOCIATE(IApplicationManager theAppMgr) throws StateException {
		return 2;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int CHANGE_CUST(IApplicationManager theAppMgr) throws StateException {
		return 1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int CANCEL_TXN(IApplicationManager theAppMgr) throws StateException {
		if (theAppMgr.getStateObject("CASHIER_SESSION") != null) {
			return 6;
		} else {
			if (cancelTransaction(theAppMgr)) {
				try {
					CMSCompositePOSTransaction txn = CMSTransactionPOSHelper.allocate(theAppMgr);
					CMSEmployee employee = (CMSEmployee) theAppMgr.getStateObject("OPERATOR");
					theAppMgr.clearStateObjects();
					theAppMgr.addStateObject("TXN_POS", txn);
					theAppMgr.addStateObject("OPERATOR", employee);
				} catch (Exception ex) {
					theAppMgr.showErrorDlg(res.getString(ex.getMessage()));
					theAppMgr.goHome();
				}
				return 2;
			}
			return -1;
		}
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int OK(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int CANCEL(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MOD_DEP(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int PREV(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.removeStateObject("OVERRIDE_EMPLOYEE_DISCOUNT");
		theAppMgr.removeStateObject("IS_SUBTOTAL_DISCOUNT");
		theAppMgr.removeStateObject("IS_MULTI_DISCOUNT");
		theAppMgr.removeStateObject("IS_LINE_ITEM_DISCOUNT");
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SALE(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int ITEM_DETAIL(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int CHANGE_LINE_CONS(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int RETURN_TRANS(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MODIFY_TAX(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int CHANGE_DEPOSIT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int CONTINUE(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int RESTORE_CONS(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int RESTORE_TAX(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MODIFY_TAX_PERCENT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SHOW_MISC_ITEMS(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SEARCH(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int LOCATE(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SHIPPING(IApplicationManager theAppMgr) throws StateException {
		return 5;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int ADD_ITEM(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SUBTOTAL_DISCOUNT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	//Ks: modified for Consignments
	public int CONSIGNMENTS(IApplicationManager theAppMgr) throws StateException {
		if (cancelTransaction(theAppMgr)) {
			//VM: Transfer of Associate and Customer between Sale, PreSale and Consignment
			CompositePOSTransaction theTxn = (CompositePOSTransaction) theAppMgr.getStateObject("TXN_POS");
			if (theTxn.getCustomer() != null)
				theAppMgr.addStateObject("CUSTOMER", theTxn.getCustomer());
			if (theTxn.getConsultant() != null)
				theAppMgr.addStateObject("ASSOCIATE", theTxn.getConsultant());
			removeStateObjects(theAppMgr);
			return 17;
		} else
			return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int PRESALES(IApplicationManager theAppMgr) throws StateException {
		if (cancelTransaction(theAppMgr)) {
			//VM: Transfer of Associate and Customer between Sale, PreSale and Consignment
			CompositePOSTransaction theTxn = (CompositePOSTransaction) theAppMgr.getStateObject("TXN_POS");
			if (theTxn.getCustomer() != null)
				theAppMgr.addStateObject("CUSTOMER", theTxn.getCustomer());
			if (theTxn.getConsultant() != null)
				theAppMgr.addStateObject("ASSOCIATE", theTxn.getConsultant());
			removeStateObjects(theAppMgr);
			return 16;
		} else
			return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int RESERVATIONS(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int PRICING(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MANAGEMENT(IApplicationManager theAppMgr) throws StateException {
		if (cancelTransaction(theAppMgr)) {
			removeStateObjects(theAppMgr);
			return 10;
		}
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int OPTIONS(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int INQUIRIES(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int TRANS_MGMT(IApplicationManager theAppMgr) throws StateException {
		if (cancelTransaction(theAppMgr)) {
			removeStateObjects(theAppMgr);
			return 14;
		}
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int OTHER_TXN(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int DISCOUNT_PERCENTAGE(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int DISCOUNT_AMOUNT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int DISCOUNT_PRICE(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int LINE_DISCOUNT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int ALTERATIONS(IApplicationManager theAppMgr) throws StateException {
		return 19;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int OPTIONS_ALTERATIONS(IApplicationManager theAppMgr) throws StateException {
		return 19;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SEND_SALE(IApplicationManager theAppMgr) throws StateException {
		//ks: Redirect to customer lookup screen if Customer is not added to the txn
		CMSCompositePOSTransaction theTxn = (CMSCompositePOSTransaction) theAppMgr.getStateObject("TXN_POS");
		if (theTxn.getCustomer() == null) {
			theAppMgr.addStateObject("ARM_DIRECT_TO", "SHIPPING_HEADER_APPLET");
			theAppMgr.addStateObject("ARM_DIRECTED_FROM", "SALE_APPLET");
			theAppMgr.addStateObject("ARM_CUST_REQUIRED", "TRUE");
			return 1;
		} else {
			return 5;
		}
	}

	public int PRINT_FISCAL_NOSALE(IApplicationManager theAppMgr) throws StateException {
		// ks: Redirect to customer lookup screen if Customer is not added to the txn
		CMSCompositePOSTransaction theTxn = (CMSCompositePOSTransaction) theAppMgr.getStateObject("TXN_POS");
		if (theTxn.getCustomer() == null) {
			theAppMgr.addStateObject("ARM_DIRECT_TO", "SALE_APPLET");
			theAppMgr.addStateObject("ARM_DIRECTED_FROM", "SALE_APPLET");
			theAppMgr.addStateObject("ARM_CUST_REQUIRED", "TRUE");
			return 1;
		} else {
			return -1;
		}
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MGMT_MENU(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SYSTEM_UTILS(IApplicationManager theAppMgr) throws StateException {
		if (cancelTransaction(theAppMgr)) {
			removeStateObjects(theAppMgr);
			return 15;
		}
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int TENDER(IApplicationManager theAppMgr) throws StateException {
		CMSCompositePOSTransaction theTxn = (CMSCompositePOSTransaction) theAppMgr.getStateObject("TXN_POS");
		if (theTxn.getLineItemsArray().length > 0 || theTxn.getPresaleLineItemsArray().length > 0) {
			if (theTxn.getCustomer() == null) {
				theAppMgr.addStateObject("ARM_DIRECTED_FROM", "SALE_APPLET");
				theAppMgr.addStateObject("ARM_DIRECT_TO", "PAYMENT_APPLET");
				if (theAppMgr.getStateObject("TXN_MODE") != null) {
					int iMode = ((Integer) theAppMgr.getStateObject("TXN_MODE")).intValue();
					if (iMode == InitialSaleApplet_EUR.PRE_SALE_CLOSE || iMode == InitialSaleApplet_EUR.PRE_SALE_OPEN || iMode == InitialSaleApplet_EUR.CONSIGNMENT_CLOSE
							|| iMode == InitialSaleApplet_EUR.CONSIGNMENT_OPEN || iMode == InitialSaleApplet_EUR.RESERVATIONS_OPEN || iMode == InitialSaleApplet_EUR.RESERVATIONS_CLOSE
							|| iMode == InitialSaleApplet_EUR.NO_OPEN_RESERVATIONS_CLOSE_SALE || iMode == InitialSaleApplet_EUR.NO_OPEN_RESERVATIONS_CLOSE_RETURN) {
						theAppMgr.addStateObject("ARM_CUST_REQUIRED", "TRUE");
					}
				}
				if ((theAppMgr.getStateObject("TAX_EXEMPT") != null)) {
					theAppMgr.addStateObject("ARM_CUST_REQUIRED", "TRUE");
				}
				//         else
				//         {
				//             theAppMgr.addStateObject("ARM_CUST_REQUIRED", "FALSE");
				//         }
				return 1;
			}
			// theAppMgr.addStateObject("ARM_IS_CUSTMER_ADDED", "TRUE");
			return 0;
		} else {
			theAppMgr.showErrorDlg(res.getString("You cannot proceed to payments until a line item has been added."));
			return -1;
		}
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int CANCEL_ACTION(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int ITEM_LOOKUP(IApplicationManager theAppMgr) throws StateException {
		return 18;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int RECALL_TXN(IApplicationManager theAppMgr) throws StateException {
		return 20;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int ADD_CUSTOMER(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.addStateObject("ARM_DIRECTED_FROM", "SALE_APPLET");
		theAppMgr.addStateObject("ARM_DIRECT_TO", "SALE_APPLET");
		if ((theAppMgr.getStateObject("TAX_EXEMPT") != null)) {
			theAppMgr.addStateObject("ARM_CUST_REQUIRED", "TRUE");
		}
		return 1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int TRANS_DISCOUNT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int PRICE_OVERRIDE(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int PRICING_PRICE_OVERRIDE(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SUSPEND_TXN(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int TIMECARD_MGMT(IApplicationManager theAppMgr) throws StateException {
		return 8;
	}

	/*public int MGMT_MENU_HIDDEN(IApplicationManager theAppMgr) throws StateException {
	 return 9;
	 }*/
	public int VIEW_TXN(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.addStateObject("FROM_VIEW_TXN", "FROM_VIEW_TXN");
		return 11;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int REDEEMABLE_INQUIRY(IApplicationManager theAppMgr) throws StateException {
		return 12;
	}

	//STORE_LOCATOR
	public int STORE_LOCATOR(IApplicationManager theAppMgr) throws StateException {
		return 13;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 */
	private void removeStateObjects(IApplicationManager theAppMgr) {
		theAppMgr.removeStateObject("ARM_DISCOUNT_SEQ");
		theAppMgr.removeStateObject("ARM_DISCOUNT_TYPE");
		theAppMgr.removeStateObject("ARM_EMPLOYEE_DISCOUNT");
		theAppMgr.removeStateObject("ARM_FROM_SHIPPING_ADDRESS");
		theAppMgr.removeStateObject("ARM_SHIPPING_FEE");
		theAppMgr.removeStateObject("ARM_IS_CUSTOMER_ADDED");
		theAppMgr.removeStateObject("TXN_POS");
		return;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int REWARD_DISCOUNT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 */
	private boolean cancelTransaction(IApplicationManager theAppMgr) {
		CMSCompositePOSTransaction theTxn = (CMSCompositePOSTransaction) theAppMgr.getStateObject("TXN_POS");
		if (theTxn.getLineItemsArray().length > 0) {
			if (theAppMgr.showOptionDlg(res.getString("Cancel Transaction"), res.getString("Are you sure you want to cancel this transaction?"))) {
				return true;
			} else
				return false;
		} else
			return true;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int SALE_TXN(IApplicationManager theAppMgr) throws StateException {
		//VM: Transfer of Associate and Customer between Sale, PreSale and Consignment
		CompositePOSTransaction theTxn = (CompositePOSTransaction) theAppMgr.getStateObject("TXN_POS");
		if (theTxn.getCustomer() != null)
			theAppMgr.addStateObject("CUSTOMER", theTxn.getCustomer());
		if (theTxn.getConsultant() != null)
			theAppMgr.addStateObject("ASSOCIATE", theTxn.getConsultant());
		//removeStateObjects(theAppMgr);
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int MULTI_DISCOUNT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int OVERRIDE_EMPLOYEE_DISCOUNT(IApplicationManager theAppMgr) throws StateException {
		return -1;
	}

	public int NON_FISCAL_NO_SALE(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.addStateObject("FROM_INITIAL_SALE_APPLET", "FROM_INITIAL_SALE_APPLET");
		return ADD_ASIS(theAppMgr);
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int ADD_ASIS(IApplicationManager theAppMgr) throws StateException {
		return 25;
	}

	public int DDT(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.addStateObject("ARM_PRINT_FISCAL_MODE", new Integer(PrintFiscalDocumentApplet.MODE_DDT));
		return 22;
	}

	public int TAX_FREE(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.addStateObject("ARM_PRINT_FISCAL_MODE", new Integer(PrintFiscalDocumentApplet.MODE_TAX_FREE));
		return 22;
	}

	public int VAT_INVOICE(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.addStateObject("ARM_PRINT_FISCAL_MODE", new Integer(PrintFiscalDocumentApplet.MODE_VAT_INVOICE));
		return 22;
	}

	public int CREDIT_NOTE(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.addStateObject("ARM_PRINT_FISCAL_MODE", new Integer(PrintFiscalDocumentApplet.MODE_CREDIT_NOTE));
		return 22;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 */
	public int RESERVATIONS_OPEN(IApplicationManager theAppMgr) {
		// RELOAD THE APPLET.
		return 23;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int RESERVATIONS_CLOSE(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.removeStateObject("ARM_RSV_DEPOSIT");
		return 24;
	}

	public int DEPOSIT(IApplicationManager theAppMgr) throws StateException {
		theAppMgr.addStateObject("ARM_CUST_REQUIRED", "TRUE");
		theAppMgr.addStateObject("ARM_DIRECTED_FROM", "SALE_APPLET");
		theAppMgr.addStateObject("ARM_DIRECT_TO", "SALE_APPLET");
		return 1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int COLLECTIONS(IApplicationManager theAppMgr) throws StateException {
		if (cancelTransaction(theAppMgr)) {
			cleanStateObjects(theAppMgr);
			return 27;
		}
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 * @return
	 * @exception StateException
	 */
	public int PAIDOUTS(IApplicationManager theAppMgr) throws StateException {
		if (cancelTransaction(theAppMgr)) {
			cleanStateObjects(theAppMgr);
			return 26;
		}
		return -1;
	}

	/**
	 * put your documentation comment here
	 * @param theAppMgr
	 */
	private void cleanStateObjects(IApplicationManager theAppMgr) {
		theAppMgr.removeStateObject("ARM_DISCOUNT_SEQ");
		theAppMgr.removeStateObject("ARM_DISCOUNT_TYPE");
		theAppMgr.removeStateObject("ARM_EMPLOYEE_DISCOUNT");
		theAppMgr.removeStateObject("ARM_FROM_SHIPPING_ADDRESS");
		theAppMgr.removeStateObject("ARM_SHIPPING_FEE");
		theAppMgr.removeStateObject("ARM_IS_CUSTOMER_ADDED");
		return;
	}

}
