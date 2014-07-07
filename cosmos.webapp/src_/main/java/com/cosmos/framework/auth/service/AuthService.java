/** 
 * 2013 AuthService.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.auth.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.TimeZone;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cosmos.framework.CosmosConstants;
import com.cosmos.framework.auth.Auth;
import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.cosmos.framework.code.Code;
import com.cosmos.framework.role.RoleDto;
import com.cosmos.framework.service.ServiceDto;
import com.cosmos.framework.service.dao.ServiceDao;
import com.cosmos.framework.user.UserDto;
import com.cosmos.framework.user.dao.UserDao;

/**
 * @author Steven J.S Min
 * 
 */
public class AuthService implements Auth {
	private static final Logger logger = LoggerFactory.getLogger(AuthService.class);

	@Resource(name = "userDao")
	private UserDao userDao;

	@Resource(name = "serviceDao")
	private ServiceDao serviceDao;
	
	@Resource(name = "code")
	private Code code;

	@Override
	public void setSuccessLogin(String userId) throws Exception {

		TimeZone tz = TimeZone.getTimeZone("Australia/Melbourne");
		SimpleDateFormat dFormat = new SimpleDateFormat("d MMM yyyy HH:mm:ss a");
		dFormat.setTimeZone(tz);
		String curTime = dFormat.format(new Date());

		userDao.setLoginTryCnt(userId, 0);
		userDao.setLastLoginTime(userId, curTime);

	}

	@Override
	public Integer setLoginTryCnt(String userId, int tryCnt) throws Exception {
		return userDao.setLoginTryCnt(userId, tryCnt);
	}

	@Override
	public CosmosSessionUserInfo setSessionUserInfo(String userId, HttpServletRequest request) throws Exception {
		// 1. 사용자 기본정보 설정
		// 2. 사용자 Role정보 설정( Key(롤키), 값(롤DTO) )
		// 3. 사용자 Service정보 설정( Key(서비스URL), 값(서비스DTO) )
		// 4. Role <-> 서비스 맵핑( Key(롤키), List<서비스DTO> )

		CosmosSessionUserInfo sessionUser = new CosmosSessionUserInfo();

		// 1. 사용자 기본정보 설정
		UserDto userDto = userDao.getUserInfo(userId);
		userDto.setUserTypeName(code.getCodeInfo("SYSTEM", "USER_TYPE", userDto.getUserType()).getCodeName());
		sessionUser.setUserInfo(userDto);

		// 2. 사용자 Role정보 설정( Key(롤키), 값(롤DTO) )
		HashMap<String, RoleDto> roleMap = new HashMap<String, RoleDto>();
		List<RoleDto> roleList = userDao.getUserRoles(userId);
		for (RoleDto dto : roleList) {
			roleMap.put(dto.getRoleId(), dto);
		}
		sessionUser.setRoleMap(roleMap);

		// 3. 사용자 Service정보 설정( Key(서비스URL), 값(서비스DTO) )
		HashMap<String, ServiceDto> serviceMap = new HashMap<String, ServiceDto>();
		List<ServiceDto> serviceList = serviceDao.getAllServices(userId);
		for (ServiceDto dto : serviceList) {
			serviceMap.put(dto.getSvcPrefix() + dto.getSvcUrl(), dto);
		}
		sessionUser.setServiceMap(serviceMap);

		// 4. Role <-> 서비스 맵핑( Key(롤키), List<서비스DTO> )
		HashMap<String, List<ServiceDto>> serviceRoleMap = new HashMap<String, List<ServiceDto>>();
		String roleId = null;
		for (RoleDto dto : roleList) {
			roleId = dto.getRoleId();
			serviceList = serviceDao.getServiceByRoleId(roleId);
			serviceRoleMap.put(roleId, serviceList);
		}
		sessionUser.setRoleServiceMap(serviceRoleMap);

		HttpSession session = request.getSession(true);
		session.setAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR, sessionUser);
		logger.debug("사용자 로그인 설정정보 완료");

		return sessionUser;
	}

	@Override
	public String getLoginUserTypeName(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		CosmosSessionUserInfo sessionUser = null;
		String returnVal = null;
		String userType = null;

		if (session != null) {
			sessionUser = (CosmosSessionUserInfo) session.getAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR);
			userType = sessionUser.getUserInfo().getUserType();
			returnVal = StringUtils.lowerCase(userType);
		}

		return returnVal;
	}

	@Override
	public boolean alreadyLogin(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		boolean returnVal = false;
		CosmosSessionUserInfo sessionUser = null;

		if (session != null) {
			sessionUser = (CosmosSessionUserInfo) session.getAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR);
		}

		if (sessionUser != null) returnVal = true;

		return returnVal;

	}

	@Override
	public CosmosSessionUserInfo getSessionUserInfo(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		CosmosSessionUserInfo sessionUser = null;
		if (session != null) {
			sessionUser = (CosmosSessionUserInfo) session.getAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR);
		}
		return sessionUser;
	}

	@Override
	public void logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		CosmosSessionUserInfo sessionUser = null;
		if (session != null) {
			sessionUser = (CosmosSessionUserInfo) session.getAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR);

			if (sessionUser != null) {
				session.removeAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR);
				session.removeAttribute(CosmosConstants.SELECT_MENUE_ROLEID);
				session.removeAttribute(CosmosConstants.SELECT_MENUE_SERVICEID);
			}
		}

	}

}
