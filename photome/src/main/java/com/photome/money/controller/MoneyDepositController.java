/**
 * 2013 MoneyDepositController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.controller;

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
import com.photome.dto.MoneyCollectDto;
import com.photome.dto.MoneyDepositDto;
import com.photome.money.MoneyDeposit;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/money/deposit")
public class MoneyDepositController {

	@Resource(name = "moneyDeposit")
	private MoneyDeposit moneyDeposit;

	@Resource(name = "auth")
	private Auth auth;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/deposit/main");

		return mav;
	}

	@RequestMapping(value = "/CollectListForDeposit", produces = "application/json")
	@ResponseBody
	public Map<String, Object> collectListForDeposit(HttpServletRequest request) throws Exception {

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String sessionUserId = sessionUser.getUserInfo().getUserId();

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		if (StringUtils.isNotBlank(sessionUserId)) param.put("collectCollector", sessionUserId);

		List<MoneyCollectDto> collectList = moneyDeposit.getMoneyCollectListForDeposit(param);

		JSONArray jsonCollectList = new JSONArray();
		jsonCollectList = JSONArray.fromObject(JSONSerializer.toJSON(collectList));

		model.put("jsonList", jsonCollectList); // 입금해야할 수금 목록

		return model;
	}

	@RequestMapping(value = "/DepositList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> depositList(HttpServletRequest request) throws Exception {

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String sessionUserId = sessionUser.getUserInfo().getUserId();

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		if (StringUtils.isNotBlank(sessionUserId)) param.put("collectCollector", sessionUserId);

		param = new HashMap<String, String>();
		param.put("creator", sessionUserId);
		List<MoneyDepositDto> depositList = moneyDeposit.getBankDepositList(param);
		JSONArray jsonDepositList = new JSONArray();
		jsonDepositList = JSONArray.fromObject(JSONSerializer.toJSON(depositList));

		model.put("jsonList", jsonDepositList); // 입금한 목록

		return model;
	}

	@RequestMapping("/BankDeposit")
	public ModelAndView bankDeposit(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/deposit/bankDeposit");

		return mav;
	}

	@RequestMapping(value = "/BankDepositRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyCollectRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		int updateCnt = 0;

		String allDepositRows = request.getParameter("allDepositRows");
		String bankTotalAmount = request.getParameter("bankTotalAmount");
		String bankDt = request.getParameter("bankDt");
		String status = request.getParameter("status");
		String comment = request.getParameter("comment");
		String bankDay = StringUtils.substringBefore(bankDt, "/");
		String bankMonth = StringUtils.substringBetween(bankDt, "/");
		String bankYear = StringUtils.substringAfterLast(bankDt, "/");

		if (StringUtils.isNotBlank(allDepositRows)) param.put("allDepositRows", allDepositRows);

		if (StringUtils.isNotBlank(bankTotalAmount)) param.put("bankTotalAmount", bankTotalAmount);
		if (StringUtils.isNotBlank(bankDt)) param.put("bankDt", bankDt);
		if (StringUtils.isNotBlank(comment)) param.put("comment", comment);
		if (StringUtils.isNotBlank(bankDay)) param.put("bankDay", bankDay);
		if (StringUtils.isNotBlank(bankMonth)) param.put("bankMonth", bankMonth);
		if (StringUtils.isNotBlank(bankYear)) param.put("bankYear", bankYear);
		param.put("userId", sessionUser.getUserInfo().getUserId());
		param.put("status", status);

		updateCnt = moneyDeposit.insertBankDepositInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/BankDepositInfo")
	public ModelAndView bankDepositInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/deposit/bankDepositInfo");

		String depositId = request.getParameter("depositId");

		MoneyDepositDto moneyDepositDto = moneyDeposit.getBankDepositInfo(depositId);
		List<MoneyCollectDto> moneyCollectDtoList = moneyDeposit.getMoneyCollectListForDeposit(depositId);

		mav.addObject("moneyDepositDto", moneyDepositDto);
		mav.addObject("moneyCollectDtoList", moneyCollectDtoList);

		return mav;
	}

	@RequestMapping(value = "/BankDepositCancel", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyCollectCancel(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String depositId = request.getParameter("depositId");
		updateCnt = moneyDeposit.deleteBankDepositInfo(depositId);
		// updateCnt = moneyDeposit.unmarkDepositIdToCollectInfo(depositId); // --> DB Constraint에의해서 자동으로 Null처리된다.

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/BankDepositChangeStatus", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyCollectChangeStatus(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String depositId = request.getParameter("depositId");
		String status = request.getParameter("status");
		updateCnt = moneyDeposit.changeBankDepositStatus(depositId, status);
		model.put("message", updateCnt);

		return model;
	}

}
