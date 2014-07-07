/**
 * 2013 MySqlBoothRentFeeDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage.dao.mysql;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.core.CosmosBaseDao;
import com.photome.dto.BoothRentFeeDto;
import com.photome.resmanage.dao.BoothRentFeeDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlBoothRentFeeDao extends CosmosBaseDao implements BoothRentFeeDao {

	@Override
	public List<BoothRentFeeDto> getRentFeeList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlBoothRentFeeDao.getRentFeeList", param);
	}

	@Override
	public BoothRentFeeDto getRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("boothId", boothId);
		param.put("rentYear", rentYear);
		param.put("rentMonth", rentMonth);
		return getSqlSession().selectOne("mySqlBoothRentFeeDao.getRentFeeInfo", param);
	}

	@Override
	public boolean existRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception {
		BoothRentFeeDto dto = this.getRentFeeInfo(boothId, rentYear, rentMonth);
		if (dto == null) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public Integer registRentFeeInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlBoothRentFeeDao.registRentFeeInfo", param);
	}

	@Override
	public Integer modifyRentFeeInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().update("mySqlBoothRentFeeDao.modifyRentFeeInfo", param);
	}

	@Override
	public Integer deleteRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("boothId", boothId);
		param.put("rentYear", rentYear);
		param.put("rentMonth", rentMonth);
		return getSqlSession().delete("mySqlBoothRentFeeDao.deleteRentFeeInfo", param);
	}

	@Override
	public List<BoothRentFeeDto> getRentFeeGrpList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlBoothRentFeeDao.getRentFeeGrpList", param);
	}

	@Override
	public BoothRentFeeDto getRentFeeGrpInfo(String groupId, String rentYear, String rentMonth) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		param.put("rentYear", rentYear);
		param.put("rentMonth", rentMonth);
		return getSqlSession().selectOne("mySqlBoothRentFeeDao.getRentFeeGrpInfo", param);
	}

	@Override
	public boolean existRentFeeGrpInfo(String groupId, String rentYear, String rentMonth) throws Exception {
		BoothRentFeeDto dto = this.getRentFeeGrpInfo(groupId, rentYear, rentMonth);
		if (dto == null) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public Integer registRentFeeGrpInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlBoothRentFeeDao.registRentFeeGrpInfo", param);
	}

	@Override
	public Integer modifyRentFeeGrpInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().update("mySqlBoothRentFeeDao.modifyRentFeeGrpInfo", param);
	}

	@Override
	public Integer deleteRentFeeGrpInfo(String groupId, String rentYear, String rentMonth) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		param.put("rentYear", rentYear);
		param.put("rentMonth", rentMonth);
		return getSqlSession().delete("mySqlBoothRentFeeDao.deleteRentFeeGrpInfo", param);
	}

	@Override
	public String getCurrBoothRentFee(String boothId, String rentFeeType) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("boothId", boothId);
		param.put("rentFeeType", rentFeeType);

		String rentFee = getSqlSession().selectOne("mySqlBoothRentFeeDao.getCurrBoothRentFee", param);

		return StringUtils.isBlank(rentFee) ? "0" : rentFee;
	}

	@Override
	public String getCurrGroupRentFee(String groupId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);

		String rentFee = getSqlSession().selectOne("mySqlBoothRentFeeDao.getCurrGroupRentFee", param);

		return StringUtils.isBlank(rentFee) ? "0" : rentFee;

	}

}
