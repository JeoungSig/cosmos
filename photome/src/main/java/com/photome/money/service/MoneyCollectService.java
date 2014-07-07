/**
 * 2013 MoneyCollectService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.cosmos.framework.code.dao.CodeDao;
import com.cosmos.framework.common.dao.CommonDao;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BoothDto;
import com.photome.dto.MoneyCollectDto;
import com.photome.money.CollectMoneySnapshot;
import com.photome.money.MoneyCollect;
import com.photome.money.dao.MoneyCollectDao;
import com.photome.resmanage.dao.ResourceManageDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MoneyCollectService implements MoneyCollect {

	@Resource(name = "moneyCollectDao")
	private MoneyCollectDao moneyCollectDao;

	@Resource(name = "resManageDao")
	private ResourceManageDao resManageDao;

	@Resource(name = "codeDao")
	private CodeDao codeDao;

	@Resource(name = "commonDao")
	private CommonDao commonDao;

	@Override
	public List<MoneyCollectDto> getMoneyCollectList(HashMap<String, String> param) throws Exception {
		return moneyCollectDao.getMoneyCollectList(param);
	}

	@Override
	public MoneyCollectDto getMoneyCollectInfo(String collectId) throws Exception {
		MoneyCollectDto moneyCollectDto = moneyCollectDao.getMoneyCollectInfo(collectId);
		String preCollectId = moneyCollectDto.getPreCollectId();
		String nextCollectId = null;
		if (!StringUtils.isBlank(preCollectId)) {
			nextCollectId = moneyCollectDao.getNextCollectId(preCollectId);
			moneyCollectDto.setNextCollectId(nextCollectId);
		}

		return moneyCollectDto;
	}

	@Override
	public String getMoneyCollectorListForHTMLOption(String defaultSelectedValue) throws Exception {
		List<UserDto> userList = moneyCollectDao.getMoneyCollectorList();

		StringBuffer options = new StringBuffer("<option></option>");
		for (UserDto dto : userList) {
			options.append("<option value= \"" + dto.getUserId() + "\" " + (StringUtils.equals(dto.getUserId(), defaultSelectedValue) ? " selected" : "") + ">" + dto.getFirstName() + "</option>");
		}
		return options.toString();
	}

	@Override
	public Integer insertMoneyCollectInfo(HashMap<String, String> param, CosmosSessionUserInfo sessionUser) throws Exception {
		CollectMoneySnapshot moneyShnapShot = new CollectMoneySnapshot();

		// 부스정보를 얻어온다.
		BoothDto boothDto = resManageDao.getBoothInfo(param.get("boothId"));
		param.put("rentFeeType", boothDto.getRentFeeType());
		param.put("payOnsite", boothDto.getPayOnsite());

		// 자동 설정된 금액이 있더라도 만일 수금자가 싸이트에 지급된 정보가 존재한다면 수금자가 입금한 금액을 우선으로 렌트비 정보를 설정한다.
		if (!StringUtils.isBlank(param.get("onsitePayAmount")) && StringUtils.equals(boothDto.getPayOnsite(), "Y")) {
			param.put("rentAmount", param.get("onsitePayAmount"));
		} else {
			param.put("rentAmount", boothDto.getRentAmount());
		}

		// 싸이트에서 레트비가 지급되지 않는 경우에는 사이트에서 지급되는 레트비 정보관련은 NULL로 설정
		if (!StringUtils.equals(boothDto.getPayOnsite(), "Y")) {
			param.put("onsiteIsPaid", null);
			param.put("onsitePayAmount", null);
		}

		// 이전 수금정보를 얻어온다.
		MoneyCollectDto preCollectDto = moneyCollectDao.getRecentMoneyCollectInfo(param.get("boothId"), "");

		HashMap<String, String> newParam = moneyShnapShot.makeSnapShot(param, sessionUser, preCollectDto);

		return moneyCollectDao.insertMoneyCollectInfo(newParam);
	}

	@Override
	public Integer deleteMoneyCollectInfo(String collectId) throws Exception {
		return moneyCollectDao.deleteMoneyCollectInfo(collectId);
	}

	@Override
	public Integer updateMoneyCollectInfo(HashMap<String, String> param, CosmosSessionUserInfo sessionUser) throws Exception {
		CollectMoneySnapshot moneyShnapShot = new CollectMoneySnapshot();

		// 부스정보를 얻어온다.
		BoothDto boothDto = resManageDao.getBoothInfo(param.get("boothId"));
		param.put("rentFeeType", boothDto.getRentFeeType());
		param.put("payOnsite", boothDto.getPayOnsite());

		// 자동 설정된 금액이 있더라도 만일 수금자가 싸이트에 지급된 정보가 존재한다면 수금자가 입금한 금액을 우선으로 렌트비 정보를 설정한다.
		if (!StringUtils.isBlank(param.get("onsitePayAmount")) && StringUtils.equals(boothDto.getPayOnsite(), "Y")) {
			param.put("rentAmount", param.get("onsitePayAmount"));
		} else {
			param.put("rentAmount", boothDto.getRentAmount());
		}

		// 이전 수금정보를 얻어온다.
		MoneyCollectDto preCollectDto = moneyCollectDao.getRecentMoneyCollectInfo(param.get("boothId"), param.get("collectId"));

		HashMap<String, String> newParam = moneyShnapShot.makeSnapShot(param, sessionUser, preCollectDto);

		return moneyCollectDao.updateMoneyCollectInfo(newParam);
	}

	@Override
	public String getMoneyCollectNewId() throws Exception {
		return moneyCollectDao.getMoneyCollectNewId();
	}

	@Override
	public Integer modifyCollectStatus(String collectId, String status, String userId) throws Exception {
		if (!StringUtils.equals("COLLECTING", status) && !StringUtils.equals("COLLECT_FINISH", status) && !StringUtils.equals("FINALCHK_FINISH", status)) {
			throw new Exception("Money collection status must be one among 'COLLECTING', 'COLLECT_FINISH' or 'FINALCHK_FINISH");
		}

		if (StringUtils.isBlank(collectId)) throw new Exception("Can not be empty Collect ID");
		if (StringUtils.isBlank(userId)) throw new Exception("Can not be empty Modifier(User)");

		return moneyCollectDao.modifyCollectStatus(collectId, status, userId);
	}

	@Override
	public Integer modifyBankWork(HashMap<String, String> param) throws Exception {
		return moneyCollectDao.modifyBankWork(param);
	}

	@Override
	public Integer payOnsiteRentFee(HashMap<String, String> param) throws Exception {
		return moneyCollectDao.payOnsiteRentFee(param);
	}

	@Override
	public MoneyCollectDto getRecentMoneyCollectInfo(String boothId) throws Exception {
		return this.getRecentMoneyCollectInfo(boothId, "999999");
	}

	@Override
	public MoneyCollectDto getRecentMoneyCollectInfo(String boothId, String collectId) throws Exception {
		return moneyCollectDao.getRecentMoneyCollectInfo(boothId, collectId);
	}

}
