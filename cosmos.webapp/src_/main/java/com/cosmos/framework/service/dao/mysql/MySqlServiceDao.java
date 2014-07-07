/**
 * 2013 MySqlServiceDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author.
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.service.dao.mysql;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.core.CosmosBaseDao;
import com.cosmos.framework.service.ServiceDto;
import com.cosmos.framework.service.dao.ServiceDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlServiceDao extends CosmosBaseDao implements ServiceDao {

	@Override
	public Integer deleteServiceInfo(String svcId) throws Exception {
		return getSqlSession().delete("mySqlServiceDao.deleteServiceInfo", svcId);
	}

	@Override
	public boolean existServiceInfoByUrl(String svcPrefix, String svcUrl) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("svcPrefix", svcPrefix);
		map.put("svcUrl", svcUrl);
		boolean returnVal = false;

		String resultVal = getSqlSession().selectOne("mySqlServiceDao.existServiceInfoByUrl", map);

		if (StringUtils.endsWithIgnoreCase(resultVal, "true")) {
			returnVal = true;
		}

		return returnVal;
	}

	@Override
	public List<ServiceDto> getAllServices(String userId) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		return getSqlSession().selectList("mySqlServiceDao.getAllServices", map);
	}

	@Override
	public Integer getNewServiceId() throws Exception {
		return getSqlSession().selectOne("mySqlServiceDao.getNewServiceId");
	}

	@Override
	public List<ServiceDto> getServiceByRoleId(String roleId) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("roleId", roleId);
		return getSqlSession().selectList("mySqlServiceDao.getServiceByRoleId", map);
	}

	@Override
	public ServiceDto getServiceInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().selectOne("mySqlServiceDao.getServiceInfo", map);
	}

	@Override
	public ServiceDto getServiceInfoByUrl(String svcPrefix, String svcUrl) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("svcPrefix", svcPrefix);
		map.put("svcUrl", svcUrl);

		return getSqlSession().selectOne("mySqlServiceDao.getServiceInfoByUrl", map);
	}

	@Override
	public List<ServiceDto> getServiceList(HashMap<String, String> map) throws Exception {
		return getSqlSession().selectList("mySqlServiceDao.serviceList", map);
	}

	@Override
	public HashMap<String, ServiceDto> getServiceListForNotAuthReq() throws Exception {
		List<ServiceDto> list = getSqlSession().selectList("mySqlServiceDao.serviceListForNotAuthReq");
		HashMap<String, ServiceDto> serviceMap = new HashMap<String, ServiceDto>();

		if (list != null) {
			for (ServiceDto dto : list) {
				serviceMap.put(dto.getSvcPrefix() + dto.getSvcUrl(), dto);
			}
		} else {
			serviceMap = null;
		}

		return serviceMap;
	}

	@Override
	public List<ServiceDto> getServiceListWithMapped(HashMap<String, String> map) throws Exception {
		return getSqlSession().selectList("mySqlServiceDao.serviceListWithMapped", map);
	}

	@Override
	public List<ServiceDto> getServiceListWithNotMapped(HashMap<String, String> map) throws Exception {
		return getSqlSession().selectList("mySqlServiceDao.serviceListWithNotMapped", map);
	}

	@Override
	public Integer insertServiceInfo(HashMap<String, String> map) throws Exception {
		String newId = ((Integer) this.getNewServiceId()).toString();
		map.put("svcId", newId);
		return getSqlSession().insert("mySqlServiceDao.insertServiceInfo", map);
	}

	@Override
	public Integer modifyServiceInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().insert("mySqlServiceDao.modifyServiceInfo", map);
	}

}
