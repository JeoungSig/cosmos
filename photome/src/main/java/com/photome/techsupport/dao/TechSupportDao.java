/**
 * 2013 TechSupportDao.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.techsupport.dao;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.user.UserDto;
import com.photome.dto.MaintenanceCommentDto;
import com.photome.dto.MaintenanceHistoryDto;

/**
 * @author Steven J.S Min
 * 
 */
public interface TechSupportDao {

	public Integer deleteHistoryComment(String commentId) throws Exception;

	public MaintenanceCommentDto getHistoryCommentInfo(String commentId) throws Exception;

	public List<MaintenanceCommentDto> getHistoryCommentList(String historyId) throws Exception;

	public MaintenanceHistoryDto getMaintenanceHistoryInfo(String historyId) throws Exception;

	public List<MaintenanceHistoryDto> getMaintenanceHistoryList(HashMap<String, String> param) throws Exception;

	public String getNewHistoryCommentId() throws Exception;

	public String getNewMaintenanceHistoryId() throws Exception;

	public List<UserDto> getTechnicianList(HashMap<String, String> param) throws Exception;

	public Integer insertHistoryComment(HashMap<String, String> param) throws Exception;

	public Integer insertMaintenanceHistory(HashMap<String, String> param) throws Exception;

	public Integer updateHistoryComment(HashMap<String, String> param) throws Exception;

	public Integer updateMaintenanceHistory(HashMap<String, String> param) throws Exception;
}
