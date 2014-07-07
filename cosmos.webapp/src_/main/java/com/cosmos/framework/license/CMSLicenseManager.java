/**
 * 2013 CMSLicenseManager.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.license;

import java.util.Calendar;
import java.util.GregorianCalendar;

import com.cosmos.framework.CosmosContext;

/**
 * @author Steven J.S Min
 * 
 */
public class CMSLicenseManager {

	public boolean isValidDate() {
		boolean isValid = false;
		if (org.apache.commons.lang.StringUtils.equals(CosmosContext.LICENSE.getLicenseType(), "EVALUATION")) {
			String curYear = Integer.toString(GregorianCalendar.getInstance().get(Calendar.YEAR));
			int month = GregorianCalendar.getInstance().get(Calendar.MONTH) + 1;
			int date = GregorianCalendar.getInstance().get(Calendar.DATE);
			String curMonth = month < 10 ? ("0" + month) : Integer.toString(month);
			String curDate = date < 10 ? ("0" + date) : Integer.toString(date);

			Integer licenseDate = Integer.parseInt(CosmosContext.LICENSE.getExpireDate());
			Integer currentDate = Integer.parseInt(curYear + curMonth + curDate);

			if (licenseDate > currentDate) {
				isValid = true;
			}
		}
		return isValid;
	}
}