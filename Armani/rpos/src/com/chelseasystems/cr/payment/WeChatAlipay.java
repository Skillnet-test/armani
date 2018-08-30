package com.chelseasystems.cr.payment;

/**
 *  WECHAT_ALIPAY support in POS
 *  @author Trunal Gawade 
 */
public class WeChatAlipay extends Payment {
	private static final long serialVersionUID = 1L;
	String cardNumber;
	public static String holderName = "Mobile";
	public static String tender = "WECHAT_ALIPAY";
	
	public WeChatAlipay() {
	    
	}
	
	/**
	 * 
	 * @param transactionPaymentName
	 */
	public WeChatAlipay(String transactionPaymentName) {
		super(transactionPaymentName);
		setGUIPaymentName("WECHAT_ALIPAY");
	}
	
	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	/**
	 * 
	 * @param barCode
	 * @return
	 */
	public static boolean isBarcodeAlphabetic(String barCode) {
	  char[] barCodeArray = barCode.toCharArray();
	  for(int i = 0; i < barCode.length(); i++) {
		  if(Character.isLetter(barCodeArray[i])) {
			  return true;
		  }
	  }
	  return false;
	 }
	
	@Override
	public boolean isAuthRequired() {
		return false;
	}

	@Override
	public boolean isSignatureRequired() {
		return false;
	}

	@Override
	public boolean isOverPaymentAllowed() {
		return false;
	}

	@Override
	public boolean isFrankingRequired() {
		return false;
	}
}
