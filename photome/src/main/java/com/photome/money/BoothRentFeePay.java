/**
 * 2013 BoothRentFee.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money;

import java.util.HashMap;
import java.util.List;

import com.photome.dto.BoothGroupDto;
import com.photome.dto.BoothRentFeePayDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface BoothRentFeePay {

	public List<BoothRentFeePayDto> getBoothRentFeePayInfoList(HashMap<String, String> param) throws Exception;

	public Integer registBoothRentFeePayInfo(HashMap<String, String> param) throws Exception;

	public boolean existBoothRentFeePayHistory(String groupId, String year, String month) throws Exception;

	public BoothRentFeePayDto getBoothRentFeePayInfo(String groupId, String year, String month) throws Exception;

	public Integer updateBoothRentFeePayInfo(HashMap<String, String> param) throws Exception;

	public Integer deleteBoothRentFeePayInfo(String groupId, String year, String month) throws Exception;

	public Integer changeBoothRentFeePayStatus(String groupId, String year, String month, String status, String updator) throws Exception;

	public HashMap<String, Object> generateBoothRentFeePayStatusTable(List<BoothGroupDto> boothGroupList, String year) throws Exception;
}
