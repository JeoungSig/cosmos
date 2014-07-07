/**
 * 2013 MoneyCollectDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.dao;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.user.UserDto;
import com.photome.dto.MoneyCollectDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface MoneyCollectDao {
	/**
	 * 수금목록을 조회한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<MoneyCollectDto> getMoneyCollectList(HashMap<String, String> param) throws Exception;

	/**
	 * 다음 수금 ID를 얻어온다.<br>
	 * 
	 * @param preCollectId
	 * @return
	 * @throws Exception
	 */
	public String getNextCollectId(String preCollectId) throws Exception;

	/**
	 * 수금상세정보를 얻어온다.
	 * 
	 * @param collectId
	 * @return
	 * @throws Exception
	 */
	public MoneyCollectDto getMoneyCollectInfo(String collectId) throws Exception;

	/**
	 * 수금정보를 등록한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer insertMoneyCollectInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 수금정보를 삭제한다.
	 * 
	 * @param collectId
	 * @return
	 * @throws Exception
	 */
	public Integer deleteMoneyCollectInfo(String collectId) throws Exception;

	/**
	 * 수금정보를 수정한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer updateMoneyCollectInfo(HashMap<String, String> param) throws Exception;

	/**
	 * (수금정보를 등록하기위한) 다음 수금ID를 얻는다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public String getMoneyCollectNewId() throws Exception;

	/**
	 * 현재 부스의 가장 최신의 수금 아이디를 얻는다.
	 * 
	 * @param boothId
	 * @param collectId
	 * @return
	 * @throws Exception
	 */
	public MoneyCollectDto getRecentMoneyCollectInfo(String boothId, String collectId) throws Exception;

	/**
	 * 수금상태를 변경한다.
	 * 
	 * @param collectId 수금아이디
	 * @param status 상태
	 * @param userId 변경자
	 * @return
	 * @throws Exception
	 */
	public Integer modifyCollectStatus(String collectId, String status, String userId) throws Exception;

	/**
	 * 수금후 수금된 금액에대하여 은행입금처리 정보를 업데이트한다.<br>
	 * 은행 입금에 관한 정보들은 반드시 들어와야 한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer modifyBankWork(HashMap<String, String> param) throws Exception;

	/**
	 * 사이트에서 직접 렌트비를 내는경우 지불된 렌트비 정보를 입력한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer payOnsiteRentFee(HashMap<String, String> param) throws Exception;

	/**
	 * 수금자 목록을 얻어온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<UserDto> getMoneyCollectorList() throws Exception;

}
