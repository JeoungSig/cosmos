/**
 * 2013 BoothRentFeePayStatusController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.controller;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.photome.dto.BoothFeePayStatusDto;
import com.photome.dto.BoothGroupDto;
import com.photome.money.BoothRentFeePay;
import com.photome.resmanage.ResourceManage;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/money/manage/boothrentfeepay/status")
public class BoothRentFeePayStatusController {

	@Resource(name = "boothRentFeePay")
	private BoothRentFeePay boothRentFeePay;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/manage/boothrentfeepay/status/main");

		int curYear = 0;
		String p_year = request.getParameter("year");
		if (StringUtils.isBlank(p_year)) {
			curYear = GregorianCalendar.getInstance().get(Calendar.YEAR);
		} else {
			curYear = Integer.parseInt(p_year);
		}

		StringBuffer yearOptions = new StringBuffer("");
		yearOptions.append("<option></option>");
		for (int i = (curYear + 3); i > (curYear - 10); i--) {
			yearOptions.append("<option value=\"" + i + "\"" + (i == curYear ? " selected " : "") + ">" + i + "</option>");
		}

		List<BoothGroupDto> boothGroupList = resManage.getBoothGroupInfoList(new HashMap<String, String>());

		HashMap<String, Object> rentFeeTable = boothRentFeePay.generateBoothRentFeePayStatusTable(boothGroupList, Integer.toString(curYear));

		List<BoothFeePayStatusDto> boothRentFeeStatusList = (List<BoothFeePayStatusDto>) rentFeeTable.get("boothRentFeeStatusList");
		BoothFeePayStatusDto rentFeeTableFoot = (BoothFeePayStatusDto) rentFeeTable.get("rentFeeTableFoot");

		mav.addObject("year", curYear);
		mav.addObject("yearOptions", yearOptions.toString());
		mav.addObject("boothRentFeeStatusList", boothRentFeeStatusList);
		mav.addObject("rentFeeTableFoot", rentFeeTableFoot);

		return mav;
	}

}
