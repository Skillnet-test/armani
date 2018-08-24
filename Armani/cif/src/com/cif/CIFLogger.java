package com.cif;

/**
 * Logger for CIF
 * Gets the log level from CIFManager.  Also gets the logfile name from
 * CIFManager.
 */

import java.io.*;
import java.util.*;

public class CIFLogger {

	public static final int LOG_LEVEL_INFO = 0;
	public static final int LOG_LEVEL_DEBUG = 1;
	public static final int LOG_LEVEL_ERROR = 2;
	public static final int LOG_LEVEL_URGENT = 3;
	public static final String LOG_FILENAME = "cif.log";

	private static PrintStream ps = null;
	private static CIFLogger instance = null;

	private int logLevel = 0;

	private CIFLogger() {
		try {
			ps = new PrintStream(new FileOutputStream(LOG_FILENAME));
		} catch (Exception e) {
			ps = System.out;
		}
	}

	public static synchronized CIFLogger getInstance() {
		if (instance == null) {
			instance = new CIFLogger();
		}
		return instance;
	}

	public void setLogLevel(int logLevel) {
		if (logLevel < LOG_LEVEL_INFO ||
			logLevel > LOG_LEVEL_URGENT)
		{
			return;
		}
		this.logLevel = logLevel;
	}

	public int getLogLevel() {
		return logLevel;
	}

	/**
	 * Log info
	 */
	public void logInfo(String message) {
		if (logLevel <= LOG_LEVEL_INFO)
			log(LOG_LEVEL_INFO, message);
	}

	/**
	 * Log debug
	 */
	public void logDebug(String message) {
		if (logLevel <= LOG_LEVEL_DEBUG)
			log(LOG_LEVEL_DEBUG, message);
	}

	/**
	 * Log error
	 */
	public void logError(String message) {
		if (logLevel <= LOG_LEVEL_ERROR)
			log(LOG_LEVEL_ERROR, message);
	}

	/**
	 * Log urgent
	 */
	public void logUrgent(String message) {
		if (logLevel <= LOG_LEVEL_URGENT)
			log(LOG_LEVEL_URGENT, message);
	}

	/**
	 * Log message for requested level
	 */
	private void log(int level, String msg) {
		StringBuffer sb = new StringBuffer();

		switch (level) {
			case LOG_LEVEL_INFO:
				sb.append("[INF] ");
				break;
			case LOG_LEVEL_DEBUG:
				sb.append("[DBG] ");
				break;
			case LOG_LEVEL_ERROR:
				sb.append("[ERR] ");
				break;
			case LOG_LEVEL_URGENT:
				sb.append("[URG] ");
				break;
			default:
				sb.append("[???] ");
				break;
		}

		sb.append(new Date() + ": " + msg);

		ps.println(sb.toString());
	}
}
