package com.chelseasystems.cs.pos;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Vector;
import com.chelseasystems.cr.config.ConfigMgr;
import com.chelseasystems.cr.config.FileMgr;
import com.chelseasystems.cr.currency.ArmCurrency;
import com.chelseasystems.cr.currency.CurrencyException;
import com.chelseasystems.cr.customer.Customer;
import com.chelseasystems.cr.database.ParametricStatement;
import com.chelseasystems.cr.discount.Discount;
import com.chelseasystems.cr.layaway.Layaway;
import com.chelseasystems.cr.layaway.LayawayPaymentInfo;
import com.chelseasystems.cr.layaway.LayawayPaymentTransaction;
import com.chelseasystems.cr.layaway.LayawayRTSTransaction;
import com.chelseasystems.cr.logging.LoggingServices;
import com.chelseasystems.cr.payment.DueBill;
import com.chelseasystems.cr.payment.DueBillIssue;
import com.chelseasystems.cr.payment.GiftCert;
import com.chelseasystems.cr.payment.IPaymentConstants;
import com.chelseasystems.cr.payment.Payment;
import com.chelseasystems.cr.payment.Redeemable;
import com.chelseasystems.cr.payment.RedeemableHist;
import com.chelseasystems.cr.payment.StoreValueCard;
import com.chelseasystems.cr.pos.AdHocQueryConstraints;
import com.chelseasystems.cr.pos.CompositePOSTransaction;
import com.chelseasystems.cr.pos.POSLineItem;
import com.chelseasystems.cr.pos.POSLineItemDetail;
import com.chelseasystems.cr.pos.PaymentTransaction;
import com.chelseasystems.cr.pos.RedeemableBuyBackTransaction;
import com.chelseasystems.cr.pos.ReturnLineItem;
import com.chelseasystems.cr.pos.ReturnLineItemDetail;
import com.chelseasystems.cr.pos.SaleLineItemDetail;
import com.chelseasystems.cr.pos.TransactionHeader;
import com.chelseasystems.cr.pos.TransactionPOSServices;
import com.chelseasystems.cr.pos.VoidTransaction;
import com.chelseasystems.cr.transaction.ITransaction;
import com.chelseasystems.cr.transfer.Transfer;
import com.chelseasystems.cr.transfer.TransferIn;
import com.chelseasystems.cr.txnposter.PaymentSummary;
import com.chelseasystems.cr.txnposter.SalesSummary;
import com.chelseasystems.cr.txnposter.TxnTypeSummary;
import com.chelseasystems.cr.util.DateUtil;
import com.chelseasystems.cs.collection.CMSMiscCollection;
import com.chelseasystems.cs.collection.CMSMiscCollectionCredit;
import com.chelseasystems.cs.customer.CMSCustomer;
import com.chelseasystems.cs.customer.CMSCustomerMessage;
import com.chelseasystems.cs.customer.CreditHistory;
import com.chelseasystems.cs.dataaccess.ArmCustSaleSummaryDAO;
import com.chelseasystems.cs.dataaccess.ArmPosCsgDAO;
import com.chelseasystems.cs.dataaccess.ArmPosPrsDAO;
import com.chelseasystems.cs.dataaccess.ArmPosRsvDAO;
import com.chelseasystems.cs.dataaccess.ArmStgTxnHdrDAO;
import com.chelseasystems.cs.dataaccess.CMSSQLException;
import com.chelseasystems.cs.dataaccess.CollectionDAO;
import com.chelseasystems.cs.dataaccess.CustomerDAO;
import com.chelseasystems.cs.dataaccess.EmpSaleDAO;
import com.chelseasystems.cs.dataaccess.LayawayDAO;
import com.chelseasystems.cs.dataaccess.LayawayPaymentInfoDAO;
import com.chelseasystems.cs.dataaccess.PaidOutDAO;
import com.chelseasystems.cs.dataaccess.PaymentSummaryDAO;
import com.chelseasystems.cs.dataaccess.PaymentTransactionDAO;
import com.chelseasystems.cs.dataaccess.PosLineItemDetailDAO;
import com.chelseasystems.cs.dataaccess.RedeemableHistDAO;
import com.chelseasystems.cs.dataaccess.RedeemableIssueDAO;
import com.chelseasystems.cs.dataaccess.SalesSummaryDAO;
import com.chelseasystems.cs.dataaccess.TransactionDAO;
import com.chelseasystems.cs.dataaccess.TransactionHeaderDAO;
import com.chelseasystems.cs.dataaccess.TransferOutDAO;
import com.chelseasystems.cs.dataaccess.TxnTypeSummaryDAO;
import com.chelseasystems.cs.dataaccess.VArmTxnHdrDAO;
import com.chelseasystems.cs.dataaccess.VoidTransactionDAO;
import com.chelseasystems.cs.dataaccess.ArmStgFiscalDocDAO;
import com.chelseasystems.cs.dataaccess.ArmStgTxnDtlDAO;
import com.chelseasystems.cs.dataaccess.LoyaltyDAO;
import com.chelseasystems.cs.discount.RewardDiscount;
import com.chelseasystems.cs.item.CMSItem;
import com.chelseasystems.cs.layaway.CMSLayaway;
import com.chelseasystems.cs.payment.CMSDueBill;
import com.chelseasystems.cs.payment.CMSDueBillIssue;
import com.chelseasystems.cs.payment.CMSRedeemable;
import com.chelseasystems.cs.payment.CMSStoreValueCard;
import com.chelseasystems.cs.payment.Credit;
import com.chelseasystems.cs.xml.PaymentTransactionXML;
import com.chelseasystems.cs.loyalty.*;
import com.chelseasystems.cs.dataaccess.artsoracle.dao.ArmCustSaleSummaryOracleDAO;
import com.chelseasystems.cs.dataaccess.artsoracle.dao.ArmStgTxnDtlOracleDAO;
import com.chelseasystems.cs.dataaccess.artsoracle.dao.ArmStgTxnHdrOracleDAO;
import com.chelseasystems.cs.dataaccess.artsoracle.dao.CompositeOracleDAO;
import com.chelseasystems.cs.dataaccess.artsoracle.dao.PaymentTransactionOracleDAO;
import com.chelseasystems.cs.dataaccess.artsoracle.dao.PosLineItemOracleDAO;
import com.chelseasystems.cs.dataaccess.artsoracle.databean.ArmCustDepositHistOracleBean;
import com.chelseasystems.cs.customer.DepositHistory;
import com.chelseasystems.cs.fiscaldocument.FiscalDocumentNumber;
import com.chelseasystems.cs.dataaccess.ArmFiscalDocNoDAO;
import com.chelseasystems.cs.dataaccess.ArmFiscalDocumentDAO;
import com.chelseasystems.cs.fiscaldocument.FiscalDocument;
import com.chelseasystems.cs.paidout.CMSMiscPaidOut;
import com.chelseasystems.cs.pos.CMSCompositePOSTransaction;
import com.chelseasystems.cs.pos.CMSTransactionPOSJDBCServices;
import com.chelseasystems.cs.dataaccess.artsoracle.databean.ArmStgTxnHdrOracleBean;
import com.chelseasystems.cs.dataaccess.ArmItmSohDAO;
import com.chelseasystems.cs.dataaccess.artsoracle.databean.TrTrnOracleBean;


