/**
 * 2013 AttachFileService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.common.service;

import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.common.AttachFile;
import com.cosmos.common.AttachFileDto;
import com.cosmos.common.dao.AttachFileDao;
import com.cosmos.framework.CosmosContext;

/**
 * @author Steven J.S Min
 * 
 */
public class AttachFileService implements AttachFile {

	@Resource(name = "attachFileDao")
	private AttachFileDao attachFileDao;

	@Override
	public AttachFileDto getFileInfo(String fileId) throws Exception {
		return attachFileDao.getFileInfo(fileId);
	}

	@Override
	public String getRootPath(String infoType) throws Exception {
		// return attachFileDao.getRootPath(infoType);
		return CosmosContext.SYSTEM_PROPERTY.getDataUploadRootpath();
	}

	@Override
	public Integer deleteFileInfo(String fileId) throws Exception {
		return attachFileDao.deleteFileInfo(fileId);
	}

	@Override
	public String insertFileInfo(HashMap<String, String> param) throws Exception {

		String newFileId = null;
		Integer updateCnt = 0;

		String paramFileId = param.get("fileId");
		if (StringUtils.isBlank(paramFileId)) {
			newFileId = attachFileDao.getNewFileId();
		} else {
			newFileId = paramFileId;
		}
		param.put("fileId", newFileId);

		updateCnt = attachFileDao.insertFileInfo(param);

		if (updateCnt > 0) {
			return newFileId;
		} else {
			return null;
		}

	}

	@Override
	public Integer updateFileInfo(HashMap<String, String> param) throws Exception {
		return attachFileDao.updateFileInfo(param);
	}

}
