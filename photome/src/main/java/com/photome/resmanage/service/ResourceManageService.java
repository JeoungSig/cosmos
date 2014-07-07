/**
 * 2013 ResourceManageService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.code.dao.CodeDao;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BankAcctInfoDto;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.resmanage.ResourceManage;
import com.photome.resmanage.dao.BoothRentFeeDao;
import com.photome.resmanage.dao.ResourceManageDao;

/**
 * @author Steven J.S Min
 * 
 */
public class ResourceManageService implements ResourceManage {

	@Resource(name = "resManageDao")
	private ResourceManageDao resManageDao;

	@Resource(name = "boothRentFeeDao")
	private BoothRentFeeDao boothRentFeeDao;

	@Resource(name = "codeDao")
	private CodeDao codeDao;

	@Override
	public HashMap<String, Object> resourceMainPage(String groupName, String useYn) throws Exception {

		HashMap<String, BoothGroupDto> groupMap = null;
		HashMap<String, List<BoothDto>> groupBoothMap = null;

		String groupId = null;
		HashMap<String, String> map = new HashMap<String, String>();
		if (StringUtils.isNotBlank(groupName)) {
			map.put("groupName", groupName);
		}
		map.put("useYn", useYn);

		List<BoothGroupDto> groupList = resManageDao.getBoothGroupInfoList(map);
		List<BoothDto> boothList = null;

		if (groupList.size() > 0) groupMap = new HashMap<String, BoothGroupDto>();
		if (groupList.size() > 0) groupBoothMap = new HashMap<String, List<BoothDto>>();
		for (BoothGroupDto dto : groupList) {
			groupId = dto.getGroupId();
			groupMap.put(groupId, dto);

			boothList = resManageDao.getBoothInfoListByGroupId(groupId);
			groupBoothMap.put(groupId, boothList);
		}
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("groupMap", groupMap);
		returnMap.put("groupBoothMap", groupBoothMap);

		return returnMap;
	}

	@Override
	public Integer deleteBoothGroupInfo(String groupId) throws Exception {
		return resManageDao.deleteBoothGroupInfo(groupId);
	}

	@Override
	public Integer deleteBoothInfo(String boothId) throws Exception {
		return resManageDao.deleteBoothInfo(boothId);
	}

	@Override
	public BoothGroupDto getBoothGroupInfo(String groupId) throws Exception {
		return resManageDao.getBoothGroupInfo(groupId);
	}

	@Override
	public List<BoothGroupDto> getBoothGroupInfoList(HashMap<String, String> param) throws Exception {
		return resManageDao.getBoothGroupInfoList(param);
	}

	@Override
	public BoothDto getBoothInfo(String boothId) throws Exception {
		return resManageDao.getBoothInfo(boothId);
	}

	@Override
	public List<BoothDto> getBoothInfoList(HashMap<String, String> param) throws Exception {
		return resManageDao.getBoothInfoList(param);
	}

	@Override
	public Integer insertBoothGroupInfo(HashMap<String, String> param) throws Exception {
		Integer id = resManageDao.getNewBoothGroupId();
		param.put("groupId", Integer.toString(id));
		return resManageDao.insertBoothGroupInfo(param);
	}

	@Override
	public Integer insertBoothInfo(HashMap<String, String> param) throws Exception {
		Integer id = resManageDao.getNewBoothId();
		param.put("boothId", Integer.toString(id));
		return resManageDao.insertBoothInfo(param);
	}

	@Override
	public Integer updateBoothGroupInfo(HashMap<String, String> param) throws Exception {
		return resManageDao.updateBoothGroupInfo(param);
	}

	@Override
	public Integer updateBoothInfo(HashMap<String, String> param) throws Exception {
		return resManageDao.updateBoothInfo(param);
	}

	@Override
	public Integer modifyBoothStatus(String boothId, String status) throws Exception {
		return resManageDao.modifyBoothStatus(boothId, status);
	}

