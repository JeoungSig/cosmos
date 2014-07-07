/**
 * 2013 MoneyCollectRptMapDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.report.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.photome.dto.BoothGroupDto;
import com.photome.dto.MoneyCollectRptDto;

public interface MoneyCollectRptMapDao {

	/**
	 * 실제 수금된 정보를 맵구조로 구성하여 반환한다.<br>
	 * KEY : 'BOOTH_ID | MONTH'<br>
	 * VALUE : 'BoothDto.collectRealIncome'
	 * 
	 * @param boothDto 필터링할 브스에대한 값
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getCollectRealIncomeMap(HashMap<String, String> param) throws Exception;

	public Map<String, String> getCollectRealIncomeMapByGroup(HashMap<String, String> param) throws Exception;

	/**
	 * 환불 금액 정보를 맵구조로 구성하여 반환한다.<br>
	 * KEY : 'BOOTH_ID | MONTH'<br>
	 * VALUE : 'RefundDto.refundAmount'
	 * 
	 * @param param
	 * @return
	 * @throws ExceptionByGroup
	 */
	public Map<String, String> getRefundMap(HashMap<String, String> param) throws Exception;

	public Map<String, String> getRefundMapByGroup(HashMap<String, String> param) throws Exception;
	
	public MoneyCollectRptDto getGroupRentFee(String groupId, String collectYear) throws Exception;

	/**
	 * 환불 횟수 정보를 맵구조로 구성하여 반환한다.<br>
	 * KEY : 'BOOTH_ID | MONTH'<br>
	 * VALUE : '환불된 횟수'
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, String> getRefundCntMap(HashMap<String, String> param) throws Exception;

	public Map<String, String> getRefundCntMapByGroup(HashMap<String, String> param) throws Exception;

	/**
	 * 주어진 Booth 아이디에대한 월별 렌트비용 정보를 맵구조로 구성하여 반환한다.<br>
	 * 주의 : 해당 브스가 고정된 금액 또는 % 형태로 구분하여 레트 비용이 설정되어야한다.<br>
	 * 고정된 금액인경우 설정된 금액을 렌트비용으로 설정하면 되지만, %인경우 해당 수금된 금액의 BoothRentFeeDto.rentPercent로 계산하여<br>
	 * 금액을 계산하여 설정해줘야 한다.<br>
	 * <br>
	 * KEY : 'BOOTH_ID | MONTH'<br>
	 * VALUE : 'BoothRentFeeDto.rentAmount 또는 퍼센트인경우 수금된 금액의 BoothRentFeeDto.rentPercent'
	 * 
	 * @param boothId
	 * @param rentFeeType
	 * @param year
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getBoothRentFeeAmountMap(String boothId, String rentFeeType, String year) throws Exception;

	/**
	 * 그룹단위로 계약된 레트비용 정보를 맵 구조로 구성하여 반환한다.<br>
	 * <br>
	 * KEY : 'GROUP_ID | MONTH'<br>
	 * VALUE : 'BoothRentFeeDto.rentAmount 또는 퍼센트인경우 수금된 금액의 BoothRentFeeDto.rentPercent'
	 * 
	 * @param groupList
	 * @param collectYear
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getBoothRentFeeMapByGroup(List<BoothGroupDto> groupList, String collectYear) throws Exception;
}
