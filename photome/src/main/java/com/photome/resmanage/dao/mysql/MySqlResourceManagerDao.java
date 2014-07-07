/**
 * 2013 MySqlResourceManagerDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage.dao.mysql;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.core.CosmosBaseDao;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BankAcctInfoDto;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.resmanage.dao.ResourceManageDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlResourceManagerDao extends CosmosBaseDao implements ResourceManageDao {

	@Override
	public Integer deleteBoothGroupInfo(String groupId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);

		return getSqlSession().delete("mySqlResourceManagerDao.deleteBoothGroupInfo", param);
	}

	@Override
	public Integer deleteBoothInfo(String boothId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("boothId", boothId);
		return getSqlSession().update("mySqlResourceManagerDao.deleteBoothInfo", param);
	}

	@Override
	public BoothGroupDto getBoothGroupInfo(String groupId) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);

		BoothGroupDto goothGroupDto = getSqlSession().selectOne("mySqlResourceManagerDao.getBoothGroupInfo", param);
		return goothGroupDto;
	}

	@Override
	public List<BoothGroupDto> getBoothGroupInfoList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlResourceManagerDao.getBoothGroupInfoList", param);
	}

	@Override
	public BoothDto getBoothInfo(String boothId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("boothId", boothId);

		BoothDto boothDto = getSqlSession().selectOne("mySqlResourceManagerDao.getBoothInfo", param);

		// 렌트피가 Fixed Money이면 금액이, Percent이면 퍼센테이지 값이 현재의 년,월을 기준으로 반환된다.
		param.put("rentFeeType", boothDto.getRentFeeType());
		String rentAmount = getSqlSession().selectOne("mySqlBoothRentFeeDao.getCurrBoothRentFee", param);
		if (StringUtils.isBlank(rentAmount)) rentAmount = "0";
		boothDto.setRentAmount(rentAmount);

		return boothDto;
	}

	@Override
	public List<BoothDto> getBoothInfoList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlResourceManagerDao.getBoothInfoList", param);
	}

	@Override
	public List<BoothDto> getBoothInfoListByGroupId(String groupId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		return getSqlSession().selectList("mySqlResourceManagerDao.getBoothInfoListByGroupId", param);
	}

	@Override
	public Integer getNewBoothGroupId() throws Exception {
		return getSqlSession().selectOne("mySqlResourceManagerDao.getNewBoothGroupId");
	}

	@Override
	public Integer getNewBoothId() throws Exception {
		return getSqlSession().selectOne("mySqlResourceManagerDao.getNewBoothId");
	}

	@Override
	public Integer insertBoothGroupInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlResourceManagerDao.insertBoothGroupInfo", param);
	}

	@Override
	public Integer insertBoothInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlResourceManagerDao.insertBoothInfo", param);
	}

	@Override
	public Integer updateBoothGroupInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().update("mySqlResourceManagerDao.updateBoothGroupInfo", param);
	}

	@Override
	public Integer updateBoothInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().update("mySqlResourceManagerDao.updateBoothInfo", param);
	}

	@Override
	public Integer modifyBoothStatus(String boothId, String status) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("boothId", boothId);
		param.put("status", status);

		return getSqlSession().update("mySqlResourceManagerDao.updateBoothStatus", param);
	}

	@Override
	public BankAcctInfoDto getBankAcctInfo(String acctId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("acctId", acctId);
		return getSqlSession().selectOne("mySqlResourceManagerDao.getBankAcctInfo", param);
	}

	@Override
	public List<BankAcctInfoDto> getBankAcctList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlResourceManagerDao.getBankAcctList", param);
	}

	@Override
	public Integer modifyBankAcctInfo(HashMap<String, String> param) throws Exception {
		String acctId = param.get("acctId");
		if (StringUtils.isBlank(acctId)) throw new Exception("Can not be empty Account ID");
		return getSqlSession().update("mySqlResourceManagerDao.modifyBankAcctInfo", param);
	}

	@Override
	public Integer registBankAcctInfo(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlResourceManagerDao.registBankAcctInfo", param);
	}

	@Override
	public Integer deleteBankAcctInfo(String acctId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		if (StringUtils.isBlank(acctId)) throw new Exception("Can not be empty Account ID");
		param.put("acctId", acctId);
		return getSqlSession().delete("mySqlResourceManagerDao.deleteBankAcctInfo", param);
	}

	@Override
	public Integer getNewBankAcctId() throws Exception {
		return getSqlSession().selectOne("mySqlResourceManagerDao.getNewBankAcctId");
	}

	@Override
	public Integer setBoothUseYN(String boothId, String useYn) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		if (StringUtils.isBlank(boothId) || StringUtils.isBlank(useYn)) throw new Exception("Can not be empty :  BOOTH_ID, USE_YN");
		param.put("boothId", boothId);
		param.put("useYn", useYn);
		return getSqlSession().update("mySqlResourceManagerDao.setBoothUseYN", param);
	}

	@Override
	public Integer setGroupUseYN(String groupId, String useYn) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		if (StringUtils.isBlank(groupId) || StringUtils.isBlank(useYn)) throw new Exception("Can not be empty :  GROUP_ID, USE_YN");
		param.put("groupId", groupId);
		param.put("useYn", useYn);
		return getSqlSession().update("mySqlResourceManagerDao.setGroupUseYN", param);
	}

	@Override
	public Integer setBankAcctYN(String acctId, String useYn) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		if (StringUtils.isBlank(acctId) || StringUtils.isBlank(useYn)) throw new Exception("Can not be empty :  ACCT_ID, USE_YN");
		param.put("acctId", acctId);
		param.put("useYn", useYn);
		return getSqlSession().update("mySqlResourceManagerDao.setBankAcctYN", param);
	}

	@Override
	public List<UserDto> getTechnicianList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlResourceManagerDao.getTechnicianList", param);
	}

}
