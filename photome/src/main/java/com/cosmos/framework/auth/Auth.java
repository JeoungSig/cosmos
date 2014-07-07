/** 
 * 2013 Auth.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.auth;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Steven J.S Min
 * 
 */
public interface Auth {

	/**
	 * 로그인 성공처리
	 * 
	 * @param userId
	 * @throws Exception
	 */
	public void setSuccessLogin(String userId) throws Exception;

	/**
	 * 로그인 시도횟수를 설정한다.
	 * 
	 * @param userId
	 * @param tryCnt
	 * @return
	 * @throws Exception
	 */
	public Integer setLoginTryCnt(String userId, int tryCnt) throws Exception;

	/**
	 * 사용자에대한 세션정보를 설정한다.
	 * 
	 * @param userId
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public CosmosSessionUserInfo setSessionUserInfo(String userId, HttpServletRequest request) throws Exception;

	/**
	 * 세션으로부터 사용자 설정정보를 얻는다.
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public CosmosSessionUserInfo getSessionUserInfo(HttpServletRequest request) throws Exception;

	/**
	 * 인증이 완료된 경우 적절한 페이지로 forwarding하기위하여 forwarding될 View의 논리적 이름을 얻는다.
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public String getLoginUserTypeName(HttpServletRequest request) throws Exception;

	/**
	 * 현재 시스템에 로그인되어있는지 확인한다.
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public boolean alreadyLogin(HttpServletRequest request) throws Exception;

	/**
	 * 현재 세션에대한 로그아웃처리
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public void logout(HttpServletRequest request) throws Exception;

}
