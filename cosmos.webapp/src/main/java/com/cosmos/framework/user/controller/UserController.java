/**
 * 2013 UserController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.framework.code.Code;
import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.common.Common;
import com.cosmos.framework.common.PostAddrDto;
import com.cosmos.framework.role.Role;
import com.cosmos.framework.role.RoleDto;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;

/**
 * 서비스관리 콘트롤
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/framework/usermanager")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Resource(name = "user")
	private User user;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "role")
	private Role role;

	@Resource(name = "common")
	private Common common;

	@RequestMapping("/Main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView("framework/user/main");
		return mav;
	}

	@RequestMapping(value = "/UserList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getUserList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<UserDto> list = null;

		String userType = request.getParameter("userType");
		String roleId = request.getParameter("roleId");
		String useYn = request.getParameter("useYn");
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

	@RequestMapping("/UserRegistForm")
	public ModelAndView codeRegistForm() throws Exception {
		ModelAndView mav = new ModelAndView("framework/user/userRegistForm");

		mav.addObject("userTypeOptions", code.getOptionsForHTML("SYSTEM", "USER_TYPE"));

		return mav;
	}

	@RequestMapping("/UserRole")
	public ModelAndView setUserRole(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/user/roleMapping");

		UserDto userDto = new UserDto();

		String userId = request.getParameter("userId");
		userDto = user.getUserInfo(userId);

		mav.addObject("userDto", userDto);

		return mav;
	}

	@RequestMapping(value = "/UserRoleMapping", produces = "application/json")
	@ResponseBody
	public Map<String, Object> userRole(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		List<RoleDto> list = null;

		String userId = request.getParameter("userId");
		String mapped = request.getParameter("mapped");

		if (StringUtils.endsWith(mapped, "Y")) {
			list = user.getUserRoles(userId);
		} else {
			list = user.getUserRolesNotMapping(userId);
		}

		model.put("list", list);

		return model;
	}

	@RequestMapping(value = "/UserRoleMappingApply", produces = "application/json")
	@ResponseBody
	public Map<String, Object> applyMapping(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String jsonParam = request.getParameter("jsonParam");
		logger.info(jsonParam);

		Map<String, Object> classMap = new HashMap<String, Object>();
		JSONObject jsonObject = JSONObject.fromObject(jsonParam);

		Map<String, Object> jsonModel = (Map<String, Object>) JSONObject.toBean(jsonObject, HashMap.class, classMap);
		ArrayList<Object> roles = (ArrayList<Object>) jsonModel.get("list");

		updateCnt = user.applyMapping(roles);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/UserRoleMappingRemove", produces = "application/json")
	@ResponseBody
	public Map<String, Object> applyMappingRemove(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String jsonParam = request.getParameter("jsonParam");
		logger.info(jsonParam);

		Map<String, Object> classMap = new HashMap<String, Object>();
		JSONObject jsonObject = JSONObject.fromObject(jsonParam);

		Map<String, Object> jsonModel = (Map<String, Object>) JSONObject.toBean(jsonObject, HashMap.class, classMap);
		ArrayList<Object> roles = (ArrayList<Object>) jsonModel.get("list");
		String userId = (String) jsonModel.get("userId");

		updateCnt = user.removeMapping(userId, roles);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/UserRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> userRegist(HttpServletRequest request) throws Exception {

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
		String addrZipcd = request.getParameter("addrZipcd");
		String addrState = request.getParameter("addrState");
		String addrStreet = request.getParameter("addrStreet");
		String addrSuburb = request.getParameter("addrSuburb");
		String useYn = request.getParameter("useYn");

		if (!StringUtils.isBlank(userId)) param.put("userId", userId);
		if (!StringUtils.isBlank(userName)) param.put("firstName", userName);
		if (!StringUtils.isBlank(passwd)) param.put("passwd", passwd);
		if (!StringUtils.isBlank(userType)) param.put("userType", userType);
		if (!StringUtils.isBlank(pictureFile)) param.put("pictureFile", pictureFile);
		if (!StringUtils.isBlank(sex)) param.put("sex", sex);
		if (!StringUtils.isBlank(mobilePhone)) param.put("mobilePhone", mobilePhone);
		if (!StringUtils.isBlank(telePhone)) param.put("telephone", telePhone);
		if (!StringUtils.isBlank(email)) param.put("email", email);
		if (!StringUtils.isBlank(addrZipcd)) param.put("addrZipcd", addrZipcd);
		if (!StringUtils.isBlank(addrState)) param.put("addrState", addrState);
		if (!StringUtils.isBlank(addrStreet)) param.put("addrStreet", addrStreet);
		if (!StringUtils.isBlank(addrSuburb)) param.put("addrSuburb", addrSuburb);
		if (!StringUtils.isBlank(useYn)) param.put("useYn", useYn);

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

	@RequestMapping("/UserModifyForm")
	public ModelAndView modifyUserInfoForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/user/userModifyForm");

		UserDto userDto = new UserDto();

		String userId = request.getParameter("userId");

		userDto = user.getUserInfo(userId);
		String birthDt = userDto.getBirthDt();
		if (!StringUtils.isEmpty(birthDt) && StringUtils.length(birthDt) == 8) {
			birthDt = StringUtils.substring(birthDt, 0, 2) + "/" + StringUtils.substring(birthDt, 2, 4) + "/" + StringUtils.substring(birthDt, 4);
		}
		userDto.setBirthDt(birthDt);

		List<PostAddrDto> postAddrList = (List<PostAddrDto>) common.getPostAddress(userDto.getAddrZipcd()).get("postAddrList");

		mav.addObject("userTypeOptions", code.getOptionsForHTML("SYSTEM", "USER_TYPE", userDto.getUserType()));
		mav.addObject("userPhoto", user.getProfilePhoto(userId));
		mav.addObject("postAddrList", postAddrList);
		mav.addObject("userDto", userDto);

		return mav;
	}

	@RequestMapping("/UserDetailInfo")
	public ModelAndView userDetailInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/user/userDetailInfo");

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

	@RequestMapping(value = "/UserTypeAndRole", produces = "application/json")
	@ResponseBody
	public Map<String, Object> setUserTypeAndRole(HttpServletRequest request) throws Exception {

		List<CodeDto> userTypes = code.getCodeList("SYSTEM", "USER_TYPE");

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("userTypes", userTypes);

		List<RoleDto> roleList = role.getRoleList(new HashMap<String, String>());
		model.put("roles", roleList);

		return model;
	}

	@RequestMapping(value = "/UserModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyUserInfo(HttpServletRequest request) throws Exception {
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

		updateCnt = user.modifyUserInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/ModifyUseYn", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyUserYn(HttpServletRequest request) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String userId = request.getParameter("userId");
		String useYn = request.getParameter("useYn");
		param.put("userId", userId);
		param.put("useYn", useYn);

		updateCnt = user.changeUserStatus(userId, useYn);

		model.put("message", userId);
		model.put("updateCnt", updateCnt);

		return model;
	}

	@RequestMapping(value = "/UserDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> deleteUserInfo(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;
		String userId = request.getParameter("userId");

		// 사용자 기본정보 삭제
		updateCnt = user.deleteUserInfo(userId);

		// 사용자 사진정보 삭제

		model.put("message", updateCnt);

		return model;
	}

}
