package com.cif;
/**
 * This class implements filename filter for CIF data files.
 * The filter should be instantiated with pattern specified in the
 * properties file.  Currently only pattern matching element accepted is "*" and
 * only first occurance of "*" is used.
 *
 * Potentially, in future, can use regexp.
 */

import java.io.File;
import java.io.FilenameFilter;
import java.util.Vector;

public class CIFFilenameFilter implements FilenameFilter {

	private String[] pattern = null;

	/**
	 * Constructor:
	 * @param String patternString - Pattern to use for filtering
	 */
	public CIFFilenameFilter(String patternString) {
		// Parse pattern
		if (patternString == null) {
			pattern = new String[0];
			return;
		}
		String patt = patternString.trim();
		if (patt.length() == 0) {
			pattern = new String[0];
			return;
		}
		Vector v = new Vector();
		StringBuffer sb = new StringBuffer();
		boolean wildCardAdded = false;
		for (int i=0; i < patt.length(); i++) {
			if (patt.charAt(i) != '*' || wildCardAdded) {
				sb.append(patt.charAt(i));
			} else {
				if (sb.length() > 0) {
					v.add(sb.toString());
					sb.setLength(0);
				}
				v.add("*");
				wildCardAdded = true;
			}
		}
		if (sb.length() > 0) {
			v.add(sb.toString());
			sb.setLength(0);
		}
		pattern = new String[v.size()];

		for (int i=0; i < pattern.length; i++) {
			pattern[i] = (String)v.get(i);
		}
	}

	/**
	 * This filter will only worry about first "*".
	 */
	public boolean accept(File dir, String fname) {
		switch (pattern.length) {
			case 1:
				if (fname.equals(pattern[0])) {
					return true;
				}
				return false;
			case 2:
				if (pattern[0].equals("*")) {
					if (fname.endsWith(pattern[1])) {
						return true;
					}
					return false;
				} else {
					if (fname.startsWith(pattern[0])) {
						return true;
					}
					return false;
				}
			case 3:
				if (fname.startsWith(pattern[0]) &&
					fname.endsWith(pattern[2]))
				{
					return true;
				}
				return false;
			default:
				return false;
		}
	}
}
