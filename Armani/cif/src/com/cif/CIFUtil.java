package com.cif;

/**
 * This class contains utility methods
 */
public class CIFUtil {

	// Cannot instantiate
	private CIFUtil() {
		// Nothing to do;
	}

	/**
	 * Get integer from String.  If invalid string, return default.
	 * @param String stringValue that needs conversion
	 * @param int defaultInt default value to be returned
	 */
	public static int getInt(String stringValue, int defaultInt) {
		if (stringValue == null || stringValue.trim().length() == 0) {
			return defaultInt;
		}
		// Try conversion
		try {
			int val = Integer.parseInt(stringValue.trim());

			return val;
		} catch (Exception e) {
			return defaultInt;
		}
	}

}
