/**
 * 2013 CollectMoneySnapshot.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money;

import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.photome.dto.MoneyCollectDto;
import com.photome.money.dao.MoneyCollectDao;

/**
 * 수금정보가 수집되는 시점의 상태를 수집하여 필요한 필드에대하여 계산하여 기본값으로 설정해주는 클래스이다.
 * 
 * @author Steven J.S Min
 * 
 */
public final class CollectMoneySnapshot {

	@Resource(name = "moneyCollectDao")
	private MoneyCollectDao moneyCollectDao;

	/**
	 * 수금정보를 받아서 현재 시점의 값으로 나머지 필드들을 설정후 반환한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, String> makeSnapShot(HashMap<String, String> param, CosmosSessionUserInfo sessionUser, MoneyCollectDto preCollectDto) throws Exception {

		HashMap<String, String> newParam = new HashMap<String, String>();

		String boothId = param.get("boothId");
		if (StringUtils.isEmpty(boothId)) throw new Exception("Can not be empty BOOTH_ID");

		newParam = this.initializeForEmptyMoneyCollect(param, preCollectDto, sessionUser);

		return newParam;
	}

	/**
	 * 기본적으로 넘어온 설정값들을 바탕으로 이전 수금기록을 참조하여 추가적으로 필요한 필드에<br>
	 * 값을 계산하여 설정한다.
	 * 
	 * @param param
	 * @param preCollectDto
	 * @param sessionUser
	 * @return
	 */
	private HashMap<String, String> initializeForEmptyMoneyCollect(HashMap<String, String> param, MoneyCollectDto preCollectDto, CosmosSessionUserInfo sessionUser) {

		HashMap<String, String> newParam = new HashMap<String, String>();
		newParam = param;

		if (preCollectDto == null) {
			preCollectDto = new MoneyCollectDto();
		}

		// 렌트비 설정
		if(StringUtils.isBlank(param.get("rentAmount"))){
			newParam.put("rentAmount", "0");
		}

		newParam.put("bankAmountBfr", (StringUtils.isEmpty(preCollectDto.getBankAmountBfr()) ? "0" : preCollectDto.getBankAmount())); // 이전 은행 입금금액
		newParam.put("coinMtrBfr", (StringUtils.isEmpty(preCollectDto.getCoinMtrNow()) ? "0" : preCollectDto.getCoinMtrNow())); // 이전 코인미터

		// 코인미터_수익액 : '코인미터_현재 - 코인미터_이전'
		String coinMtrNow = StringUtils.isEmpty(param.get("coinMtrNow")) ? "0" : param.get("coinMtrNow");
		String coinMtrBfr = StringUtils.isEmpty(preCollectDto.getCoinMtrNow()) ? "0" : preCollectDto.getCoinMtrNow();
		Double coinMtrIncome = Double.parseDouble(coinMtrNow) - Double.parseDouble(coinMtrBfr);
		if (StringUtils.isBlank(param.get("coinMtrNow")) || StringUtils.isBlank(preCollectDto.getCoinMtrNow())) {
			newParam.put("coinMtrIncome", "0");
		} else {
			newParam.put("coinMtrIncome", String.format("%.2f", coinMtrIncome));
		}

		// 수금_수금차이액(COLLECT_AMT_DIFF) : (수금_실제수금액 - 코인미터_수익액)
		// 목적 : 현재 수금된 금액이 코인미터와 비교해서 얼마나 차이가 나는지 확인한다.
		if (StringUtils.isBlank(param.get("coinMtrNow")) || StringUtils.isBlank(preCollectDto.getCoinMtrNow()) || StringUtils.isBlank(param.get("collectRealIncome"))) {
			newParam.put("collectAmtDiff", "0");
		} else {
			Double collectAmtDiff = 0.00;
			Double collectRealIncome = Double.parseDouble(param.get("collectRealIncome"));
			collectAmtDiff = collectRealIncome - coinMtrIncome;
			newParam.put("collectAmtDiff", String.format("%.2f", collectAmtDiff));
		}

		// 수금일/쿼터 설정
		String collectDate = param.get("collectDate");
		if (!StringUtils.isEmpty(collectDate)) {
			String collectDay = StringUtils.substringBefore(collectDate, "/");
			String collectMonth = StringUtils.substringBetween(collectDate, "/", "/");
			String collectYear = StringUtils.substringAfterLast(collectDate, "/");
			String collectQuarter = null;
			if (StringUtils.equals(collectMonth, "01") || StringUtils.equals(collectMonth, "02") || StringUtils.equals(collectMonth, "03")) {
				collectQuarter = "1Q";
			} else if (StringUtils.equals(collectMonth, "04") || StringUtils.equals(collectMonth, "05") || StringUtils.equals(collectMonth, "06")) {
				collectQuarter = "2Q";
			} else if (StringUtils.equals(collectMonth, "07") || StringUtils.equals(collectMonth, "08") || StringUtils.equals(collectMonth, "09")) {
				collectQuarter = "3Q";
			} else if (StringUtils.equals(collectMonth, "10") || StringUtils.equals(collectMonth, "11") || StringUtils.equals(collectMonth, "12")) {
				collectQuarter = "4Q";
			}
			newParam.put("collectDay", collectDay);
			newParam.put("collectMonth", collectMonth);
			newParam.put("collectYear", collectYear);
			newParam.put("collectQuarter", collectQuarter);
		}

		// '수금_실제수금액_이전' 설정
		newParam.put("collectRealIncomeBfr", (StringUtils.isEmpty(preCollectDto.getCollectRealIncome()) ? "0" : preCollectDto.getCollectRealIncome()));

		// '필름미터_이전'설정
		newParam.put("filmMtrBfr", (StringUtils.isEmpty(preCollectDto.getFilmMtrNow()) ? "0" : preCollectDto.getFilmMtrNow()));

		// '필름미터_현재 - 필름미터_이전'
		int filmMtrNow = (StringUtils.isEmpty(param.get("filmMtrNow")) ? 0 : Integer.parseInt(param.get("filmMtrNow"))); // 현재필름미터
		int filmMtrBfr = (StringUtils.isEmpty(preCollectDto.getFilmMtrNow()) ? 0 : Integer.parseInt(preCollectDto.getFilmMtrNow())); // 이전필름미터
		if (StringUtils.isBlank(preCollectDto.getFilmMtrNow()) || StringUtils.isBlank(param.get("filmMtrNow"))) {
			newParam.put("filmMtrConsume", "0");
		} else {
			newParam.put("filmMtrConsume", Integer.toString(filmMtrNow - filmMtrBfr));
		}

		// 싸이트에서 이미 렌트비가 지급완료되었으면 지급완료 처리하나.
		if (StringUtils.equals(param.get("onsiteIsPaid"), "Y") && !StringUtils.isBlank(param.get("onsitePayAmount"))) {
			newParam.put("rentFeeIsPaid", "Y");
		}

		// 이전 수금ID 설정
		if (preCollectDto != null) newParam.put("preCollectId", preCollectDto.getCollectId());

		String sessionUserId = sessionUser.getUserInfo().getUserId();
		newParam.put("creator", sessionUserId);
		newParam.put("modifier", sessionUserId);
		newParam.put("collectCollector", sessionUserId);

		return newParam;
	}
}
