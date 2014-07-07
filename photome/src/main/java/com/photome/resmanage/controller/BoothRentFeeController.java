/**
 * 2013 BoothRentFeeController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage.controller;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.common.AttachFile;
import com.cosmos.common.AttachFileDto;
import com.cosmos.framework.code.Code;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.BoothRentFeeDto;
import com.photome.resmanage.BoothRentFee;
import com.photome.resmanage.ResourceManage;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/resmanage/booth/rentfee")
public class BoothRentFeeController {

	@Resource(name = "boothRentFee")
	private BoothRentFee boothRentFee;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "attachFile")
	private AttachFile attachFile;

	@RequestMapping("/Main")
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/booth/rentfee/main");

		mav.addObject("yearOptions", this.getYearOptions(""));
		mav.addObject("monthOptions", this.getMonthOptions(""));

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));
		mav.addObject("rentFeeTypeOptions", code.getOptionsForHTML("PHOTOME", "RENT_PAY_TYPE"));

		return mav;
	}

	@RequestMapping(value = "/BoothRentFeeList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothInfoList(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		HashMap<String, String> param = new HashMap<String, String>();
		List<BoothRentFeeDto> list = null;

		String groupId = request.getParameter("groupId");
		String boothId = request.getParameter("boothId");
		String rentYear = request.getParameter("rentYear");
		String rentMonth = request.getParameter("rentMonth");
		String rentFeeType = request.getParameter("rentFeeType");
		String payOnsite = request.getParameter("payOnsite");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(rentYear)) param.put("rentYear", rentYear);
		if (StringUtils.isNotBlank(rentMonth)) param.put("rentMonth", rentMonth);
		if (StringUtils.isNotBlank(rentFeeType)) param.put("rentFeeType", rentFeeType);
		if (StringUtils.isNotBlank(payOnsite)) param.put("payOnsite", payOnsite);

		list = boothRentFee.getRentFeeList(param);

		JSONArray jsonList = new JSONArray();
		jsonList = JSONArray.fromObject(JSONSerializer.toJSON(list));

		model.put("jsonList", jsonList);

		return model;
	}

	@RequestMapping(value = "/BoothListOfGroup", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getBoothListOfGroup(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		String groupId = request.getParameter("groupId");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);

		List<BoothDto> list = resManage.getBoothInfoList(param);
		model.put("boothList", list);

		return model;
	}

	@RequestMapping(value = "/BeforeMoneyCollectInfo", produces = "application/json")
	@ResponseBody
	public Map<String, Object> beforeMoneyCollectInfo(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		String boothId = request.getParameter("boothId");

		BoothDto boothDto = resManage.getBoothInfo(boothId);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("boothDto", JSONObject.fromObject(JSONSerializer.toJSON(boothDto)));

		model.put("jsonObject", jsonObject);

		return model;
	}

	@RequestMapping("/BoothRentFeeRegistForm")
	public ModelAndView boothRentFeeRegistForm() throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/booth/rentfee/boothRentFeeRegistForm");

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));
		mav.addObject("yearOptions", this.getYearOptions(""));
		mav.addObject("monthOptions", this.getMonthOptions(""));

		return mav;
	}

	@RequestMapping(value = "/BoothRentFeeRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothRentFeeRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String groupId = request.getParameter("groupId");
		String boothId = request.getParameter("boothId");
		BoothDto boothDto = resManage.getBoothInfo(boothId);
		String rentFeeType = boothDto.getRentFeeType();
		if (StringUtils.isNotBlank(rentFeeType)) param.put("rentFeeType", rentFeeType);

		String rentYear = request.getParameter("rentYear");
		String fromRentMonth = request.getParameter("fromRentMonth");
		String toRentMonth = request.getParameter("toRentMonth");
		String rentFee = request.getParameter("rentFee");

		if (StringUtils.isBlank(rentYear) || StringUtils.isBlank(fromRentMonth) || StringUtils.isBlank(toRentMonth)) return null;
		if (StringUtils.isBlank(rentFee)) rentFee = "0";

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(rentYear)) param.put("rentYear", rentYear);
		if (StringUtils.isNotBlank(fromRentMonth)) param.put("fromRentMonth", fromRentMonth);
		if (StringUtils.isNotBlank(toRentMonth)) param.put("toRentMonth", toRentMonth);
		if (StringUtils.isNotBlank(rentFee)) param.put("rentFee", rentFee);

		updateCnt = boothRentFee.registRentFeeInfo(param);
		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/BoothRentFeeDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothRentFeeDelete(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String boothId = request.getParameter("boothId");
		String rentYear = request.getParameter("rentYear");
		String rentMonth = request.getParameter("rentMonth");

		updateCnt = boothRentFee.deleteRentFeeInfo(boothId, rentYear, rentMonth);
		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/GroupInfo")
	@ResponseBody
	public ModelAndView groupInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/common/groupInfo");

		String groupId = request.getParameter("groupId");
		BoothGroupDto groupDto = resManage.getBoothGroupInfo(groupId);

		AttachFileDto attachFileDto = null;
		String attachFileId = groupDto.getAttachFile();
		if (!StringUtils.isEmpty(attachFileId)) {
			attachFileDto = attachFile.getFileInfo(attachFileId);
		}

		mav.addObject("groupDto", groupDto);
		mav.addObject("attachFileDto", attachFileDto);

		return mav;
	}

	@RequestMapping("/BoothInfo")
	@ResponseBody
	public ModelAndView boothInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/common/boothInfo");

		String boothId = request.getParameter("boothId");
		BoothDto boothDto = resManage.getBoothInfo(boothId);

		mav.addObject("boothDto", boothDto);

		return mav;
	}

	private String getYearOptions(String selectYear) {
		StringBuffer yearOptions = new StringBuffer("");

		yearOptions.append("<option></option>");
		int curYear = GregorianCalendar.getInstance().get(Calendar.YEAR);
		if (!StringUtils.isBlank(selectYear)) {
			if (StringUtils.isNumeric(selectYear)) {
				curYear = Integer.parseInt(selectYear);
			}
		}
		for (int i = (curYear + 3); i > (curYear - 10); i--) {
			yearOptions.append("<option value=\"" + i + "\"" + (i == curYear ? " selected " : "") + ">" + i + "</option>");
		}
		return yearOptions.toString();
	}

	private String getMonthOptions(String selectMonth) {
		StringBuffer monthOptions = new StringBuffer("");
		String curMonth = "";

		if (!StringUtils.isBlank(selectMonth)) {
			if (StringUtils.isNumeric(selectMonth)) {
				curMonth = selectMonth;
			}
		} else {
			curMonth = Integer.toString(GregorianCalendar.getInstance().get(Calendar.MONTH) + 1);
		}
		if ((GregorianCalendar.getInstance().get(Calendar.MONTH) + 1) < 10) curMonth = "0" + curMonth;

		monthOptions.append("<option></option>");
		monthOptions.append("<option value=\"01\"" + (StringUtils.equals(curMonth, "01") ? " selected " : "") + ">Jan</option>");
		monthOptions.append("<option value=\"02\"" + (StringUtils.equals(curMonth, "02") ? " selected " : "") + ">Feb</option>");
		monthOptions.append("<option value=\"03\"" + (StringUtils.equals(curMonth, "03") ? " selected " : "") + ">Mar</option>");
		monthOptions.append("<option value=\"04\"" + (StringUtils.equals(curMonth, "04") ? " selected " : "") + ">Apr</option>");
		monthOptions.append("<option value=\"05\"" + (StringUtils.equals(curMonth, "05") ? " selected " : "") + ">May</option>");
		monthOptions.append("<option value=\"06\"" + (StringUtils.equals(curMonth, "06") ? " selected " : "") + ">Jun</option>");
		monthOptions.append("<option value=\"07\"" + (StringUtils.equals(curMonth, "07") ? " selected " : "") + ">Jul</option>");
		monthOptions.append("<option value=\"08\"" + (StringUtils.equals(curMonth, "08") ? " selected " : "") + ">Aug</option>");
		monthOptions.append("<option value=\"09\"" + (StringUtils.equals(curMonth, "09") ? " selected " : "") + ">Sep</option>");
		monthOptions.append("<option value=\"10\"" + (StringUtils.equals(curMonth, "10") ? " selected " : "") + ">Oct</option>");
		monthOptions.append("<option value=\"11\"" + (StringUtils.equals(curMonth, "11") ? " selected " : "") + ">Nov</option>");
		monthOptions.append("<option value=\"12\"" + (StringUtils.equals(curMonth, "12") ? " selected " : "") + ">Dec</option>");

		return monthOptions.toString();
	}
}
