/**
 * 2013 MySqlSysProptyDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.system.dao.mysql;

import java.util.HashMap;

import com.cosmos.common.AttachFileDto;
import com.cosmos.framework.core.CosmosBaseDao;
import com.cosmos.framework.system.SysProptyDto;
import com.cosmos.framework.system.dao.SysProptyDao;
import com.cosmos.framework.user.UserDto;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlSysProptyDao extends CosmosBaseDao implements SysProptyDao {

	@Override
	public Integer accessCheckExceptUrlModify(String acessChkExceptUrl) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("acessChkExceptUrl", acessChkExceptUrl);
		return getSqlSession().update("mySqlSysProptyDao.modifyAccessCheckExceptUrl", map);
	}

	@Override
	public HashMap<String, String> getSysPropertyInfo() throws Exception {

		HashMap<String, String> map = getSqlSession().selectOne("mySqlSysProptyDao.getSysPropertyInfo");
		return map;
	}

	@Override
	public HashMap<String, Object> getSysPropertyInfo2() throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();

		HashMap<String, String> property = getSqlSession().selectOne("mySqlSysProptyDao.getSysPropertyInfo");

		UserDto userDto = new UserDto();
		AttachFileDto fileDto = new AttachFileDto();
		SysProptyDto propertyDto = new SysProptyDto();

		propertyDto.setSysId(((Integer) ((Object) property.get("sysId"))).toString());
		propertyDto.setSysName(property.get("sysName"));
		propertyDto.setSysDescript(property.get("sysDescript"));
		propertyDto.setCopyright(property.get("copyright"));
		propertyDto.setFileId(((Integer) ((Object) property.get("fileId"))).toString());
		propertyDto.setAdminUserId(property.get("adminUserId"));
		propertyDto.setAcessChkExceptUrl(property.get("acessChkExceptUrl"));
		propertyDto.setDataUploadRootpath(property.get("dataUploadRootpath"));

		userDto.setUserId(property.get("adminUserId"));
		userDto.setFirstName(property.get("firstName"));
		userDto.setEmail(property.get("email"));
		userDto.setMobilePhone(property.get("mobilePhone"));
		userDto.setTelephone(property.get("telephone"));

		fileDto.setFileId(((Integer) ((Object) property.get("fileId"))).toString());
		fileDto.setFileName(property.get("fileName"));
		fileDto.setSavedName(property.get("savedName"));
		fileDto.setInfoType(property.get("infoType"));
		fileDto.setFullPath(property.get("savedName"));

		map.put("propertyDto", propertyDto);
		map.put("userDto", userDto);
		map.put("fileDto", fileDto);

		return map;
	}

	@Override
	public Integer modifyAdministrator(String userId) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		return getSqlSession().update("mySqlSysProptyDao.modifyAdministrator", map);
	}

	@Override
	public Integer modifyBasicInfo(HashMap<String, String> map) throws Exception {
		return getSqlSession().update("mySqlSysProptyDao.modifyBasicInfo", map);
	}

	@Override
	public Integer modifyDataUploadRootPath(String rootPath) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("dataUploadRootpath", rootPath);
		return getSqlSession().update("mySqlSysProptyDao.modifyDataUploadRootpath", map);
	}

	
}
