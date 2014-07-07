/**
 * 2013 MoneyCollectController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
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
import net.sf.json.JSONObject;
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
import com.photome.dto.BankAcctInfoDto;
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
@RequestMapping("/business/money/collect")
public class MoneyCollectController {

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
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/collect/main");

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

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		mav.addObject("yearOptions", yearOptions.toString());
		mav.addObject("monthOptions", monthOptions.toString());
		if (StringUtils.equals(sessionUser.getUserInfo().getUserId(), "admin")) {
			mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));
		} else {
			mav.addObject("groupListOptions", resManage.getGroupComboOptions(sessionUser.getUserInfo().getUserId(), ""));
		}
		mav.addObject("collectStatusOptions", code.getOptionsForHTML("PHOTOME", "COLLECT_STATUS"));

		return mav;
	}

	@RequestMapping(value = "/MoneyCollectList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyCollectList(HttpServletRequest request) throws Exception {

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String collectCollector = sessionUser.getUserInfo().getUserId();

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<MoneyCollectDto> list = null;

		String groupId = request.getParameter("groupId");
		String collectYear = request.getParameter("collectYear");
		String collectMonth = request.getParameter("collectMonth");
		String boothId = request.getParameter("boothId");
		String collectStatus = request.getParameter("collectStatus");
		String bankDt = request.getParameter("bankDt");

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

	@RequestMapping("/MoneyCollectRegistForm")
	public ModelAndView moneyCollectRegistForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/collect/moneyCollectRegistForm");

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		if (StringUtils.equals(sessionUser.getUserInfo().getUserId(), "admin")) {
			mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));
		} else {
			mav.addObject("groupListOptions", resManage.getGroupComboOptions(sessionUser.getUserInfo().getUserId(), ""));
		}
		String sessionUserId = null;
		String sessionUserName = null;
		if (sessionUser != null) {
			sessionUserId = sessionUser.getUserInfo().getUserId();
			sessionUserName = sessionUser.getUserInfo().getFirstName();
		}
		mav.addObject("sessionUserId", sessionUserId);
		mav.addObject("sessionUserName", sessionUserName);

		return mav;
	}

	@RequestMapping(value = "/MoneyCollectRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyCollectRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		int updateCnt = 0;

		String collectDate = request.getParameter("collectDate");
		String groupId = request.getParameter("groupId");
		String boothId = request.getParameter("boothId");
		String filmMtrNow = request.getParameter("filmMtrNow");
		String coinMtrNow = request.getParameter("coinMtrNow");
		String collectRealIncome = request.getParameter("collectRealIncome");
		String bankAccount = request.getParameter("bankAccount");
		String bankAmount = request.getParameter("bankAmount");
		String bankDt = request.getParameter("bankDt");
		String cashMtr = request.getParameter("cashMtr");
		String payOnsite = request.getParameter("payOnsite");
		String onsiteIsPaid = request.getParameter("onsiteIsPaid");
		String onsitePayAmount = request.getParameter("onsitePayAmount");
		String collectStatus = request.getParameter("collectStatus");

		if (StringUtils.isNotBlank(collectDate)) param.put("collectDate", collectDate);
		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(filmMtrNow)) param.put("filmMtrNow", filmMtrNow);
		if (StringUtils.isNotBlank(coinMtrNow)) param.put("coinMtrNow", coinMtrNow);
		if (StringUtils.isNotBlank(collectRealIncome)) param.put("collectRealIncome", collectRealIncome);
		if (StringUtils.isNotBlank(bankAccount)) param.put("bankAccount", bankAccount);
		if (StringUtils.isNotBlank(bankAmount)) param.put("bankAmount", bankAmount);
		if (StringUtils.isNotBlank(bankDt)) param.put("bankDt", bankDt);
		if (StringUtils.isNotBlank(cashMtr)) param.put("cashMtr", cashMtr);
		if (StringUtils.isNotBlank(payOnsite)) param.put("payOnsite", payOnsite);
		if (StringUtils.isNotBlank(onsiteIsPaid)) param.put("onsiteIsPaid", onsiteIsPaid);
		if (StringUtils.isNotBlank(onsitePayAmount)) param.put("onsitePayAmount", onsitePayAmount);
		if (StringUtils.isNotBlank(collectStatus)) param.put("collectStatus", collectStatus);

		updateCnt = moneyCollect.insertMoneyCollectInfo(param, sessionUser);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/MoneyCollectModifyForm")
	public ModelAndView moneyCollectModifyForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/collect/moneyCollectModifyForm");

		String collectId = request.getParameter("collectId");
		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String sessionUserId = null;
		String sessionUserName = null;
		if (sessionUser != null) {
			sessionUserId = sessionUser.getUserInfo().getUserId();
			sessionUserName = sessionUser.getUserInfo().getFirstName();
		}
		MoneyCollectDto moneyCollectDto = moneyCollect.getMoneyCollectInfo(collectId);

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(moneyCollectDto.getGroupId()));
		mav.addObject("boothListOptions", resManage.getBoothOptionsForHTML(moneyCollectDto.getGroupId(), moneyCollectDto.getBoothId()));
		mav.addObject("moneyCollectDto", moneyCollectDto);
		mav.addObject("sessionUserId", sessionUserId);
		mav.addObject("sessionUserName", sessionUserName);

		return mav;
	}

	@RequestMapping(value = "/MoneyCollectModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyCollectModify(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		int updateCnt = 0;

		String collectId = request.getParameter("collectId");
		String collectDate = request.getParameter("collectDate");
		String groupId = request.getParameter("groupId");
		String boothId = request.getParameter("boothId");
		// String filmMtrNow = request.getParameter("filmMtrNow");
		String coinMtrNow = request.getParameter("coinMtrNow");
		String collectRealIncome = request.getParameter("collectRealIncome");
		// String bankAccount = request.getParameter("bankAccount");
		// String bankAmount = request.getParameter("bankAmount");
		// String bankDt = request.getParameter("bankDt");
		String cashMtr = request.getParameter("cashMtr");
		String payOnsite = request.getParameter("payOnsite");
		String onsiteIsPaid = request.getParameter("onsiteIsPaid");
		String onsitePayAmount = request.getParameter("onsitePayAmount");
		String collectStatus = request.getParameter("collectStatus");

		if (StringUtils.isNotBlank(collectId)) param.put("collectId", collectId);
		if (StringUtils.isNotBlank(collectDate)) param.put("collectDate", collectDate);
		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		// if (StringUtils.isNotBlank(filmMtrNow)) param.put("filmMtrNow", filmMtrNow);
		if (StringUtils.isNotBlank(coinMtrNow)) param.put("coinMtrNow", coinMtrNow);
		if (StringUtils.isNotBlank(collectRealIncome)) param.put("collectRealIncome", collectRealIncome);
		// if (StringUtils.isNotBlank(bankAccount)) param.put("bankAccount", bankAccount);
		// if (StringUtils.isNotBlank(bankAmount)) param.put("bankAmount", bankAmount);
		// if (StringUtils.isNotBlank(bankDt)) param.put("bankDt", bankDt);
		if (StringUtils.isNotBlank(cashMtr)) param.put("cashMtr", cashMtr);
		if (StringUtils.isNotBlank(payOnsite)) param.put("payOnsite", payOnsite);
		if (StringUtils.isNotBlank(onsiteIsPaid)) param.put("onsiteIsPaid", onsiteIsPaid);
		if (StringUtils.isNotBlank(onsitePayAmount)) param.put("onsitePayAmount", onsitePayAmount);
		if (StringUtils.isNotBlank(collectStatus)) param.put("collectStatus", collectStatus);

		updateCnt = moneyCollect.updateMoneyCollectInfo(param, sessionUser);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/MoneyCollectDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyCollectDelete(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;
		String collectId = request.getParameter("collectId");
		updateCnt = moneyCollect.deleteMoneyCollectInfo(collectId);
		model.put("message", updateCnt);
		return model;
	}

	@RequestMapping("/MoneyCollectInfo")
	public ModelAndView moneyCollectInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/collect/viewMoneyCollectInfo");
		String collectId = request.getParameter("collectId");
		MoneyCollectDto moneyCollectDto = moneyCollect.getMoneyCollectInfo(collectId);

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		mav.addObject("sessionUser", sessionUser.getUserInfo());
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
		// String technician = request.getParameter("technician");
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

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String technician = sessionUser.getUserInfo().getUserId();

		if (!StringUtils.equals(sessionUser.getUserInfo().getUserId(), "admin") && StringUtils.isNotBlank(technician)) {
			if (StringUtils.isNotBlank(technician)) param.put("technician", technician);
		}

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothName)) param.put("boothName", boothName);
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

	@RequestMapping(value = "/BeforeMoneyCollectInfo", produces = "application/json")
	@ResponseBody
	public Map<String, Object> beforeMoneyCollectInfo(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		String boothId = request.getParameter("boothId");

		// 해당부스의 현재 렌트 설정 정보를 얻는다.
		BoothDto boothDto = resManage.getBoothInfo(boothId);
		MoneyCollectDto recentCollectDto = moneyCollect.getRecentMoneyCollectInfo(boothId);

		if (boothDto != null) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("boothDto", JSONObject.fromObject(JSONSerializer.toJSON(boothDto)));
			model.put("jsonObject", jsonObject);
		}

		if (recentCollectDto != null) {
			JSONObject jsonObject2 = new JSONObject();
			jsonObject2.put("recentCollectDto", JSONObject.fromObject(JSONSerializer.toJSON(recentCollectDto)));
			model.put("jsonObject2", jsonObject2);
		}

		return model;
	}

	@RequestMapping("/SetBankAccountForm")
	public ModelAndView setBankAccountForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/collect/setBankAccountForm");
		mav.addObject("bankList", code.getOptionsForHTML("PHOTOME", "ACCOUNT_BANK"));
		return mav;
	}

	@RequestMapping(value = "/SetBankAccountList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> bankAccountList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<BankAcctInfoDto> list = null;

		String bankName = request.getParameter("bankName");
		if (StringUtils.isNotBlank(bankName)) param.put("bankName", bankName);
		list = resManage.getBankAcctList(param);

		model.put("list", list);

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
}
