/**
 * 2013 MoneyManagerController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
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
import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.MoneyCollectDto;
import com.photome.money.MoneyCollect;
import com.photome.resmanage.ResourceManage;
import com.photome.techsupport.TechSupport;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/money/manage")
public class MoneyManagerController {

	@Resource(name = "moneyCollect")
	private MoneyCollect moneyCollect;

	@Resource(name = "techSupport")
	private TechSupport techSupport;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "user")
	private User user;

	@Resource(name = "auth")
	private Auth auth;

	@Resource(name = "attachFile")
	private AttachFile attachFile;

	@RequestMapping("/Main")
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView("business/money/manage/main");

		String curMonth = Integer.toString(GregorianCalendar.getInstance().get(Calendar.MONTH) + 1);
		if ((GregorianCalendar.getInstance().get(Calendar.MONTH) + 1) < 10) curMonth = "0" + curMonth;

		StringBuffer yearOptions = new StringBuffer("");
		StringBuffer monthOptions = new StringBuffer("");
		yearOptions.append("<option></option>");

		int curYear = GregorianCalendar.getInstance().get(Calendar.YEAR);
		for (int i = curYear; i > (curYear - 10); i--) {
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
		mav.addObject("collectStatusOptions", code.getOptionsForHTML("PHOTOME", "COLLECT_STATUS"));
		mav.addObject("collectCollectorOptions", moneyCollect.getMoneyCollectorListForHTMLOption(""));

		return mav;
	}

	@RequestMapping(value = "/MoneyCollectList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyCollectList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<MoneyCollectDto> list = null;

		String groupId = request.getParameter("groupId");
		String collectYear = request.getParameter("collectYear");
		String collectMonth = request.getParameter("collectMonth");
		String boothId = request.getParameter("boothId");
		String collectStatus = request.getParameter("collectStatus");
		String bankDt = request.getParameter("bankDt");
		String collectCollector = request.getParameter("collectCollector");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(collectYear)) param.put("collectYear", collectYear);
		if (StringUtils.isNotBlank(collectMonth)) param.put("collectMonth", collectMonth);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(collectStatus)) param.put("collectStatus", collectStatus);
		if (StringUtils.isNotBlank(bankDt)) param.put("bankDt", bankDt);
		if (StringUtils.isNotBlank(collectCollector)) param.put("collectCollector", collectCollector);

		list = moneyCollect.getMoneyCollectList(param);

		JSONArray jsonList = new JSONArray();
		jsonList = JSONArray.fromObject(JSONSerializer.toJSON(list));

		model.put("jsonList", jsonList);

		return model;
	}

	@RequestMapping("/MoneyCollectInfo")
	public ModelAndView moneyCollectInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/manage/viewMoneyCollectInfo");
		String collectId = request.getParameter("collectId");
		MoneyCollectDto moneyCollectDto = moneyCollect.getMoneyCollectInfo(collectId);

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		mav.addObject("sessionUser", sessionUser);
		mav.addObject("moneyCollectDto", moneyCollectDto);

		return mav;
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

	@RequestMapping(value = "/ChangeCollectStatus", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyCollectStatus(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		String collectId = request.getParameter("collectId");
		String collectStatus = request.getParameter("collectStatus");
		String userId = sessionUser.getUserInfo().getUserId();

		if (StringUtils.isNotBlank(collectId)) param.put("collectId", collectId);
		if (StringUtils.isNotBlank(collectStatus)) param.put("collectStatus", collectStatus);
		if (StringUtils.isNotBlank(userId)) param.put("userId", userId);

		Integer updateCnt = moneyCollect.modifyCollectStatus(collectId, collectStatus, userId);
		model.put("updateCnt", updateCnt);

		return model;
	}

}
