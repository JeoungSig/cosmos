/**
 * 2013 BoothRentFeeService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.photome.dto.BoothFeePayStatusDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.BoothRentFeePayDto;
import com.photome.money.BoothRentFeePay;
import com.photome.money.dao.BoothRentFeePayDao;

/**
 * @author Steven J.S Min
 * 
 */
public class BoothRentFeePayService implements BoothRentFeePay {

	private static final Logger logger = LoggerFactory.getLogger(BoothRentFeePayService.class);

	@Resource(name = "boothRentFeePayDao")
	private BoothRentFeePayDao boothRentFeePayDao;

	@Override
	public List<BoothRentFeePayDto> getBoothRentFeePayInfoList(HashMap<String, String> param) throws Exception {
		return boothRentFeePayDao.getBoothRentFeePayInfoList(param);
	}

	@Override
	public boolean existBoothRentFeePayHistory(String groupId, String year, String month) throws Exception {
		return boothRentFeePayDao.existBoothRentFeePayHistory(groupId, year, month);
	}

	@Override
	public BoothRentFeePayDto getBoothRentFeePayInfo(String groupId, String year, String month) throws Exception {
		return boothRentFeePayDao.getBoothRentFeePayInfo(groupId, year, month);
	}

	@Override
	public Integer updateBoothRentFeePayInfo(HashMap<String, String> param) throws Exception {
		return boothRentFeePayDao.updateBoothRentFeePayInfo(param);
	}

	@Override
	public Integer deleteBoothRentFeePayInfo(String groupId, String year, String month) throws Exception {
		return boothRentFeePayDao.deleteBoothRentFeePayInfo(groupId, year, month);
	}

