/**
 * 2013 PhotoMeReportService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.report.service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.user.UserDto;
import com.cosmos.framework.user.dao.UserDao;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.MoneyCollectRptDto;
import com.photome.report.dao.MoneyCollectRptMapDao;
import com.photome.resmanage.dao.ResourceManageDao;

/**
 * @author Steven J.S Min
 * 
 */
public class PhotoMeReportService implements PhotoMeReport {
	@Resource(name = "moneyCollectRptMapDao")
	private MoneyCollectRptMapDao moneyCollectRptMapDao;

	@Resource(name = "resManageDao")
	private ResourceManageDao resManageDao;

	@Resource(name = "userDao")
	private UserDao userDao;

	@Override
	public List<MoneyCollectRptDto> getReportDataForRpt01(HashMap<String, String> param) throws Exception {

		List<MoneyCollectRptDto> reportList = new ArrayList<MoneyCollectRptDto>();
		String groupId = param.get("groupId");

		if (StringUtils.equalsIgnoreCase(groupId, "ALL")) {
			List<BoothGroupDto> groupList = resManageDao.getBoothGroupInfoList(new HashMap<String, String>());
			for (BoothGroupDto groupDto : groupList) {
				// 리포트를 생성할 대상 Booth목록을 얻는다.
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("groupId", groupDto.getGroupId());
				List<BoothDto> boothList = resManageDao.getBoothInfoList(map);

				// 집계 대상이되는 Booth에대하여
				// "Key=BoothID|월, 렌트비" 형태로 맵에 저장한다.
				Map rentFeeMap = new HashMap<String, String>();
				for (BoothDto boothDto : boothList) {
					rentFeeMap.putAll(moneyCollectRptMapDao.getBoothRentFeeAmountMap(boothDto.getBoothId(), boothDto.getRentFeeType(), param.get("collectYear")));
				}
				Map realIncomeMap = moneyCollectRptMapDao.getCollectRealIncomeMap(param);
				Map refundMap = moneyCollectRptMapDao.getRefundMap(param);

				MoneyCollectRptDto rptDto = null;

				String boothId = "";
				for (BoothDto boothDto : boothList) {
					rptDto = new MoneyCollectRptDto();
					rptDto.setBoothDto(boothDto);

					boothId = boothDto.getBoothId();

					rptDto = setMonthCollectAmount(realIncomeMap, rptDto, boothId);
					rptDto = setMonthRentFeeAmount(rentFeeMap, rptDto, boothId);
					rptDto = setMonthRefundAmount(refundMap, rptDto, boothId);
					rptDto = setRatioOfReturnIncome(rptDto);

					reportList.add(rptDto);
				}
			}

		} else {
			// 리포트를 생성할 대상 Booth목록을 얻는다.
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("groupId", groupId);
			List<BoothDto> boothList = resManageDao.getBoothInfoList(map);

			// 집계 대상이되는 Booth에대하여
			// "Key=BoothID|월, 렌트비" 형태로 맵에 저장한다.
			Map rentFeeMap = new HashMap<String, String>();
			for (BoothDto boothDto : boothList) {
				rentFeeMap.putAll(moneyCollectRptMapDao.getBoothRentFeeAmountMap(boothDto.getBoothId(), boothDto.getRentFeeType(), param.get("collectYear")));
			}
			Map realIncomeMap = moneyCollectRptMapDao.getCollectRealIncomeMap(param);
			Map refundMap = moneyCollectRptMapDao.getRefundMap(param);

			MoneyCollectRptDto rptDto = null;

			String boothId = "";
			for (BoothDto boothDto : boothList) {
				rptDto = new MoneyCollectRptDto();
				rptDto.setBoothDto(boothDto);

				boothId = boothDto.getBoothId();

				rptDto = setMonthCollectAmount(realIncomeMap, rptDto, boothId);
				rptDto = setMonthRentFeeAmount(rentFeeMap, rptDto, boothId);
				rptDto = setMonthRefundAmount(refundMap, rptDto, boothId);
				rptDto = setRatioOfReturnIncome(rptDto);

				reportList.add(rptDto);
			}
		}

		return reportList;
	}

