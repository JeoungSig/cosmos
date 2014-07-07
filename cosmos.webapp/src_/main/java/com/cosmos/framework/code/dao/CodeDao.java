/**
 * 2013 CodeDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.code.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.code.CodeDto;

/**
 * Framwork code data access interface.
 * 
 * @author Steven J.S Min
 * 
 */
public interface CodeDao {

	/**
	 * 특정 코드 정보를 얻는다.<br>
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public CodeDto getCodeInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 코드 목록을 얻어온다.<br>
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<CodeDto> getCodeList(HashMap<String, String> param) throws Exception;

	/**
	 * 코드정보를 삭제한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer deleteCodeInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 코드 정보를 삭제한다. CodeDto에 다음의 값을 반드시 설정해야한다.
	 * 
	 * @param keyList
	 * @return
	 * @throws Exception
	 */
	public Integer deleteCodeInfos(ArrayList<Object> keyList) throws Exception;

	/**
	 * 최상단의 시스템 코드 목록을 얻어온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<CodeDto> getSystemCodeList() throws Exception;

	/**
	 * 시스템코드에 해당하는 카테고리 코드를 얻어온다.
	 * 
	 * @param systemCd
	 * @return
	 * @throws Exception
	 */
	public List<CodeDto> getCategoryCodeList(String systemCd) throws Exception;

	/**
	 * 코드정보를 등록한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer insertCodeInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 코드정보를 수정한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer modifyCodeInfo(HashMap<String, String> param) throws Exception;

}
