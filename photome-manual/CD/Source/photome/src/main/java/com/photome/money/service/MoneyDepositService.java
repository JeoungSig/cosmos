/**
 * 2013 MoneyDepositService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.user.UserDto;
import com.photome.dto.MoneyCollectDto;
import com.photome.dto.MoneyDepositDto;
import com.photome.money.MoneyDeposit;
import com.photome.money.dao.MoneyDepositDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MoneyDepositService implements MoneyDeposit {

	@Resource(name = "moneyDepositDao")
	private MoneyDepositDao moneyDepositDao;

	@Override
	public List<MoneyCollectDto> getMoneyCollectListForDeposit(HashMap<String, String> param) throws Exception {
		return moneyDepositDao.getMoneyCollectListForDeposit(param);
	}

	@Override
	public List<MoneyCollectDto> getMoneyCollectListForDeposit(String depositId) throws Exception {
		return moneyDepositDao.getMoneyCollectListForDeposit(depositId);
	}

	@Override
	public Integer getDepositedMoneyCollectCnt(String depositId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer markDepositIdToCollectInfo(String collectId, String depositId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer unmarkDepositIdToCollectInfo(String depositId) throws Exception {
		return moneyDepositDao.unmarkDepositIdToCollectInfo(depositId);
	}

	@Override
	public Integer updateMoneyCollectInfo(HashMap<String, String> param) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MoneyDepositDto> getBankDepositList(HashMap<String, String> param) throws Exception {
		return moneyDepositDao.getBankDepositList(param);
	}

	@Override
	public String getCreatorListForHTMLOptions() throws Exception {
		List<UserDto> creatorList = moneyDepositDao.getCreatorList();
		StringBuffer creators = new StringBuffer("<option selected></option>");
		for (UserDto dto : creatorList) {
			creators.append("<option value=\"" + dto.getUserId() + "\" >" + dto.getFirstName() + "</option>");
		}
		return creators.toString();
	}

	@Override
	public MoneyDepositDto getBankDepositInfo(String depositId) throws Exception {
		return moneyDepositDao.getBankDepositInfo(depositId);
	}

	@Override
	public Integer deleteBankDepositInfo(String depositId) throws Exception {
		Integer cnt = 0;
		cnt = moneyDepositDao.deleteBankingInfoByDepositId(depositId); // 수금정보의 은행 입금 정보 내역을 삭제한다.
		return moneyDepositDao.deleteBankDepositInfo(depositId);
	}

	@Override
	public Integer insertBankDepositInfo(HashMap<String, String> param) throws Exception {
		String allDepositRows = param.get("allDepositRows");
		String bankDt = param.get("bankDt");
		String bankYear = param.get("bankYear");
		String bankMonth = param.get("bankMonth");
		String bankDay = param.get("bankDay");
		String status = param.get("status");
		String comment = param.get("comment");
		String bankTotalAmount = param.get("bankTotalAmount");
		String creator = param.get("userId");
		String userId = param.get("userId");

		HashMap<String, String> map = new HashMap<String, String>();

		String depositId = moneyDepositDao.getBankDepositNewId();

		// 입금정보를 등록한다.
		HashMap<String, String> map1 = new HashMap<String, String>();
		map1.put("depositId", depositId);
		map1.put("bankDt", bankDt);
		map1.put("bankYear", bankYear);
		map1.put("bankMonth", bankMonth);
		map1.put("bankDay", bankDay);
		map1.put("status", status);
		map1.put("comment", comment);
		map1.put("bankTotalAmount", bankTotalAmount);
		map1.put("creator", creator);

		Integer cnt = moneyDepositDao.insertBankDepositInfo(map1);

		// 수금정보를 갱신한다.
		String collectAmts[] = StringUtils.split(allDepositRows, "|");
		String collectId = "";
		String bankAmount = "";
		for (String collectAmt : collectAmts) {
			collectId = StringUtils.substringBefore(collectAmt, ":");
			bankAmount = StringUtils.substringAfterLast(collectAmt, ":");
			map.put("bankDt", bankDt);
			map.put("bankAmount", bankAmount);
			map.put("userId", userId);
			map.put("collectStatus", status);
			map.put("collectId", collectId);
			map.put("depositId", depositId);

			moneyDepositDao.updateMoneyCollectInfo(map);
		}

		return cnt;
	}

	@Override
	public Integer changeBankDepositStatus(String depositId, String status) throws Exception {
		Integer cnt = moneyDepositDao.changeBankDepositStatus(depositId, status);
		return cnt;
	}

}