/**
 * put your documentation comment here
 */
public class CMSTransactionPosterJDBCServices extends CMSTransactionPOSJDBCServices {
	private static CMSTransactionPosterJDBCServices current = null;
	public CMSTransactionPosterJDBCServices()
    {
    }

    public static TransactionPOSServices getCurrent()
    {
        return current;
    }

    public static void setCurrent(CMSTransactionPosterJDBCServices svcs)
    {
        current = svcs;
    }
    public boolean submitBroken(PaymentTransaction paymentTransaction)
	  throws java.lang.Exception {
		System.out.println("CMSTransacionPOSJDBCServicesEx submitBroken");
		Thread.dumpStack();
	paymentTransaction.doSetPostDate(new java.util.Date());
	if (paymentTransaction instanceof CMSCompositePOSTransaction) {
	  FiscalDocument fiscalDocument = ((CMSCompositePOSTransaction)paymentTransaction).
	      getCurrFiscalDocument();
	  if (fiscalDocument != null)return submitFiscalDocument(fiscalDocument);
	}

	writeXMLToFile(paymentTransaction);
	try {
	  //long startTime = System.currentTimeMillis();
	  updateOfflinePayment(paymentTransaction);
	  List statements = new ArrayList();
	  statements.addAll(Arrays.asList(persistCustomer(paymentTransaction)));
	  statements.addAll(Arrays.asList(persistTransaction(paymentTransaction)));
//	  statements.addAll(Arrays.asList(persistNewReservation(paymentTransaction)));
	  statements.addAll(Arrays.asList(updateRedeemableIssued(paymentTransaction)));
	  statements.addAll(Arrays.asList(persistNewLayaway(paymentTransaction)));
	  statements.addAll(Arrays.asList(persistRedeemable(paymentTransaction)));
	  statements.addAll(Arrays.asList(persistNewDueBillIssue(paymentTransaction)));
	  statements.addAll(Arrays.asList(addLayawayPaymentTransaction(paymentTransaction)));
	  statements.addAll(Arrays.asList(updateLayawayForRTS(paymentTransaction)));
	  statements.addAll(Arrays.asList(undoForVoidTransaciton(paymentTransaction)));
	  statements.addAll(Arrays.asList(addToEmployeeSale(paymentTransaction)));
	  statements.addAll(Arrays.asList(updateRewardCards(paymentTransaction)));
	  statements.addAll(Arrays.asList(persistCustDepositHistory(paymentTransaction)));
	  statements.addAll(Arrays.asList(persistCustCreditHistory(paymentTransaction)));

	  statements.addAll(Arrays.asList(armStgTxnHdrDAO.getStgTxnHeaderInsertSQL(paymentTransaction)));
	  if (paymentTransaction instanceof CMSCompositePOSTransaction) {
	    CMSCompositePOSTransaction newRsvOpenTxn = ((CMSCompositePOSTransaction)paymentTransaction).
	        getNewReservationOpenTxn();
	    if (newRsvOpenTxn != null) {
	      statements.addAll(Arrays.asList(armStgTxnHdrDAO.getStgTxnHeaderInsertSQL((newRsvOpenTxn))));
	    }
	  }
	  transactionDAO.execute((ParametricStatement[])statements.toArray(new ParametricStatement[0]));
	  //System.out.println("Time to presist transaction " + paymentTransaction.getId() + ": " + (System.currentTimeMillis() - startTime) + "ms");
	  return true;
	} catch (Exception exception) {
	  LoggingServices.getCurrent().logMsg(this.getClass().getName(), "submit", "Exception"
	      , "See Exception", LoggingServices.MAJOR, exception);
	  exception.printStackTrace();
	  if(exception instanceof CMSSQLException){
		  throw exception; 
	  }else{
		return false;  
	  }
	  
	} catch (Throwable throwable) {
	  LoggingServices.getCurrent().logMsg(this.getClass().getName(), "submit", "Throwable"
	      , "See Exception", LoggingServices.MAJOR, new Exception(throwable.getMessage()));
	  return false;
	}
	}
    
