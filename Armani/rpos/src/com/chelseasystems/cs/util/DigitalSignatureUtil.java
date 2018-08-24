package com.chelseasystems.cs.util;

/**
 * Created by Satin. 
 * This class creates a message used for creating digital signature. 
 * Then it executes two commands to create digital signature.
 * 
 */


import com.chelseasystems.cr.config.*;
import com.chelseasystems.cr.currency.ArmCurrency;
import com.chelseasystems.cr.logging.*;
import com.chelseasystems.cr.pos.*;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.*;

import com.chelseasystems.cs.collection.CMSMiscCollection;
import com.chelseasystems.cs.pos.CMSCompositePOSTransaction;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.io.*;
import java.nio.channels.*;

public class DigitalSignatureUtil {
	

	public DigitalSignatureUtil() {
	  }
	
	public static String createMessageAndDigitalSignature(PaymentTransaction txn, String previousSignature) throws Exception{
		String previousDigitalSignature = previousSignature;
		ConfigMgr cfgMgr = new ConfigMgr("payment.cfg");
		String activateDigitalSignature = cfgMgr.getString("ACTIVATE_DIGITAL_SIGNATURE");
		
		if (((CMSCompositePOSTransaction)txn) instanceof CMSCompositePOSTransaction){
			CMSCompositePOSTransaction theTxnPOS = ((CMSCompositePOSTransaction) txn);
			String totalAmount = theTxnPOS.getCompositeTotalAmountDue().toString();
			 String[] splittedString = totalAmount.split("->");
			 String grossTotal = splittedString[1];
			 			 
			 DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			 String d = df.format(theTxnPOS.getCreateDate());
			 
			 //RICCARDINO MODIFICA METTO IL CREATE DATE 
			 //Date date = new Date();
			 DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 String e= df1.format(theTxnPOS.getCreateDate());
			 e= e.replace(" ", "T");
			 DateFormat df2 = new SimpleDateFormat("yyyy");
			 String f = df2.format(theTxnPOS.getCreateDate());
			 
			 
			 //String fsclReceiptNumber = ((CMSCompositePOSTransaction)txn).getFiscalReceiptNumber();
			 //String fsclReceiptNumber = fiscalInterface.getDocumentResponse().getDocumentNumber();
			 String fsclReceiptNumber = theTxnPOS.getId();
			 
		 
			 String finalMessageString;
			 if (previousDigitalSignature != null){
				 finalMessageString = d.concat(";").concat(e).concat(";").concat(fsclReceiptNumber).concat(";").concat(grossTotal).concat(";").concat(previousDigitalSignature);
			 }
			 else 
			 finalMessageString = d.concat(";").concat(e).concat(";").concat(fsclReceiptNumber).concat(";").concat(grossTotal);


	 
			 Writer output = null;
			 String messageFile=cfgMgr.getString("MESSAGE_FILE");
			 File file = new File(messageFile);
			  
			  try {
				output = new BufferedWriter(new FileWriter(file));
				output.write(finalMessageString);
				output.close();
			} catch (IOException e1) {
				e1.printStackTrace();
				LoggingServices.getCurrent().logMsg("Message from DigitalSignatureUtil.java :IOException in creating the Message.txt file");
				LoggingServices.getCurrent().logMsg(DigitalSignatureUtil.class.getName(), "start", "Exception"
				          , "See Exception", LoggingServices.MAJOR, e1);
				}
		}
		// End of message creation
		
		
		
		String digitalSignature;
			
            /* These are the commands that we need to execute
             *  from the directory "C:\OpenSSL-Win32\bin" directory 
             */
			String folderPath = cfgMgr.getString("FOLDER_PATH");
			File directory1 = new File(folderPath);
			String cmd1 = cfgMgr.getString("COMMAND1");
        	String cmd2 = cfgMgr.getString("COMMAND2");

        	Process p = Runtime.getRuntime().exec(cmd1, null, directory1);
        	try {
				p.waitFor();
			} catch (InterruptedException e1) {
				e1.printStackTrace();
				// Added by Satin to update the log
				LoggingServices.getCurrent().logMsg("ERROR in DigitalSignatureUtil.java : Interrupted Exception. Command not executed sucessfully.");
				LoggingServices.getCurrent().logMsg(DigitalSignatureUtil.class.getName(), "start", "Exception"
				          , "See Exception", LoggingServices.MAJOR, e1);
				}
        	int exitcode = p.exitValue();
        	if (exitcode == 0){System.out.println("****----Record1.sha1 sucessfully created----****");}
        	else{
        		LoggingServices.getCurrent().logMsg("Message from DigitalSignatureUtil.java : failure in generating Record1.sha1");
        	}
        		
        	
        	if (exitcode==0){
        		Process p1 = Runtime.getRuntime().exec(cmd2, null, directory1);
        		p1.waitFor();
        	}
     	
        	// This is to read the Record1.b64 file which stores the digital signature.
        	// This digital signature will be stored in TR_RTL table.
        	String b64FilePath=cfgMgr.getString("B64_FILE_PATH");
        	File f = new File(b64FilePath);
        	FileInputStream fis1 = new FileInputStream(f);
            DataInputStream dis = new DataInputStream(fis1);
            byte[] keyBytes = new byte[(int) f.length()];
            dis.readFully(keyBytes);
            dis.close();

            digitalSignature = new String(keyBytes);
          // End of block for creation of digital signature
            
            return(digitalSignature);
            
	}
//Vivek Mishra : Merged updated code from source provided by Sergio 19-MAY-16
	public static String createNewMessageAndDigitalSignature(PaymentTransaction txn, String previousSignature, String fsclReceiptNumber ) throws Exception{
		String previousDigitalSignature = previousSignature;
		ConfigMgr cfgMgr = new ConfigMgr("payment.cfg");
		String activateDigitalSignature = cfgMgr.getString("ACTIVATE_DIGITAL_SIGNATURE");
		
		/*   if (txn instanceof CmsCollectionCredit) {
							    txnId = ((CMSMiscCollection)txn).getId();
						   }
		 * */
		
		
		if (((CMSCompositePOSTransaction)txn) instanceof CMSCompositePOSTransaction){
			CMSCompositePOSTransaction theTxnPOS = ((CMSCompositePOSTransaction) txn);
			String totalAmount = theTxnPOS.getCompositeTotalAmountDue().toString();
			 String[] splittedString = totalAmount.split("->");
			 String grossTotal = splittedString[1];
			 String totalAmt = theTxnPOS.getSaleRetailAmount().formattedStringValue().substring(1,theTxnPOS.getSaleRetailAmount().formattedStringValue().length());
			 grossTotal = grossTotal.replace('-', ' ');
			 grossTotal = grossTotal.trim();
			 
			 float numero = Float.parseFloat(grossTotal);
			 numero = Math.abs(numero);
			 
			 String tot = String.format("%.2f", numero);

			 tot = tot.replace("," , ".");
			 
			// int lastindex = grossTotal.lastIndexOf(".");
			 
			 
			
				 
				 
			 DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			 String d = df.format(theTxnPOS.getCreateDate());
			 
			//RICCARDINO MODIFICA METTO IL CREATE DATE 
			 //Date date = new Date();
			 Date date = new Date();
			 DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 String e= df1.format(theTxnPOS.getCreateDate());
			 e= e.replace(" ", "T");
			 DateFormat df2 = new SimpleDateFormat("yyyy");
			 String f = df2.format(theTxnPOS.getCreateDate());
			 
			 
			 //String fsclReceiptNumber = ((CMSCompositePOSTransaction)txn).getFiscalReceiptNumber();
			 //String fsclReceiptNumber = fiscalInterface.getDocumentResponse().getDocumentNumber();
			 
						 
			 //grossTotal
			 
			 String finalMessageString;
			 if (previousDigitalSignature != null){
				 finalMessageString = d.concat(";").concat(e).concat(";").concat(fsclReceiptNumber).concat(";").concat(tot).concat(";").concat(previousDigitalSignature);
			 }
			 else 
			 finalMessageString = d.concat(";").concat(e).concat(";").concat(fsclReceiptNumber).concat(";").concat(tot).concat(";");


	 
			 Writer output = null;
			 String messageFile=cfgMgr.getString("MESSAGE_FILE");
			 File file = new File(messageFile);
			  
			  try {
				output = new BufferedWriter(new FileWriter(file));
				output.write(finalMessageString);
				output.close();
			} catch (IOException e1) {
				e1.printStackTrace();
				LoggingServices.getCurrent().logMsg("Message from DigitalSignatureUtil.java :IOException in creating the Message.txt file");
				LoggingServices.getCurrent().logMsg(DigitalSignatureUtil.class.getName(), "start", "Exception"
				          , "See Exception", LoggingServices.MAJOR, e1);
				}
		}
		// End of message creation
		
		
		
		String digitalSignature;
			
            /* These are the commands that we need to execute
             *  from the directory "C:\OpenSSL-Win32\bin" directory 
             */
			String folderPath = cfgMgr.getString("FOLDER_PATH");
			File directory1 = new File(folderPath);
			String cmd1 = cfgMgr.getString("COMMAND1");
        	String cmd2 = cfgMgr.getString("COMMAND2");

        	Process p = Runtime.getRuntime().exec(cmd1, null, directory1);
        	try {
				p.waitFor();
			} catch (InterruptedException e1) {
				e1.printStackTrace();
				// Added by Satin to update the log
				LoggingServices.getCurrent().logMsg("ERROR in DigitalSignatureUtil.java : Interrupted Exception. Command not executed sucessfully.");
				LoggingServices.getCurrent().logMsg(DigitalSignatureUtil.class.getName(), "start", "Exception"
				          , "See Exception", LoggingServices.MAJOR, e1);
				}
        	int exitcode = p.exitValue();
        	if (exitcode == 0){System.out.println("****----Record1.sha1 sucessfully created----****");}
        	else{
        		LoggingServices.getCurrent().logMsg("Message from DigitalSignatureUtil.java : failure in generating Record1.sha1");
        	}
        		
        	
        	if (exitcode==0){
        		Process p1 = Runtime.getRuntime().exec(cmd2, null, directory1);
        		p1.waitFor();
        	}
     	
        	// This is to read the Record1.b64 file which stores the digital signature.
        	// This digital signature will be stored in TR_RTL table.
        	String b64FilePath=cfgMgr.getString("B64_FILE_PATH");
        	File f = new File(b64FilePath);
        	FileInputStream fis1 = new FileInputStream(f);
            DataInputStream dis = new DataInputStream(fis1);
            byte[] keyBytes = new byte[(int) f.length()];
            dis.readFully(keyBytes);
            dis.close();

            digitalSignature = new String(keyBytes);
          // End of block for creation of digital signature
            
            return(digitalSignature);
            
	}	
	
	//Ends here
	
}
