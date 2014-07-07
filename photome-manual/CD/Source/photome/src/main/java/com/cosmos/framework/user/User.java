/**
 * 2013 User.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is prohibited
 * by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.role.RoleDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface User {
	/**
	 * 사용자 상세정보를 조회한다.
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public UserDto getUserInfo(String userId) throws Exception;

	/**
	 * 사용자 상세정보를 조회한다. 사용 상태가 'N'으로 마크된 사용자는 가저오지 않는다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public UserDto getValidUserInfo(String userId) throws Exception;

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
	 * 비밀번호와 함께 사용자의 유효성 검증을 한다.<br>
	 * 해당 사용자가 존재하면 true, 존재하지 않으면 false를 반환한다.
	 * 
	 * @param userId
	 * @param passwd
	 * @return
	 * @throws Exception
	 */
	public boolean validateUserInfoWithPasswd(String userId, String passwd) throws Exception;

	/**
	 * 등록된서비스 목록을 얻어온다.<br>
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<UserDto> getUserList(HashMap<String, String> param) throws Exception;

	/**
	 * 사용자 롤 목록을 얻어온다.
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<RoleDto> getUserRoles(String userId) throws Exception;

	/**
	 * 아직 해당사용자에게 맵핑되지 않은 롤 목록을 얻어온다.
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<RoleDto> getUserRolesNotMapping(String userId) throws Exception;

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
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer insertUserInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 서비스정보를 수정한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer modifyUserInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 사용자 상태정보를 업데이트한다.
	 * 
	 * @param userId
	 * @param useYn
	 * @return
	 * @throws Exception
	 */
	public Integer changeUserStatus(String userId, String useYn) throws Exception;

	/**
	 * 선택된 롤정보들을 사용자에 맵핑한다.
	 * 
	 * @param roles
	 * @return
	 * @throws Exception
	 */
	public Integer applyMapping(ArrayList<Object> roles) throws Exception;

	/**
	 * 지정된 사용자에대한 롤맵핑정보를 삭제한다..
	 * 
	 * @param userId
	 * @param roles
	 * @return
	 * @throws Exception
	 */
	public Integer removeMapping(String userId, ArrayList<Object> roles) throws Exception;

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
	 * 최근 로그인 날짜를 설정한다.
	 * 
	 * @param userId
	 * @param loginDt
	 * @return
	 * @throws Exception
	 */
	public Integer setLastLoginTime(String userId, String loginDt) throws Exception;

}