	@Override
	public BankAcctInfoDto getBankAcctInfo(String acctId) throws Exception {
		return resManageDao.getBankAcctInfo(acctId);
	}

	@Override
	public List<BankAcctInfoDto> getBankAcctList(HashMap<String, String> param) throws Exception {
		return resManageDao.getBankAcctList(param);
	}

	@Override
	public Integer modifyBankAcctInfo(HashMap<String, String> param) throws Exception {
		return resManageDao.modifyBankAcctInfo(param);
	}

	@Override
	public Integer registBankAcctInfo(HashMap<String, String> param) throws Exception {
		Integer acctId = resManageDao.getNewBankAcctId();
		param.put("acctId", Integer.toString(acctId));
		return resManageDao.registBankAcctInfo(param);
	}

	@Override
	public Integer deleteBankAcctInfo(String acctId) throws Exception {
		return resManageDao.deleteBankAcctInfo(acctId);
	}

	@Override
	public String getBoothOptionsForHTML(String groupId, String defaultSelectedValue) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("groupId", groupId);
		List<BoothDto> boothList = this.getBoothInfoList(param);
		StringBuffer boothOptions = new StringBuffer("<option></option>");
		for (BoothDto boothDto : boothList) {
			boothOptions.append("<option value=\"" + boothDto.getBoothId() + "\"" + (StringUtils.equals(boothDto.getBoothId(), defaultSelectedValue) ? " selected " : "") + ">"
					+ boothDto.getBoothName() + "</option>");
		}

		return boothOptions.toString();
	}

	@Override
	public Integer setBoothUseYN(String boothId, String useYn) throws Exception {
		return resManageDao.setBoothUseYN(boothId, useYn);
	}

	@Override
	public Integer setGroupUseYN(String groupId, String useYn) throws Exception {
		return resManageDao.setGroupUseYN(groupId, useYn);
	}

	@Override
	public Integer setBankAcctYN(String acctId, String useYn) throws Exception {
		return resManageDao.setBankAcctYN(acctId, useYn);
	}

	@Override
	public String getGroupComboOptions(String selectedValue) throws Exception {
		StringBuffer groupOptions = new StringBuffer("<option></option>");
		List<BoothGroupDto> groupList = this.getBoothGroupInfoList(new HashMap<String, String>());
		for (BoothGroupDto dto : groupList) {
			groupOptions.append("<option value=\"" + dto.getGroupId() + "\"" + (StringUtils.equals(dto.getGroupId(), selectedValue) ? " selected " : "") + " >" + dto.getGroupName() + "</option>");
		}
		return groupOptions.toString();
	}

	@Override
	public String getGroupComboOptions(String technician, String selectedValue) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("technician", technician);

		StringBuffer groupOptions = new StringBuffer("<option></option>");
		List<BoothGroupDto> groupList = this.getBoothGroupInfoList(param);
		for (BoothGroupDto dto : groupList) {
			groupOptions.append("<option value=\"" + dto.getGroupId() + "\"" + (StringUtils.equals(dto.getGroupId(), selectedValue) ? " selected " : "") + " >" + dto.getGroupName() + "</option>");
		}
		return groupOptions.toString();
	}

	@Override
	public String getTechnicianOptionsForHTML(String selectedTechnician) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		if (!StringUtils.isBlank(selectedTechnician)) param.put("userId", selectedTechnician);

		StringBuffer technicianOptions = new StringBuffer("<option></option>");
		List<UserDto> groupList = resManageDao.getTechnicianList(param);
		for (UserDto dto : groupList) {
			technicianOptions.append("<option value=\"" + dto.getUserId() + "\"" + (StringUtils.equals(dto.getUserId(), selectedTechnician) ? " selected " : "") + " >" + dto.getFirstName()
					+ "</option>");
		}
		return technicianOptions.toString();
	}

}