	@Override
	public List<MoneyCollectRptDto> getReportDataForRpt02(HashMap<String, String> param) throws Exception {
		// 리포트를 생성할 대상 Booth목록을 얻는다.
		List<BoothGroupDto> groupList = resManageDao.getBoothGroupInfoList(new HashMap<String, String>());

		Map rentFeeMap = moneyCollectRptMapDao.getBoothRentFeeMapByGroup(groupList, param.get("collectYear"));
		Map realIncomeMap = moneyCollectRptMapDao.getCollectRealIncomeMapByGroup(param);
		Map refundMap = moneyCollectRptMapDao.getRefundMapByGroup(param);

		List<MoneyCollectRptDto> reportList = new ArrayList<MoneyCollectRptDto>();
		MoneyCollectRptDto rptDto = null;

		String groupId = "";
		for (BoothGroupDto boothGroupDto : groupList) {
			rptDto = new MoneyCollectRptDto();
			rptDto.setBoothGroupDto(boothGroupDto);

			groupId = boothGroupDto.getGroupId();

			rptDto = setMonthCollectAmount(realIncomeMap, rptDto, groupId);
			rptDto = setMonthRentFeeAmount(rentFeeMap, rptDto, groupId);
			rptDto = setMonthRefundAmount(refundMap, rptDto, groupId);
			rptDto = setRatioOfReturnIncome(rptDto);

			reportList.add(rptDto);
		}

		return reportList;
	}

	@Override
	public List<UserDto> getCollectorList(String collectYear, String userId) throws Exception {
		List<UserDto> collectorList = moneyCollectRptMapDao.getCollectorList(collectYear, userId);
		return collectorList;
	}

