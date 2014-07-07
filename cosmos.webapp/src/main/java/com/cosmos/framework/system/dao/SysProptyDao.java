/**
 * 2013 SysProptyDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.system.dao;

import java.util.HashMap;

/**
 * Framwork System Property access interface.
 * 
 * @author Steven J.S Min
 * 
 */
public interface SysProptyDao {

	/**
	 * 시스템 기본 설정 정보를 조회한다.
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, String> getSysPropertyInfo() throws Exception;

	/**
	 * 시스템 기본 설정 정보를 조회한다.<br>
	 * 기본 기능은 HashMap<String, String> getSysPropertyInfo() 와 같지만 리턴값을 각 해당하는 DTO로 변환하여 HashMap에 담아 리턴한다.<br>
	 * 리턴 키 값에따른 반환 OBJECT :<br>
	 * ---------------------------------<br>
	 * key | DTO<br>
	 * ---------------------------------<br>
	 * 'propertyDto' | 시스템 기본정보<br>
	 * 'userDto' | 관리자 기본정보<br>
	 * 'fileDto' | 시스템 로그파일에대한 정보<br>
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, Object> getSysPropertyInfo2() throws Exception;

	/**
	 * 시스템 관리자 정보를 수정한다.
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Integer modifyAdministrator(String userId) throws Exception;

	/**
	 * 시스템 관리자 정보를 수정한다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer modifyBasicInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 접근권한 체크에대한 예외 서비스 URL정보를 수정한다.
	 * 
	 * @param acessChkExceptUrl
	 * @return
	 * @throws Exception
	 */
	public Integer accessCheckExceptUrlModify(String acessChkExceptUrl) throws Exception;

	/**
	 * 시스템의 데이터 업로드 최상위 Path를 설정한다.
	 * 
	 * @param rootPath
	 * @return
	 * @throws Exception
	 */
	public Integer modifyDataUploadRootPath(String rootPath) throws Exception;

}