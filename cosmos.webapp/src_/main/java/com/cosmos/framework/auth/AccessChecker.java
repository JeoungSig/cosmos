/**
 * 2013 AccessChecker.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.auth;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cosmos.framework.CosmosConstants;
import com.cosmos.framework.CosmosContext;
import com.cosmos.framework.service.ServiceDto;

/**
 * @author Steven J.S Min
 * 
 */
public class AccessChecker {
	private static final Logger logger = LoggerFactory.getLogger(AccessChecker.class);

	public boolean hasAuth(HttpServletRequest request) {
		boolean hasAuth = false;

		try {

			String requestedUrl = request.getServletPath();
			String serviceUrl = StringUtils.substringBeforeLast(requestedUrl, "/");
			ServiceDto svcDto = null;

			logger.debug("서비스 URL:" + serviceUrl);
			HttpSession session = request.getSession(false);
			CosmosSessionUserInfo sessionUser = (CosmosSessionUserInfo) session.getAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR);

			HashMap<String, ServiceDto> serviceMap = sessionUser.getServiceMap();

			if (serviceMap.containsKey(serviceUrl)) {
				hasAuth = true;
				svcDto = (ServiceDto) serviceMap.get(serviceUrl);
				logger.debug("요청 서비스 정보:" + svcDto);
			} else {
				// 요청 URL에 없는 경우 해당 서비스가 인증이 필요한 서비스인지 체크
				if (CosmosContext.NO_LIMITED_SERVICE_MAP.containsKey(serviceUrl)) {
					hasAuth = true;
				} else {
					hasAuth = false;
				}
			}

		} catch (Exception e) {
			logger.debug("접근권한 체크도중 예외상황 발생:" + e.getMessage());
			e.printStackTrace();
			hasAuth = false;
		}
		return hasAuth;
	}
}