    private Boolean WRITE_TXN_TO_XML = null;

    /**
     *
     * @param paymentTransaction PaymentTransaction
     */
    private void writeXMLToFile(PaymentTransaction paymentTransaction) {
      if (!(paymentTransaction instanceof CompositePOSTransaction))
        return;
      try {
        if (WRITE_TXN_TO_XML == null)
          WRITE_TXN_TO_XML = new Boolean(new ConfigMgr("pos.cfg").getString("WRITE_TXN_TO_XML"));
      } catch (Exception exp) {
        System.out.println("Exception --> " + exp);
        exp.printStackTrace();
        WRITE_TXN_TO_XML = Boolean.FALSE;
      }
      if (!WRITE_TXN_TO_XML.booleanValue())
        return;
      try {
        char[] array = paymentTransaction.getId().toCharArray();
        StringBuffer sb = new StringBuffer(10);
        for (int i = 0; i < array.length; i++)
          if (Character.isDigit(array[i]))
            sb.append(array[i]);
        String fileName = FileMgr.getLocalFile("tmp", "TXN" + sb + ".xml");
        new PaymentTransactionXML().writToFile(fileName, paymentTransaction);
      } catch (Exception exception) {
        LoggingServices.getCurrent().logMsg(this.getClass().getName(), "writeXMLToFile", "Exception"
            , "See Exception", LoggingServices.MAJOR, exception);
        exception.printStackTrace();
      }
    }


}


