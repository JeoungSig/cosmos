/**
 * 2013 BoothRentFeePayController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.controller;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.common.AttachFile;
import com.cosmos.common.AttachFileDto;
import com.cosmos.framework.auth.Auth;
import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.cosmos.framework.code.Code;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothFeePayStatusDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.BoothRentFeeDto;
import com.photome.dto.BoothRentFeePayDto;
import com.photome.money.BoothRentFeePay;
import com.photome.resmanage.BoothRentFee;
import com.photome.resmanage.ResourceManage;
import com.photome.techsupport.TechSupport;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/money/manage/boothrentfeepay")
public class BoothRentFeePayController {

	@Resource(name = "boothRentFeePay")
	private BoothRentFeePay boothRentFeePay;

	@Resource(name = "boothRentFee")
	private BoothRentFee boothRentFee;

	@Resource(name = "techSupport")
	private TechSupport techSupport;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "auth")
	private Auth auth;

	@Resource(name = "attachFile")
	private AttachFile attachFile;

	@RequestMapping("/Main")
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView("business/money/manage/boothrentfeepay/main");

		String curMonth = Integer.toString(GregorianCalendar.getInstance().get(Calendar.MONTH) + 1);
		if ((GregorianCalendar.getInstance().get(Calendar.MONTH) + 1) < 10) curMonth = "0" + curMonth;

		StringBuffer yearOptions = new StringBuffer("");
		StringBuffer monthOptions = new StringBuffer("");
		yearOptions.append("<option></option>");

		int curYear = GregorianCalendar.getInstance().get(Calendar.YEAR);
		for (int i = (curYear + 3); i > (curYear - 10); i--) {
			yearOptions.append("<option value=\"" + i + "\"" + (i == curYear ? " selected " : "") + ">" + i + "</option>");
		}
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

		mav.addObject("yearOptions", yearOptions.toString());
		mav.addObject("monthOptions", monthOptions.toString());
		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));
		mav.addObject("payRentStatusOptions", code.getOptionsForHTML("PHOTOME", "PAY_RENT_STATUS"));

		return mav;
	}

	@RequestMapping(value = "/BoothRentFeePayFeeList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothRentFeePayPayFeeList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<BoothRentFeePayDto> list = null;

		String groupId = request.getParameter("groupId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String status = request.getParameter("status");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(year)) param.put("year", year);
		if (StringUtils.isNotBlank(month)) param.put("month", month);
		if (StringUtils.isNotBlank(status)) param.put("status", status);

		list = boothRentFeePay.getBoothRentFeePayInfoList(param);

		JSONArray jsonList = new JSONArray();
		jsonList = JSONArray.fromObject(JSONSerializer.toJSON(list));

		model.put("jsonList", jsonList);

		return model;
	}

	@RequestMapping(value = "/RentFee", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getRentFee(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		String groupId = request.getParameter("groupId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");

		String rentAmount = "0";

		String rentFeeType = "";
		String tmpAmt = "0";

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		param.put("rentYear", year);
		param.put("rentMonth", month);
		List<BoothRentFeeDto> list = boothRentFee.getRentFeeList(param);
		for (BoothRentFeeDto dto : list) {
			rentFeeType = dto.getRentFeeType();
			if (StringUtils.equals(rentFeeType, "FIXED_MONEY")) {
				tmpAmt = dto.getRentAmount();
				if (StringUtils.isBlank(tmpAmt)) tmpAmt = "0";
				rentAmount = Double.toString(Double.parseDouble(rentAmount) + Double.parseDouble(tmpAmt));
			}
		}

		model.put("rentAmount", rentAmount);

		return model;
	}

	@RequestMapping(value = "/BoothRentFeePayFeeDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothRentFeePayPayFeeDelete(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		Integer updateCnt = 0;

		String groupId = request.getParameter("groupId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(year)) param.put("year", year);
		if (StringUtils.isNotBlank(month)) param.put("month", month);

		updateCnt = boothRentFeePay.deleteBoothRentFeePayInfo(groupId, year, month);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/BoothRentFeePayInfo")
	public ModelAndView boothRentFeePayPayInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/manage/boothrentfeepay/viewBoothRentFeePayInfo");
		String groupId = request.getParameter("groupId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");

		BoothRentFeePayDto boothRentFeePayDto = boothRentFeePay.getBoothRentFeePayInfo(groupId, year, month);
		BoothGroupDto boothGroupDto = resManage.getBoothGroupInfo(groupId);

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		mav.addObject("sessionUser", sessionUser);
		mav.addObject("boothGroupDto", boothGroupDto);
		mav.addObject("boothRentFeePayDto", boothRentFeePayDto);

		return mav;
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

	@RequestMapping(value = "/ChangeCollectStatus", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyCollectStatus(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		String groupId = request.getParameter("groupId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String status = request.getParameter("status");
		String updator = sessionUser.getUserInfo().getUserId();

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(year)) param.put("year", year);
		if (StringUtils.isNotBlank(month)) param.put("month", month);
		if (StringUtils.isNotBlank(status)) param.put("status", status);
		if (StringUtils.isNotBlank(updator)) param.put("updator", updator);

		Integer updateCnt = boothRentFeePay.changeBoothRentFeePayStatus(groupId, year, month, status, updator);
		model.put("updateCnt", updateCnt);

		return model;
	}

	@RequestMapping("/BoothRentFeePayModifyForm")
	public ModelAndView boothRentFeePayModifyForm(HttpServletRequest request) throws Exception {

		ModelAndView mav = new ModelAndView("business/money/manage/boothrentfeepay/boothRentFeePayInfoModifyForm");

		String p_groupId = request.getParameter("groupId");
		String p_year = request.getParameter("year");
		String p_month = request.getParameter("month");

		BoothRentFeePayDto boothRentFeePayDto = boothRentFeePay.getBoothRentFeePayInfo(p_groupId, p_year, p_month);
		String curYear = boothRentFeePayDto.getYear();
		String curMonth = boothRentFeePayDto.getMonth();

		StringBuffer yearOptions = new StringBuffer("");
		StringBuffer monthOptions = new StringBuffer("");

		yearOptions.append("<option></option>");
		int year = GregorianCalendar.getInstance().get(Calendar.YEAR);
		for (int i = (year + 3); i > (year - 10); i--) {
			yearOptions.append("<option value=\"" + i + "\"" + (i == Integer.parseInt(curYear) ? " selected " : "") + ">" + i + "</option>");
		}

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

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(boothRentFeePayDto.getGroupId()));
		mav.addObject("yearOptions", yearOptions.toString());
		mav.addObject("monthOptions", monthOptions.toString());
		mav.addObject("payRentStatusOptions", code.getOptionsForHTML("PHOTOME", "PAY_RENT_STATUS", boothRentFeePayDto.getStatus()));
		mav.addObject("boothRentFeePayDto", boothRentFeePayDto);

		return mav;
	}

	@RequestMapping(value = "/BoothRentFeePayModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothRentFeePayPayModify(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		String groupId = request.getParameter("groupId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String status = request.getParameter("status");
		String rentFee = request.getParameter("rentFee");
		String payDt = request.getParameter("payDt");
		String rentComment = request.getParameter("rentComment");
		String updator = sessionUser.getUserInfo().getUserId();

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(year)) param.put("year", year);
		if (StringUtils.isNotBlank(month)) param.put("month", month);
		if (StringUtils.isNotBlank(status)) param.put("status", status);
		if (StringUtils.isNotBlank(rentFee)) param.put("rentFee", rentFee);
		if (StringUtils.isNotBlank(payDt)) param.put("payDt", payDt);
		if (StringUtils.isNotBlank(rentComment)) param.put("rentComment", rentComment);
		if (StringUtils.isNotBlank(updator)) param.put("updator", updator);

		Integer updateCnt = boothRentFeePay.updateBoothRentFeePayInfo(param);
		model.put("updateCnt", updateCnt);

		return model;
	}

	@RequestMapping("/BoothRentFeePayRegistForm")
	public ModelAndView boothRentFeePayRegistForm(HttpServletRequest request) throws Exception {

		ModelAndView mav = new ModelAndView("business/money/manage/boothrentfeepay/boothRentFeePayInfoRegistForm");

		String curMonth = Integer.toString(GregorianCalendar.getInstance().get(Calendar.MONTH) + 1);
		if ((GregorianCalendar.getInstance().get(Calendar.MONTH) + 1) < 10) curMonth = "0" + curMonth;

		StringBuffer yearOptions = new StringBuffer("");
		StringBuffer monthOptions = new StringBuffer("");
		yearOptions.append("<option></option>");

		int curYear = GregorianCalendar.getInstance().get(Calendar.YEAR);
		for (int i = (curYear + 3); i > (curYear - 10); i--) {
			yearOptions.append("<option value=\"" + i + "\"" + (i == curYear ? " selected " : "") + ">" + i + "</option>");
		}
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

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));
		mav.addObject("yearOptions", yearOptions.toString());
		mav.addObject("monthOptions", monthOptions.toString());
		mav.addObject("payRentStatusOptions", code.getOptionsForHTML("PHOTOME", "PAY_RENT_STATUS"));

		return mav;
	}

	@RequestMapping(value = "/BoothRentFeePayRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothRentFeePayRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		String groupId = request.getParameter("groupId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String status = request.getParameter("status");
		String rentFee = request.getParameter("rentFee");
		String payDt = request.getParameter("payDt");
		String rentComment = request.getParameter("rentComment");
		String updator = sessionUser.getUserInfo().getUserId();
		String creator = sessionUser.getUserInfo().getUserId();

		if (boothRentFeePay.existBoothRentFeePayHistory(groupId, year, month)) {
			throw new Exception("Already exist pay history !!!");
		}

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(year)) param.put("year", year);
		if (StringUtils.isNotBlank(month)) param.put("month", month);
		if (StringUtils.isNotBlank(status)) param.put("status", status);
		if (StringUtils.isNotBlank(rentFee)) param.put("rentFee", rentFee);
		if (StringUtils.isNotBlank(payDt)) param.put("payDt", payDt);
		if (StringUtils.isNotBlank(rentComment)) param.put("rentComment", rentComment);
		if (StringUtils.isNotBlank(updator)) param.put("updator", updator);
		if (StringUtils.isNotBlank(creator)) param.put("creator", creator);

		Integer updateCnt = boothRentFeePay.registBoothRentFeePayInfo(param);
		model.put("updateCnt", updateCnt);

		return model;
	}

	@RequestMapping(value = "/ExistBoothRentFeePayHistory", produces = "application/json")
	@ResponseBody
	public Map<String, Object> existBoothRentFeePayHistory(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		String groupId = request.getParameter("groupId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");

		String exist = "NO";

		if (boothRentFeePay.existBoothRentFeePayHistory(groupId, year, month)) exist = "YES";

		model.put("message", exist);

		return model;
	}

	@RequestMapping("/RenFeePayStatus")
	public ModelAndView renFeePayStatus(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/manage/boothrentfeepay/status/renFeePayStatus");

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
