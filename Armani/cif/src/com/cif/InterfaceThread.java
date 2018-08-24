package com.cif;
/**
 * Interface thread executes the interface scripts, responds to commands from
 * admin thread
 */

import java.util.Hashtable;
import java.util.Vector;
import java.util.ResourceBundle;
import java.util.Properties;
import java.util.Date;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.io.File;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

public class InterfaceThread implements Runnable {
	// Constants
	public static final int STATE_INITING = 0;
	public static final int STATE_RUNNING = 1;
	public static final int STATE_STOPPING = 2;
	public static final int STATE_SUSPENDED = 3;
	public static final int STATE_SLEEPING = 4;

	public static final String[] STATE_LABELS = {
		"Initing",
		"Running",
		"Stopping",
		"Suspended",
		"Sleeping"
	};

	public static final int NUM_STATES = 5;

	//
	public static final int NEXT_STATE_INVALID_INPUT = -1;
	public static final int NEXT_STATE_NO_CHANGE = 0;
	public static final int NEXT_STATE_SKIP = 1;
	public static final int NEXT_STATE_STOP = 2;
	public static final int NEXT_STATE_SUSPEND = 3;
	public static final int NEXT_STATE_RESUME = 4;

	public static final String[] NEXT_STATE_LABELS = {
		"None",
		"Will Skip",
		"Will Stop",
		"Will Suspend",
		"Will Resume"
	};

	//
	public static final int COMMAND_NONE = 0;
	public static final int COMMAND_SKIP = 1;
	public static final int COMMAND_STOP = 2;
	public static final int COMMAND_SUSPEND = 3;
	public static final int COMMAND_RESUME = 4;

	public static final String[] COMMAND_LABELS = {
		"None",
		"SKIP",
		"STOP",
		"SUSPEND",
		"RESUME"
	};

	public static final int NUM_COMMANDS = 5;

	//
	private static final int[][] STATE_MACHINE = {
		// Initing = 0
		{NEXT_STATE_INVALID_INPUT, NEXT_STATE_SKIP, NEXT_STATE_STOP, NEXT_STATE_SUSPEND, NEXT_STATE_NO_CHANGE},
		// Running = 1
		{NEXT_STATE_INVALID_INPUT, NEXT_STATE_SKIP, NEXT_STATE_STOP, NEXT_STATE_SUSPEND, NEXT_STATE_NO_CHANGE},
		// Stopping = 2
		{NEXT_STATE_INVALID_INPUT, NEXT_STATE_STOP, NEXT_STATE_STOP, NEXT_STATE_STOP, NEXT_STATE_STOP},
		// Suspended = 3
		{NEXT_STATE_INVALID_INPUT, NEXT_STATE_NO_CHANGE, NEXT_STATE_STOP, NEXT_STATE_NO_CHANGE, NEXT_STATE_RESUME},
		// Sleeping = 4
		{NEXT_STATE_INVALID_INPUT, NEXT_STATE_SKIP, NEXT_STATE_STOP, NEXT_STATE_SUSPEND, NEXT_STATE_RESUME}
	};

	//
	public static final String IFX_THREAD_CONFIG_NAME = "threadconfig";

	// Class members
	private static Hashtable ifxThreads = new Hashtable();

	// Instance members
	private String threadName = null;
	private int skipCounter = 0;
	private Date lastSkipTimestamp = null;
	private int processCounter = 0;
	private Date lastProcessDoneTimestamp = null;
	private Date thisProcessStartTimestamp = null;
	private int cycleCounter = 0;
	private Properties props = null;

	// State related members
	private int currentState = 0;
	private int nextState = 0;

	private int lastCommand = 0;
	private Date lastCommandExecuted = null;

	/*
	 * Send email that contains error
	 */
	private void sendEmail(String message) {
          try {
            String smtpAddr = props.getProperty("SMTP_ADDRESS");
            String smtpPort = props.getProperty("SMTP_PORT");
            String emailId = props.getProperty(threadName + "." + "ON_ERROR");
            String from = props.getProperty("EMAIL_FROM");
            emailId = emailId.substring(8);
            String subject = "Error processing data feed " + threadName;

            CIFLogger.getInstance().logInfo("Sending email to: " + emailId);

            //Set the host smtp address
            Properties props = new Properties();
            props.put("mail.smtp.host", smtpAddr);
            props.put("mail.smtp.port", smtpPort);

          // create some properties and get the default Session
            Session session = Session.getDefaultInstance(props, null);

            // create a message
            Message msg = new MimeMessage(session);

          // set the from and to address
            InternetAddress addressFrom = new InternetAddress(from);
            msg.setFrom(addressFrom);
            InternetAddress addressTo = new InternetAddress(emailId);
            msg.addRecipient(Message.RecipientType.TO, addressTo);

            // Setting the Subject and Content Type
            msg.setSubject(subject);
            msg.setContent(message, "text/plain");
            Transport.send(msg);
          } catch (Exception e) {
            CIFLogger.getInstance().logError("Process " + threadName
                                             + " email error: " + e.getMessage());
          }
	}

