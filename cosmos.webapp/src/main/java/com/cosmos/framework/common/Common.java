/**
 * 2013 Common.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is prohibited
 * by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.common;

import java.util.HashMap;
import java.util.List;

/**
 * @author Steven J.S Min
 * 
 */
public interface Common {
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
	 * 모든 주를 콤보박스의 Option항목으로 Html코드로 생성하여 반환한다.
	 * 
	 * @param selectedValue
	 * @return
	 * @throws Exception
	 */
	public String getStateComboOptions(String selectedValue) throws Exception;

	/**
	 * 검색조건에 맞는 주소 목록을 얻는다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<PostAddrDto> getAddressList(HashMap<String, String> param) throws Exception;
}
