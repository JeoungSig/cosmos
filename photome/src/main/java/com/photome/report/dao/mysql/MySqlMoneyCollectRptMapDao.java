/**
 * 2013 MySqlMoneyCollectRtpMapDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.report.dao.mysql;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.core.CosmosBaseDao;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.BoothRentFeeDto;
import com.photome.dto.MoneyCollectDto;
import com.photome.dto.MoneyCollectRptDto;
import com.photome.dto.RefundDto;
import com.photome.report.dao.MoneyCollectRptMapDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlMoneyCollectRptMapDao extends CosmosBaseDao implements MoneyCollectRptMapDao {

	@Override
	public Map<String, String> getCollectRealIncomeMap(HashMap<String, String> param) throws Exception {
		List<MoneyCollectDto> list = getSqlSession().selectList("mySqlMoneyCollectRptMapDao.getCollectRealIncomeMap", param);

		Map<String, String> realIncomeMap = new HashMap<String, String>();

		for (MoneyCollectDto dto : list) {
			realIncomeMap.put(dto.getBoothId() + "|" + dto.getCollectMonth(), dto.getCollectRealIncome());
		}

		return realIncomeMap;
	}

	@Override
	public Map<String, String> getCollectRealIncomeMapByGroup(HashMap<String, String> param) throws Exception {
		List<MoneyCollectDto> list = getSqlSession().selectList("mySqlMoneyCollectRptMapDao.getCollectRealIncomeMapByGroup", param);

		Map<String, String> realIncomeMap = new HashMap<String, String>();

		for (MoneyCollectDto dto : list) {
			realIncomeMap.put(dto.getCollectId(), dto.getCollectRealIncome());
		}

		return realIncomeMap;
	}

	@Override
	public Map<String, String> getRefundMap(HashMap<String, String> param) throws Exception {
		List<RefundDto> list = getSqlSession().selectList("mySqlMoneyCollectRptMapDao.getRefundMap", param);

		Map<String, String> refundMap = new HashMap<String, String>();

		for (RefundDto dto : list) {
			refundMap.put(dto.getBoothId() + "|" + dto.getRefundDt(), dto.getRefundAmount());
		}

		return refundMap;
	}

	@Override
	public Map<String, String> getRefundMapByGroup(HashMap<String, String> param) throws Exception {
		List<RefundDto> list = getSqlSession().selectList("mySqlMoneyCollectRptMapDao.getRefundMapByGroup", param);

		Map<String, String> refundMap = new HashMap<String, String>();

		String temp = "";
		for (RefundDto dto : list) {
			temp = StringUtils.substringAfterLast(dto.getRefundAmount(), ".");
			if (temp != null) {
				if (temp.length() > 2) {
					refundMap.put(dto.getRefundId(), StringUtils.substringBeforeLast(dto.getRefundAmount(), ".") + "." + temp.substring(0, 2));
				} else {
					refundMap.put(dto.getRefundId(), dto.getRefundAmount());
				}
			} else {
				refundMap.put(dto.getRefundId(), dto.getRefundAmount());
			}
		}

		return refundMap;
	}

	@Override
	public HashMap<String, String> getRefundCntMap(HashMap<String, String> param) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public HashMap<String, String> getRefundCntMapByGroup(HashMap<String, String> param) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 렌트비 정보를 해쉬맵에 저장하기위하여 "키:BoothId|월, 값:렌트비"형태로 저장한다.
	 */
	@Override
	public Map<String, String> getBoothRentFeeAmountMap(String boothId, String rentFeeType, String year) throws Exception {

		// 현재 년도에 대해서 계산을 하는 경우 현재월까지만 데이터를 구성하고
		// 현재 년도보다 작은 년도를 계산하는 경우 상관없이 모든 월에대한 데이터를 구성한다.
		boolean filter = true;
		int paramYear = Integer.parseInt(year);
		int curYear = GregorianCalendar.getInstance().get(Calendar.YEAR);
		int curMonth = GregorianCalendar.getInstance().get(Calendar.MONTH) + 1;
		if (paramYear < curYear) filter = false;

		Map<String, String> rentFeeMap = new HashMap<String, String>();

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("boothId", boothId);
		param.put("year", year);

		if (StringUtils.equals(rentFeeType, "FIXED_MONEY")) {
			List<BoothRentFeeDto> list = getSqlSession().selectList("mySqlMoneyCollectRptMapDao.getBoothRentFeeAmountMap", param);
			for (BoothRentFeeDto dto : list) {
				if (paramYear <= curYear) {
					if (filter) {
						// 조회 년도가 현재년도와 동일한 경우
						int dtoMonth = Integer.parseInt(dto.getRentMonth());
						if (dtoMonth <= curMonth) {
							rentFeeMap.put(dto.getBoothId() + "|" + dto.getRentMonth(), dto.getRentAmount());
						}
					} else {
						// 조회 년도가 현재 년도보다 작은경우
						rentFeeMap.put(dto.getBoothId() + "|" + dto.getRentMonth(), dto.getRentAmount());
					}
				} else {
					// 아무것도 하지 저장하지 않는다.
				}
			}

		} else if (StringUtils.equals(rentFeeType, "PERCENT")) {
			// 렌트비가 퍼센트로 계산하여 지급하는 경우 수금된 금액에 대하여 해당 퍼센트로 설정한다.

			// 계산을 위하여 부스별 수금된 금액을 저장한다.
			List<MoneyCollectDto> collectList = getSqlSession().selectList("mySqlMoneyCollectRptMapDao.getCollectAmountForRentFeePercentMap", param);
			Map<String, String> collectMap = new HashMap<String, String>();
			for (MoneyCollectDto dto : collectList) {
				collectMap.put(dto.getBoothId() + "|" + dto.getCollectMonth(), dto.getCollectRealIncome());
			}

			String percent = "";
			String moneyCollect = "";
			String rentAmount = "";
			String key = "";

			List<BoothRentFeeDto> percentList = getSqlSession().selectList("mySqlMoneyCollectRptMapDao.getBoothRentFeePercentMap", param);

			for (BoothRentFeeDto dto : percentList) {
				key = dto.getBoothId() + "|" + dto.getRentMonth();
				percent = dto.getRentPercent();
				moneyCollect = collectMap.get(key);

				if (StringUtils.isBlank(percent) || StringUtils.isBlank(moneyCollect)) {
					rentAmount = null;
				} else {
					// (렌트비(%)/100) * 매출금액
					rentAmount = Double.toString((Double.parseDouble(percent) / 100) * Double.parseDouble(moneyCollect));
				}

				if (paramYear <= curYear) {
					if (filter) {
						// 조회 년도가 현재년도와 동일한 경우
						int dtoMonth = Integer.parseInt(dto.getRentMonth());
						if (dtoMonth <= curMonth) {
							rentFeeMap.put(key, rentAmount);
						}
					} else {
						// 조회 년도가 현재 년도보다 작은경우
						rentFeeMap.put(key, rentAmount);
					}

				} else {
					// 아무것도 하지 저장하지 않는다.
				}

			}
		}

		return rentFeeMap;
	}

	@Override
	public MoneyCollectRptDto getGroupRentFee(String groupId, String collectYear) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		param.put("year", collectYear);
		List<BoothRentFeeDto> boothRentFeeList = getSqlSession().selectList("mySqlMoneyCollectRptMapDao.getBoothRentFeeForGrpMap", param);
		MoneyCollectRptDto rptDto = new MoneyCollectRptDto();
		Map<String, String> rentFeeMap_tmp = new HashMap<String, String>();

		String key = "";
		String value = "";
		for (BoothRentFeeDto groupRentFeeDto : boothRentFeeList) {
			key = groupRentFeeDto.getGroupId() + "|" + groupRentFeeDto.getRentMonth();
			rentFeeMap_tmp.put(key, groupRentFeeDto.getRentAmount());
		}
		value = rentFeeMap_tmp.get(groupId + "|" + "01");
		rptDto.setRentFeeAmt01(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "02");
		rptDto.setRentFeeAmt02(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "03");
		rptDto.setRentFeeAmt03(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "04");
		rptDto.setRentFeeAmt04(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "05");
		rptDto.setRentFeeAmt05(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "06");
		rptDto.setRentFeeAmt06(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "07");
		rptDto.setRentFeeAmt07(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "08");
		rptDto.setRentFeeAmt08(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "09");
		rptDto.setRentFeeAmt09(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "10");
		rptDto.setRentFeeAmt10(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "11");
		rptDto.setRentFeeAmt11(StringUtils.isBlank(value) ? null : value);

		value = rentFeeMap_tmp.get(groupId + "|" + "12");
		rptDto.setRentFeeAmt12(StringUtils.isBlank(value) ? null : value);

		Double rentFeeAmt01 = StringUtils.isBlank(rptDto.getRentFeeAmt01()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt01());
		Double rentFeeAmt02 = StringUtils.isBlank(rptDto.getRentFeeAmt02()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt02());
		Double rentFeeAmt03 = StringUtils.isBlank(rptDto.getRentFeeAmt03()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt03());
		Double rentFeeAmt04 = StringUtils.isBlank(rptDto.getRentFeeAmt04()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt04());
		Double rentFeeAmt05 = StringUtils.isBlank(rptDto.getRentFeeAmt05()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt05());
		Double rentFeeAmt06 = StringUtils.isBlank(rptDto.getRentFeeAmt06()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt06());
		Double rentFeeAmt07 = StringUtils.isBlank(rptDto.getRentFeeAmt07()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt07());
		Double rentFeeAmt08 = StringUtils.isBlank(rptDto.getRentFeeAmt08()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt08());
		Double rentFeeAmt09 = StringUtils.isBlank(rptDto.getRentFeeAmt09()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt09());
		Double rentFeeAmt10 = StringUtils.isBlank(rptDto.getRentFeeAmt10()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt10());
		Double rentFeeAmt11 = StringUtils.isBlank(rptDto.getRentFeeAmt11()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt11());
		Double rentFeeAmt12 = StringUtils.isBlank(rptDto.getRentFeeAmt12()) ? 0.00 : Double.parseDouble(rptDto.getRentFeeAmt12());

		Double rentFeeAmtQ1 = rentFeeAmt01 + rentFeeAmt02 + rentFeeAmt03;
		Double rentFeeAmtQ2 = rentFeeAmt04 + rentFeeAmt05 + rentFeeAmt06;
		Double rentFeeAmtQ3 = rentFeeAmt07 + rentFeeAmt08 + rentFeeAmt09;
		Double rentFeeAmtQ4 = rentFeeAmt10 + rentFeeAmt11 + rentFeeAmt12;

		Double rentFeeAmtTot = rentFeeAmtQ1 + rentFeeAmtQ2 + rentFeeAmtQ3 + rentFeeAmtQ4;
		rptDto.setRentFeeAmtQ1(Double.toString(rentFeeAmtQ1));
		rptDto.setRentFeeAmtQ2(Double.toString(rentFeeAmtQ2));
		rptDto.setRentFeeAmtQ3(Double.toString(rentFeeAmtQ3));
		rptDto.setRentFeeAmtQ4(Double.toString(rentFeeAmtQ4));
		rptDto.setRentFeeAmtQ4(Double.toString(rentFeeAmtQ4));
		rptDto.setRentFeeAmtTot(Double.toString(rentFeeAmtTot));

		return rptDto;
	}

	@Override
	public Map<String, String> getBoothRentFeeMapByGroup(List<BoothGroupDto> groupList, String collectYear) throws Exception {
		Map<String, String> rentFeeMap = new HashMap<String, String>();
		Map<String, String> rentFeeMap_tmp = new HashMap<String, String>();

		String rentFee01 = "0.00";
		String rentFee02 = "0.00";
		String rentFee03 = "0.00";
		String rentFee04 = "0.00";
		String rentFee05 = "0.00";
		String rentFee06 = "0.00";
		String rentFee07 = "0.00";
		String rentFee08 = "0.00";
		String rentFee09 = "0.00";
		String rentFee10 = "0.00";
		String rentFee11 = "0.00";
		String rentFee12 = "0.00";

		HashMap<String, String> param = new HashMap<String, String>();
		String groupId = "";
		String key = "";
		String value = "";
		String boothId = "";
		String rentFeeType = "";
		List<BoothDto> boothList = null;

		for (BoothGroupDto boothGroupDto : groupList) {
			groupId = boothGroupDto.getGroupId();
			param.put("groupId", groupId);

			boothList = getSqlSession().selectList("mySqlResourceManagerDao.getBoothInfoList", param);

			rentFee01 = "0.00";
			rentFee02 = "0.00";
			rentFee03 = "0.00";
			rentFee04 = "0.00";
			rentFee05 = "0.00";
			rentFee06 = "0.00";
			rentFee07 = "0.00";
			rentFee08 = "0.00";
			rentFee09 = "0.00";
			rentFee10 = "0.00";
			rentFee11 = "0.00";
			rentFee12 = "0.00";

			rentFeeMap_tmp = new HashMap<String, String>();
			for (BoothDto boothDto : boothList) {
				boothId = boothDto.getBoothId();
				rentFeeType = boothDto.getRentFeeType();
				rentFeeMap_tmp = this.getBoothRentFeeAmountMap(boothId, rentFeeType, collectYear);

				key = boothId + "|" + "01";
				value = rentFeeMap_tmp.get(key);
				rentFee01 = Double.toString(Double.parseDouble(rentFee01) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "02";
				value = rentFeeMap_tmp.get(key);
				rentFee02 = Double.toString(Double.parseDouble(rentFee02) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "03";
				value = rentFeeMap_tmp.get(key);
				rentFee03 = Double.toString(Double.parseDouble(rentFee03) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "04";
				value = rentFeeMap_tmp.get(key);
				rentFee04 = Double.toString(Double.parseDouble(rentFee04) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "05";
				value = rentFeeMap_tmp.get(key);
				rentFee05 = Double.toString(Double.parseDouble(rentFee05) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "06";
				value = rentFeeMap_tmp.get(key);
				rentFee06 = Double.toString(Double.parseDouble(rentFee06) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "07";
				value = rentFeeMap_tmp.get(key);
				rentFee07 = Double.toString(Double.parseDouble(rentFee07) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "08";
				value = rentFeeMap_tmp.get(key);
				rentFee08 = Double.toString(Double.parseDouble(rentFee08) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "09";
				value = rentFeeMap_tmp.get(key);
				rentFee09 = Double.toString(Double.parseDouble(rentFee09) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "10";
				value = rentFeeMap_tmp.get(key);
				rentFee10 = Double.toString(Double.parseDouble(rentFee10) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "11";
				value = rentFeeMap_tmp.get(key);
				rentFee11 = Double.toString(Double.parseDouble(rentFee11) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

				key = boothId + "|" + "12";
				value = rentFeeMap_tmp.get(key);
				rentFee12 = Double.toString(Double.parseDouble(rentFee12) + (StringUtils.isBlank(value) ? 0.00 : Double.parseDouble(value)));

			}
			rentFeeMap.put(groupId + "|" + "01", rentFee01);
			rentFeeMap.put(groupId + "|" + "02", rentFee02);
			rentFeeMap.put(groupId + "|" + "03", rentFee03);
			rentFeeMap.put(groupId + "|" + "04", rentFee04);
			rentFeeMap.put(groupId + "|" + "05", rentFee05);
			rentFeeMap.put(groupId + "|" + "06", rentFee06);
			rentFeeMap.put(groupId + "|" + "07", rentFee07);
			rentFeeMap.put(groupId + "|" + "08", rentFee08);
			rentFeeMap.put(groupId + "|" + "09", rentFee09);
			rentFeeMap.put(groupId + "|" + "10", rentFee10);
			rentFeeMap.put(groupId + "|" + "11", rentFee11);
			rentFeeMap.put(groupId + "|" + "12", rentFee12);

		}

		return rentFeeMap;
	}

}
