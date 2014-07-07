/** 
 * 2013 RoleDao.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.role.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.role.RoleDto;

/**
 * Framwork Role data access interface.
 * 
 * @author Steven J.S Min
 * 
 */
public interface RoleDao {

	/**
	 * Framwork code data access interface.
	 * 
	 * @author Steven J.S Min
	 * 
	 */
	/**
	 * 롤의 상세정보를 조회한다.
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public RoleDto getRoleInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 등록된 롤 목록을 얻어온다.<br>
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<RoleDto> getRoleList(HashMap<String, String> map) throws Exception;

	/**
	 * 롤 정보를 삭제한다.
	 * 
	 * @param keyList
	 * @return
	 * @throws Exception
	 */
	public Integer deleteRoleInfo(String roleId) throws Exception;

	/**
	 * 롤정보를 등록한다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer insertRoleInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 롤정보를 수정한다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer modifyRoleInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 새로운 롤아이디를 얻는다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer getNewRoleId() throws Exception;

	/**
	 * 선택된 서비스정보들을 롤에 맵핑한다.
	 * 
	 * @param services
	 * @return
	 * @throws Exception
	 */
	public Integer applyMappingWithService(ArrayList<Object> services) throws Exception;

	/**
	 * 지정된 롤에대한 맵핑정보를 삭제한다..
	 * 
	 * @param roleId
	 * @param services
	 * @return
	 * @throws Exception
	 */
	public Integer removeRoleMappingWithService(String roleId, ArrayList<Object> services) throws Exception;

}