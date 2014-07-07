/**
 * 2013 MyBoothManageController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage.controller;

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

import com.cosmos.framework.auth.Auth;
import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.cosmos.framework.code.Code;
import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.common.Common;
import com.photome.dto.BoothDto;
import com.photome.dto.MaintenanceHistoryDto;
import com.photome.dto.MoneyCollectDto;
import com.photome.money.MoneyCollect;
import com.photome.resmanage.ResourceManage;
import com.photome.techsupport.TechSupport;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/resmanage/mybooth")
public class MyBoothManageController {

	@Resource(name = "moneyCollect")
	private MoneyCollect moneyCollect;

	@Resource(name = "techSupport")
	private TechSupport techSupport;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "common")
	private Common common;

	@Resource(name = "auth")
	private Auth auth;

	@Resource(name = "code")
	private Code code;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/mybooth/main");
		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String sessionId = sessionUser.getUserInfo().getUserId();

		boolean isMgr = false;
		if (sessionId.equals("admin")) isMgr = true;
		List<CodeDto> mgrList = code.getCodeList("PHOTOME", "MYBOOTH_MGR_LST");
		String id = "";
		for (CodeDto codeDto : mgrList) {
			id = codeDto.getCodeValue();
			if (id.equals(sessionId)) isMgr = true;
		}

		if (isMgr) {
			mav.addObject("technicianOptions", resManage.getTechnicianOptionsForHTML(""));
		} else {
			String option = "<option value=\"" + sessionId + "\">" + sessionUser.getUserInfo().getUserId() + "</option>";
			mav.addObject("technicianOptions", option);
		}

		return mav;
	}

	@RequestMapping("/BoothInfo")
	@ResponseBody
	public ModelAndView boothInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/mybooth/myBoothInfo");
		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		String boothId = request.getParameter("boothId");
		BoothDto boothDto = resManage.getBoothInfo(boothId);

		mav.addObject("sessionUser", sessionUser);
		mav.addObject("boothDto", boothDto);

		return mav;
	}

	@RequestMapping(value = "/BoothInfoList", produces = "application/json")
	public ModelAndView boothInfoList(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();

		HashMap<String, String> param = new HashMap<String, String>();
		List<BoothDto> list = null;

		String technician = request.getParameter("technician");
		String useYn = "Y";

		if (StringUtils.isNotBlank(technician)) param.put("technician", technician);
		if (StringUtils.isNotBlank(useYn)) param.put("useYn", useYn);

		list = resManage.getBoothInfoList(param);

		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping("/BoothInfoUpdateForm")
	public ModelAndView boothInfoUpdateForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/mybooth/myBoothInfoUpdateForm");

		String boothId = request.getParameter("boothId");
		BoothDto boothDto = resManage.getBoothInfo(boothId);

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
		String status = request.getParameter("status");
		String locDetail = request.getParameter("locDetail");
		String locStreetNo = request.getParameter("locStreetNo");
		String locSuburb = request.getParameter("locSuburb");
		String locState = request.getParameter("locState");
		String locPostcd = request.getParameter("locPostcd");
		String serialNo = request.getParameter("serialNo");
		String printerModel = request.getParameter("printerModel");
		String captureType = request.getParameter("captureType");
		String padLock = request.getParameter("padLock");
		String insideLock = request.getParameter("insideLock");
		String tagDueDt = request.getParameter("tagDueDt");
		String type = request.getParameter("type");
		String boothComment = request.getParameter("boothComment");
		String monitorType = request.getParameter("monitorType");

		param.put("boothId", boothId);
		if (StringUtils.isNotBlank(status)) param.put("status", status);
		if (StringUtils.isNotBlank(locDetail)) param.put("locDetail", locDetail);
		if (StringUtils.isNotBlank(locStreetNo)) param.put("locStreetNo", locStreetNo);
		if (StringUtils.isNotBlank(locSuburb)) param.put("locSuburb", locSuburb);
		if (StringUtils.isNotBlank(locState)) param.put("locState", locState);
		if (StringUtils.isNotBlank(locPostcd)) param.put("locPostcd", locPostcd);
		if (StringUtils.isNotBlank(serialNo)) param.put("serialNo", serialNo);
		if (StringUtils.isNotBlank(printerModel)) param.put("printerModel", printerModel);
		if (StringUtils.isNotBlank(captureType)) param.put("captureType", captureType);
		if (StringUtils.isNotBlank(padLock)) param.put("padLock", padLock);
		if (StringUtils.isNotBlank(insideLock)) param.put("insideLock", insideLock);
		if (StringUtils.isNotBlank(tagDueDt)) param.put("tagDueDt", tagDueDt);
		if (StringUtils.isNotBlank(type)) param.put("type", type);
		if (StringUtils.isNotBlank(boothComment)) param.put("boothComment", boothComment);
		if (StringUtils.isNotBlank(monitorType)) param.put("monitorType", monitorType);

		updateCnt = resManage.updateBoothInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/MoneyCollectAndServiceRequestList", produces = "application/json")
	@ResponseBody
	public ModelAndView moneyCollectList(HttpServletRequest request) throws Exception {

		ModelAndView mav = new ModelAndView();
		HashMap<String, String> param = new HashMap<String, String>();

		String boothId = request.getParameter("boothId");
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);

		JSONArray moneyCollectJsonList = new JSONArray();
		List<MoneyCollectDto> moneyCollectlist = moneyCollect.getMoneyCollectList(param);
		moneyCollectJsonList = JSONArray.fromObject(JSONSerializer.toJSON(moneyCollectlist));

		JSONArray svcReqJsonList = new JSONArray();
		List<MaintenanceHistoryDto> svcReqCollectlist = techSupport.getMaintenanceHistoryList(param);
		svcReqJsonList = JSONArray.fromObject(JSONSerializer.toJSON(svcReqCollectlist));

		mav.addObject("svcReqJsonList", svcReqJsonList);
		mav.addObject("moneyCollectJsonList", moneyCollectJsonList);

		return mav;
	}

}
