/**
 * 2013 BoothManageController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.framework.auth.Auth;
import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.cosmos.framework.code.Code;
import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.common.Common;
import com.cosmos.framework.role.Role;
import com.cosmos.framework.role.RoleDto;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BoothDto;
import com.photome.resmanage.ResourceManage;
import com.photome.techsupport.TechSupport;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/resmanage/booth")
public class BoothManageController {

	@Resource(name = "techSupport")
	private TechSupport techSupport;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "common")
	private Common common;

	@Resource(name = "user")
	private User user;

	@Resource(name = "auth")
	private Auth auth;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "role")
	private Role role;

	@RequestMapping("/Main")
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/booth/main");

		mav.addObject("stateListOptions", common.getStateComboOptions(""));
		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));

		mav.addObject("technicianOptions", resManage.getTechnicianOptionsForHTML(""));
		mav.addObject("monitorTypeOptions", code.getOptionsForHTML("PHOTOME", "MONITOR_TYPE"));
		mav.addObject("boothStatusOptions", code.getOptionsForHTML("PHOTOME", "BOOTH_STATUS"));
		mav.addObject("qltyResultOptions", code.getOptionsForHTML("PHOTOME", "QLTY_TST_RSLT"));
		mav.addObject("boothTypeOptions", code.getOptionsForHTML("PHOTOME", "BOOTH_TYPE"));
		mav.addObject("printerTypeOptions", code.getOptionsForHTML("PHOTOME", "PRINTER_MODEL"));
		mav.addObject("rentFeeTypeOptions", code.getOptionsForHTML("PHOTOME", "RENT_PAY_TYPE"));

		return mav;
	}

	@RequestMapping("/BoothInfo")
	@ResponseBody
	public ModelAndView boothInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/booth/boothInfo");
		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		String boothId = request.getParameter("boothId");
		BoothDto boothDto = resManage.getBoothInfo(boothId);

		mav.addObject("sessionUser", sessionUser);
		mav.addObject("boothDto", boothDto);

		return mav;
	}

	@RequestMapping(value = "/BoothInfoList", produces = "application/json")
	public ModelAndView boothInfoList(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/booth/boothInfoList");

		HashMap<String, String> param = new HashMap<String, String>();
		List<BoothDto> list = null;

		String boothName = request.getParameter("boothName");
		String technician = request.getParameter("technician");
		String status = request.getParameter("status");
		String locState = request.getParameter("locState");
		String groupId = request.getParameter("groupId");
		String serialNo = request.getParameter("serialNo");
		String printerModel = request.getParameter("printerModel");
		String captureType = request.getParameter("captureType");
		String tagDueDt = request.getParameter("tagDueDt");
		String qualityTestResult = request.getParameter("qualityTestResult");
		String type = request.getParameter("type");
		String boothComment = request.getParameter("boothComment");
		String monitorType = request.getParameter("monitorType");
		String useYn = request.getParameter("useYn");

		if (StringUtils.isNotBlank(boothName)) param.put("boothName", boothName);
		if (StringUtils.isNotBlank(technician)) param.put("technician", technician);
		if (StringUtils.isNotBlank(status)) param.put("status", status);
		if (StringUtils.isNotBlank(locState)) param.put("locState", locState);
		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(serialNo)) param.put("serialNo", serialNo);
		if (StringUtils.isNotBlank(printerModel)) param.put("printerModel", printerModel);
		if (StringUtils.isNotBlank(captureType)) param.put("captureType", captureType);
		if (StringUtils.isNotBlank(tagDueDt)) param.put("tagDueDt", tagDueDt);
		if (StringUtils.isNotBlank(qualityTestResult)) param.put("qualityTestResult", qualityTestResult);
		if (StringUtils.isNotBlank(type)) param.put("type", type);
		if (StringUtils.isNotBlank(boothComment)) param.put("boothComment", boothComment);
		if (StringUtils.isNotBlank(monitorType)) param.put("monitorType", monitorType);
		if (StringUtils.isNotBlank(useYn)) param.put("useYn", useYn);

		list = resManage.getBoothInfoList(param);

		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping("/BoothInfoRegistForm")
	public ModelAndView boothInfoRegistForm() throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/booth/boothInfoRegistForm");

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));

		mav.addObject("monitorTypeOptions", code.getOptionsForHTML("PHOTOME", "MONITOR_TYPE"));
		mav.addObject("boothStatusOptions", code.getOptionsForHTML("PHOTOME", "BOOTH_STATUS"));
		mav.addObject("qltyResultOptions", code.getOptionsForHTML("PHOTOME", "QLTY_TST_RSLT"));
		mav.addObject("boothTypeOptions", code.getOptionsForHTML("PHOTOME", "BOOTH_TYPE"));
		mav.addObject("captureTypeOptions", code.getOptionsForHTML("PHOTOME", "CAPTURE_TYPE"));
		mav.addObject("printerTypeOptions", code.getOptionsForHTML("PHOTOME", "PRINTER_MODEL"));
		mav.addObject("rentFeeTypeOptions", code.getOptionsForHTML("PHOTOME", "RENT_PAY_TYPE"));
		return mav;
	}

	@RequestMapping(value = "/BoothInfoRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothInfoRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String boothName = request.getParameter("boothName");
		String technician = request.getParameter("technician");
		String status = request.getParameter("status");
		String locDetail = request.getParameter("locDetail");
		String locStreetNo = request.getParameter("locStreetNo");
		String locSuburb = request.getParameter("locSuburb");
		String locState = request.getParameter("locState");
		String locPostcd = request.getParameter("locPostcd");
		String groupId = request.getParameter("groupId");
		String manager = request.getParameter("manager");
		String serialNo = request.getParameter("serialNo");
		String printerModel = request.getParameter("printerModel");
		String captureType = request.getParameter("captureType");
		String padLock = request.getParameter("padLock");
		String insideLock = request.getParameter("insideLock");
		String tagDueDt = request.getParameter("tagDueDt");
		String qualityTestResult = request.getParameter("qualityTestResult");
		String qualityTestDt = request.getParameter("qualityTestDt");
		String rentFeeType = request.getParameter("rentFeeType");
		String payOnsite = request.getParameter("payOnsite");
		String type = request.getParameter("type");
		String boothComment = request.getParameter("boothComment");
		String monitorType = request.getParameter("monitorType");

		if (StringUtils.isNotBlank(boothName)) param.put("boothName", boothName);
		if (StringUtils.isNotBlank(technician)) param.put("technician", technician);
		if (StringUtils.isNotBlank(status)) param.put("status", status);
		if (StringUtils.isNotBlank(locDetail)) param.put("locDetail", locDetail);
		if (StringUtils.isNotBlank(locStreetNo)) param.put("locStreetNo", locStreetNo);
		if (StringUtils.isNotBlank(locSuburb)) param.put("locSuburb", locSuburb);
		if (StringUtils.isNotBlank(locState)) param.put("locState", locState);
		if (StringUtils.isNotBlank(locPostcd)) param.put("locPostcd", locPostcd);
		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(manager)) param.put("manager", manager);
		if (StringUtils.isNotBlank(serialNo)) param.put("serialNo", serialNo);
		if (StringUtils.isNotBlank(printerModel)) param.put("printerModel", printerModel);
		if (StringUtils.isNotBlank(captureType)) param.put("captureType", captureType);
		if (StringUtils.isNotBlank(padLock)) param.put("padLock", padLock);
		if (StringUtils.isNotBlank(insideLock)) param.put("insideLock", insideLock);
		if (StringUtils.isNotBlank(tagDueDt)) param.put("tagDueDt", tagDueDt);
		if (StringUtils.isNotBlank(qualityTestResult)) param.put("qualityTestResult", qualityTestResult);
		if (StringUtils.isNotBlank(qualityTestDt)) param.put("qualityTestDt", qualityTestDt);
		if (StringUtils.isNotBlank(rentFeeType)) param.put("rentFeeType", rentFeeType);
		if (StringUtils.isNotBlank(payOnsite)) param.put("payOnsite", payOnsite);
		if (StringUtils.isNotBlank(type)) param.put("type", type);
		if (StringUtils.isNotBlank(boothComment)) param.put("boothComment", boothComment);
		if (StringUtils.isNotBlank(monitorType)) param.put("monitorType", monitorType);

		updateCnt = resManage.insertBoothInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/BoothInfoUpdateForm")
	public ModelAndView boothInfoUpdateForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/booth/boothInfoUpdateForm");

		String boothId = request.getParameter("boothId");
		BoothDto boothDto = resManage.getBoothInfo(boothId);

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(boothDto.getGroupId()));

		mav.addObject("monitorTypeOptions", code.getOptionsForHTML("PHOTOME", "MONITOR_TYPE", boothDto.getMonitorType()));
		mav.addObject("boothStatusOptions", code.getOptionsForHTML("PHOTOME", "BOOTH_STATUS", boothDto.getStatus()));
		mav.addObject("qltyResultOptions", code.getOptionsForHTML("PHOTOME", "QLTY_TST_RSLT", boothDto.getQualityTestResult()));
		mav.addObject("boothTypeOptions", code.getOptionsForHTML("PHOTOME", "BOOTH_TYPE", boothDto.getType()));
		mav.addObject("captureTypeOptions", code.getOptionsForHTML("PHOTOME", "CAPTURE_TYPE", boothDto.getCaptureType()));
		mav.addObject("printerTypeOptions", code.getOptionsForHTML("PHOTOME", "PRINTER_MODEL", boothDto.getPrinterModel()));
		mav.addObject("rentFeeTypeOptions", code.getOptionsForHTML("PHOTOME", "RENT_PAY_TYPE", boothDto.getRentFeeType()));

		mav.addObject("boothDto", boothDto);

		return mav;
	}

	@RequestMapping(value = "/BoothInfoUpdate", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothInfoUpdate(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String boothId = request.getParameter("boothId");
		String boothName = request.getParameter("boothName");
		String technician = request.getParameter("technician");
		String status = request.getParameter("status");
		String locDetail = request.getParameter("locDetail");
		String locStreetNo = request.getParameter("locStreetNo");
		String locSuburb = request.getParameter("locSuburb");
		String locState = request.getParameter("locState");
		String locPostcd = request.getParameter("locPostcd");
		String groupId = request.getParameter("groupId");
		String manager = request.getParameter("manager");
		String serialNo = request.getParameter("serialNo");
		String printerModel = request.getParameter("printerModel");
		String captureType = request.getParameter("captureType");
		String padLock = request.getParameter("padLock");
		String insideLock = request.getParameter("insideLock");
		String tagDueDt = request.getParameter("tagDueDt");
		String qualityTestResult = request.getParameter("qualityTestResult");
		String qualityTestDt = request.getParameter("qualityTestDt");
		String rentFeeType = request.getParameter("rentFeeType");
		String payOnsite = request.getParameter("payOnsite");
		String type = request.getParameter("type");
		String boothComment = request.getParameter("boothComment");
		String monitorType = request.getParameter("monitorType");

		param.put("boothId", boothId);
		if (StringUtils.isNotBlank(boothName)) param.put("boothName", boothName);
		if (StringUtils.isNotBlank(technician)) param.put("technician", technician);
		if (StringUtils.isNotBlank(status)) param.put("status", status);
		if (StringUtils.isNotBlank(locDetail)) param.put("locDetail", locDetail);
		if (StringUtils.isNotBlank(locStreetNo)) param.put("locStreetNo", locStreetNo);
		if (StringUtils.isNotBlank(locSuburb)) param.put("locSuburb", locSuburb);
		if (StringUtils.isNotBlank(locState)) param.put("locState", locState);
		if (StringUtils.isNotBlank(locPostcd)) param.put("locPostcd", locPostcd);
		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(manager)) param.put("manager", manager);
		if (StringUtils.isNotBlank(serialNo)) param.put("serialNo", serialNo);
		if (StringUtils.isNotBlank(printerModel)) param.put("printerModel", printerModel);
		if (StringUtils.isNotBlank(captureType)) param.put("captureType", captureType);
		if (StringUtils.isNotBlank(padLock)) param.put("padLock", padLock);
		if (StringUtils.isNotBlank(insideLock)) param.put("insideLock", insideLock);
		if (StringUtils.isNotBlank(tagDueDt)) param.put("tagDueDt", tagDueDt);
		if (StringUtils.isNotBlank(qualityTestResult)) param.put("qualityTestResult", qualityTestResult);
		if (StringUtils.isNotBlank(qualityTestDt)) param.put("qualityTestDt", qualityTestDt);
		if (StringUtils.isNotBlank(rentFeeType)) param.put("rentFeeType", rentFeeType);
		if (StringUtils.isNotBlank(payOnsite)) param.put("payOnsite", payOnsite);
		if (StringUtils.isNotBlank(type)) param.put("type", type);
		if (StringUtils.isNotBlank(boothComment)) param.put("boothComment", boothComment);
		if (StringUtils.isNotBlank(monitorType)) param.put("monitorType", monitorType);

		updateCnt = resManage.updateBoothInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/BoothInfoDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothInfoDelete(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String boothId = request.getParameter("boothId");
		updateCnt = resManage.deleteBoothInfo(boothId);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/SetBoothUseYN", produces = "application/json")
	@ResponseBody
	public Map<String, Object> setBoothUseYN(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String boothId = request.getParameter("boothId");
		String useYn = request.getParameter("useYn");
		updateCnt = resManage.setBoothUseYN(boothId, useYn);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/SetPersonForm")
	public ModelAndView setPersonForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/booth/setPersonForm");
		String who = request.getParameter("who");
		mav.addObject("who", who);
		return mav;
	}

	@RequestMapping(value = "/UserList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getUserList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<UserDto> list = null;

		String userType = request.getParameter("userType");
		String roleId = request.getParameter("roleId");
		String useYn = request.getParameter("useYn");
		String firstName = request.getParameter("firstName");

		if (StringUtils.isEmpty(firstName)) {
			firstName = "%";
		} else {
			firstName = "%" + firstName + "%";
		}

		try {
			param.put("firstName", firstName);
			param.put("userType", StringUtils.isEmpty(userType) ? null : userType);
			param.put("roleId", StringUtils.isEmpty(roleId) ? null : roleId);
			param.put("useYn", StringUtils.isEmpty(useYn) ? null : useYn);
			list = user.getUserList(param);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("list", list);

		return model;
	}

	@RequestMapping(value = "/UserTypeAndRole", produces = "application/json")
	@ResponseBody
	public Map<String, Object> setUserTypeAndRole(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		List<CodeDto> userTypes = code.getCodeList("SYSTEM", "USER_TYPE");
		List<RoleDto> roleList = role.getRoleList(new HashMap<String, String>());

		model.put("userTypes", userTypes);
		model.put("roles", roleList);

		return model;
	}

	@RequestMapping("/UserDetailInfo")
	public ModelAndView userDetailInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/common/userDetailInfo");

		UserDto userDto = new UserDto();

		String userId = request.getParameter("userId");
		userDto = user.getUserInfo(userId);

		String userTypeName = null;
		CodeDto cdoeDto = code.getCodeInfo("SYSTEM", "USER_TYPE", userDto.getUserType());
		if (cdoeDto != null) userTypeName = cdoeDto.getCodeName();

		String birthDt = userDto.getBirthDt();
		if (!StringUtils.isEmpty(birthDt) && StringUtils.length(birthDt) == 8) {
			birthDt = StringUtils.substring(birthDt, 0, 2) + "/" + StringUtils.substring(birthDt, 2, 4) + "/" + StringUtils.substring(birthDt, 4);
		}
		userDto.setBirthDt(birthDt);
		userDto.setUserTypeName(userTypeName);

		mav.addObject("userPhoto", user.getProfilePhoto(userId));
		mav.addObject("userDto", userDto);

		return mav;
	}
}
