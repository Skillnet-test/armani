package com.cif;
/**
 * CIF manager class is a master thread that starts other interface threads.
 * It also refreshes the list of active interfaces and sends appropriate
 * commands to interface threads.
 * Currently the only commands this thread sends to interface threads are
 * - STOP - Do cleanup and return
 * - SKIP - Skip next processing cycle
 * - SUSPEND - Suspend processing till resume is obtained (or a stop) and
 * - RESUME - Resume suspended processing
 * Each of these commands come into effect when the thread wakes up from
 * sleep before the processing starts.
 *
 * This master thread is also starts an admin thread after interface threads
 * are started.  Before starting interface threads, it binds to specified port.
 * If it cannot bind to port, main thread exits with error.
 */

import java.util.Hashtable;
import java.util.Vector;
import java.util.Date;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.Enumeration;
import java.net.*;
import java.io.*;

public class CIFManager implements Runnable {
	// Class members
	private static Hashtable interfaces = null;
	private static CIFManager instance = null;

	// Instance members
	private String name = null;
	private Properties props = null;

	private int adminPort = 0;
	private boolean doNotStop = true;
	private boolean softShutdown = false;

	private ThreadGroup threadGroup = null;


	/**
     * Method constructs Interface thread for given interface OR
     * returns existing thread for the interface
     */
	public static synchronized InterfaceThread getInterfaceThread(String ifxName, boolean create)
		throws Exception
	{
		InterfaceThread ifxThread = (InterfaceThread) interfaces.get(ifxName);

		// if does not exist, create one
		if (ifxThread == null && create) {
			ifxThread = new InterfaceThread(ifxName);
			interfaces.put(ifxName, ifxThread);
		}

		return ifxThread;
	}

	public static synchronized void removeInterfaceThread(String ifxName) {
		interfaces.remove(ifxName);
	}

	/**
	 * Get access to properties file
	 */
	protected Properties getProperties() {
		return props;
	}


	/**
	 * Method implements runnable.  Starting point in the framework.
	 */
	public void run() {
		CIFLogger.getInstance().logInfo("Interfaces: " + interfaces);
		ServerSocket serverSocket = null;
		try {
			CIFLogger.getInstance().logInfo("CIFManager Starting");

			props = CIFResourceBundle.getPropertiesFromBundle(name);

			// Create ServerSocket, do not do accept at this time
			String prop = props.getProperty("ADMIN_PORT");

			adminPort = CIFUtil.getInt(prop, 2345);

			serverSocket = new ServerSocket(adminPort);

			CIFAdminThread adminThread = CIFAdminThread.getInstance(serverSocket);

			Thread at = new Thread(adminThread);

			at.start();
		} catch (Exception excp) {
						CIFLogger.getInstance().logError("CIFManager run-init: "
							+ excp.getMessage());
		}

		// All clear for rest of the threads.
		threadGroup = new ThreadGroup("Interfaces");

		while (doNotStop) {
			// Replace current config
			StringTokenizer st = new StringTokenizer(
									props.getProperty("ACTIVE_INTERFACES"),","
									);
			String ifx = null;
			while (st.hasMoreTokens()) {
				ifx = st.nextToken().trim();
				if (ifx.length() == 0) {
					continue;
				}
				InterfaceThread ifxThread =
					(InterfaceThread)interfaces.get(ifx);
				if (ifxThread == null) {
					try {
						ifxThread = new InterfaceThread(ifx);
						interfaces.put(ifx, ifxThread);
						new Thread(threadGroup, ifxThread, ifx).start();
					} catch (Exception ex) {
						CIFLogger.getInstance().logError("Thread create: "
							+ ifx + " "
							+ ex.getMessage());
					}
				}
			}
			// Check the LOG_LEVEL
			int logLevel = CIFUtil.getInt(props.getProperty("LOG_LEVEL"), 1);
			CIFLogger.getInstance().setLogLevel(logLevel);
			// Get active threads
			CIFLogger.getInstance().logInfo("CIFManager Going to sleep");
			try {
				Thread.sleep(CIFUtil.getInt(props.getProperty("CONFIG_FILE_POLL_INTERVAL"), 20)*1000);
			} catch (Exception exp) {
				CIFLogger.getInstance().logError("Sleep interrupted?: " + exp.getMessage());
			}

			synchronized (this) {
				try {
					props = CIFResourceBundle.getPropertiesFromBundle(name);
				} catch (Exception e) {
					CIFLogger.getInstance().logError("Get resource failed: " + e.getMessage());
				}
			}
		}

		if (softShutdown) {
			// Wait for all interfaces to finish
			CIFLogger.getInstance().logUrgent("Soft shutdown in progress...");

			while(interfaces.size() != 0) {
				CIFLogger.getInstance().logUrgent("Interfaces count is: " + interfaces.size());
				try {
					Thread.sleep(10*1000);
				} catch (Exception e) {
					CIFLogger.getInstance().logError("Shutdown sleep: " + e.getMessage());
				}
			}
			CIFLogger.getInstance().logUrgent("Shutdown complete");
		}
	}

