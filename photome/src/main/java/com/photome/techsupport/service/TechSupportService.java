/**
 * 2013 TechSupportService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.techsupport.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.code.dao.CodeDao;
import com.cosmos.framework.common.dao.CommonDao;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.MaintenanceCommentDto;
import com.photome.dto.MaintenanceHistoryDto;
import com.photome.resmanage.ResourceManage;
import com.photome.techsupport.TechSupport;
import com.photome.techsupport.dao.TechSupportDao;

/**
 * @author Steven J.S Min
 * 
 */
public class TechSupportService implements TechSupport {

	@Resource(name = "techSupportDao")
	private TechSupportDao techSupportDao;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "codeDao")
	private CodeDao codeDao;

	@Resource(name = "commonDao")
	private CommonDao commonDao;

	@Override
	public Integer deleteHistoryComment(String commentId) throws Exception {
		if (StringUtils.isBlank(commentId)) throw new Exception("Can not be empty COMMENT_ID");

		return techSupportDao.deleteHistoryComment(commentId);
	}

	@Override
	public MaintenanceCommentDto getHistoryCommentInfo(String commentId) throws Exception {
		return techSupportDao.getHistoryCommentInfo(commentId);
	}

	@Override
	public List<MaintenanceCommentDto> getHistoryCommentList(String historyId) throws Exception {
		return techSupportDao.getHistoryCommentList(historyId);
	}

	@Override
	public MaintenanceHistoryDto getMaintenanceHistoryInfo(String historyId) throws Exception {
		return techSupportDao.getMaintenanceHistoryInfo(historyId);
	}

	@Override
	public List<MaintenanceHistoryDto> getMaintenanceHistoryList(HashMap<String, String> param) throws Exception {
		return techSupportDao.getMaintenanceHistoryList(param);
	}

	@Override
	public String getNewHistoryCommentId() throws Exception {
		return techSupportDao.getNewHistoryCommentId();
	}

	@Override
	public List<UserDto> getTechnicianList(HashMap<String, String> param) throws Exception {
		return techSupportDao.getTechnicianList(param);
	}

	@Override
	public Integer insertHistoryComment(HashMap<String, String> param) throws Exception {
		String commentId = techSupportDao.getNewHistoryCommentId();
		param.put("commentId", commentId);

		return techSupportDao.insertHistoryComment(param);
	}

	@Override
	public Integer insertMaintenanceHistory(HashMap<String, String> param) throws Exception {
		String historyId = techSupportDao.getNewMaintenanceHistoryId();
		param.put("historyId", historyId);

		String claimType = (String) param.get("claimType");

		// 고장신고인 경우 포토부스의 고장 상태를 설정한다.
		if (StringUtils.endsWith(claimType, "RPT_BROKEN")) {
			String boothId = (String) param.get("boothId");
			String boothStatus = (String) param.get("boothStatus");
			resManage.modifyBoothStatus(boothId, boothStatus);
		}

		return techSupportDao.insertMaintenanceHistory(param);
	}

	@Override
	public Integer updateHistoryComment(HashMap<String, String> param) throws Exception {
		String commentId = (String) param.get("commentId");
		if (StringUtils.isBlank(commentId)) throw new Exception("Can not be empty COMMENT_ID");

		return techSupportDao.updateHistoryComment(param);
	}

	@Override
	public Integer updateMaintenanceHistory(HashMap<String, String> param) throws Exception {
		String historyId = param.get("historyId");
		if (StringUtils.isBlank(historyId)) throw new Exception("Can not be empty historyId for modify");
		return techSupportDao.updateMaintenanceHistory(param);
	}

}
