/**
 * 2013 PhotoMeReportService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.report.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

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

	@Override
	public List<MoneyCollectRptDto> getReportDataForRpt01(HashMap<String, String> param) throws Exception {

		// 리포트를 생성할 대상 Booth목록을 얻는다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("groupId", param.get("groupId"));
		List<BoothDto> boothList = resManageDao.getBoothInfoList(map);
		
		// 집계 대상이되는 Booth에대하여
		// "Key=BoothID|월, 렌트비" 형태로 맵에 저장한다.
		Map rentFeeMap = new HashMap<String, String>();
		for (BoothDto boothDto : boothList) {
			rentFeeMap.putAll(moneyCollectRptMapDao.getBoothRentFeeAmountMap(boothDto.getBoothId(), boothDto.getRentFeeType(), param.get("collectYear")));
		}
		Map realIncomeMap = moneyCollectRptMapDao.getCollectRealIncomeMap(param);
		Map refundMap = moneyCollectRptMapDao.getRefundMap(param);

		List<MoneyCollectRptDto> reportList = new ArrayList<MoneyCollectRptDto>();
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
		rptDto.setRateOfReturn01(Double.toString(collectAmt01 - cost01));

		Double cost02 = Double.parseDouble(rptDto.getRefundAmt02()) + Double.parseDouble(rptDto.getRentFeeAmt02());
		Double collectAmt02 = Double.parseDouble(rptDto.getCollectAmt02());
		rptDto.setRateOfReturn02(Double.toString(collectAmt02 - cost02));

		Double cost03 = Double.parseDouble(rptDto.getRefundAmt03()) + Double.parseDouble(rptDto.getRentFeeAmt03());
		Double collectAmt03 = Double.parseDouble(rptDto.getCollectAmt03());
		rptDto.setRateOfReturn03(Double.toString(collectAmt03 - cost03));

		Double cost04 = Double.parseDouble(rptDto.getRefundAmt04()) + Double.parseDouble(rptDto.getRentFeeAmt04());
		Double collectAmt04 = Double.parseDouble(rptDto.getCollectAmt04());
		rptDto.setRateOfReturn04(Double.toString(collectAmt04 - cost04));

		Double cost05 = Double.parseDouble(rptDto.getRefundAmt05()) + Double.parseDouble(rptDto.getRentFeeAmt05());
		Double collectAmt05 = Double.parseDouble(rptDto.getCollectAmt05());
		rptDto.setRateOfReturn05(Double.toString(collectAmt05 - cost05));

		Double cost06 = Double.parseDouble(rptDto.getRefundAmt06()) + Double.parseDouble(rptDto.getRentFeeAmt06());
		Double collectAmt06 = Double.parseDouble(rptDto.getCollectAmt06());
		rptDto.setRateOfReturn06(Double.toString(collectAmt06 - cost06));

		Double cost07 = Double.parseDouble(rptDto.getRefundAmt07()) + Double.parseDouble(rptDto.getRentFeeAmt07());
		Double collectAmt07 = Double.parseDouble(rptDto.getCollectAmt07());
		rptDto.setRateOfReturn07(Double.toString(collectAmt07 - cost07));

		Double cost08 = Double.parseDouble(rptDto.getRefundAmt08()) + Double.parseDouble(rptDto.getRentFeeAmt08());
		Double collectAmt08 = Double.parseDouble(rptDto.getCollectAmt08());
		rptDto.setRateOfReturn08(Double.toString(collectAmt08 - cost08));

		Double cost09 = Double.parseDouble(rptDto.getRefundAmt09()) + Double.parseDouble(rptDto.getRentFeeAmt09());
		Double collectAmt09 = Double.parseDouble(rptDto.getCollectAmt09());
		rptDto.setRateOfReturn09(Double.toString(collectAmt09 - cost09));

		Double cost10 = Double.parseDouble(rptDto.getRefundAmt10()) + Double.parseDouble(rptDto.getRentFeeAmt10());
		Double collectAmt10 = Double.parseDouble(rptDto.getCollectAmt10());
		rptDto.setRateOfReturn10(Double.toString(collectAmt10 - cost10));

		Double cost11 = Double.parseDouble(rptDto.getRefundAmt11()) + Double.parseDouble(rptDto.getRentFeeAmt11());
		Double collectAmt11 = Double.parseDouble(rptDto.getCollectAmt11());
		rptDto.setRateOfReturn11(Double.toString(collectAmt11 - cost11));

		Double cost12 = Double.parseDouble(rptDto.getRefundAmt12()) + Double.parseDouble(rptDto.getRentFeeAmt12());
		Double collectAmt12 = Double.parseDouble(rptDto.getCollectAmt12());
		rptDto.setRateOfReturn12(Double.toString(collectAmt12 - cost12));

		// 분기별 수익율 설정
		Double costQ1 = cost01 + cost02 + cost03;
		Double collectAmtQ1 = collectAmt01 + collectAmt02 + collectAmt03;
		rptDto.setRateOfReturnQ1(Double.toString(collectAmtQ1 - costQ1));

		Double costQ2 = cost04 + cost05 + cost06;
		Double collectAmtQ2 = collectAmt04 + collectAmt05 + collectAmt06;
		rptDto.setRateOfReturnQ2(Double.toString(collectAmtQ2 - costQ2));

		Double costQ3 = cost07 + cost08 + cost09;
		Double collectAmtQ3 = collectAmt07 + collectAmt08 + collectAmt09;
		rptDto.setRateOfReturnQ3(Double.toString(collectAmtQ3 - costQ3));

		Double costQ4 = cost10 + cost11 + cost12;
		Double collectAmtQ4 = collectAmt10 + collectAmt11 + collectAmt12;
		rptDto.setRateOfReturnQ4(Double.toString(collectAmtQ4 - costQ4));

		Double costAmt = costQ1 + costQ2 + costQ3 + costQ4;
		Double collectAmt = collectAmtQ1 + collectAmtQ2 + collectAmtQ3 + collectAmtQ4;
		rptDto.setRateOfReturnTot(Double.toString(collectAmt - costAmt));

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
		rptDto.setRefundAmtQ1(Double.toString(amtQ1));
		rptDto.setRefundAmtQ2(Double.toString(amtQ2));
		rptDto.setRefundAmtQ3(Double.toString(amtQ3));
		rptDto.setRefundAmtQ4(Double.toString(amtQ4));

		rptDto.setRefundAmtTot(Double.toString(amtQ1 + amtQ2 + amtQ3 + amtQ4));

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
		rptDto.setRentFeeAmt01(value);

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
		rptDto.setRentFeeAmtQ1(Double.toString(amtQ1));
		rptDto.setRentFeeAmtQ2(Double.toString(amtQ2));
		rptDto.setRentFeeAmtQ3(Double.toString(amtQ3));
		rptDto.setRentFeeAmtQ4(Double.toString(amtQ4));

		rptDto.setRentFeeAmtTot(Double.toString(amtQ1 + amtQ2 + amtQ3 + amtQ4));

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
		rptDto.setCollectAmtQ1(Double.toString(amtQ1));
		rptDto.setCollectAmtQ2(Double.toString(amtQ2));
		rptDto.setCollectAmtQ3(Double.toString(amtQ3));
		rptDto.setCollectAmtQ4(Double.toString(amtQ4));

		rptDto.setCollectAmtTot(Double.toString(amtQ1 + amtQ2 + amtQ3 + amtQ4));

		return rptDto;
	}

}
