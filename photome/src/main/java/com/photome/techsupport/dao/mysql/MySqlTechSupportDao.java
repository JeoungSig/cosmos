/**
 * 2013 MySqlTechSupportDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.techsupport.dao.mysql;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.core.CosmosBaseDao;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.MaintenanceCommentDto;
import com.photome.dto.MaintenanceHistoryDto;
import com.photome.techsupport.dao.TechSupportDao;

/**
 * @author Steven J.S Min
 * 
 */
public class MySqlTechSupportDao extends CosmosBaseDao implements TechSupportDao {

	@Override
	public Integer deleteHistoryComment(String commentId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("commentId", commentId);
		return getSqlSession().delete("mySqlTechSupportDao.deleteHistoryComment", param);
	}

	@Override
	public MaintenanceCommentDto getHistoryCommentInfo(String commentId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("commentId", commentId);
		return getSqlSession().selectOne("mySqlTechSupportDao.getHistoryCommentInfo", param);
	}

	@Override
	public List<MaintenanceCommentDto> getHistoryCommentList(String historyId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("historyId", historyId);
		return getSqlSession().selectList("mySqlTechSupportDao.getHistoryCommentList", param);
	}

	@Override
	public MaintenanceHistoryDto getMaintenanceHistoryInfo(String historyId) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("historyId", historyId);
		return getSqlSession().selectOne("mySqlTechSupportDao.getMaintenanceHistoryInfo", param);
	}

	@Override
	public List<MaintenanceHistoryDto> getMaintenanceHistoryList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlTechSupportDao.getMaintenanceHistoryList", param);
	}

	@Override
	public String getNewHistoryCommentId() throws Exception {
		String retVal = null;
		Integer newId = getSqlSession().selectOne("mySqlTechSupportDao.getNewHistoryCommentId");
		if (newId != null) {
			retVal = Integer.toString(newId);
		} else {
			retVal = null;
		}

		return retVal;
	}

	@Override
	public String getNewMaintenanceHistoryId() throws Exception {
		String retVal = null;
		Integer newId = getSqlSession().selectOne("mySqlTechSupportDao.getNewMaintenanceHistoryId");
		if (newId != null) {
			retVal = Integer.toString(newId);
		} else {
			retVal = null;
		}

		return retVal;
	}

	@Override
	public List<UserDto> getTechnicianList(HashMap<String, String> param) throws Exception {
		return getSqlSession().selectList("mySqlTechSupportDao.getTechnicianList", param);
	}

	@Override
	public Integer insertHistoryComment(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlTechSupportDao.insertHistoryComment", param);
	}

	@Override
	public Integer insertMaintenanceHistory(HashMap<String, String> param) throws Exception {
		return getSqlSession().insert("mySqlTechSupportDao.insertMaintenanceHistory", param);
	}

	@Override
	public Integer updateHistoryComment(HashMap<String, String> param) throws Exception {
		return getSqlSession().update("mySqlTechSupportDao.updateHistoryComment", param);
	}

	@Override
	public Integer updateMaintenanceHistory(HashMap<String, String> param) throws Exception {
		return getSqlSession().update("mySqlTechSupportDao.updateMaintenanceHistory", param);
	}

}
