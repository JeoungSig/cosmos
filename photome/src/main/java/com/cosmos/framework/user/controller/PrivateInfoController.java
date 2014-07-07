/**
 * 2013 PrivateInfoController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.framework.CosmosConstants;
import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.cosmos.framework.code.Code;
import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.common.Common;
import com.cosmos.framework.common.PostAddrDto;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;

/**
 * 개인정보 관리 콘트롤
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/framework/privateInfo")
public class PrivateInfoController {
	private static final Logger logger = LoggerFactory.getLogger(PrivateInfoController.class);

	@Resource(name = "user")
	private User user;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "common")
	private Common common;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession(false);
		CosmosSessionUserInfo sessionUser = null;
		if (session != null) {
			sessionUser = (CosmosSessionUserInfo) session.getAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR);
			request.setAttribute("userId", sessionUser.getUserInfo().getUserId());
		}

		mav = this.userDetailInfo(request);
		mav.setViewName("framework/privateInfo/main");
		mav.addObject("pupupMode", "NO");
		return mav;
	}

	@RequestMapping("/PrivateInfoModifyForm")
	public ModelAndView modifyUserInfoForm(HttpServletRequest request) throws Exception {
		String pupupMode = request.getParameter("pupupMode");
		String viewName = "framework/privateInfo/popup/privateInfoModifyForm";
		if (StringUtils.equals(pupupMode, "YES")) {
			viewName = "framework/privateInfo/popup/privateInfoModifyForm";
		} else {
			viewName = "framework/privateInfo/privateInfoModifyForm";
		}
		ModelAndView mav = new ModelAndView(viewName);

		UserDto userDto = new UserDto();

		String userId = request.getParameter("userId");

		userDto = user.getUserInfo(userId);
		String birthDt = userDto.getBirthDt();
		if (!StringUtils.isEmpty(birthDt) && StringUtils.length(birthDt) == 8) {
			birthDt = StringUtils.substring(birthDt, 0, 2) + "/" + StringUtils.substring(birthDt, 2, 4) + "/" + StringUtils.substring(birthDt, 4);
		}
		userDto.setBirthDt(birthDt);

		String userTypeOptions = code.getOptionsForHTML("SYSTEM", "USER_TYPE", userDto.getUserType());
		mav.addObject("userTypeOptions", userTypeOptions);

		List<PostAddrDto> postAddrList = (List<PostAddrDto>) common.getPostAddress(userDto.getAddrZipcd()).get("postAddrList");

		mav.addObject("pupupMode", pupupMode);
		mav.addObject("userPhoto", user.getProfilePhoto(userId));
		mav.addObject("postAddrList", postAddrList);
		mav.addObject("userDto", userDto);

		return mav;
	}

	@RequestMapping(value = "/PrivateInfoModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyUserInfo(HttpServletRequest request) {
		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		String passwd = request.getParameter("passwd");
		String userType = request.getParameter("userType");
		String pictureFile = request.getParameter("pictureFile");
		String sex = request.getParameter("sex");
		String mobilePhone = request.getParameter("mobilePhone");
		String telePhone = request.getParameter("telephone");
		String email = request.getParameter("email");
		String birthDt = request.getParameter("birthDt");
		String addrZipcd = request.getParameter("addrZipcd");
		String addrState = request.getParameter("addrState");
		String addrStreet = request.getParameter("addrStreet");
		String addrSuburb = request.getParameter("addrSuburb");
		String useYn = request.getParameter("useYn");

		if (!StringUtils.isBlank(userId)) param.put("userId", userId);
		if (!StringUtils.isBlank(userName)) param.put("firstName", userName);
		if (!StringUtils.isBlank(passwd)) param.put("passwd", passwd);
		if (!StringUtils.isBlank(userType)) param.put("userType", userType);
		param.put("pictureFile", StringUtils.isEmpty(pictureFile) ? null : pictureFile);
		if (!StringUtils.isBlank(sex)) param.put("sex", sex);
		if (!StringUtils.isBlank(mobilePhone)) param.put("mobilePhone", mobilePhone);
		if (!StringUtils.isBlank(telePhone)) param.put("telephone", telePhone);
		if (!StringUtils.isBlank(email)) param.put("email", email);

		birthDt = StringUtils.replace(birthDt, "/", "");
		if (!StringUtils.isBlank(birthDt)) param.put("birthDt", birthDt);
		if (!StringUtils.isBlank(addrZipcd)) param.put("addrZipcd", addrZipcd);
		if (!StringUtils.isBlank(addrState)) param.put("addrState", addrState);
		if (!StringUtils.isBlank(addrStreet)) param.put("addrStreet", addrStreet);
		if (!StringUtils.isBlank(addrSuburb)) param.put("addrSuburb", addrSuburb);
		if (!StringUtils.isBlank(useYn)) param.put("useYn", useYn);

		try {
			updateCnt = user.modifyUserInfo(param);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/PrivateDetailInfo")
	public ModelAndView userDetailInfo(HttpServletRequest request) throws Exception {
		String pupupMode = request.getParameter("pupupMode");
		String viewName = "framework/privateInfo/popup/privateDetailInfo";
		
		if (StringUtils.equals(pupupMode, "YES")) {
			viewName = "framework/privateInfo/popup/privateDetailInfo";
		} else {
			viewName = "framework/privateInfo/main";
		}
		ModelAndView mav = new ModelAndView(viewName);

		UserDto userDto = new UserDto();

		String userId = request.getParameter("userId");
		if (StringUtils.isEmpty(userId)) userId = (String) request.getAttribute("userId");
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

		mav.addObject("pupupMode", "YES");
		mav.addObject("userPhoto", user.getProfilePhoto(userId));
		mav.addObject("userDto", userDto);

		return mav;
	}

}
