/**
 * 2013 BankAccountManageController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
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

import com.cosmos.framework.code.Code;
import com.photome.dto.BankAcctInfoDto;
import com.photome.resmanage.ResourceManage;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/resmanage/bankAccount")
public class BankAccountManageController {

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "code")
	private Code code;

	@RequestMapping("/Main")
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/bankAccount/main");
		mav.addObject("bankList", code.getOptionsForHTML("PHOTOME", "ACCOUNT_BANK"));
		return mav;
	}

	@RequestMapping(value = "/BankAccountList", produces = "application/json")
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

	@RequestMapping("/BankAccountInfoRegistForm")
	public ModelAndView bankAccountInfoRegistForm() throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/bankAccount/bankAccountRegistForm");
		mav.addObject("bankList", code.getOptionsForHTML("PHOTOME", "ACCOUNT_BANK"));

		return mav;
	}

	@RequestMapping(value = "/BankAccountInfoRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> bankAccountInfoRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String acctName = request.getParameter("acctName");
		String bankName = request.getParameter("bankName");
		String bankBsb = request.getParameter("bankBsb");
		String bankAcctNo = request.getParameter("bankAcctNo");
		String bankAcctHolderName = request.getParameter("bankAcctHolderName");

		if (StringUtils.isNotBlank(acctName)) param.put("acctName", acctName);
		if (StringUtils.isNotBlank(bankName)) param.put("bankName", bankName);
		if (StringUtils.isNotBlank(bankBsb)) param.put("bankBsb", bankBsb);
		if (StringUtils.isNotBlank(bankAcctNo)) param.put("bankAcctNo", bankAcctNo);
		if (StringUtils.isNotBlank(bankAcctHolderName)) param.put("bankAcctHolderName", bankAcctHolderName);

		updateCnt = resManage.registBankAcctInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/BankAccountInfoUpdateForm")
	public ModelAndView bankAccountInfoUpdateForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/bankAccount/bankAccountModifyForm");

		mav.addObject("bankList", code.getOptionsForHTML("PHOTOME", "ACCOUNT_BANK"));

		String acctId = request.getParameter("acctId");
		BankAcctInfoDto bankAcctInfoDto = resManage.getBankAcctInfo(acctId);

		mav.addObject("bankAcctInfoDto", bankAcctInfoDto);

		return mav;
	}

	@RequestMapping(value = "/BankAccountInfoUpdate", produces = "application/json")
	@ResponseBody
	public Map<String, Object> bankAccountInfoUpdate(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String acctId = request.getParameter("acctId");
		String acctName = request.getParameter("acctName");
		String bankName = request.getParameter("bankName");
		String bankBsb = request.getParameter("bankBsb");
		String bankAcctNo = request.getParameter("bankAcctNo");
		String bankAcctHolderName = request.getParameter("bankAcctHolderName");

		param.put("acctId", acctId);
		if (StringUtils.isNotBlank(acctName)) param.put("acctName", acctName);
		if (StringUtils.isNotBlank(bankName)) param.put("bankName", bankName);
		if (StringUtils.isNotBlank(bankBsb)) param.put("bankBsb", bankBsb);
		if (StringUtils.isNotBlank(bankAcctNo)) param.put("bankAcctNo", bankAcctNo);
		if (StringUtils.isNotBlank(bankAcctHolderName)) param.put("bankAcctHolderName", bankAcctHolderName);

		updateCnt = resManage.modifyBankAcctInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/BankAccountInfoDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> bankAccountInfoDelete(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String acctId = request.getParameter("acctId");

		param.put("acctId", acctId);
		updateCnt = resManage.deleteBankAcctInfo(acctId);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/BankAccountInfo")
	@ResponseBody
	public ModelAndView boothInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/bankAccount/bankAccountInfo");

		String acctId = request.getParameter("acctId");
		BankAcctInfoDto bankAcctInfoDto = resManage.getBankAcctInfo(acctId);

		mav.addObject("bankAcctInfoDto", bankAcctInfoDto);

		return mav;
	}


}
