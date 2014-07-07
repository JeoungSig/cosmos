/**
 * 2013 RoleService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.role.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.role.Role;
import com.cosmos.framework.role.RoleDto;
import com.cosmos.framework.role.dao.RoleDao;

/**
 * @author Steven J.S Min
 * 
 */
public class RoleService implements Role {

	@Resource(name = "roleDao")
	private RoleDao roleDao;

	@Override
	public RoleDto getRoleInfo(String roleId) throws Exception {
		if (StringUtils.isBlank(roleId)) throw new Exception("ROLE_IDcan not be empty. Check the value");

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("roleId", roleId);

		return roleDao.getRoleInfo(param);
	}

	@Override
	public List<RoleDto> getRoleList(HashMap<String, String> param) throws Exception {
		return roleDao.getRoleList(param);
	}

	@Override
	public Integer deleteRoleInfo(String roleId) throws Exception {
		if (StringUtils.isBlank(roleId)) throw new Exception("ROLE_IDcan not be empty. Check the values");

		return roleDao.deleteRoleInfo(roleId);
	}

	@Override
	public Integer insertRoleInfo(HashMap<String, String> param) throws Exception {
		return roleDao.insertRoleInfo(param);
	}

	@Override
	public Integer modifyRoleInfo(HashMap<String, String> param) throws Exception {
		String roleId = param.get("roleId");
		if (StringUtils.isBlank(roleId)) throw new Exception("ROLE_IDcan not be empty. Check the value");

		return roleDao.modifyRoleInfo(param);
	}

	@Override
	public Integer applyMappingWithService(ArrayList<Object> services) throws Exception {

		if (services.size() == 0) return 0;

		return roleDao.applyMappingWithService(services);
	}

	@Override
	public Integer removeRoleMappingWithService(String roleId, ArrayList<Object> services) throws Exception {
		if (StringUtils.isBlank(roleId)) throw new Exception("ROLE_IDcan not be empty. Check the value");
		if (services.size() == 0) return 0;

		return roleDao.removeRoleMappingWithService(roleId, services);
	}

}
