/**
 * 2013 CommonDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.common.dao;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.common.PostAddrDto;

/**
 * Framwork Common data access interface.
 * 
 * @author Steven J.S Min
 * 
 */
public interface CommonDao {

	/**
	 * 우편번호에 해당하는 주소정보를 얻는다.
	 * 
	 * @param zipCd
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, Object> getPostAddress(String zipCd) throws Exception;

	/**
	 * 모든 주목록을 얻어온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<String> getStateList() throws Exception;

	/**
	 * 검색조건에 맞는 주소 목록을 얻는다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<PostAddrDto> getAddressList(HashMap<String, String> param) throws Exception;

}