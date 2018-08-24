package com.chelseasystems.cs.rules.customer;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ResourceBundle;

import com.chelseasystems.cr.logging.LoggingServices;
import com.chelseasystems.cr.rules.Rule;
import com.chelseasystems.cr.rules.RulesInfo;
import com.chelseasystems.cr.util.ResourceManager;
import com.chelseasystems.cs.customer.CMSCustomer;

public class CustomerPassportNoIsValid extends Rule {

	public CustomerPassportNoIsValid(){
		
	}
	 public RulesInfo execute(Object theParent, Object args[]) {
		    return (execute((CMSCustomer)theParent, (String)args[0]));
		  }
	 
	 private RulesInfo execute(CMSCustomer cmscustomer, String string) {
		    if (string != null && string.length() > 0) {
		    	 if(string.contains("12"))
		             return new RulesInfo("Customer Passport number is not valid.");
		    }
		    return (new RulesInfo());
		  }
	 
	 public String getName() {
		    return "PassportNoIsValid";
		  }
 
		  /**
		   * put your documentation comment here
		   * @return
		   */
		  public String getDesc() {
		    return "Passport No must be valid.";
		  }
}