	@Override
	public List<MoneyCollectRptDto> getReportDataForRpt03(HashMap<String, String> param) throws Exception {
		String collectYear = param.get("collectYear");
		String userId = param.get("userId");
		Map<String, String> collectMap = moneyCollectRptMapDao.getCollectAmtPerPerson(collectYear, userId);

		List<MoneyCollectRptDto> reportList = new ArrayList<MoneyCollectRptDto>();
		MoneyCollectRptDto rptDto = null;

		List<UserDto> collectorList = moneyCollectRptMapDao.getCollectorList(collectYear, userId);
		String keyUserId = "";
		String collectAmt01 = "";
		String collectAmt02 = "";
		String collectAmt03 = "";
		String collectAmt04 = "";
		String collectAmt05 = "";
		String collectAmt06 = "";
		String collectAmt07 = "";
		String collectAmt08 = "";
		String collectAmt09 = "";
		String collectAmt10 = "";
		String collectAmt11 = "";
		String collectAmt12 = "";
		for (UserDto userDto : collectorList) {
			rptDto = new MoneyCollectRptDto();
			keyUserId = userDto.getUserId();

			collectAmt01 = (String) collectMap.get(keyUserId + "|01");
			if (StringUtils.isBlank(collectAmt01)) collectAmt01 = "0.00";
			rptDto.setCollectAmt01(collectAmt01);

			collectAmt02 = (String) collectMap.get(keyUserId + "|02");
			if (StringUtils.isBlank(collectAmt02)) collectAmt02 = "0.00";
			rptDto.setCollectAmt02(collectAmt02);

			collectAmt03 = (String) collectMap.get(keyUserId + "|03");
			if (StringUtils.isBlank(collectAmt03)) collectAmt03 = "0.00";
			rptDto.setCollectAmt03(collectAmt03);

			collectAmt04 = (String) collectMap.get(keyUserId + "|04");
			if (StringUtils.isBlank(collectAmt04)) collectAmt04 = "0.00";
			rptDto.setCollectAmt04(collectAmt04);

			collectAmt05 = (String) collectMap.get(keyUserId + "|05");
			if (StringUtils.isBlank(collectAmt05)) collectAmt05 = "0.00";
			rptDto.setCollectAmt05(collectAmt05);

			collectAmt06 = (String) collectMap.get(keyUserId + "|06");
			if (StringUtils.isBlank(collectAmt06)) collectAmt06 = "0.00";
			rptDto.setCollectAmt06(collectAmt06);

			collectAmt07 = (String) collectMap.get(keyUserId + "|07");
			if (StringUtils.isBlank(collectAmt07)) collectAmt07 = "0.00";
			rptDto.setCollectAmt07(collectAmt07);

			collectAmt08 = (String) collectMap.get(keyUserId + "|08");
			if (StringUtils.isBlank(collectAmt08)) collectAmt08 = "0.00";
			rptDto.setCollectAmt08(collectAmt08);

			collectAmt09 = (String) collectMap.get(keyUserId + "|09");
			if (StringUtils.isBlank(collectAmt09)) collectAmt09 = "0.00";
			rptDto.setCollectAmt09(collectAmt09);

			collectAmt10 = (String) collectMap.get(keyUserId + "|10");
			if (StringUtils.isBlank(collectAmt10)) collectAmt10 = "0.00";
			rptDto.setCollectAmt10(collectAmt10);

			collectAmt11 = (String) collectMap.get(keyUserId + "|11");
			if (StringUtils.isBlank(collectAmt11)) collectAmt11 = "0.00";
			rptDto.setCollectAmt11(collectAmt11);

			collectAmt12 = (String) collectMap.get(keyUserId + "|12");
			if (StringUtils.isBlank(collectAmt12)) collectAmt12 = "0.00";
			rptDto.setCollectAmt12(collectAmt12);

			Double collectAmtQ1 = Double.parseDouble(collectAmt01) + Double.parseDouble(collectAmt02) + Double.parseDouble(collectAmt03);
			Double collectAmtQ2 = Double.parseDouble(collectAmt04) + Double.parseDouble(collectAmt05) + Double.parseDouble(collectAmt06);
			Double collectAmtQ3 = Double.parseDouble(collectAmt07) + Double.parseDouble(collectAmt08) + Double.parseDouble(collectAmt09);
			Double collectAmtQ4 = Double.parseDouble(collectAmt10) + Double.parseDouble(collectAmt11) + Double.parseDouble(collectAmt12);
			Double collectAmtTotal = collectAmtQ1 + collectAmtQ2 + collectAmtQ3 + collectAmtQ4;
			rptDto.setCollectAmtQ1(roundOff(collectAmtQ1));
			rptDto.setCollectAmtQ2(roundOff(collectAmtQ2));
			rptDto.setCollectAmtQ3(roundOff(collectAmtQ3));
			rptDto.setCollectAmtQ4(roundOff(collectAmtQ4));
			rptDto.setCollectAmtTot(roundOff(collectAmtTotal));

			rptDto.setUserDto(userDao.getUserInfo(keyUserId));

			reportList.add(rptDto);
		}

		return reportList;
	}

	@Override
	public MoneyCollectRptDto getGroupRentFee(String groupId, String collectYear) throws Exception {
		MoneyCollectRptDto moneyCollectRptDto = moneyCollectRptMapDao.getGroupRentFee(groupId, collectYear);
		return moneyCollectRptDto;
	}

