/**
 * 2013 MoneyDepositDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.money.dao;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.user.UserDto;
import com.photome.dto.MoneyCollectDto;
import com.photome.dto.MoneyDepositDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface MoneyDepositDao {

	/**
	 * 은행에 입금해야할 대상이되는 수금정보 목록을 얻어온다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<MoneyCollectDto> getMoneyCollectListForDeposit(HashMap<String, String> param) throws Exception;

	/**
	 * 은행에 입금된 수금정보 목록을 얻어온다.
	 * 
	 * @param depositId 입금정보 ID
	 * @return
	 * @throws Exception
	 */
	public List<MoneyCollectDto> getMoneyCollectListForDeposit(String depositId) throws Exception;

	/**
	 * 입금정보를 작성한 사용자 목록을 얻어온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<UserDto> getCreatorList() throws Exception;

	/**
	 * 해당 입금정보에 해당하는 수금건수가 몇개인지 카운트한다.
	 * 
	 * @param depositId
	 * @return
	 * @throws Exception
	 */
	public Integer getDepositedMoneyCollectCnt(String depositId) throws Exception;

	/**
	 * 수금정보 테이블에 수금된 정보를 표시(입금아이디 설정)한다.
	 * 
	 * @param collectId
	 * @param depositId
	 * @return
	 * @throws Exception
	 */
	public Integer markDepositIdToCollectInfo(String collectId, String depositId) throws Exception;

	/**
	 * 수금정보 테이블에 수금된 정보를 표시(입금아이디 설정)를 해제한다.
	 * 
	 * @param depositId
	 * @return
	 * @throws Exception
	 */
	public Integer unmarkDepositIdToCollectInfo(String depositId) throws Exception;

	/**
	 * 은행에 입금하는 경우 각 부스에대한 입금 금액과 입금 날짜를 수금정보 테이블에 저장한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer updateMoneyCollectInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 은행에 입금한 내역 정보 목록을 입금정보 테이블로부터 얻어온다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<MoneyDepositDto> getBankDepositList(HashMap<String, String> param) throws Exception;

	/**
	 * 은행에 입금한 내역 정보를 입금정보 테이블로부터 얻어온다.
	 * 
	 * @param depositId
	 * @return
	 * @throws Exception
	 */
	public MoneyDepositDto getBankDepositInfo(String depositId) throws Exception;

	/**
	 * 은행에 입금한 내역 정보를 입금정보 테이블에서 삭제한다.
	 * 
	 * @param depositId
	 * @return
	 * @throws Exception
	 */
	public Integer deleteBankDepositInfo(String depositId) throws Exception;

	/**
	 * 은행에 입금한 정보를 입금정보 테이블에서 등록한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer insertBankDepositInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 새로운 입금정보 아이디를 생성한다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public String getBankDepositNewId() throws Exception;

	/**
	 * 입금정보의 상태를 변경한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer changeBankDepositInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 은행 입금상태를 변경한다.
	 * 
	 * @param depositId
	 * @param status
	 * @return
	 * @throws Exception
	 */
	public Integer changeBankDepositStatus(String depositId, String status) throws Exception;

	/**
	 * 수금정보의 뱅킹정보를 삭제한다.
	 * 
	 * @param depositId
	 * @return
	 * @throws Exception
	 */
	public Integer deleteBankingInfoByDepositId(String depositId) throws Exception;

}
