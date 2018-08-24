/*
 * put your module comment here
 * formatted with JxBeauty (c) johann.langhofer@nextra.at
 */


package com.chelseasystems.cs.txnposter;

import com.chelseasystems.cs.txnposter.CMSSalesSummary;
import com.chelseasystems.cr.currency.ArmCurrency;
import com.chelseasystems.cr.currency.CurrencyException;


/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
public class ArmSalesSummary extends CMSSalesSummary {
  private ArmCurrency saleMarkdownAmt;
  private ArmCurrency returnMarkdownAmt;
  private ArmCurrency netSaleAmt;
  private ArmCurrency netReturnAmt;
  private int saleQty;
  private int returnQty;
  private String grpDivision;
  private String barCode;

  /**
   * put your documentation comment here
   */
  public ArmSalesSummary() {
  }

  /**
   * put your documentation comment here
   * @return
   */
  public ArmCurrency getSaleMarkdownAmt() {
    return this.saleMarkdownAmt;
  }

  /**
   * put your documentation comment here
   * @param saleMarkdownAmt
   */
  public void setSaleMarkdownAmt(ArmCurrency saleMarkdownAmt) {
    doSetSaleMarkdownAmt(saleMarkdownAmt);
  }

  /**
   * put your documentation comment here
   * @param saleMarkdownAmt
   */
  public void doSetSaleMarkdownAmt(ArmCurrency saleMarkdownAmt) {
    this.saleMarkdownAmt = saleMarkdownAmt;
  }

  /**
   * put your documentation comment here
   * @return
   */
  public ArmCurrency getReturnMarkdownAmt() {
    return this.returnMarkdownAmt;
  }

  /**
   * put your documentation comment here
   * @param rtnMarkdownAmt
   */
  public void setReturnMarkdownAmt(ArmCurrency rtnMarkdownAmt) {
    doSetReturnMarkdownAmt(rtnMarkdownAmt);
  }

  /**
   * put your documentation comment here
   * @param rtnMarkdownAmt
   */
  public void doSetReturnMarkdownAmt(ArmCurrency rtnMarkdownAmt) {
    this.returnMarkdownAmt = rtnMarkdownAmt;
  }

  /**
   * put your documentation comment here
   * @return
   */
  public ArmCurrency getNetSaleAmt() {
    return this.netSaleAmt;
  }

  /**
   * put your documentation comment here
   * @return
   */
  public ArmCurrency getGrossSaleAmt() {
    try {
      return this.netSaleAmt.add(this.saleMarkdownAmt);
    } catch (CurrencyException e) {
      return new ArmCurrency(0.0d);
    }
  }

  /**
   * put your documentation comment here
   * @param saleAmt
   */
  public void setNetSaleAmt(ArmCurrency saleAmt) {
    doSetNetSaleAmt(saleAmt);
  }

  /**
   * put your documentation comment here
   * @param saleAmt
   */
  public void doSetNetSaleAmt(ArmCurrency saleAmt) {
    this.netSaleAmt = saleAmt;
  }

  /**
   * put your documentation comment here
   * @return
   */
  public ArmCurrency getNetReturnAmt() {
    return this.netReturnAmt;
  }

  /**
   * put your documentation comment here
   * @return
   */
  public ArmCurrency getGrossReturnAmt() {
    try {
      return this.netReturnAmt.add(this.returnMarkdownAmt);
    } catch (CurrencyException e) {
      return new ArmCurrency(0.0d);
    }
  }

  /**
   * put your documentation comment here
   * @param rtnAmt
   */
  public void setNetReturnAmt(ArmCurrency rtnAmt) {
    doSetNetReturnAmt(rtnAmt);
  }

  /**
   * put your documentation comment here
   * @param rtnAmt
   */
  public void doSetNetReturnAmt(ArmCurrency rtnAmt) {
    this.netReturnAmt = rtnAmt;
  }

  /**
   * put your documentation comment here
   * @return
   */
  public ArmCurrency getTotalAmount() {
    try {
      return this.getNetSaleAmt().add(this.getNetReturnAmt());
    } catch (CurrencyException ce) {
      return new ArmCurrency(0.0d);
    }
  }

  /**
   * put your documentation comment here
   * @return
   */
  public Long getTotalQuantity() {
    return new Long(this.saleQty + this.returnQty);
  }

  /**
   * put your documentation comment here
   * @return
   */
  public int getSaleQty() {
    return this.saleQty;
  }

  /**
   * put your documentation comment here
   * @param qty
   */
  public void setSaleQty(int qty) {
    doSetSaleQty(qty);
  }

  /**
   * put your documentation comment here
   * @param qty
   */
  public void doSetSaleQty(int qty) {
    this.saleQty = qty;
  }

  /**
   * put your documentation comment here
   * @return
   */
  public int getReturnQty() {
    return this.returnQty;
  }

  /**
   * put your documentation comment here
   * @param qty
   */
  public void setReturnQty(int qty) {
    doSetReturnQty(qty);
  }

  /**
   * put your documentation comment here
   * @param qty
   */
  public void doSetReturnQty(int qty) {
    this.returnQty = qty;
  }

  /**
   * put your documentation comment here
   * @param div
   */
  public void setGrpDiv(String div) {
    doSetGrpDiv(div);
  }

  /**
   * put your documentation comment here
   * @param div
   */
  public void doSetGrpDiv(String div) {
    this.grpDivision = div;
  }

  /**
   * put your documentation comment here
   * @return
   */
  public String getGrpDiv() {
    return this.grpDivision;
  }

  /**
   * put your documentation comment here
   * @param barCode
   */
  public void setBarCode(String barCode) {
    doSetBarCode(barCode);
  }

  /**
   * put your documentation comment here
   * @param barCode
   */
  public void doSetBarCode(String barCode) {
    this.barCode = barCode;
  }

  /**
   * put your documentation comment here
   * @return
   */
  public String getBarCode() {
    return this.barCode;
  }
}