	/*
     * private constructor.  Must be only one for each interface.
     */
	private CIFManager(String name) throws Exception {
		// Instantiate config
		this.name = name;
		interfaces = new Hashtable();
	}

	/**
     * Get list of active interfaces
     * @return String list of active interfaces
     */
	public String getInterfacesList() {
		StringBuffer sb = new StringBuffer();
		Enumeration enm = interfaces.keys();
		boolean first = true;
		while (enm.hasMoreElements()) {
			if (first) {
				first = false;
			} else {
				sb.append(", ");
			}
			sb.append((String)enm.nextElement());
		}
		return sb.toString();
	}

	/**
     * Get list of active interfaces threads
     * @return String list of active interface threads
     */
	public void getInterfaceThreads(PrintStream ps) {
		PrintStream tmpOut = System.out;

		System.setOut(ps);

		threadGroup.list();

		System.setOut(tmpOut);
	}

	/**
     * Mark for graceful shutdown
     */
	protected void shutdown() {
		doNotStop = false;
		softShutdown = true;

		Enumeration enm = interfaces.keys();
		while (enm.hasMoreElements()) {
			InterfaceThread ifxThread = (InterfaceThread)interfaces.get(enm.nextElement());
			try {
				ifxThread.executeCommand(InterfaceThread.COMMAND_STOP);
			} catch (Exception e) {
				CIFLogger.getInstance().logError("Shutdown command: " + e.getMessage());
			}
		}

		return;
	}

	/**
     * Returns admin port
     *
     * @return int Admin port as read from config properties
     */
	protected int getAdminPort() {
		return adminPort;
	}

	/**
     * Method constructs Interface thread for given interface OR
     * returns existing thread for the interface
     *
     * @param name Name of properties file that has configuration
     */
	public static synchronized CIFManager getInstance(String name)
		throws Exception
	{
		// if does not exist, create one
		if (instance == null) {
			instance = new CIFManager(name);
		}

		return instance;
	}

	// Usage:
	private static void usage() {
		System.err.println(
			"Usage: java com.chelseasystems.cs.cif.CIFManager");
	}

	/**
	 * Starting point of application.
	 * Usage: java com.chelseasystems.cs.cif.CIFManager
	 */
	public static void main(String[] args) {
		CIFLogger.getInstance().logInfo("User.dir is " + System.getProperty("user.dir"));
		String workingDir = ".";
		if (args.length != 0) {
			usage();
			System.exit(1);
		}

		// Start manager thread
		try {
			CIFManager cifManager = CIFManager.getInstance("CIFManager");

			Thread t = new Thread(cifManager);

			t.start();

			t.join();
		} catch (Exception e) {
			//Do nothing
			CIFLogger.getInstance().logError(e.getMessage());
		}

		CIFLogger.getInstance().logUrgent("Exiting...");

		System.exit(0);
	}
}