	/**
	 * 월별 수익비율 설정
	 * 
	 * @param rptDto
	 * @return
	 */
	private MoneyCollectRptDto setRatioOfReturnIncome(MoneyCollectRptDto rptDto) {

		// 월별 수익비율 설정
		Double cost01 = Double.parseDouble(rptDto.getRefundAmt01()) + Double.parseDouble(rptDto.getRentFeeAmt01());
		Double collectAmt01 = Double.parseDouble(rptDto.getCollectAmt01());
		rptDto.setRateOfReturn01(roundOff(collectAmt01 - cost01));
		if (collectAmt01 != 0) {
			Double rateOfExpense01 = (cost01 / collectAmt01) * 100;
			rptDto.setRateOfExpense01(roundOff(rateOfExpense01));
		}

		Double cost02 = Double.parseDouble(rptDto.getRefundAmt02()) + Double.parseDouble(rptDto.getRentFeeAmt02());
		Double collectAmt02 = Double.parseDouble(rptDto.getCollectAmt02());
		rptDto.setRateOfReturn02(roundOff(collectAmt02 - cost02));
		if (collectAmt02 != 0) {
			Double rateOfExpense02 = (cost02 / collectAmt02) * 100;
			rptDto.setRateOfExpense02(roundOff(rateOfExpense02));
		}

		Double cost03 = Double.parseDouble(rptDto.getRefundAmt03()) + Double.parseDouble(rptDto.getRentFeeAmt03());
		Double collectAmt03 = Double.parseDouble(rptDto.getCollectAmt03());
		rptDto.setRateOfReturn03(roundOff(collectAmt03 - cost03));
		if (collectAmt03 != 0) {
			Double rateOfExpense03 = (cost03 / collectAmt03) * 100;
			rptDto.setRateOfExpense03(roundOff(rateOfExpense03));
		}

		Double cost04 = Double.parseDouble(rptDto.getRefundAmt04()) + Double.parseDouble(rptDto.getRentFeeAmt04());
		Double collectAmt04 = Double.parseDouble(rptDto.getCollectAmt04());
		rptDto.setRateOfReturn04(roundOff(collectAmt04 - cost04));
		if (collectAmt04 != 0) {
			Double rateOfExpense04 = (cost04 / collectAmt04) * 100;
			rptDto.setRateOfExpense04(roundOff(rateOfExpense04));
		}

		Double cost05 = Double.parseDouble(rptDto.getRefundAmt05()) + Double.parseDouble(rptDto.getRentFeeAmt05());
		Double collectAmt05 = Double.parseDouble(rptDto.getCollectAmt05());
		rptDto.setRateOfReturn05(roundOff(collectAmt05 - cost05));
		if (collectAmt05 != 0) {
			Double rateOfExpense05 = (cost05 / collectAmt05) * 100;
			rptDto.setRateOfExpense05(roundOff(rateOfExpense05));
		}

		Double cost06 = Double.parseDouble(rptDto.getRefundAmt06()) + Double.parseDouble(rptDto.getRentFeeAmt06());
		Double collectAmt06 = Double.parseDouble(rptDto.getCollectAmt06());
		rptDto.setRateOfReturn06(roundOff(collectAmt06 - cost06));
		if (collectAmt06 != 0) {
			Double rateOfExpense06 = (cost06 / collectAmt06) * 100;
			rptDto.setRateOfExpense06(roundOff(rateOfExpense06));
		}

		Double cost07 = Double.parseDouble(rptDto.getRefundAmt07()) + Double.parseDouble(rptDto.getRentFeeAmt07());
		Double collectAmt07 = Double.parseDouble(rptDto.getCollectAmt07());
		rptDto.setRateOfReturn07(roundOff(collectAmt07 - cost07));
		if (collectAmt07 != 0) {
			Double rateOfExpense07 = (cost07 / collectAmt07) * 100;
			rptDto.setRateOfExpense07(roundOff(rateOfExpense07));
		}

		Double cost08 = Double.parseDouble(rptDto.getRefundAmt08()) + Double.parseDouble(rptDto.getRentFeeAmt08());
		Double collectAmt08 = Double.parseDouble(rptDto.getCollectAmt08());
		rptDto.setRateOfReturn08(roundOff(collectAmt08 - cost08));
		if (collectAmt08 != 0) {
			Double rateOfExpense08 = (cost08 / collectAmt08) * 100;
			rptDto.setRateOfExpense08(roundOff(rateOfExpense08));
		}

		Double cost09 = Double.parseDouble(rptDto.getRefundAmt09()) + Double.parseDouble(rptDto.getRentFeeAmt09());
		Double collectAmt09 = Double.parseDouble(rptDto.getCollectAmt09());
		rptDto.setRateOfReturn09(roundOff(collectAmt09 - cost09));
		if (collectAmt09 != 0) {
			Double rateOfExpense09 = (cost09 / collectAmt09) * 100;
			rptDto.setRateOfExpense09(roundOff(rateOfExpense09));
		}

		Double cost10 = Double.parseDouble(rptDto.getRefundAmt10()) + Double.parseDouble(rptDto.getRentFeeAmt10());
		Double collectAmt10 = Double.parseDouble(rptDto.getCollectAmt10());
		rptDto.setRateOfReturn10(roundOff(collectAmt10 - cost10));
		if (collectAmt10 != 0) {
			Double rateOfExpense10 = (cost10 / collectAmt10) * 100;
			rptDto.setRateOfExpense10(roundOff(rateOfExpense10));
		}

		Double cost11 = Double.parseDouble(rptDto.getRefundAmt11()) + Double.parseDouble(rptDto.getRentFeeAmt11());
		Double collectAmt11 = Double.parseDouble(rptDto.getCollectAmt11());
		rptDto.setRateOfReturn11(roundOff(collectAmt11 - cost11));
		if (collectAmt11 != 0) {
			Double rateOfExpense11 = (cost11 / collectAmt11) * 100;
			rptDto.setRateOfExpense11(roundOff(rateOfExpense11));
		}

		Double cost12 = Double.parseDouble(rptDto.getRefundAmt12()) + Double.parseDouble(rptDto.getRentFeeAmt12());
		Double collectAmt12 = Double.parseDouble(rptDto.getCollectAmt12());
		rptDto.setRateOfReturn12(roundOff(collectAmt12 - cost12));
		if (collectAmt12 != 0) {
			Double rateOfExpense12 = (cost12 / collectAmt12) * 100;
			rptDto.setRateOfExpense12(roundOff(rateOfExpense12));
		}

		// 분기별 수익율 설정
		Double costQ1 = cost01 + cost02 + cost03;
		Double collectAmtQ1 = collectAmt01 + collectAmt02 + collectAmt03;
		rptDto.setRateOfReturnQ1(roundOff(collectAmtQ1 - costQ1));
		if (collectAmtQ1 != 0) {
			Double rateOfExpenseQ1 = (costQ1 / collectAmtQ1) * 100;
			rptDto.setRateOfExpenseQ1(roundOff(Math.round(rateOfExpenseQ1)));
		}

		Double costQ2 = cost04 + cost05 + cost06;
		Double collectAmtQ2 = collectAmt04 + collectAmt05 + collectAmt06;
		rptDto.setRateOfReturnQ2(roundOff(collectAmtQ2 - costQ2));
		if (collectAmtQ2 != 0) {
			Double rateOfExpenseQ2 = (costQ2 / collectAmtQ2) * 100;
			rptDto.setRateOfExpenseQ2(roundOff(Math.round(rateOfExpenseQ2)));
		}

		Double costQ3 = cost07 + cost08 + cost09;
		Double collectAmtQ3 = collectAmt07 + collectAmt08 + collectAmt09;
		rptDto.setRateOfReturnQ3(roundOff(collectAmtQ3 - costQ3));
		if (collectAmtQ3 != 0) {
			Double rateOfExpenseQ3 = (costQ3 / collectAmtQ3) * 100;
			rptDto.setRateOfExpenseQ3(roundOff(Math.round(rateOfExpenseQ3)));
		}

		Double costQ4 = cost10 + cost11 + cost12;
		Double collectAmtQ4 = collectAmt10 + collectAmt11 + collectAmt12;
		rptDto.setRateOfReturnQ4(roundOff(collectAmtQ4 - costQ4));
		if (collectAmtQ4 != 0) {
			Double rateOfExpenseQ4 = (costQ4 / collectAmtQ4) * 100;
			rptDto.setRateOfExpenseQ4(roundOff(Math.round(rateOfExpenseQ4)));
		}

		Double costAmt = costQ1 + costQ2 + costQ3 + costQ4;
		Double collectAmt = collectAmtQ1 + collectAmtQ2 + collectAmtQ3 + collectAmtQ4;
		rptDto.setRateOfReturnTot(roundOff(collectAmt - costAmt));
		if (collectAmt != 0) {
			Double rateOfExpense = (costAmt / collectAmt) * 100;
			rptDto.setRateOfExpenseTot(roundOff(Math.round(rateOfExpense)));
		}

		return rptDto;
	}

