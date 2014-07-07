/**
 * 2013 BoothRentFeeDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage.dao;

import java.util.HashMap;
import java.util.List;

import com.photome.dto.BoothRentFeeDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface BoothRentFeeDao {

	public List<BoothRentFeeDto> getRentFeeList(HashMap<String, String> param) throws Exception;

	public BoothRentFeeDto getRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception;

	public boolean existRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception;

	public Integer registRentFeeInfo(HashMap<String, String> param) throws Exception;

	public Integer modifyRentFeeInfo(HashMap<String, String> param) throws Exception;

	public Integer deleteRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception;

	public List<BoothRentFeeDto> getRentFeeGrpList(HashMap<String, String> param) throws Exception;

	public BoothRentFeeDto getRentFeeGrpInfo(String groupId, String rentYear, String rentMonth) throws Exception;

	public boolean existRentFeeGrpInfo(String groupId, String rentYear, String rentMonth) throws Exception;

	public Integer registRentFeeGrpInfo(HashMap<String, String> param) throws Exception;

	public Integer modifyRentFeeGrpInfo(HashMap<String, String> param) throws Exception;

	public Integer deleteRentFeeGrpInfo(String groupId, String rentYear, String rentMonth) throws Exception;

	public String getCurrBoothRentFee(String boothId, String rentFeeType) throws Exception;

	public String getCurrGroupRentFee(String groupId) throws Exception;

}
