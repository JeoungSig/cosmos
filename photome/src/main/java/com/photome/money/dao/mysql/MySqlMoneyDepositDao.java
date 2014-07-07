/**
 * 2013 MySqlMoneyDepositDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.dao.mysql;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.core.CosmosBaseDao;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.MoneyCollectDto;
import com.photome.dto.MoneyDepositDto;
import com.photome.money.dao.MoneyDepositDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlMoneyDepositDao extends CosmosBaseDao implements MoneyDepositDao {

	@Override
	public List<MoneyCollectDto> getMoneyCollectListForDeposit(HashMap<String, String> param) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		String collectCollector = param.get("collectCollector");
		map.put("depositId", "null");
		map.put("collectCollector", collectCollector);
		// map.put("collectStatus", "COLLECTING");

		return getSqlSession().selectList("mySqlMoneyCollectDao.getMoneyCollectList", map);
	}

	@Override
	public List<MoneyCollectDto> getMoneyCollectListForDeposit(String depositId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("depositId", depositId);
		return getSqlSession().selectList("mySqlMoneyCollectDao.getMoneyCollectList", param);
	}

	@Override
	public Integer getDepositedMoneyCollectCnt(String depositId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("depositId", depositId);

		return getSqlSession().selectOne("mySqlMoneyDepositDao.getDepositedMoneyCollectCnt", param);
	}

	@Override
	public Integer markDepositIdToCollectInfo(String collectId, String depositId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("collectId", collectId);
		param.put("depositId", depositId);

		return getSqlSession().update("mySqlMoneyDepositDao.markDepositIdToCollectInfo", param);
	}

	@Override
	public Integer unmarkDepositIdToCollectInfo(String collectId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("collectId", collectId);

		return getSqlSession().update("mySqlMoneyDepositDao.unmarkDepositIdToCollectInfo", param);
	}

	@Override
	public Integer updateMoneyCollectInfo(HashMap<String, String> param) throws Exception {
		String collectId = param.get("collectId");
		if (StringUtils.isBlank(collectId)) throw new Exception("collectId can not be empty!!");

		String bankDt = param.get("bankDt");
		String bankAmount = param.get("bankAmount");
		String status = param.get("collectStatus");
		String depositId = param.get("depositId");
		String userId = param.get("userId");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("collectId", collectId);
		map.put("bankDt", bankDt);
		map.put("bankAmount", bankAmount);
		map.put("collectStatus", status);
		map.put("depositId", depositId);
		map.put("userId", userId);

		return getSqlSession().update("mySqlMoneyCollectDao.modifyBankWork", map);
	}

	@Override
	public List<MoneyDepositDto> getBankDepositList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlMoneyDepositDao.getBankDepositList", param);
	}

	@Override
	public List<UserDto> getCreatorList() throws Exception {
		return getSqlSession().selectList("mySqlMoneyDepositDao.getCreatorList");
	}

	@Override
	public MoneyDepositDto getBankDepositInfo(String depositId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("depositId", depositId);

		return getSqlSession().selectOne("mySqlMoneyDepositDao.getBankDepositInfo", param);
	}

	@Override
	public Integer deleteBankDepositInfo(String depositId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("depositId", depositId);
		return getSqlSession().delete("mySqlMoneyDepositDao.deleteBankDepositInfo", param);
	}

	@Override
	public Integer insertBankDepositInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlMoneyDepositDao.insertBankDepositInfo", param);
	}

	@Override
	public String getBankDepositNewId() throws Exception {
		return getSqlSession().selectOne("mySqlMoneyDepositDao.getBankDepositNewId");
	}

	@Override
	public Integer changeBankDepositInfo(HashMap<String, String> param) throws Exception {
		String depositId = param.get("depositId");
		if (StringUtils.isBlank(depositId)) throw new Exception("depositId can not be empty!!");

		return getSqlSession().update("mySqlMoneyDepositDao.changeBankDepositInfo", param);
	}

	@Override
	public Integer changeBankDepositStatus(String depositId, String status) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("depositId", depositId);
		param.put("status", status);
		param.put("collectStatus", status);

		Integer updateCnt = 0;
		updateCnt = getSqlSession().update("mySqlMoneyCollectDao.modifyCollectStatusByDepositId", param);
		updateCnt = getSqlSession().update("mySqlMoneyDepositDao.changeBankDepositStatus", param);

		return updateCnt;
	}

	@Override
	public Integer deleteBankingInfoByDepositId(String depositId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("depositId", depositId);

		Integer updateCnt = getSqlSession().update("mySqlMoneyCollectDao.deleteBankingInfoByDepositId", param);

		return updateCnt;
	}

}
