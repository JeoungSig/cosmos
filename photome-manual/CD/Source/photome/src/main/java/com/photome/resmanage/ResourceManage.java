/**
 * 2013 ResourceManage.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage;

import java.util.HashMap;
import java.util.List;

import com.photome.dto.BankAcctInfoDto;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface ResourceManage {

	/**
	 * 리소스관리 메인 페이지를 구성한다.<br>
	 * 메인 페이지를 구성하기위한 다음과 같은 두가지 HashMap을 구성하여 반환한다.<br>
	 * 1. 그룹정보 : key-그룹키, value-그룹DTO<br>
	 * 2. 그룹별 부스정보 : key-그룹키, List<BoothDto>
	 * 
	 * @param groupName
	 * @param useYn
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, Object> resourceMainPage(String groupName, String useYn) throws Exception;

	/**
	 * 부스그룹 정보 삭제
	 * 
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	public Integer deleteBoothGroupInfo(String groupId) throws Exception;

	/**
	 * 부스정보 삭제
	 * 
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	public Integer deleteBoothInfo(String boothId) throws Exception;

	/**
	 * 부스그룹 정보 조회
	 * 
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	public BoothGroupDto getBoothGroupInfo(String groupId) throws Exception;

	/**
	 * 검색조건에 해당하는 부스그룹 정보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<BoothGroupDto> getBoothGroupInfoList(HashMap<String, String> param) throws Exception;

	/**
	 * 부스정보 조회
	 * 
	 * @param boothId
	 * @return
	 * @throws Exception
	 */
	public BoothDto getBoothInfo(String boothId) throws Exception;

	/**
	 * 검색조건에 해당하는 부스정보 목록 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<BoothDto> getBoothInfoList(HashMap<String, String> param) throws Exception;

	/**
	 * 부스그룹 정보 추가
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer insertBoothGroupInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 부스정보 추가
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer insertBoothInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 부스그룹 정보 수정
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer updateBoothGroupInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 부스정보 수정
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer updateBoothInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 포토 Booth 현재 상태를 수정한다.
	 * 
	 * @param boothId
	 * @param status
	 * @return
	 * @throws Exception
	 */
	public Integer modifyBoothStatus(String boothId, String status) throws Exception;

	/**
	 * 은행계좌 상세정보를 얻어온다.
	 * 
	 * @param acctId
	 * @return
	 * @throws Exception
	 */
	public BankAcctInfoDto getBankAcctInfo(String acctId) throws Exception;

	/**
	 * 은행계좌 목록을 얻어온다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<BankAcctInfoDto> getBankAcctList(HashMap<String, String> param) throws Exception;

	/**
	 * 은행계좌 정보를 수정한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer modifyBankAcctInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 은행계좌정보를 등록한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer registBankAcctInfo(HashMap<String, String> param) throws Exception;

	/**
	 * 은행계좌 정보를 삭제한다.
	 * 
	 * @param acctId
	 * @return
	 * @throws Exception
	 */
	public Integer deleteBankAcctInfo(String acctId) throws Exception;

	/**
	 * 부스의 사용여부 상태를 설정한다.
	 * 
	 * @param boothId
	 * @param useYn
	 * @return
	 * @throws Exception
	 */
	public Integer setBoothUseYN(String boothId, String useYn) throws Exception;

	/**
	 * 그룹의 사용여부 상태를 설정한다.
	 * 
	 * @param groupId
	 * @param useYn
	 * @return
	 * @throws Exception
	 */
	public Integer setGroupUseYN(String groupId, String useYn) throws Exception;

	/**
	 * 계정의 사용여부 상태를 설정한다.
	 * 
	 * @param acctId
	 * @param useYn
	 * @return
	 * @throws Exception
	 */
	public Integer setBankAcctYN(String acctId, String useYn) throws Exception;

	/**
	 * 해당 그룹에대한 Booth목록을 콤보 박스구성을 위한 Option Html코드를 반환한다.
	 * 
	 * @param groupId
	 * @param defaultSelectedValue
	 * @return
	 * @throws Exception
	 */
	public String getBoothOptionsForHTML(String groupId, String defaultSelectedValue) throws Exception;

	/**
	 * 그룹 목록을 콤보 박스구성을 위한 Option Html코드형태로 얻는다.
	 * 
	 * @param selectedValue
	 * @return
	 * @throws Exception
	 */
	public String getGroupComboOptions(String selectedValue) throws Exception;

	/**
	 * 테크니션이 담당하고 있는 그룹 목록을 콤보 박스구성을 위한 Option Html코드형태로 얻는다.
	 * 
	 * @param technician
	 * @param selectedValue
	 * @return
	 * @throws Exception
	 */
	public String getGroupComboOptions(String technician, String selectedValue) throws Exception;

	/**
	 * 부스를 관리하는 테크니션 목록을 콤보박스 형태로 얻는다.
	 * 
	 * @param selectedTechnician 선택되어질 테크니션의 사용자 아이디
	 * @return
	 * @throws Exception
	 */
	public String getTechnicianOptionsForHTML(String selectedTechnician) throws Exception;

}