	private MoneyCollectRptDto setMonthRefundAmount(Map refundMap, MoneyCollectRptDto rptDto, String prefixKey) {
		String value = "";

		value = (String) refundMap.get(prefixKey + "|01");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt01(value);

		value = (String) refundMap.get(prefixKey + "|02");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt02(value);

		value = (String) refundMap.get(prefixKey + "|03");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt03(value);

		value = (String) refundMap.get(prefixKey + "|04");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt04(value);

		value = (String) refundMap.get(prefixKey + "|05");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt05(value);

		value = (String) refundMap.get(prefixKey + "|06");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt06(value);

		value = (String) refundMap.get(prefixKey + "|07");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt07(value);

		value = (String) refundMap.get(prefixKey + "|08");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt08(value);

		value = (String) refundMap.get(prefixKey + "|09");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt09(value);

		value = (String) refundMap.get(prefixKey + "|10");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt10(value);

		value = (String) refundMap.get(prefixKey + "|11");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt11(value);

		value = (String) refundMap.get(prefixKey + "|12");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRefundAmt12(value);

		Double amtQ1 = Double.parseDouble(rptDto.getRefundAmt01()) + Double.parseDouble(rptDto.getRefundAmt02()) + Double.parseDouble(rptDto.getRefundAmt03());
		Double amtQ2 = Double.parseDouble(rptDto.getRefundAmt04()) + Double.parseDouble(rptDto.getRefundAmt05()) + Double.parseDouble(rptDto.getRefundAmt06());
		Double amtQ3 = Double.parseDouble(rptDto.getRefundAmt07()) + Double.parseDouble(rptDto.getRefundAmt08()) + Double.parseDouble(rptDto.getRefundAmt09());
		Double amtQ4 = Double.parseDouble(rptDto.getRefundAmt10()) + Double.parseDouble(rptDto.getRefundAmt11()) + Double.parseDouble(rptDto.getRefundAmt12());
		rptDto.setRefundAmtQ1(roundOff(amtQ1));
		rptDto.setRefundAmtQ2(roundOff(amtQ2));
		rptDto.setRefundAmtQ3(roundOff(amtQ3));
		rptDto.setRefundAmtQ4(roundOff(amtQ4));

		rptDto.setRefundAmtTot(roundOff(amtQ1 + amtQ2 + amtQ3 + amtQ4));

		return rptDto;
	}

