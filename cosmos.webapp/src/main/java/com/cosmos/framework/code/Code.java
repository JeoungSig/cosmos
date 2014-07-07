/**
 * 2013 CodeDao.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.code;

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
public interface Code {

	/**
	 * 특정 코드 정보를 얻는다.<br>
	 * 
	 * @param systemCd
	 * @param categoryCd
	 * @param codeValue
	 * @return
	 * @throws Exception
	 */
	public CodeDto getCodeInfo(String systemCd, String categoryCd, String codeValue) throws Exception;

	/**
	 * 시스템코드와 카테고리코드에 관련된 코드 정보를 얻는다.
	 * 
	 * @param systemCd
	 * @param categoryCd
	 * @return
	 * @throws Exception
	 */
	public List<CodeDto> getCodeList(String systemCd, String categoryCd) throws Exception;

	/**
	 * 코드 목록을 얻어온다.<br>
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<CodeDto> getCodeList(HashMap<String, String> param) throws Exception;

	/**
	 * 코드 정보가 존재하는지 확인한다. CodeDto에 다음의 값을 반드시 설정해야한다.
	 * <ul>
	 * <li>systemCd : 시스템 구분</li>
	 * <li>categoryCd : 업무 구분</li>
	 * <li>codeValue : 코드 값</li>
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public boolean existCode(String systemCd, String categoryCd, String codeValue) throws Exception;

	/**
	 * 코드정보를 삭제한다.
	 * 
	 * @param systemCd
	 * @param categoryCd
	 * @param codeValue
	 * @return
	 * @throws Exception
	 */
	public Integer deleteCodeInfo(String systemCd, String categoryCd, String codeValue) throws Exception;

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
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer insertCodeInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 코드정보를 수정한다.
	 * 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Integer modifyCodeInfo(HashMap<String, String> map) throws Exception;

	/**
	 * 시스템 코드를 콤보박스를 구성하기위하여 Html option 엘리먼트를 HTML코드로 구성하여 반환한다.
	 * 
	 * @param systemCd 시스템코드
	 * @param categoryCd 카테고리코드
	 * @return
	 * @throws Exception
	 */

	public String getOptionsForHTML(String systemCd, String categoryCd) throws Exception;

	/**
	 * 시스템 코드를 콤보박스를 구성하기위하여 Html option 엘리먼트를 HTML코드로 구성하여 반환한다.
	 * 
	 * @param systemCd 시스템코드
	 * @param categoryCd 카테고리코드
	 * @param defaultSelectedValue 기본적으로 선택되어질 값
	 * @return
	 * @throws Exception
	 */
	public String getOptionsForHTML(String systemCd, String categoryCd, String defaultSelectedValue) throws Exception;

	/**
	 * 시스템 코드를 콤보박스를 구성하기위하여 Html option 엘리먼트를 HTML코드로 구성하여 반환한다.
	 * 
	 * @param defaultSelectedValue 기본적으로 선택되어질 값
	 * @return
	 * @throws Exception
	 */
	public String getSystemComboOptionsForHTML(String defaultSelectedValue) throws Exception;

	/**
	 * 카테고리 코드를 콤보박스를 구성하기위하여 Html option 엘리먼트를 HTML코드로 구성하여 반환한다.
	 * 
	 * @param systemCd
	 * @param defaultSelectedValue 기본적으로 선택되어질 값
	 * @return
	 * @throws Exception
	 */
	public String getCategoryComboOptionsForHTML(String systemCd, String defaultSelectedValue) throws Exception;
}
