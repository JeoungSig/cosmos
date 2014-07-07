/**
 * 2013 ServiceDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author.
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.service.dao;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.service.ServiceDto;

/**
 * Framwork Service data access interface.
 * 
 * @author Steven J.S Min
 * 
 */
public interface ServiceDao {

	/**
	 * 서비스 정보를 삭제한다.
	 * 
	 * @param keyList
	 * @return
	 * @throws Exception
	 */
	public Integer deleteServiceInfo(String svcId) throws Exception;

	/**
	 * 서비스의 URL(서비스접두사 + 서비스접미사) 값으로 해당 서비스가 존재하는지 체크한다.
	 * 
	 * @param svcPrefix
	 * @param svcUrl
	 * @return
	 * @throws Exception
	 */
	public boolean existServiceInfoByUrl(String svcPrefix, String svcUrl) throws Exception;

	/**
	 * 사용자의 모든 서비스를 조회한다.
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<ServiceDto> getAllServices(String userId) throws Exception;

	/**
	 * 새로운서비스 아이디를 얻는다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer getNewServiceId() throws Exception;

	/**
	 * 지정된 롤에 해당하는 서비스 목록을 조회한다.
	 * 
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	public List<ServiceDto> getServiceByRoleId(String roleId) throws Exception;

	/**
	 * 서비스 상세정보를 조회한다.
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public ServiceDto getServiceInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 서비스의 URL(서비스접두사 + 서비스접미사) 값으로 해당 서비스 정보를 얻는다.
	 * 
	 * @param svcPrefix
	 * @param svcUrl
	 * @return
	 * @throws Exception
	 */
	public ServiceDto getServiceInfoByUrl(String svcPrefix, String svcUrl) throws Exception;

	/**
	 * 등록된서비스 목록을 얻어온다.<br>
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<ServiceDto> getServiceList(HashMap<String, String> map) throws Exception;

	/**
	 * 인증이 필요없는 모든 서비스 목록을 HashMap 형태로 얻어온다.<br>
	 * 이때 HashMap의 키는 서비스 URL(dto.getSvcPrefix() + dto.getSvcUrl())가 된다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, ServiceDto> getServiceListForNotAuthReq() throws Exception;

	/**
	 * 해당 롤에 맵핑된 롤 목록을 얻어온다.<br>
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */

	public List<ServiceDto> getServiceListWithMapped(HashMap<String, String> map) throws Exception;

	/**
	 * 해당 롤에 맵핑되지 않는 롤 목록을 얻어온다.<br>
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<ServiceDto> getServiceListWithNotMapped(HashMap<String, String> map) throws Exception;

	/**
	 * 서비스정보를 등록한다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer insertServiceInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 서비스정보를 수정한다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer modifyServiceInfo(HashMap<String, String> map) throws Exception;

}