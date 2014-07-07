/**
 * 2013 MySqlRefundDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.refund.dao.mysql;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.core.CosmosBaseDao;
import com.photome.dto.RefundDto;
import com.photome.refund.dao.RefundDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlRefundDao extends CosmosBaseDao implements RefundDao {

	@Override
	public List<RefundDto> getRefundList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlRefundDao.getRefundList", param);
	}

	@Override
	public RefundDto getRefundInfo(String refundId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("refundId", refundId);
		return getSqlSession().selectOne("mySqlRefundDao.getRefundInfo", param);
	}

	@Override
	public Integer registRefundInfo(HashMap<String, String> param) throws Exception {
		Integer newId = getSqlSession().selectOne("mySqlRefundDao.getNewRefundId");
		if(newId == null) throw new Exception("REFUND_ID required for insert");
		param.put("refundId", Integer.toString(newId));
		return getSqlSession().insert("mySqlRefundDao.registRefundInfo", param);
	}

	@Override
	public Integer updateRefundInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().update("mySqlRefundDao.updateRefundInfo", param);
	}

	@Override
	public Integer deleteRefundInfo(String refundId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("refundId", refundId);		
		return getSqlSession().delete("mySqlRefundDao.deleteRefundInfo", param);
	}

}
