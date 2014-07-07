/**
 * 2013 MySqlCommonDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.common.dao.mysql;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.common.PostAddrDto;
import com.cosmos.framework.common.dao.CommonDao;
import com.cosmos.framework.core.CosmosBaseDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlCommonDao extends CosmosBaseDao implements CommonDao {

	@Override
	public HashMap<String, Object> getPostAddress(String zipCd) throws Exception {

		String state = (String) getSqlSession().selectOne("mySqlCommonDao.getStateByZipcd", zipCd);
		List<PostAddrDto> postAddrList = getSqlSession().selectList("mySqlCommonDao.getPostAddrByZipcd", zipCd);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("state", state);
		map.put("postAddrList", postAddrList);

		return map;
	}

	@Override
	public List<String> getStateList() throws Exception {
		return getSqlSession().selectList("mySqlCommonDao.getStateList");
	}

	@Override
	public List<PostAddrDto> getAddressList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlCommonDao.getAddressList", param);
	}

}
