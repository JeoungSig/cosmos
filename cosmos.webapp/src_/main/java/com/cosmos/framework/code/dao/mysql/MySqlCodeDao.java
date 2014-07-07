/**
 * 2013 MySqlCodeDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.code.dao.mysql;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.code.dao.CodeDao;
import com.cosmos.framework.core.CosmosBaseDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlCodeDao extends CosmosBaseDao implements CodeDao {

	@Override
	public CodeDto getCodeInfo(HashMap<String, String> param) throws Exception {
		return (CodeDto) getSqlSession().selectOne("mySqlCodeDao.codeInfo", param);
	}

	@Override
	public List<CodeDto> getCodeList(HashMap<String, String> map) throws Exception {
		return getSqlSession().selectList("mySqlCodeDao.codeList", map);
	}

	@Override
	public List<CodeDto> getSystemCodeList() throws Exception {
		return getSqlSession().selectList("mySqlCodeDao.systemCodeList");
	}

	@Override
	public List<CodeDto> getCategoryCodeList(String systemCd) throws Exception {
		return getSqlSession().selectList("mySqlCodeDao.getCategoryCodeList", systemCd);
	}

	@Override
	public Integer insertCodeInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().insert("mySqlCodeDao.insertCodeInfo", map);
	}

	@Override
	public Integer modifyCodeInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().insert("mySqlCodeDao.modifyCodeInfo", map);
	}

	@Override
	public Integer deleteCodeInfos(ArrayList<Object> keyList) throws Exception {

		if (keyList.size() <= 0) return 0;

		CodeDto code = null;
		List<CodeDto> list = new ArrayList<CodeDto>();

		for (Object obj : keyList) {
			code = new CodeDto();
			Map<String, String> mp = BeanUtils.describe(obj);
			code.setSystemCd(mp.get("systemCd"));
			code.setCategoryCd(mp.get("categoryCd"));
			code.setCodeValue(mp.get("codeValue"));

			list.add(code);
		}

		return getSqlSession().delete("mySqlCodeDao.deleteCodeInfos", list);
	}

	@Override
	public Integer deleteCodeInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlCodeDao.deleteCodeInfo", param);
	}
	
	

}
