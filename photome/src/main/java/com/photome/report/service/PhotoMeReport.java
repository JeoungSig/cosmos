/**
 * 2013 PhotoMeReport.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.report.service;

import java.util.HashMap;
import java.util.List;

import com.photome.dto.MoneyCollectRptDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface PhotoMeReport {

	public List<MoneyCollectRptDto> getReportDataForRpt01(HashMap<String, String> param) throws Exception;

	public List<MoneyCollectRptDto> getReportDataForRpt02(HashMap<String, String> param) throws Exception;
	
	public MoneyCollectRptDto getGroupRentFee(String groupId, String collectYear) throws Exception;

}
