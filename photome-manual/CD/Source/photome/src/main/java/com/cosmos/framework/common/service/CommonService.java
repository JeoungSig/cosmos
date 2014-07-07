/**
 * 2013 CommonService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.common.Common;
import com.cosmos.framework.common.PostAddrDto;
import com.cosmos.framework.common.dao.CommonDao;

/**
 * @author Steven J.S Min
 * 
 */
public class CommonService implements Common {

	@Resource(name = "commonDao")
	private CommonDao commonDao;

	@Override
	public HashMap<String, Object> getPostAddress(String zipCd) throws Exception {
		return commonDao.getPostAddress(zipCd);
	}

	@Override
	public List<String> getStateList() throws Exception {
		return commonDao.getStateList();
	}

	@Override
	public String getStateComboOptions(String selectedValue) throws Exception {
		StringBuffer options = new StringBuffer("<option></option>");
		List<String> stateList = commonDao.getStateList();
		for (String state : stateList) {
			options.append("<option value=\"" + state + "\"" + (StringUtils.equals(state, selectedValue) ? " selected " : "") + " >" + state + "</option>");
		}

		return options.toString();
	}

	@Override
	public List<PostAddrDto> getAddressList(HashMap<String, String> param) throws Exception {
		return commonDao.getAddressList(param);
	}

	@Override
	public List<Map> selectCommonSQL(String sql) throws Exception {
		return commonDao.selectCommonSQL(sql);
	}

	@Override
	public Integer updateCommonSQL(String sql) throws Exception {
		return commonDao.updateCommonSQL(sql);
	}

	@Override
	public Integer deleteCommonSQL(String sql) throws Exception {
		return commonDao.deleteCommonSQL(sql);
	}

}