	/**
	 * 리포트 데이터DTO에 렌트비 정보를 설정한다.
	 * 
	 * @param realIncomeMap
	 * @param rptDto
	 * @param prefixKey
	 * @return
	 */
	private MoneyCollectRptDto setMonthRentFeeAmount(Map rentFeeMap, MoneyCollectRptDto rptDto, String prefixKey) {
		String value = "";

		value = (String) rentFeeMap.get(prefixKey + "|01");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt01(roundOff(Double.parseDouble(value)));

		value = (String) rentFeeMap.get(prefixKey + "|02");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt02(value);

		value = (String) rentFeeMap.get(prefixKey + "|03");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt03(value);

		value = (String) rentFeeMap.get(prefixKey + "|04");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt04(value);

		value = (String) rentFeeMap.get(prefixKey + "|05");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt05(value);

		value = (String) rentFeeMap.get(prefixKey + "|06");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt06(value);

		value = (String) rentFeeMap.get(prefixKey + "|07");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt07(value);

		value = (String) rentFeeMap.get(prefixKey + "|08");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt08(value);

		value = (String) rentFeeMap.get(prefixKey + "|09");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt09(value);

		value = (String) rentFeeMap.get(prefixKey + "|10");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt10(value);

		value = (String) rentFeeMap.get(prefixKey + "|11");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt11(value);

		value = (String) rentFeeMap.get(prefixKey + "|12");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setRentFeeAmt12(value);

		int curYear = GregorianCalendar.getInstance().get(Calendar.YEAR);

		Double amtQ1 = Double.parseDouble(rptDto.getRentFeeAmt01()) + Double.parseDouble(rptDto.getRentFeeAmt02()) + Double.parseDouble(rptDto.getRentFeeAmt03());
		Double amtQ2 = Double.parseDouble(rptDto.getRentFeeAmt04()) + Double.parseDouble(rptDto.getRentFeeAmt05()) + Double.parseDouble(rptDto.getRentFeeAmt06());
		Double amtQ3 = Double.parseDouble(rptDto.getRentFeeAmt07()) + Double.parseDouble(rptDto.getRentFeeAmt08()) + Double.parseDouble(rptDto.getRentFeeAmt09());
		Double amtQ4 = Double.parseDouble(rptDto.getRentFeeAmt10()) + Double.parseDouble(rptDto.getRentFeeAmt11()) + Double.parseDouble(rptDto.getRentFeeAmt12());
		rptDto.setRentFeeAmtQ1(roundOff(amtQ1));
		rptDto.setRentFeeAmtQ2(roundOff(amtQ2));
		rptDto.setRentFeeAmtQ3(roundOff(amtQ3));
		rptDto.setRentFeeAmtQ4(roundOff(amtQ4));

		rptDto.setRentFeeAmtTot(roundOff(amtQ1 + amtQ2 + amtQ3 + amtQ4));

		return rptDto;
	}

