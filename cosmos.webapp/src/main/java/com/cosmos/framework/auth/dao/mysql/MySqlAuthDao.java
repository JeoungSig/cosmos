/** 
 * 2013 MySqlAuthDao.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.auth.dao.mysql;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.auth.AuthDao;
import com.cosmos.framework.core.CosmosBaseDao;
import com.cosmos.framework.user.UserDto;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlAuthDao extends CosmosBaseDao implements AuthDao {

	@Override
	public UserDto getUserInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().selectOne("mySqlUserDao.getUserInfo", map);
	}

	@Override
	public String getProfilePhoto(String userId) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		return getSqlSession().selectOne("mySqlUserDao.getProfilePhoto", map);
	}

	@Override
	public List<UserDto> getUserList(HashMap<String, String> map) throws Exception {
		return getSqlSession().selectList("mySqlUserDao.userList", map);
	}

	@Override
	public Integer deleteUserInfo(String userId) throws Exception {
		return getSqlSession().delete("mySqlUserDao.deleteUserInfo", userId);
	}

	@Override
	public Integer insertUserInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().insert("mySqlUserDao.insertUserInfo", map);
	}

	@Override
	public Integer modifyUserInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().insert("mySqlUserDao.modifyUserInfo", map);
	}

	@Override
	public boolean existUserInfo(String userId) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		UserDto userDto = this.getUserInfo(map);

		if (userDto == null)
			return false;
		else
			return true;
	}

	@Override
	public Integer modifyUserYn(HashMap<String, String> map) throws Exception {
		return getSqlSession().insert("mySqlUserDao.modifyUserYn", map);
	}

}
