/**
 * 2013 UserService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.role.RoleDto;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;
import com.cosmos.framework.user.dao.UserDao;

/**
 * @author Steven J.S Min
 * 
 */
public class UserService implements User {

	@Resource(name = "userDao")
	private UserDao userDao;
	
	@Override
	public UserDto getUserInfo(String userId) throws Exception {
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");
		return userDao.getUserInfo(userId);
	}

	@Override
	public UserDto getValidUserInfo(String userId) throws Exception {
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");
		return userDao.getValidUserInfo(userId);
	}

	@Override
	public String getProfilePhoto(String userId) throws Exception {
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");
		return userDao.getProfilePhoto(userId);
	}

	@Override
	public boolean existUserInfo(String userId) throws Exception {
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");
		return userDao.existUserInfo(userId);
	}

	@Override
	public boolean validateUserInfoWithPasswd(String userId, String passwd) throws Exception {
		if (StringUtils.isBlank(userId) || StringUtils.isBlank(passwd)) throw new Exception("USER_ID, PASSWD are can not be empty.");
		return userDao.validateUserInfoWithPasswd(userId, passwd);
	}

	@Override
	public List<UserDto> getUserList(HashMap<String, String> param) throws Exception {
		return userDao.getUserList(param);
	}

	@Override
	public List<RoleDto> getUserRoles(String userId) throws Exception {
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");
		return userDao.getUserRoles(userId);
	}

	@Override
	public List<RoleDto> getUserRolesNotMapping(String userId) throws Exception {
		return userDao.getUserRolesNotMapping(userId);
	}

	@Override
	public Integer deleteUserInfo(String userId) throws Exception {
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");
		return userDao.deleteUserInfo(userId);
	}

	@Override
	public Integer insertUserInfo(HashMap<String, String> param) throws Exception {
		String userId = param.get("userId");
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");

		UserDto userDto = this.getUserInfo(userId);
		if (userDto != null) throw new Exception("Can not regist this user because this user already registed : " + userId);

		return userDao.insertUserInfo(param);
	}

	@Override
	public Integer modifyUserInfo(HashMap<String, String> param) throws Exception {
		String userId = param.get("userId");
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");

		return userDao.modifyUserInfo(param);
	}

	@Override
	public Integer changeUserStatus(String userId, String useYn) throws Exception {
		if (StringUtils.isBlank(userId) || StringUtils.isBlank(useYn)) throw new Exception("USER_ID and USE_YN are can not be empty.");
		return userDao.changeUserStatus(userId, useYn, "0");
	}

	@Override
	public Integer applyMapping(ArrayList<Object> roles) throws Exception {
		return userDao.applyMapping(roles);
	}

	@Override
	public Integer removeMapping(String userId, ArrayList<Object> roles) throws Exception {
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");
		return userDao.removeMapping(userId, roles);
	}

	@Override
	public Integer setLoginTryCnt(String userId, int tryCnt) throws Exception {
		if (StringUtils.isBlank(userId)) throw new Exception("USER_ID can not be empty.");
		return userDao.setLoginTryCnt(userId, tryCnt);
	}

	@Override
	public Integer setLastLoginTime(String userId, String loginDt) throws Exception {
		if (StringUtils.isBlank(userId) || StringUtils.isBlank(loginDt)) throw new Exception("USER_ID and LOGIN_DT are can not be empty.");
		return userDao.setLastLoginTime(userId, loginDt);
	}

}
