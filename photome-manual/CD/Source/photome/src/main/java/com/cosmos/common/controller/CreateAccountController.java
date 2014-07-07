/**
 * 2013 CreateAccountController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.common.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.framework.common.Common;
import com.cosmos.framework.user.User;

/**
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/common/createAccount")
public class CreateAccountController {
	private static final Logger logger = LoggerFactory.getLogger(CreateAccountController.class);

	@Resource(name = "user")
	private User user;

	@Resource(name = "common")
	private Common common;

	@RequestMapping("/AccountRegistForm")
	public ModelAndView registForm() throws Exception {
		ModelAndView mav = new ModelAndView("guest/createNewAccount");
		return mav;
	}

	@RequestMapping(value = "/AccountRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> regist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		String passwd = request.getParameter("passwd");
		String pictureFile = request.getParameter("pictureFile");
		String sex = request.getParameter("sex");
		String birthDt = request.getParameter("birthDt");
		String mobilePhone = request.getParameter("mobilePhone");
		String telePhone = request.getParameter("telephone");
		String email = request.getParameter("email");
		String addrZipcd = request.getParameter("addrZipcd");
		String addrState = request.getParameter("addrState");
		String addrStreet = request.getParameter("addrStreet");
		String addrSuburb = request.getParameter("addrSuburb");

		param.put("userId", userId);
		param.put("firstName", userName);
		param.put("userType", "GUEST");
		param.put("passwd", passwd);
		param.put("pictureFile", pictureFile);
		param.put("sex", sex);
		param.put("mobilePhone", mobilePhone);
		param.put("telephone", telePhone);
		param.put("email", email);
		if (!StringUtils.isEmpty(birthDt)) birthDt = StringUtils.replace(birthDt, "/", "");
		param.put("birthDt", birthDt);
		param.put("addrZipcd", addrZipcd);
		param.put("addrState", addrState);
		param.put("addrStreet", addrStreet);
		param.put("addrSuburb", addrSuburb);
		param.put("useYn", "N");

		updateCnt = user.insertUserInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/ExistUserInfo", produces = "application/json")
	@ResponseBody
	public Map<String, Object> existUserInfo(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		boolean existUer = false;

		String userId = request.getParameter("userId");
		param.put("userId", userId);

		existUer = user.existUserInfo(userId);

		model.put("message", Boolean.toString(existUer));

		return model;
	}

}
