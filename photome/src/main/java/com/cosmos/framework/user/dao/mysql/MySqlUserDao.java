/**
 * 2013 MySqlUserDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.user.dao.mysql;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.cosmos.framework.core.CosmosBaseDao;
import com.cosmos.framework.role.RoleDto;
import com.cosmos.framework.user.UserDto;
import com.cosmos.framework.user.dao.UserDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlUserDao extends CosmosBaseDao implements UserDao {

	@Override
	public UserDto getUserInfo(String userId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("userId", userId);
		return getSqlSession().selectOne("mySqlUserDao.getUserInfo", param);
	}

	@Override
	public UserDto getValidUserInfo(String userId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("userId", userId);
		param.put("useYn", "Y");

		return getSqlSession().selectOne("mySqlUserDao.getUserInfo", param);
	}

	@Override
	public String getProfilePhoto(String userId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("userId", userId);
		return getSqlSession().selectOne("mySqlUserDao.getProfilePhoto", param);
	}

	@Override
	public List<UserDto> getUserList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlUserDao.userList", param);
	}

	@Override
	public Integer deleteUserInfo(String userId) throws Exception {
		return getSqlSession().delete("mySqlUserDao.deleteUserInfo", userId);
	}

	@Override
	public Integer insertUserInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlUserDao.insertUserInfo", param);
	}

	@Override
	public Integer modifyUserInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().update("mySqlUserDao.modifyUserInfo", param);
	}

	@Override
	public boolean existUserInfo(String userId) throws Exception {
		UserDto userDto = this.getUserInfo(userId);
		if (userDto == null) return false;
		else
			return true;
	}

	@Override
	public Integer changeUserStatus(String userId, String useYn, String pwdfailCnt) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("userId", userId);
		param.put("useYn", useYn);
		param.put("pwdfailCnt", pwdfailCnt);
		return getSqlSession().update("mySqlUserDao.changeUserStatus", param);
	}

	@Override
	public List<RoleDto> getUserRoles(String userId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("userId", userId);
		return getSqlSession().selectList("mySqlUserDao.getUserRoles", param);
	}

	@Override
	public List<RoleDto> getUserRolesNotMapping(String userId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("userId", userId);
		return getSqlSession().selectList("mySqlUserDao.getUserRolesNotMapping", param);
	}

	@Override
	public Integer applyMapping(ArrayList<Object> roles) throws Exception {
		if (roles.size() <= 0) return 0;

		List<HashMap> list = new ArrayList<HashMap>();
		HashMap<String, String> param = null;

		for (Object obj : roles) {
			param = new HashMap<String, String>();
			Map<String, String> mp = BeanUtils.describe(obj);
			param.put("userId", (mp.get("userId")));
			param.put("roleId", (mp.get("roleId")));
			list.add(param);
		}

		return getSqlSession().insert("mySqlUserDao.applyMapping", list);
	}

	@Override
	public Integer removeMapping(String userId, ArrayList<Object> services) throws Exception {
		if (services.size() <= 0) return 0;

		List<String> list = new ArrayList<String>();
		HashMap<String, String> svcIds = null;
		HashMap<String, Object> param = new HashMap<String, Object>();

		for (Object obj : services) {
			Map<String, String> mp = BeanUtils.describe(obj);
			list.add(mp.get("roleId"));
		}
		param.put("userId", userId);
		param.put("list", list);

		return getSqlSession().delete("mySqlUserDao.removeMapping", param);
	}

	@Override
	public boolean validateUserInfoWithPasswd(String userId, String passwd) throws Exception {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("passwd", passwd);
		
		UserDto userDto = getSqlSession().selectOne("mySqlUserDao.getUserInfo", param);

		if (userDto == null) return false;
		else
			return true;
	}

	@Override
	public Integer setLoginTryCnt(String userId, int tryCnt) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("userId", userId);
		param.put("pwdfailCnt", Integer.toString(tryCnt));

		return getSqlSession().update("mySqlUserDao.setLoginTryCnt", param);
	}


	@Override
	public Integer setLastLoginTime(String userId, String loginDt) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("userId", userId);
		param.put("loginDt", loginDt);

		return getSqlSession().update("mySqlUserDao.setLastLoginTime", param);
	}

}
