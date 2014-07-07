/** 
 * 2013 MySqlRoleDao.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.role.dao.mysql;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.cosmos.framework.core.CosmosBaseDao;
import com.cosmos.framework.role.RoleDto;
import com.cosmos.framework.role.dao.RoleDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlRoleDao extends CosmosBaseDao implements RoleDao {

	@Override
	public RoleDto getRoleInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().selectOne("mySqlRoleDao.getRoleInfo", map);
	}

	@Override
	public List<RoleDto> getRoleList(HashMap<String, String> map) throws Exception {
		return getSqlSession().selectList("mySqlRoleDao.roleList", map);
	}

	@Override
	public Integer deleteRoleInfo(String roleId) throws Exception {
		return getSqlSession().delete("mySqlRoleDao.deleteRoleInfo", roleId);
	}

	@Override
	public Integer insertRoleInfo(HashMap<String, String> map) throws Exception {
		String newId = ((Integer) this.getNewRoleId()).toString();
		map.put("roleId", newId);
		return getSqlSession().insert("mySqlRoleDao.insertRoleInfo", map);
	}

	@Override
	public Integer modifyRoleInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().insert("mySqlRoleDao.modifyRoleInfo", map);
	}

	@Override
	public Integer getNewRoleId() throws Exception {
		return getSqlSession().selectOne("mySqlRoleDao.getNewRoleId");
	}

	@Override
	public Integer applyMappingWithService(ArrayList<Object> services) throws Exception {
		if (services.size() <= 0)
			return 0;

		List<HashMap> list = new ArrayList<HashMap>();
		HashMap<String, String> param = null;

		for (Object obj : services) {
			param = new HashMap<String, String>();
			Map<String, String> mp = BeanUtils.describe(obj);
			param.put("svcId", (mp.get("svcId")));
			param.put("roleId", (mp.get("roleId")));
			list.add(param);
		}

		return getSqlSession().insert("mySqlRoleDao.applyMappingWithService", list);
	}

	@Override
	public Integer removeRoleMappingWithService(String roleId, ArrayList<Object> services) throws Exception {
		if (services.size() <= 0)
			return 0;

		List<String> list = new ArrayList<String>();
		HashMap<String, String> svcIds = null;
		HashMap<String, Object> param = new HashMap<String, Object>();

		for (Object obj : services) {
			Map<String, String> mp = BeanUtils.describe(obj);
			list.add(mp.get("svcId"));
		}
		param.put("roleId", roleId);
		param.put("list", list);

		return getSqlSession().delete("mySqlRoleDao.removeRoleMappingWithService", param);
	}

}
