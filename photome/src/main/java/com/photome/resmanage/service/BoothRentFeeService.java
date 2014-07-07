/**
 * 2013 BoothRentFeeService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.photome.dto.BoothRentFeeDto;
import com.photome.resmanage.BoothRentFee;
import com.photome.resmanage.dao.BoothRentFeeDao;

/**
 * @author Steven J.S Min
 * 
 */
public class BoothRentFeeService implements BoothRentFee {

	@Resource(name = "boothRentFeeDao")
	private BoothRentFeeDao boothRentFeeDao;

	@Override
	public List<BoothRentFeeDto> getRentFeeList(HashMap<String, String> param) throws Exception {
		return boothRentFeeDao.getRentFeeList(param);
	}

	@Override
	public BoothRentFeeDto getRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception {
		return boothRentFeeDao.getRentFeeInfo(boothId, rentYear, rentMonth);
	}

	@Override
	public boolean existRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception {
		return boothRentFeeDao.existRentFeeInfo(boothId, rentYear, rentMonth);
	}

	@Override
	public Integer registRentFeeInfo(HashMap<String, String> param) throws Exception {

		int updateCnt = 0;
		String rentFeeType = param.get("rentFeeType");
		String rentFee = param.get("rentFee");
		if (StringUtils.equals(rentFeeType, "FIXED_MONEY")) {
			param.put("rentAmount", rentFee);
			param.put("rentPercent", "0");
		} else if (StringUtils.equals(rentFeeType, "PERCENT")) {
			param.put("rentAmount", "0");
			param.put("rentPercent", rentFee);
		}

		String boothId = param.get("boothId");
		String rentYear = param.get("rentYear");

		String fromRentMonth = param.get("fromRentMonth");
		String toRentMonth = param.get("toRentMonth");
		int fromMonth = Integer.parseInt(fromRentMonth);
		int toMonth = Integer.parseInt(toRentMonth);
		if (fromMonth > toMonth) return 0;

		int cnt = 0;
		String month = "";
		for (int i = fromMonth; i <= toMonth; i++) {
			month = Integer.toString(i);
			if (i < 10) month = "0" + month;
			param.put("rentMonth", month);

			if (this.existRentFeeInfo(boothId, rentYear, month)) {
				cnt = boothRentFeeDao.modifyRentFeeInfo(param);
			} else {
				cnt = boothRentFeeDao.registRentFeeInfo(param);
			}

			updateCnt = updateCnt + cnt;
		}

		return updateCnt;
	}

	@Override
	public Integer modifyRentFeeInfo(HashMap<String, String> param) throws Exception {
		return boothRentFeeDao.modifyRentFeeInfo(param);
	}

	@Override
	public Integer deleteRentFeeInfo(String boothId, String rentYear, String rentMonth) throws Exception {
		return boothRentFeeDao.deleteRentFeeInfo(boothId, rentYear, rentMonth);
	}

}
