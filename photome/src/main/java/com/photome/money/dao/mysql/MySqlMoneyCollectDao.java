/**
 * 2013 MySqlMoneyCollectDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.dao.mysql;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.core.CosmosBaseDao;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.MoneyCollectDto;
import com.photome.money.dao.MoneyCollectDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlMoneyCollectDao extends CosmosBaseDao implements MoneyCollectDao {

	@Override
	public String getNextCollectId(String preCollectId) throws Exception {
		List<String> nextCollectIds = null;
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("preCollectId", preCollectId);

		nextCollectIds = getSqlSession().selectList("mySqlMoneyCollectDao.getNextCollectId", param);
		String nextCollectId = null;
		if (nextCollectIds.size() == 1) {
			nextCollectId = nextCollectIds.get(0);
		} else {
			return null;
		}

		return nextCollectId;

	}

	@Override
	public List<MoneyCollectDto> getMoneyCollectList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlMoneyCollectDao.getMoneyCollectList", param);
	}

	@Override
	public MoneyCollectDto getMoneyCollectInfo(String collectId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("collectId", collectId);
		return getSqlSession().selectOne("mySqlMoneyCollectDao.getMoneyCollectInfo", param);
	}

	@Override
	public Integer insertMoneyCollectInfo(HashMap<String, String> param) throws Exception {
		String collectId = this.getMoneyCollectNewId();
		param.put("collectId", collectId);
		return getSqlSession().insert("mySqlMoneyCollectDao.insertMoneyCollectInfo", param);
	}

	@Override
	public Integer deleteMoneyCollectInfo(String collectId) throws Exception {
		if (StringUtils.isBlank(collectId)) throw new Exception("Can not be empty Collect ID for delete");

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("collectId", collectId);
		return getSqlSession().delete("mySqlMoneyCollectDao.deleteMoneyCollectInfo", param);
	}

	@Override
	public Integer updateMoneyCollectInfo(HashMap<String, String> param) throws Exception {
		String collectId = param.get("collectId");
		if (StringUtils.isBlank(collectId)) throw new Exception("Can not be empty Collect ID for update");
		return getSqlSession().update("mySqlMoneyCollectDao.updateMoneyCollectInfo", param);
	}

	@Override
	public String getMoneyCollectNewId() throws Exception {
		Integer collectId = getSqlSession().selectOne("mySqlMoneyCollectDao.getMoneyCollectNewId");
		return Integer.toString(collectId);
	}

	@Override
	public MoneyCollectDto getRecentMoneyCollectInfo(String boothId, String collectId) throws Exception {
		MoneyCollectDto moneyCollectDto = null;

		// 가장 최신의 수금정보를 얻어온다.
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("boothId", boothId);
		if (!StringUtils.isBlank(collectId)) param.put("collectId", collectId);
		
		String recentCollectId = getSqlSession().selectOne("mySqlMoneyCollectDao.getMoneyCollectRecentId", param);

		if (StringUtils.equals(recentCollectId, "0")) {
			return null;
		} else {
			moneyCollectDto = this.getMoneyCollectInfo(recentCollectId);
			return moneyCollectDto;
		}
	}

	@Override
	public Integer modifyCollectStatus(String collectId, String status, String userId) throws Exception {
		if (!StringUtils.equals("COLLECTING", status) && !StringUtils.equals("COLLECT_FINISH", status) && !StringUtils.equals("FINALCHK_FINISH", status)) {
			throw new Exception("Money collection status must be one among 'COLLECTING', 'COLLECT_FINISH' or 'FINALCHK_FINISH");
		}
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("userId", userId);
		param.put("collectStatus", status);
		param.put("collectId", collectId);

		return getSqlSession().update("mySqlMoneyCollectDao.modifyCollectStatus", param);
	}

	@Override
	public Integer modifyBankWork(HashMap<String, String> param) throws Exception {
		String collectId = param.get("collectId");
		String bankAccount = param.get("bankAccount");
		String bankAmount = param.get("bankAmount");
		String bankDt = param.get("bankDt");
		String userId = param.get("userId");

		if (StringUtils.isBlank(collectId)) throw new Exception("Can not be empty Collect ID");
		if (StringUtils.isBlank(bankAccount)) throw new Exception("Can not be empty Bank Account Information");
		if (StringUtils.isBlank(bankAmount)) throw new Exception("Can not be empty Input Money");
		if (StringUtils.isBlank(bankDt)) throw new Exception("Can not be empty Money send date");
		if (StringUtils.isBlank(userId)) throw new Exception("Can not be empty Modifier(User)");

		return getSqlSession().update("mySqlMoneyCollectDao.modifyBankWork", param);
	}

	@Override
	public Integer payOnsiteRentFee(HashMap<String, String> param) throws Exception {
		return null;
	}

	@Override
	public List<UserDto> getMoneyCollectorList() throws Exception {
		return getSqlSession().selectList("mySqlMoneyCollectDao.getMoneyCollectorList");
	}

}
