/**
 * 2013 AuthController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.auth.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.framework.CosmosConstants;
import com.cosmos.framework.auth.Auth;
import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.cosmos.framework.code.Code;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;

/**
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/common/auth")
public class AuthController {
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

	@Resource(name = "user")
	private User user;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "auth")
	private Auth auth;

	@RequestMapping("/Welcome")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		// 1. 로그인된 정보가 없는 경우 로그인할수 있는 페이지로 이동하도록한다.
		// 2. 로그인된 정보가 있는 경우 해당 첫페이지로 이동하도록 한다.
		ModelAndView mav = new ModelAndView("guest/welcome");
		String viewName = "";
		String userTypeName = "";

		if (auth.alreadyLogin(request)) {
			userTypeName = auth.getLoginUserTypeName(request);
			viewName = userTypeName + "/welcome";

			CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

			mav.addObject("userDto", sessionUser.getUserInfo());
			mav.addObject("userTypeName", code.getCodeInfo("SYSTEM", "USER_TYPE", sessionUser.getUserInfo().getUserType()).getCodeName());

			mav.addObject("roleMap", sessionUser.getRoleMap());
			mav.addObject("serviceMap", sessionUser.getServiceMap());
			mav.addObject("roleServiceMap", sessionUser.getRoleServiceMap());
		} else {
			viewName = "guest/welcome";
		}
		mav.setViewName(viewName);

		return mav;
	}

	@RequestMapping("/Logout")
	public ModelAndView logout(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("guest/welcome");
		auth.logout(request);
		return mav;
	}

	@RequestMapping("/RestrictArea")
	public ModelAndView restrictArea(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/access_restrict");
		return mav;
	}
	
	@RequestMapping("/LicenseRestrict")
	public ModelAndView licenseRestrict(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/license_restrict");
		return mav;
	}	

	@RequestMapping(value = "/Login", produces = "application/json")
	@ResponseBody
	public ModelAndView login(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("guest/frontpage");
		HashMap<String, String> param = new HashMap<String, String>();

		String userId = request.getParameter("userId");
		String passwd = request.getParameter("passwd");
		param.put("userId", userId);
		param.put("passwd", passwd);

		UserDto userDto = user.getValidUserInfo(userId);
		boolean valid = user.validateUserInfoWithPasswd(userId, passwd);
		String message = "";
		String status = "failure";
		int loginErrCnt = 0;

		if (userDto != null) {
			if (valid) {
				if (userDto.getPwdfailCnt() == null) {
					loginErrCnt = 0;
				} else {
					loginErrCnt = Integer.parseInt(userDto.getPwdfailCnt());
				}
				if (userDto.getUseYn() != "N" && loginErrCnt >= 5) {
					message = "You are blocked for login or fail over 5 times. Contact administrator.";
					status = "failure";
				} else {
					status = "success";

					auth.setSuccessLogin(userId);

					// 로그인이 최종적으로 성공할 경우 필요한 권한 설정 정보를 세션에 설정한다.
					// CosmosSessionUserInfo sessionUser = auth.setUserSesscionInfo(userId, request);
					auth.setSessionUserInfo(userId, request);
				}

			} else {
				if (userDto.getPwdfailCnt() == null) {
					loginErrCnt = 1;
				} else {
					loginErrCnt = Integer.parseInt(userDto.getPwdfailCnt()) + 1;
				}
				auth.setLoginTryCnt(userId, loginErrCnt);

				if (loginErrCnt >= 5) {
					user.changeUserStatus(userId, "N");

					message = "Warng password. Because your try for login over 5 times your accout was blocked. Contact administrator..";
					status = "failure";

				} else {
					message = "Not correct password. Failure :" + loginErrCnt + "times(Maximub 5times)";
					status = "failure";
				}
			}
		} else {
			// 존재하지 않는 사용자인 경우
			logger.debug("요청하신 인증정보에대한 정보가 존재하지 않습니다.");

			message = "No exist information";
			status = "failure";
		}

		mav.addObject("status", status);
		mav.addObject("message", message);
		return mav;
	}

	/**
	 * 페이지의 선택된 메뉴를 유지하기위하여 선택된 메뉴를 세션에 저장한다.<br>
	 * 1차 메뉴는 롤아이디, 2차 메뉴는 서비스 아이디이다.
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/SelectMenu", produces = "application/json")
	@ResponseBody
	public ModelAndView selectMenu(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();

		String selectedRroleId = request.getParameter("selectedRroleId");
		String selectedServiceId = request.getParameter("selectedServiceId");
		String serviceUrl = request.getParameter("serviceUrl");

		HttpSession session = request.getSession(true);

		if (!StringUtils.isEmpty(selectedRroleId)) {
			session.setAttribute(CosmosConstants.SELECT_MENUE_ROLEID, selectedRroleId);
			mav.addObject("selectedRroleId", CosmosConstants.SELECT_MENUE_ROLEID);
		}
		if (!StringUtils.isEmpty(selectedServiceId)) {
			session.setAttribute(CosmosConstants.SELECT_MENUE_SERVICEID, selectedServiceId);
			mav.addObject("selectedServiceId", CosmosConstants.SELECT_MENUE_SERVICEID);
		}

		mav.addObject("serviceUrl", serviceUrl);

		return mav;
	}

}
