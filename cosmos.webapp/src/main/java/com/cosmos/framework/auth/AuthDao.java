/** 
 * 2013 AuthDao.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.auth;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.user.UserDto;

/**
 * Framwork User data access interface.
 * 
 * @author Steven J.S Min
 * 
 */
public interface AuthDao {

	/**
	 * Framwork User data access interface.
	 * 
	 * @author Steven J.S Min
	 * 
	 */
	/**
	 * 서비스 상세정보를 조회한다.
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public UserDto getUserInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 사용자 프로파일 사진정보 경로를 얻어온다.
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public String getProfilePhoto(String userId) throws Exception;

	/**
	 * 해당아이디에 해당하는 사용자가 존재하는지 체크한다.
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public boolean existUserInfo(String userId) throws Exception;

	/**
	 * 등록된서비스 목록을 얻어온다.<br>
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<UserDto> getUserList(HashMap<String, String> map) throws Exception;

	/**
	 * 서비스 정보를 삭제한다.
	 * 
	 * @param keyList
	 * @return
	 * @throws Exception
	 */
	public Integer deleteUserInfo(String svcId) throws Exception;

	/**
	 * 서비스정보를 등록한다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer insertUserInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 서비스정보를 수정한다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer modifyUserInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 사용자 상태정보를 업데이트한다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer modifyUserYn(HashMap<String, String> map) throws Exception;

}