	/**
	 * 리포트 데이터DTO에 수금액정보를 설정한다.
	 * 
	 * @param realIncomeMap
	 * @param rptDto
	 * @param prefixKey
	 * @return
	 */
	private MoneyCollectRptDto setMonthCollectAmount(Map realIncomeMap, MoneyCollectRptDto rptDto, String prefixKey) {
		String value = "";

		value = (String) realIncomeMap.get(prefixKey + "|01");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt01(value);

		value = (String) realIncomeMap.get(prefixKey + "|02");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt02(value);

		value = (String) realIncomeMap.get(prefixKey + "|03");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt03(value);

		value = (String) realIncomeMap.get(prefixKey + "|04");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt04(value);

		value = (String) realIncomeMap.get(prefixKey + "|05");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt05(value);

		value = (String) realIncomeMap.get(prefixKey + "|06");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt06(value);

		value = (String) realIncomeMap.get(prefixKey + "|07");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt07(value);

		value = (String) realIncomeMap.get(prefixKey + "|08");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt08(value);

		value = (String) realIncomeMap.get(prefixKey + "|09");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt09(value);

		value = (String) realIncomeMap.get(prefixKey + "|10");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt10(value);

		value = (String) realIncomeMap.get(prefixKey + "|11");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt11(value);

		value = (String) realIncomeMap.get(prefixKey + "|12");
		if (StringUtils.isBlank(value)) value = "0.00";
		rptDto.setCollectAmt12(value);

		Double amtQ1 = Double.parseDouble(rptDto.getCollectAmt01()) + Double.parseDouble(rptDto.getCollectAmt02()) + Double.parseDouble(rptDto.getCollectAmt03());
		Double amtQ2 = Double.parseDouble(rptDto.getCollectAmt04()) + Double.parseDouble(rptDto.getCollectAmt05()) + Double.parseDouble(rptDto.getCollectAmt06());
		Double amtQ3 = Double.parseDouble(rptDto.getCollectAmt07()) + Double.parseDouble(rptDto.getCollectAmt08()) + Double.parseDouble(rptDto.getCollectAmt09());
		Double amtQ4 = Double.parseDouble(rptDto.getCollectAmt10()) + Double.parseDouble(rptDto.getCollectAmt11()) + Double.parseDouble(rptDto.getCollectAmt12());
		rptDto.setCollectAmtQ1(roundOff(amtQ1));
		rptDto.setCollectAmtQ2(roundOff(amtQ2));
		rptDto.setCollectAmtQ3(roundOff(amtQ3));
		rptDto.setCollectAmtQ4(roundOff(amtQ4));

		rptDto.setCollectAmtTot(roundOff(amtQ1 + amtQ2 + amtQ3 + amtQ4));

		return rptDto;
	}

	private static String roundOff(double num) {
		int point = 2;
		String roundStr = String.valueOf(Math.floor(num * Math.pow(10, point) + 0.5) / Math.pow(10, point));

		DecimalFormat df = new DecimalFormat("#########0.00");
		String returnVal = df.format(Double.parseDouble(roundStr));

		return returnVal;

	}
}
