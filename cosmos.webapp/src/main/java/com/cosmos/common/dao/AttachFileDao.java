/**
 * 2013 AttachFileDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.common.dao;

import java.util.HashMap;

import com.cosmos.common.AttachFileDto;

/**
 * Framwork attached file access interface.
 * 
 * @author Steven J.S Min
 * 
 */
public interface AttachFileDao {

	/**
	 * 첨부파일의 상세 정보를 얻는다.
	 * 
	 * @param fileId
	 * @return
	 * @throws Exception
	 */
	public AttachFileDto getFileInfo(String fileId) throws Exception;

	/**
	 * 정보타입에따른 저장소 최상위 위치를 얻는다.
	 * 
	 * @param infoType
	 * @return
	 * @throws Exception
	 */
	public String getRootPath(String infoType) throws Exception;

	/**
	 * 첨부파일의 새 아이디를 얻는다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public String getNewFileId() throws Exception;

	/**
	 * 첨부파일 정보를 삭제한다.
	 * 
	 * @param fileId
	 * @return
	 * @throws Exception
	 */
	public Integer deleteFileInfo(String fileId) throws Exception;

	/**
	 * 첨부파일 정보를 등록한다.<br>
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer insertFileInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 첨부파일의 정보를 수정한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer updateFileInfo(HashMap<String, String> param) throws Exception;

}