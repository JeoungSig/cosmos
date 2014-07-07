/**
 * 2013 MoneyDepositController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
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

import com.cosmos.framework.code.Code;
import com.photome.dto.MoneyCollectDto;
import com.photome.dto.MoneyDepositDto;
import com.photome.money.MoneyDeposit;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/money/manage/deposit")
public class CheckMoneyDepositController {

	@Resource(name = "moneyDeposit")
	private MoneyDeposit moneyDeposit;

	@Resource(name = "code")
	private Code code;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/manage/deposit/main");

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
		mav.addObject("cretorOptions", moneyDeposit.getCreatorListForHTMLOptions());
		mav.addObject("statusOptions", code.getOptionsForHTML("PHOTOME", "COLLECT_STATUS"));
		
		return mav;
	}

	@RequestMapping(value = "/DepositList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> depositList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		String creator = request.getParameter("creator");
		String bankYear = request.getParameter("bankYear");
		String bankMonth = request.getParameter("bankMonth");
		String status = request.getParameter("status");

		param = new HashMap<String, String>();
		if (StringUtils.isNotBlank(creator)) param.put("creator", creator);
		if (StringUtils.isNotBlank(bankYear)) param.put("bankYear", bankYear);
		if (StringUtils.isNotBlank(bankMonth)) param.put("bankMonth", bankMonth);
		if (StringUtils.isNotBlank(status)) param.put("status", status);

		List<MoneyDepositDto> depositList = moneyDeposit.getBankDepositList(param);
		JSONArray jsonDepositList = new JSONArray();
		jsonDepositList = JSONArray.fromObject(JSONSerializer.toJSON(depositList));

		model.put("jsonList", jsonDepositList); // 입금한 목록

		return model;
	}

	@RequestMapping("/BankDepositInfo")
	public ModelAndView bankDepositInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/manage/deposit/bankDepositInfo");

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