	@Override
	public Integer changeBoothRentFeePayStatus(String groupId, String year, String month, String status, String updator) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		param.put("year", year);
		param.put("month", month);
		param.put("updator", updator);
		return boothRentFeePayDao.changeBoothRentFeePayStatus(param);
	}

	@Override
	public Integer registBoothRentFeePayInfo(HashMap<String, String> param) throws Exception {
		return boothRentFeePayDao.registBoothRentFeePayInfo(param);
	}

	@Override
	public HashMap<String, Object> generateBoothRentFeePayStatusTable(List<BoothGroupDto> boothGroupList, String year) throws Exception {

		HashMap<String, Object> returnMap = new HashMap<String, Object>();

		List<BoothFeePayStatusDto> boothRentFeeStatusList = new ArrayList<BoothFeePayStatusDto>();
		BoothFeePayStatusDto boothRentFeeStatusDto = null;
		BoothFeePayStatusDto rentFeeTableFoot = new BoothFeePayStatusDto();

		String foot_month_01 = "0.00";
		String foot_month_02 = "0.00";
		String foot_month_03 = "0.00";
		String foot_month_04 = "0.00";
		String foot_month_05 = "0.00";
		String foot_month_06 = "0.00";
		String foot_month_07 = "0.00";
		String foot_month_08 = "0.00";
		String foot_month_09 = "0.00";
		String foot_month_10 = "0.00";
		String foot_month_11 = "0.00";
		String foot_month_12 = "0.00";

		String foot_month_total = "0.00";

		try {
			for (BoothGroupDto groupDto : boothGroupList) {
				boothRentFeeStatusDto = this.getRentFeeForYear(groupDto, year);

				foot_month_01 = Double.toString(Double.parseDouble(foot_month_01)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_01(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_01()));
				foot_month_02 = Double.toString(Double.parseDouble(foot_month_02)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_02(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_02()));
				foot_month_03 = Double.toString(Double.parseDouble(foot_month_03)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_03(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_03()));
				foot_month_04 = Double.toString(Double.parseDouble(foot_month_04)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_04(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_04()));
				foot_month_05 = Double.toString(Double.parseDouble(foot_month_05)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_05(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_05()));
				foot_month_06 = Double.toString(Double.parseDouble(foot_month_06)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_06(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_06()));
				foot_month_07 = Double.toString(Double.parseDouble(foot_month_07)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_07(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_07()));
				foot_month_08 = Double.toString(Double.parseDouble(foot_month_08)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_08(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_08()));
				foot_month_09 = Double.toString(Double.parseDouble(foot_month_09)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_09(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_09()));
				foot_month_10 = Double.toString(Double.parseDouble(foot_month_10)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_10(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_10()));
				foot_month_11 = Double.toString(Double.parseDouble(foot_month_11)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_11(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_11()));
				foot_month_12 = Double.toString(Double.parseDouble(foot_month_12)
						+ Double.parseDouble(StringUtils.equals(boothRentFeeStatusDto.getMonth_12(), "-") ? "0.00" : boothRentFeeStatusDto.getMonth_12()));

				boothRentFeeStatusList.add(cordinateCurrencyFormat(boothRentFeeStatusDto));
				
			}

			foot_month_total = Double.toString(Double.parseDouble(foot_month_01) + Double.parseDouble(foot_month_02) + Double.parseDouble(foot_month_03) + Double.parseDouble(foot_month_04)
					+ Double.parseDouble(foot_month_05) + Double.parseDouble(foot_month_06) + Double.parseDouble(foot_month_07) + Double.parseDouble(foot_month_08) + Double.parseDouble(foot_month_09)
					+ Double.parseDouble(foot_month_10) + Double.parseDouble(foot_month_11) + Double.parseDouble(foot_month_12));

			rentFeeTableFoot.setGroupId("rentFeeTableFoot");
			rentFeeTableFoot.setMonth_01(foot_month_01);
			rentFeeTableFoot.setMonth_02(foot_month_02);
			rentFeeTableFoot.setMonth_03(foot_month_03);
			rentFeeTableFoot.setMonth_04(foot_month_04);
			rentFeeTableFoot.setMonth_05(foot_month_05);
			rentFeeTableFoot.setMonth_06(foot_month_06);
			rentFeeTableFoot.setMonth_07(foot_month_07);
			rentFeeTableFoot.setMonth_08(foot_month_08);
			rentFeeTableFoot.setMonth_09(foot_month_09);
			rentFeeTableFoot.setMonth_10(foot_month_10);
			rentFeeTableFoot.setMonth_11(foot_month_11);
			rentFeeTableFoot.setMonth_12(foot_month_12);
			rentFeeTableFoot.setMonth_total(foot_month_total);

			returnMap.put("boothRentFeeStatusList", boothRentFeeStatusList);
			returnMap.put("rentFeeTableFoot", cordinateCurrencyFormat(rentFeeTableFoot));

		} catch (Exception ex) {
			logger.debug("레트비 지급 현황 테이블을 구성하는 도중에 오류가 예외 상항이 발생하였습니다. : " + ex.getMessage());
			ex.printStackTrace();
		}

		return returnMap;
	}

	/**
	 * 특정 그룹 년도에 해당하는 1~12까지 지불된 렌트비와 모든 합계금액을 마지막 배열에 담아서 반환한다.
	 * 
	 * @param groupId
	 * @param year
	 * @return
	 * @throws Exception
	 */
	private BoothFeePayStatusDto getRentFeeForYear(BoothGroupDto groupDto, String year) throws Exception {
		HashMap<String, String> tmpMap = new HashMap<String, String>();
		HashMap<String, String> tmpMapStatus = new HashMap<String, String>();

		BoothFeePayStatusDto boothRentFeeStatusDto = new BoothFeePayStatusDto();
		boothRentFeeStatusDto.setGroupId(groupDto.getGroupId());
		boothRentFeeStatusDto.setBoothGroup(groupDto);

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupDto.getGroupId());
		param.put("year", year);
		List<BoothRentFeePayDto> feeList = boothRentFeePayDao.getBoothRentFeePayInfoList(param);

		for (BoothRentFeePayDto feeDto : feeList) {
			tmpMap.put(feeDto.getMonth(), feeDto.getRentFee());
			tmpMapStatus.put(feeDto.getMonth(), feeDto.getStatus());
		}

		Double totalFeePerYear = 0.00;

		// 01월 설정
		if (StringUtils.isBlank(tmpMap.get("01"))) {
			boothRentFeeStatusDto.setMonth_01("-");
		} else {
			boothRentFeeStatusDto.setMonth_01(tmpMap.get("01"));
			boothRentFeeStatusDto.setMonth_01_status(tmpMapStatus.get("01"));
		}
		// 02월 설정
		if (StringUtils.isBlank(tmpMap.get("02"))) {
			boothRentFeeStatusDto.setMonth_02("-");
		} else {
			boothRentFeeStatusDto.setMonth_02(tmpMap.get("02"));
			boothRentFeeStatusDto.setMonth_02_status(tmpMapStatus.get("02"));
		}
		// 03월 설정
		if (StringUtils.isBlank(tmpMap.get("03"))) {
			boothRentFeeStatusDto.setMonth_03("-");
		} else {
			boothRentFeeStatusDto.setMonth_03(tmpMap.get("03"));
			boothRentFeeStatusDto.setMonth_03_status(tmpMapStatus.get("03"));
		}
		// 04월 설정
		if (StringUtils.isBlank(tmpMap.get("04"))) {
			boothRentFeeStatusDto.setMonth_04("-");
		} else {
			boothRentFeeStatusDto.setMonth_04(tmpMap.get("04"));
			boothRentFeeStatusDto.setMonth_04_status(tmpMapStatus.get("04"));
		}
		// 05월 설정
		if (StringUtils.isBlank(tmpMap.get("05"))) {
			boothRentFeeStatusDto.setMonth_05("-");
		} else {
			boothRentFeeStatusDto.setMonth_05(tmpMap.get("05"));
			boothRentFeeStatusDto.setMonth_05_status(tmpMapStatus.get("05"));
		}
		// 06월 설정
		if (StringUtils.isBlank(tmpMap.get("06"))) {
			boothRentFeeStatusDto.setMonth_06("-");
		} else {
			boothRentFeeStatusDto.setMonth_06(tmpMap.get("06"));
			boothRentFeeStatusDto.setMonth_06_status(tmpMapStatus.get("06"));
		}
		// 07월 설정
		if (StringUtils.isBlank(tmpMap.get("07"))) {
			boothRentFeeStatusDto.setMonth_07("-");
		} else {
			boothRentFeeStatusDto.setMonth_07(tmpMap.get("07"));
			boothRentFeeStatusDto.setMonth_07_status(tmpMapStatus.get("07"));
		}
		// 08월 설정
		if (StringUtils.isBlank(tmpMap.get("08"))) {
			boothRentFeeStatusDto.setMonth_08("-");
		} else {
			boothRentFeeStatusDto.setMonth_08(tmpMap.get("08"));
			boothRentFeeStatusDto.setMonth_08_status(tmpMapStatus.get("08"));
		}
		// 09월 설정
		if (StringUtils.isBlank(tmpMap.get("09"))) {
			boothRentFeeStatusDto.setMonth_09("-");
		} else {
			boothRentFeeStatusDto.setMonth_09(tmpMap.get("09"));
			boothRentFeeStatusDto.setMonth_09_status(tmpMapStatus.get("09"));
		}
		// 10월 설정
		if (StringUtils.isBlank(tmpMap.get("10"))) {
			boothRentFeeStatusDto.setMonth_10("-");
		} else {
			boothRentFeeStatusDto.setMonth_10(tmpMap.get("10"));
			boothRentFeeStatusDto.setMonth_10_status(tmpMapStatus.get("10"));
		}
		// 11월 설정
		if (StringUtils.isBlank(tmpMap.get("11"))) {
			boothRentFeeStatusDto.setMonth_11("-");
		} else {
			boothRentFeeStatusDto.setMonth_11(tmpMap.get("11"));
			boothRentFeeStatusDto.setMonth_11_status(tmpMapStatus.get("11"));
		}
		// 12월 설정
		if (StringUtils.isBlank(tmpMap.get("12"))) {
			boothRentFeeStatusDto.setMonth_12("-");
		} else {
			boothRentFeeStatusDto.setMonth_12(tmpMap.get("12"));
			boothRentFeeStatusDto.setMonth_12_status(tmpMapStatus.get("12"));
		}

		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_01(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_01());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_02(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_02());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_03(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_03());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_04(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_04());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_05(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_05());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_06(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_06());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_07(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_07());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_08(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_08());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_09(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_09());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_10(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_10());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_11(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_11());
		if (!StringUtils.equals(boothRentFeeStatusDto.getMonth_12(), "-")) totalFeePerYear = totalFeePerYear + Double.parseDouble(boothRentFeeStatusDto.getMonth_12());

		boothRentFeeStatusDto.setMonth_total(Double.toString(totalFeePerYear));

		return boothRentFeeStatusDto;
	}

	private BoothFeePayStatusDto cordinateCurrencyFormat(BoothFeePayStatusDto boothRentFeeStatusDto) {

		String value = "";
		DecimalFormat formatter = new DecimalFormat("###,###,###,##0.00");
		value = boothRentFeeStatusDto.getMonth_01();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_01( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_02();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_02( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_03();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_03( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_04();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_04( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_05();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_05( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_06();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_06( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_07();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_07( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_08();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_08( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_09();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_09( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_10();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_10( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_11();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_11( formatter.format(Double.parseDouble(value)));
		value = boothRentFeeStatusDto.getMonth_12();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_12( formatter.format(Double.parseDouble(value)));

		value = boothRentFeeStatusDto.getMonth_total();
		if (!StringUtils.isBlank(value) && !StringUtils.equals(value, "-")) boothRentFeeStatusDto.setMonth_total( formatter.format(Double.parseDouble(value)));

		return boothRentFeeStatusDto;
	}

}
