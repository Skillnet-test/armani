package com.cif;

import java.util.ResourceBundle;
import java.util.PropertyResourceBundle;
import java.util.Properties;
import java.util.Enumeration;

public class CIFResourceBundle {
	private CIFResourceBundle() {
		super();
		// Nothing to do
	}

	/**
	 * Create a properties file from resource bundle
	 * @param bundlename Name of resource bundle
	 * @return Properties If resource bundle has entries, properties is returned, else null is returned
	 */
	public static Properties getPropertiesFromBundle(String bundleName)
			throws Exception
	{
		Properties props = null;

		// Assumption is that there does not exist an equivalent class
		// Only properties file exists (otherwise ClassCastException).
		ResourceBundle rb = ResourceBundle.getBundle(bundleName);
		PropertyResourceBundle prb = (PropertyResourceBundle)rb;

		Enumeration enm = prb.getKeys();

		String key = null;
		if (enm.hasMoreElements()) {
			props = new Properties();
		}
		while(enm.hasMoreElements()) {
			key = (String)enm.nextElement();
			props.put(key, prb.getString(key));
		}

		prb = null;
		rb = null;
		System.gc();

		return props;
	}
}
