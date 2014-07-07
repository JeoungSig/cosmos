/**
 * 2013 AccessCheckFilter.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.auth;

import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import com.cosmos.framework.CosmosConstants;
import com.cosmos.framework.CosmosContext;
import com.cosmos.framework.license.CMSLicenseManager;

/**
 * @author Steven J.S Min
 * 
 */
public class AccessCheckFilter implements Filter {
	private static final Logger logger = LoggerFactory.getLogger(AccessCheckFilter.class);
	private ArrayList<String> ignorUrlList;
	private CMSLicenseManager licenseMgt = new CMSLicenseManager();

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		String urls = CosmosContext.SYSTEM_PROPERTY.getAcessChkExceptUrl();

		urls = StringUtils.trimAllWhitespace(urls);
		StringTokenizer token = new StringTokenizer(urls, ",");
		ignorUrlList = new ArrayList<String>();

		while (token.hasMoreTokens()) {
			ignorUrlList.add(token.nextToken());

		}
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		AccessChecker accChecker = new AccessChecker();
		CosmosSessionUserInfo sessionUser = null;

		HttpSession session = request.getSession(false);
		if (session != null) {
			sessionUser = (CosmosSessionUserInfo) session.getAttribute(CosmosConstants.LOGIN_USER_SESSION_ATTR);
		}

		String url = request.getServletPath();
		// logger.debug("\n\nAccessCheckFilter: 요청  URL : " + url + "\n\n");
		if (ignorUrlList.contains(url)) {

			// 체크할 필요가 없는 URL인경우 바로 다음프로세스 처리
			// /common/auth/RestrictArea.action 은 Viwe페이지에서 사용자 세션정보를 필요로 하기 때문에 바로 Redirect하면 오류가 발생할 수 있다.
			if (org.apache.commons.lang.StringUtils.equals(url, "/common/auth/RestrictArea.action")) {
				if (sessionUser != null) {
					chain.doFilter(req, res);
				} else {
					response.sendRedirect("/photome/common/auth/Welcome.action");
				}

			} else {
				chain.doFilter(req, res);
			}

		} else {

			if (!licenseMgt.isValidDate()) {
				response.sendRedirect("/photome/common/auth/LicenseRestrict.action");
			}
			
			if (session == null) {
				// 세션이 없는 경우 검사할 필요없이 로그인 처리 페이지로 이동
				response.sendRedirect("/photome/common/auth/Welcome.action");
			} else {

				if (sessionUser != null) {
					if (accChecker.hasAuth(request) || StringUtils.endsWithIgnoreCase(sessionUser.getUserInfo().getUserId(), "admin")) {
						chain.doFilter(req, res);
					} else {
						// 권한이 없는 경우
						response.sendRedirect("/photome/common/auth/RestrictArea.action");
					}
				} else {
					// 사용장에대한 세션정보 자체가 없는 경우
					response.sendRedirect("/photome/common/auth/Welcome.action");
				}
			}
		}

	}

	@Override
	public void destroy() {
	}

}
