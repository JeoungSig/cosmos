/**
 * 2013 RefundService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.refund.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import com.photome.dto.RefundDto;
import com.photome.refund.Refund;
import com.photome.refund.dao.RefundDao;

/**
 * @author Steven J.S Min
 * 
 */
public class RefundService implements Refund {
	@Resource(name = "refundDao")
	private RefundDao refundDao;

	@Override
	public List<RefundDto> getRefundList(HashMap<String, String> param) throws Exception {
		return refundDao.getRefundList(param);
	}

	@Override
	public RefundDto getRefundInfo(String refundId) throws Exception {
		return refundDao.getRefundInfo(refundId);
	}

	@Override
	public Integer registRefundInfo(HashMap<String, String> param) throws Exception {
		return refundDao.registRefundInfo(param);
	}

	@Override
	public Integer updateRefundInfo(HashMap<String, String> param) throws Exception {
		return refundDao.updateRefundInfo(param);
	}

	@Override
	public Integer deleteRefundInfo(String refundId) throws Exception {
		return refundDao.deleteRefundInfo(refundId);
	}

}
