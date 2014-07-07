/**
 * 2013 RefundDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.refund.dao;

import java.util.HashMap;
import java.util.List;

import com.photome.dto.RefundDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface RefundDao {

	public List<RefundDto> getRefundList(HashMap<String, String> param) throws Exception;

	public RefundDto getRefundInfo(String refundId) throws Exception;

	public Integer registRefundInfo(HashMap<String, String> param) throws Exception;

	public Integer updateRefundInfo(HashMap<String, String> param) throws Exception;

	public Integer deleteRefundInfo(String refundId) throws Exception;
	
}
