/**
 * 2013 CommonController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.common.controller;

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

import com.cosmos.framework.common.Common;
import com.cosmos.framework.common.PostAddrDto;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/common/common")
public class CommonController {

	@Resource(name = "user")
	private User user;

	@Resource(name = "common")
	private Common common;

	@RequestMapping(value = "/PostalAddress", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getUserPostalAddress(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		HashMap<String, Object> map = null;

		String addrZipcd = request.getParameter("addrZipcd");

		try {
			map = common.getPostAddress(addrZipcd);
		} catch (Exception e) {
			e.printStackTrace();

		}

		model.put("state", (String) map.get("state"));
		model.put("postAddrList", (List<PostAddrDto>) map.get("postAddrList"));

		return model;
	}

	@RequestMapping("/alluserlist/Main")
	public ModelAndView getAllUserList(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/user/allUserList");
		return mav;
	}
	
	@RequestMapping(value = "/alluserlist/UserList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getUserList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<UserDto> list = null;

		String userType = request.getParameter("userType");
		String roleId = request.getParameter("roleId");
		String useYn = "Y";
		String firstName = request.getParameter("firstName");

		if (StringUtils.isEmpty(firstName)) {
			firstName = "%";
		} else {
			firstName = "%" + firstName + "%";
		}

		try {
			param.put("firstName", firstName);
			param.put("userType", StringUtils.isEmpty(userType) ? null : userType);
			param.put("roleId", StringUtils.isEmpty(roleId) ? null : roleId);
			param.put("useYn", StringUtils.isEmpty(useYn) ? null : useYn);
			list = user.getUserList(param);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("list", list);

		return model;
	}

}
