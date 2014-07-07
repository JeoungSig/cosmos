/**
 * 2013 BoothRentFee.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage;

import java.util.HashMap;
import java.util.List;

import com.photome.dto.BoothRentFeeDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface BoothRentFee {
	public List<BoothRentFeeDto> getRentFeeList(HashMap<String, String> param) throws Exception;

	public BoothRentFeeDto getRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception;

	public boolean existRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception;

	/**
	 * 기존에 정보가 존재하는경우 갱신하고, 없는경우에는 Update 처리한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer registRentFeeInfo(HashMap<String, String> param) throws Exception;

	public Integer modifyRentFeeInfo(HashMap<String, String> param) throws Exception;

	public Integer deleteRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception;

}
