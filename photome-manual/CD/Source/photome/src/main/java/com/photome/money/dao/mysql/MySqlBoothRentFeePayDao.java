/**
 * 2013 MySqlBoothRentFeePayDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.dao.mysql;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.core.CosmosBaseDao;
import com.photome.dto.BoothRentFeePayDto;
import com.photome.money.dao.BoothRentFeePayDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlBoothRentFeePayDao extends CosmosBaseDao implements BoothRentFeePayDao {

	@Override
	public List<BoothRentFeePayDto> getBoothRentFeePayInfoList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlBoothRentFeePayDao.getBoothRentFeePayInfoList", param);
	}

	@Override
	public boolean existBoothRentFeePayHistory(String groupId, String year, String month) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		param.put("year", year);
		param.put("month", month);
		BoothRentFeePayDto dto = this.getBoothRentFeePayInfo(groupId, year, month);

		if (dto == null) return false;
		else
			return true;
	}

	@Override
	public BoothRentFeePayDto getBoothRentFeePayInfo(String groupId, String year, String month) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		param.put("year", year);
		param.put("month", month);
		return getSqlSession().selectOne("mySqlBoothRentFeePayDao.getBoothRentFeePayInfo", param);
	}

	@Override
	public Integer updateBoothRentFeePayInfo(HashMap<String, String> param) throws Exception {
		String groupId = param.get("groupId");
		String year = param.get("year");
		String month = param.get("month");
		if (StringUtils.isBlank(groupId) || StringUtils.isBlank(year) || StringUtils.isBlank(month)) throw new Exception("Can not be empty : GROUP_ID, YEAR or MONTH for update");
		return getSqlSession().update("mySqlBoothRentFeePayDao.updateBoothRentFeePayInfo", param);
	}

	@Override
	public Integer deleteBoothRentFeePayInfo(String groupId, String year, String month) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		param.put("year", year);
		param.put("month", month);
		if (StringUtils.isBlank(groupId) || StringUtils.isBlank(year) || StringUtils.isBlank(month)) throw new Exception("Can not be empty : GROUP_ID, YEAR or MONTH for delete");
		return getSqlSession().delete("mySqlBoothRentFeePayDao.deleteBoothRentFeePayInfo", param);
	}

	@Override
	public Integer changeBoothRentFeePayStatus(HashMap<String, String> param) throws Exception {
		String p_groupId = param.get("groupId");
		String p_year = param.get("year");
		String p_month = param.get("month");
		String p_status = param.get("status");
		if (StringUtils.isBlank(p_groupId) || StringUtils.isBlank(p_year) || StringUtils.isBlank(p_month) || StringUtils.isBlank(p_status))
			throw new Exception("Can not be empty : GROUP_ID, YEAR, MONTH or STATUS for delete");
		return getSqlSession().update("mySqlBoothRentFeePayDao.changeBoothRentFeePayStatus", param);
	}

	@Override
	public Integer registBoothRentFeePayInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().update("mySqlBoothRentFeePayDao.registBoothRentFeePayInfo", param);
	}

}