	/*
	 * invokeInterface:
	 * Invoke interface.  If error returned, log error and take ON_ERROR action.
	 */
	private void invokeInterface() {
          // Make sure that we have a file to process, else do nothing
          File dirIn = null, dirOut = null;
          String inbound = "", processed = "";
          String[] datFiles = null;
          String user1 = "", user2 = "", pwd1 = "", pwd2 = "", db1 = "", db2 = "";
          SimpleDateFormat sdf = null;

          try {
            dirIn = new File(threadName + File.separator +
                           props.getProperty("INBOUND_DATA_DIRECTORY"));
            dirOut = new File(threadName + File.separator +
                           props.getProperty("PROCESSED_DIRECTORY"));
            CIFFilenameFilter filter = new CIFFilenameFilter(props.getProperty(
                                           threadName + ".FILENAME_PATTERN"));
            datFiles = dirIn.list(filter);
            user1 = props.getProperty("ORACLE_EXT_USER");
            pwd1 = props.getProperty("ORACLE_EXT_PWD");
            db1 = props.getProperty("ORACLE_EXT_DBNAME");
            user2 = props.getProperty("ORACLE_BASE_USER");
            pwd2 = props.getProperty("ORACLE_BASE_PWD");
            db2 = props.getProperty("ORACLE_BASE_DBNAME");
          }
          catch (Exception exp) {
            CIFLogger.getInstance().logError("Interface directory does not exist" +
                                             threadName + exp.getMessage());
          }

          // iterate through dat file list
          for (int i=0; i<datFiles.length; i++) {
            CIFLogger.getInstance().logInfo(threadName + " InvokeInterface()");
            thisProcessStartTimestamp = new Date();
            String ifxProcess = props.getProperty(threadName + "." + "PROCESS_NAME");
            String datFile = dirIn.getAbsolutePath() + File.separator + datFiles[i];

            try {
              sdf = new SimpleDateFormat("yyyyMMddHH:mm:ss");
              CIFLogger.getInstance().logInfo("Executing process -- " + threadName
                                + File.separator + ifxProcess + " "
                                + user1 + " "
                                + pwd1 + " "
                                + db1 + " "
                                + datFile + " "
                                + user2 + " "
                                + pwd2 + " "
                                + db2 + " "
                                + sdf.format(new Date()));

              Process process = Runtime.getRuntime().exec(threadName
                                + File.separator + ifxProcess + " "
                                + user1 + " "
                                + pwd1 + " "
                                + db1 + " "
                                + datFile + " "
                                + user2 + " "
                                + pwd2 + " "
                                + db2 + " "
                                + sdf.format(new Date()));
              process.waitFor();
              int exitValue = process.exitValue();
              if (exitValue != 0) {
                sendEmail("\nProcess File : " + ifxProcess
                          + "\nData File : " + datFile
                          + "\nExit Code : " + exitValue
                          + "\n\n For more information please refer to ARM_PROCESS_LOG table");
              }
              // move files to processed dir either way
              File fin = new File(datFile);
              File fout = new File(dirOut.getAbsolutePath() + File.separator + datFiles[i]);
              if (fout.exists()) {
                sdf = new SimpleDateFormat("yyyy_MM_dd_HHmmss");
                fin.renameTo(new File(dirOut.getAbsolutePath() + File.separator
                             + datFiles[i] + "_" + sdf.format(new Date())));
              } else {
                fin.renameTo(new File(dirOut.getAbsolutePath() + File.separator + datFiles[i]));
              }
              CIFLogger.getInstance().logInfo("Exit of " + threadName +
                                              " interface is: " + exitValue);
            }
            catch (Exception e) {
              CIFLogger.getInstance().logError("Process " + threadName +
                                               " interface error: " + e.getMessage());
            }
            processCounter++;
            lastProcessDoneTimestamp = new Date();
          }
          return;
	}

	/*
	 * invokeSleep:
	 * Sleep for configured amount of time
	 */
	private void invokeSleep() {
		CIFLogger.getInstance().logInfo(threadName + " InvokeSleep()");
		String interval = props.getProperty(threadName + "." + "SLEEP_INTERVAL");
		try {
			Thread.sleep(CIFUtil.getInt(interval, 60)*1000);
		} catch (Exception e) {
			CIFLogger.getInstance().logError("From Sleep: " + e.getMessage());
		}
		return;
	}

	/*
	 * invokeStop:
	 * Perform cleanup if required and go back
	 */
	private void invokeStop() {
		CIFLogger.getInstance().logInfo(threadName + " InvokeStop()");
		try {
			CIFManager.getInstance("CIFManager").removeInterfaceThread(threadName);
		} catch (Exception e) {
			//
			CIFLogger.getInstance().logError(threadName +
											" during stop: " + e.getMessage());
		}
		return;
	}

	/*
     * protected constructor.
     */
	protected InterfaceThread(String ifxName) throws Exception {
		// Instantiate config
		threadName = ifxName;
		props = CIFManager.getInstance("CIFManager").getProperties();
	}

