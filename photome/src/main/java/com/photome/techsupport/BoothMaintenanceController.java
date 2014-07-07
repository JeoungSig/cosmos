/**
 * 2013 BoothMaintenanceController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.techsupport;

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

import com.cosmos.common.AttachFile;
import com.cosmos.common.AttachFileDto;
import com.cosmos.framework.auth.Auth;
import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.cosmos.framework.code.Code;
import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.common.Common;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.MaintenanceHistoryDto;
import com.photome.resmanage.ResourceManage;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/techsupport/maintenance")
public class BoothMaintenanceController {

	@Resource(name = "techSupport")
	private TechSupport techSupport;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "auth")
	private Auth auth;

	@Resource(name = "attachFile")
	private AttachFile attachFile;

	@Resource(name = "user")
	private User user;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "common")
	private Common common;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/techsupport/maintenance/main");

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));
		mav.addObject("stateListOptions", common.getStateComboOptions(""));

		List<UserDto> technicianList = techSupport.getTechnicianList(new HashMap<String, String>());
		StringBuffer technicians = new StringBuffer("<option selected></option>");
		for (UserDto dto : technicianList) {
			technicians.append("<option value=\"" + dto.getUserId() + "\" >" + dto.getFirstName() + "</option>");
		}
		mav.addObject("technicianListOptions", technicians.toString());

		mav.addObject("claimTypeOptions", code.getOptionsForHTML("PHOTOME", "CLAIM_TYPE"));
		mav.addObject("claimStatusOptions", code.getOptionsForHTML("PHOTOME", "CLAIM_STATUS"));

		return mav;
	}

	@RequestMapping(value = "/HistoryList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getHistoryList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<MaintenanceHistoryDto> list = null;

		String groupId = request.getParameter("groupId");
		String boothId = request.getParameter("boothId");
		String pstState = request.getParameter("pstState");
		String creator = request.getParameter("creator");
		String claimType = request.getParameter("claimType");
		String claimStatus = request.getParameter("claimStatus");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(pstState)) param.put("pstState", pstState);
		if (StringUtils.isNotBlank(creator)) param.put("creator", creator);
		if (StringUtils.isNotBlank(claimType)) param.put("claimType", claimType);
		if (StringUtils.isNotBlank(claimStatus)) param.put("claimStatus", claimStatus);

		list = techSupport.getMaintenanceHistoryList(param);

		model.put("list", list);

		return model;
	}

	@RequestMapping("/HistoryInfo")
	public ModelAndView getHistoryInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/techsupport/maintenance/historyInfo");
		String historyId = request.getParameter("historyId");
		MaintenanceHistoryDto historyDto = techSupport.getMaintenanceHistoryInfo(historyId);

		AttachFileDto attachFileDto = null;
		String attachFileId = historyDto.getAttachFile();
		if (!StringUtils.isEmpty(attachFileId)) {
			attachFileDto = attachFile.getFileInfo(attachFileId);
		}

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String sessionUserId = null;
		if (sessionUser != null) {
			sessionUserId = sessionUser.getUserInfo().getUserId();
		}

		mav.addObject("sessionUserId", sessionUserId);
		mav.addObject("attachFileDto", attachFileDto);
		mav.addObject("historyDto", historyDto);

		return mav;
	}

	@RequestMapping("/HistoryRegistForm")
	public ModelAndView registHistoryForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/techsupport/maintenance/historyRegistForm");

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		mav.addObject("groupListOptions", resManage.getGroupComboOptions(sessionUser.getUserInfo().getUserId(), ""));
		mav.addObject("boothStatusOptions", code.getOptionsForHTML("PHOTOME", "BOOTH_STATUS"));
		mav.addObject("claimTypeOptions", code.getOptionsForHTML("PHOTOME", "CLAIM_TYPE"));
		mav.addObject("claimStatusOptions", code.getOptionsForHTML("PHOTOME", "CLAIM_STATUS"));

		return mav;
	}

	@RequestMapping(value = "/HistoryRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> registHistory(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;
		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String sessionUserId = null;
		if (sessionUser != null) {
			sessionUserId = sessionUser.getUserInfo().getUserId();
		}

		String boothId = request.getParameter("boothId");
		String subject = request.getParameter("subject");
		String contents = request.getParameter("contents");
		String claimType = request.getParameter("claimType");
		String claimStatus = request.getParameter("claimStatus");
		String attachFile = request.getParameter("attachFile");
		String pstPostcd = request.getParameter("pstPostcd");
		String pstState = request.getParameter("pstState");
		String pstSuburb = request.getParameter("pstSuburb");
		String pstStreetNo = request.getParameter("pstStreetNo");
		String boothStatus = request.getParameter("boothStatus");

		if (!StringUtils.endsWith(claimType, "RPT_BROKEN")) boothStatus = null;
		if (!StringUtils.endsWith(claimType, "REQ_PART")) {
			pstPostcd = null;
			pstState = null;
			pstSuburb = null;
			pstStreetNo = null;
		}

		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(subject)) param.put("subject", subject);
		if (StringUtils.isNotBlank(contents)) param.put("contents", contents);
		if (StringUtils.isNotBlank(sessionUserId)) param.put("creator", sessionUserId);
		if (StringUtils.isNotBlank(claimType)) param.put("claimType", claimType);
		if (StringUtils.isNotBlank(claimStatus)) param.put("claimStatus", claimStatus);
		if (StringUtils.isNotBlank(attachFile)) param.put("attachFile", attachFile);
		if (StringUtils.isNotBlank(pstPostcd)) param.put("pstPostcd", pstPostcd);
		if (StringUtils.isNotBlank(pstState)) param.put("pstState", pstState);
		if (StringUtils.isNotBlank(pstSuburb)) param.put("pstSuburb", pstSuburb);
		if (StringUtils.isNotBlank(pstStreetNo)) param.put("pstStreetNo", pstStreetNo);
		if (StringUtils.isNotBlank(boothStatus)) param.put("boothStatus", boothStatus);

		updateCnt = techSupport.insertMaintenanceHistory(param);

		model.put("message", updateCnt);
		return model;
	}

	@RequestMapping("/HistoryModifyForm")
	public ModelAndView modifyHistoryForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/techsupport/maintenance/historyModifyForm");

		String historyId = request.getParameter("historyId");
		MaintenanceHistoryDto historyDto = techSupport.getMaintenanceHistoryInfo(historyId);

		AttachFileDto attachFileDto = null;
		String attachFileId = historyDto.getAttachFile();
		if (!StringUtils.isEmpty(attachFileId)) {
			attachFileDto = attachFile.getFileInfo(attachFileId);
		}

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(historyDto.getGroupId()));
		mav.addObject("boothStatusOptions", code.getOptionsForHTML("PHOTOME", "BOOTH_STATUS", historyDto.getBoothStatus()));
		mav.addObject("claimTypeOptions", code.getOptionsForHTML("PHOTOME", "CLAIM_TYPE", historyDto.getClaimType()));
		mav.addObject("claimStatusOptions", code.getOptionsForHTML("PHOTOME", "CLAIM_STATUS", historyDto.getClaimStatus()));

		mav.addObject("attachFileDto", attachFileDto);
		mav.addObject("historyDto", historyDto);

		return mav;
	}

	@RequestMapping(value = "/HistoryModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyHistory(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String historyId = request.getParameter("historyId");
		String boothId = request.getParameter("boothId");
		String subject = request.getParameter("subject");
		String contents = request.getParameter("contents");
		String claimType = request.getParameter("claimType");
		String claimStatus = request.getParameter("claimStatus");
		String attachFile = request.getParameter("attachFile");
		String pstPostcd = request.getParameter("pstPostcd");
		String pstState = request.getParameter("pstState");
		String pstSuburb = request.getParameter("pstSuburb");
		String pstStreetNo = request.getParameter("pstStreetNo");
		String boothStatus = request.getParameter("boothStatus");

		if (!StringUtils.endsWith(claimType, "RPT_BROKEN")) boothStatus = null;
		if (!StringUtils.endsWith(claimType, "REQ_PART")) {
			pstPostcd = null;
			pstState = null;
			pstSuburb = null;
			pstStreetNo = null;
		}

		if (StringUtils.isNotBlank(historyId)) param.put("historyId", historyId);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(subject)) param.put("subject", subject);
		if (StringUtils.isNotBlank(contents)) param.put("contents", contents);
		if (StringUtils.isNotBlank(claimType)) param.put("claimType", claimType);
		if (StringUtils.isNotBlank(claimStatus)) param.put("claimStatus", claimStatus);
		if (StringUtils.isNotBlank(attachFile)) param.put("attachFile", attachFile);
		if (StringUtils.isNotBlank(pstPostcd)) param.put("pstPostcd", pstPostcd);
		if (StringUtils.isNotBlank(pstState)) param.put("pstState", pstState);
		if (StringUtils.isNotBlank(pstSuburb)) param.put("pstSuburb", pstSuburb);
		if (StringUtils.isNotBlank(pstStreetNo)) param.put("pstStreetNo", pstStreetNo);
		if (StringUtils.isNotBlank(boothStatus)) param.put("boothStatus", boothStatus);

		updateCnt = techSupport.updateMaintenanceHistory(param);

		model.put("message", updateCnt);
		return model;
	}

	@RequestMapping(value = "/TechnicianListOfMaintenance", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getTechnicianListOfMaintenance(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		String boothId = request.getParameter("boothId");
		String pstState = request.getParameter("pstState");
		String claimType = request.getParameter("claimType");
		String claimStatus = request.getParameter("claimStatus");

		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(pstState)) param.put("pstState", pstState);
		if (StringUtils.isNotBlank(claimType)) param.put("claimType", claimType);
		if (StringUtils.isNotBlank(claimStatus)) param.put("claimStatus", claimStatus);

		List<UserDto> technicianList = techSupport.getTechnicianList(param);
		model.put("technicianList", technicianList);

		return model;
	}

	@RequestMapping(value = "/BoothListOfGroup", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getBoothListOfGroup(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		String groupId = request.getParameter("groupId");
		String boothName = request.getParameter("boothName");
		String technician = request.getParameter("technician");
		String status = request.getParameter("status");
		String locState = request.getParameter("locState");
		String serialNo = request.getParameter("serialNo");
		String printerModel = request.getParameter("printerModel");
		String captureType = request.getParameter("captureType");
		String tagDueDt = request.getParameter("tagDueDt");
		String qualityTestResult = request.getParameter("qualityTestResult");
		String type = request.getParameter("type");
		String boothComment = request.getParameter("boothComment");
		String monitorType = request.getParameter("monitorType");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothName)) param.put("boothName", boothName);
		if (StringUtils.isNotBlank(technician)) param.put("technician", technician);
		if (StringUtils.isNotBlank(status)) param.put("status", status);
		if (StringUtils.isNotBlank(locState)) param.put("locState", locState);
		if (StringUtils.isNotBlank(serialNo)) param.put("serialNo", serialNo);
		if (StringUtils.isNotBlank(printerModel)) param.put("printerModel", printerModel);
		if (StringUtils.isNotBlank(captureType)) param.put("captureType", captureType);
		if (StringUtils.isNotBlank(tagDueDt)) param.put("tagDueDt", tagDueDt);
		if (StringUtils.isNotBlank(qualityTestResult)) param.put("qualityTestResult", qualityTestResult);
		if (StringUtils.isNotBlank(type)) param.put("type", type);
		if (StringUtils.isNotBlank(boothComment)) param.put("boothComment", boothComment);
		if (StringUtils.isNotBlank(monitorType)) param.put("monitorType", monitorType);

		List<BoothDto> list = resManage.getBoothInfoList(param);
		model.put("boothList", list);

		return model;
	}

	@RequestMapping("/GroupInfo")
	@ResponseBody
	public ModelAndView groupInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/group/groupInfo");

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
