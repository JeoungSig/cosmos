/**
 * 2013 MySqlAttachFileDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.common.dao.mysql;

import java.util.HashMap;

import org.apache.commons.lang.StringUtils;

import com.cosmos.common.AttachFileDto;
import com.cosmos.common.dao.AttachFileDao;
import com.cosmos.framework.CosmosContext;
import com.cosmos.framework.core.CosmosBaseDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlAttachFileDao extends CosmosBaseDao implements AttachFileDao {

	@Override
	public AttachFileDto getFileInfo(String fileId) throws Exception {
		return getSqlSession().selectOne("mySqlAttachFileDao.getFileInfo", fileId);
	}

	@Override
	public Integer deleteFileInfo(String fileId) throws Exception {
		return getSqlSession().delete("mySqlAttachFileDao.deleteFileInfo", fileId);
	}

	@Override
	public Integer updateFileInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().delete("mySqlAttachFileDao.updateFileInfo", param);
	}

	@Override
	public Integer insertFileInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlAttachFileDao.insertFileInfo", param);
	}

	@Override
	public String getNewFileId() throws Exception {
		return getSqlSession().selectOne("mySqlAttachFileDao.getNewFileId");
	}

	@Override
	public String getRootPath(String infoType) throws Exception {
		// return getSqlSession().selectOne("mySqlAttachFileDao.getRootPath", infoType);
		return CosmosContext.SYSTEM_PROPERTY.getDataUploadRootpath();
	}

}