	/**
     * Method executes command on thread
     * @return int nextstate
     */
	public synchronized int executeCommand(int command)
		throws Exception
	{
		switch (command) {
			case COMMAND_NONE:
			case COMMAND_SKIP:
			case COMMAND_STOP:
			case COMMAND_SUSPEND:
			case COMMAND_RESUME:
				nextState = STATE_MACHINE[currentState][command];
				lastCommand = command;
				lastCommandExecuted = new Date();
				return nextState;
			default:
				return -1;
		}
	}

	/**
	 * Set value for property
	 * Return true if operation was successful, else return false
	 *
  	 * @param propName Name of property
     * @param propValue Value of property
     *
     * @return boolean
	 */
	public boolean setProperty(String propName, String propValue) {
		if (propName == null || propValue == null
			|| propName.trim().length() == 0
			|| propValue.trim().length() == 0)
		{
			return false;
		}

		String value = props.getProperty(threadName + "." + propName);

		// Property must exist
		if (value == null) {
			return false;
		}

		// Set the value
		props.setProperty(threadName + "." + propName, propValue);

		return true;
	}

	/**
	 * Get value for property
	 * Return value if operation was successful, else return null
	 *
  	 * @param propName Name of property
     *
     * @return String
	 */
	public String getProperty(String propName) {
		if (propName == null
			|| propName.trim().length() == 0)
		{
			return null;
		}

		String value = props.getProperty(threadName + "." + propName);

		return value;
	}

	/**
 	 * Run:
	 * Method implements runnable requirement.  It does the work as dictated by
	 * currentState and nextState variables.
	 */
	public void run() {
		CIFManager cifManager = null;
		while(true) {
			if (cycleCounter != 0) {
				if (currentState != STATE_SUSPENDED) {
					currentState = STATE_SLEEPING;
				}
				// Invoke sleep
				invokeSleep();
				// Refresh properties
				try {
					cifManager = CIFManager.getInstance("CIFManager");
				} catch (Exception exp) {
					CIFLogger.getInstance().logUrgent(
						"Something wrong with CIFManager");
					System.exit(5);
				}
				synchronized (cifManager) {
					try {
						props = cifManager.getProperties();
					} catch (Exception e) {
						CIFLogger.getInstance().logDebug(
							"Is something wrong with properties files?");
					}
				}
				CIFLogger.getInstance().logInfo(threadName +
												" Woke up from sleep");
			} else {
				// Pretend thread woke up
				currentState = 4;
				nextState = 0;
			}
			cycleCounter++;
			switch (nextState) {
				case NEXT_STATE_INVALID_INPUT:
					break;
				case NEXT_STATE_NO_CHANGE:
					break;
				case NEXT_STATE_SKIP:
					nextState = NEXT_STATE_NO_CHANGE;
					skipCounter++;
					lastSkipTimestamp = new Date();
					continue;
				case NEXT_STATE_STOP:
					CIFLogger.getInstance().logInfo(
						Thread.currentThread().getName() + " stopping"); //log
					invokeStop();
					return;
				case NEXT_STATE_SUSPEND:
					currentState = STATE_SUSPENDED;
					nextState = NEXT_STATE_NO_CHANGE;
					break;
				case NEXT_STATE_RESUME:
					currentState = STATE_SLEEPING;
					nextState = NEXT_STATE_NO_CHANGE;
					break;
				default:
					CIFLogger.getInstance().logError("Bad next state:\n" + this);
					currentState = STATE_SLEEPING;
					nextState = NEXT_STATE_NO_CHANGE;
					continue;
			}

			// Take action depending on the current state
			switch (currentState) {
				case STATE_SUSPENDED:
					break;
				case STATE_SLEEPING:
					currentState = STATE_RUNNING;
					// Invoke the configured interface
					invokeInterface();
					break;
				default:
					CIFLogger.getInstance().logError("Bad current state:\n" + this);
					currentState = STATE_SLEEPING;
					nextState = NEXT_STATE_NO_CHANGE;
					continue;
			}
		}
	}

	/**
	 * Create string for STATUS commands, etc.
	 */

	public String toString() {
		StringBuffer sb = new StringBuffer();

		sb.append("Interface Name: " + threadName + "\n");
		sb.append("Current State: " + STATE_LABELS[currentState] + "\n");
		sb.append("Next State: " + NEXT_STATE_LABELS[nextState] + "\n");
		sb.append("Process Count: " + processCounter + "\n");
		if (lastProcessDoneTimestamp != null)
			sb.append("Last Processed: " + lastProcessDoneTimestamp + "\n");
		if (currentState == InterfaceThread.STATE_RUNNING) {
			sb.append("Current Process Start: " + thisProcessStartTimestamp + "\n");
		}
		sb.append("Skip Count: " + skipCounter + "\n");
		if (lastSkipTimestamp != null)
			sb.append("Last Skip: " + lastSkipTimestamp + "\n");
		if (lastCommand != 0)
			sb.append("Last Command: " + COMMAND_LABELS[lastCommand] + "\n");
		if (lastCommandExecuted != null)
			sb.append("Last Command Executed: " + lastCommandExecuted + "\n");

		return sb.toString();
	}
}
