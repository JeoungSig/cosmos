/**
 * 2013 BoothCommentController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.techsupport;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.common.AttachFile;
import com.cosmos.common.AttachFileDto;
import com.cosmos.framework.auth.Auth;
import com.cosmos.framework.auth.CosmosSessionUserInfo;
import com.cosmos.framework.code.Code;
import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.MaintenanceCommentDto;
import com.photome.dto.MaintenanceHistoryDto;
import com.photome.resmanage.ResourceManage;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/techsupport/maintenance/comment")
public class BoothCommentController {

	@Resource(name = "techSupport")
	private TechSupport techSupport;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "attachFile")
	private AttachFile attachFile;

	@Resource(name = "user")
	private User user;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "auth")
	private Auth auth;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/techsupport/maintenance/comment/main");
		String boothId = request.getParameter("boothId");
		String groupId = request.getParameter("groupId");

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String sessionUserId = null;
		if (sessionUser != null) {
			sessionUserId = sessionUser.getUserInfo().getUserId();
		}

		// 이전페이지에서 그룹ID와 브스 아이디가 넘어오는 경우 페이지에서 기본적으로 보여주기위한 작업
		List<BoothDto> boothList = null;
		mav.addObject("groupId", groupId);
		mav.addObject("boothId", boothId);
		if (!StringUtils.isBlank(groupId)) {
			// 해당 Booth 목록을 얻어온다.
			HashMap<String, String> param = new HashMap<String, String>();
			param.put("groupId", groupId);
			boothList = resManage.getBoothInfoList(param);

			StringBuffer boothOptions = new StringBuffer("");
			for (BoothDto dto : boothList) {
				boothOptions.append("<option value='" + dto.getBoothId() + "'");
				if (StringUtils.endsWith(boothId, dto.getBoothId())) boothOptions.append(" selected ");
				boothOptions.append(">" + dto.getBoothName() + "</option>");
			}
			mav.addObject("boothList", boothOptions.toString());
		}

		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));
		mav.addObject("claimStatusOptions", code.getOptionsForHTML("PHOTOME", "CLAIM_STATUS"));
		mav.addObject("sessionUserId", sessionUserId);

		return mav;
	}

	@RequestMapping(value = "/HistoryList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getHistoryList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<MaintenanceHistoryDto> list = null;

		String groupId = request.getParameter("groupId");
		String boothId = request.getParameter("boothId");
		String pstState = request.getParameter("pstState");
		String creator = request.getParameter("creator");
		String claimType = request.getParameter("claimType");
		String claimStatus = request.getParameter("claimStatus");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(pstState)) param.put("pstState", pstState);
		if (StringUtils.isNotBlank(creator)) param.put("creator", creator);
		if (StringUtils.isNotBlank(claimType)) param.put("claimType", claimType);
		if (StringUtils.isNotBlank(claimStatus)) param.put("claimStatus", claimStatus);

		list = techSupport.getMaintenanceHistoryList(param);

		model.put("list", list);

		return model;
	}

	@RequestMapping(value = "/CommentList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getCommentList(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		List<MaintenanceCommentDto> list = null;

		String historyId = request.getParameter("historyId");
		list = techSupport.getHistoryCommentList(historyId);

		model.put("commentList", list);

		return model;
	}

	@RequestMapping("/HistoryInfo")
	public ModelAndView getHistoryInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/techsupport/maintenance/comment/historyInfo");
		String historyId = request.getParameter("historyId");
		MaintenanceHistoryDto historyDto = techSupport.getMaintenanceHistoryInfo(historyId);

		AttachFileDto attachFileDto = null;
		String attachFileId = historyDto.getAttachFile();
		if (!StringUtils.isEmpty(attachFileId)) {
			attachFileDto = attachFile.getFileInfo(attachFileId);
		}

		mav.addObject("attachFileDto", attachFileDto);
		mav.addObject("historyDto", historyDto);

		return mav;
	}

	@RequestMapping(value = "/CommentRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> registHistory(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;
		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);
		String sessionUserId = null;
		if (sessionUser != null) {
			sessionUserId = sessionUser.getUserInfo().getUserId();
		}

		String comment = request.getParameter("comment");
		String historyId = request.getParameter("historyId");

		if (StringUtils.isNotBlank(comment)) param.put("comment", comment);
		if (StringUtils.isNotBlank(historyId)) param.put("historyId", historyId);
		if (StringUtils.isNotBlank(sessionUserId)) param.put("creator", sessionUserId);

		updateCnt = techSupport.insertHistoryComment(param);

		model.put("message", updateCnt);
		return model;
	}

	@RequestMapping(value = "/CommentModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyComment(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String comment = request.getParameter("comment");
		String commentId = request.getParameter("commentId");

		if (StringUtils.isNotBlank(comment)) param.put("comment", comment);
		if (StringUtils.isNotBlank(commentId)) param.put("commentId", commentId);

		updateCnt = techSupport.insertHistoryComment(param);
		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/CommentDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> deleteComment(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;
		String commentId = request.getParameter("commentId");

		updateCnt = techSupport.deleteHistoryComment(commentId);
		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/BoothListOfGroup", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getBoothListOfGroup(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		String groupId = request.getParameter("groupId");
		String boothName = request.getParameter("boothName");
		String technician = request.getParameter("technician");
		String status = request.getParameter("status");
		String locState = request.getParameter("locState");
		String serialNo = request.getParameter("serialNo");
		String printerModel = request.getParameter("printerModel");
		String captureType = request.getParameter("captureType");
		String tagDueDt = request.getParameter("tagDueDt");
		String qualityTestResult = request.getParameter("qualityTestResult");
		String type = request.getParameter("type");
		String boothComment = request.getParameter("boothComment");
		String monitorType = request.getParameter("monitorType");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothName)) param.put("boothName", boothName);
		if (StringUtils.isNotBlank(technician)) param.put("technician", technician);
		if (StringUtils.isNotBlank(status)) param.put("status", status);
		if (StringUtils.isNotBlank(locState)) param.put("locState", locState);
		if (StringUtils.isNotBlank(serialNo)) param.put("serialNo", serialNo);
		if (StringUtils.isNotBlank(printerModel)) param.put("printerModel", printerModel);
		if (StringUtils.isNotBlank(captureType)) param.put("captureType", captureType);
		if (StringUtils.isNotBlank(tagDueDt)) param.put("tagDueDt", tagDueDt);
		if (StringUtils.isNotBlank(qualityTestResult)) param.put("qualityTestResult", qualityTestResult);
		if (StringUtils.isNotBlank(type)) param.put("type", type);
		if (StringUtils.isNotBlank(boothComment)) param.put("boothComment", boothComment);
		if (StringUtils.isNotBlank(monitorType)) param.put("monitorType", monitorType);

		List<BoothDto> list = resManage.getBoothInfoList(param);
		model.put("boothList", list);

		return model;
	}

	@RequestMapping("/GroupInfoJson")
	@ResponseBody
	public ModelAndView groupInfoForJson(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();

		String groupId = request.getParameter("groupId");
		BoothGroupDto groupDto = resManage.getBoothGroupInfo(groupId);

		AttachFileDto attachFileDto = null;
		String attachFileId = groupDto.getAttachFile();
		if (!StringUtils.isEmpty(attachFileId)) {
			attachFileDto = attachFile.getFileInfo(attachFileId);
		}

		mav.addObject("groupDto", groupDto);
		mav.addObject("attachFileDto", attachFileDto);

		return mav;
	}

	@RequestMapping("/BoothInfoJson")
	@ResponseBody
	public ModelAndView boothInfoForJaon(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();

		String boothId = request.getParameter("boothId");
		BoothDto boothDto = resManage.getBoothInfo(boothId);

		mav.addObject("boothDto", boothDto);

		return mav;
	}

	@RequestMapping("/GroupInfo")
	public ModelAndView groupInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/common/groupInfo");

		String groupId = request.getParameter("groupId");
		BoothGroupDto groupDto = resManage.getBoothGroupInfo(groupId);

		AttachFileDto attachFileDto = null;
		String attachFileId = groupDto.getAttachFile();
		if (!StringUtils.isEmpty(attachFileId)) {
			attachFileDto = attachFile.getFileInfo(attachFileId);
		}

		mav.addObject("groupDto", groupDto);
		mav.addObject("attachFileDto", attachFileDto);

		return mav;
	}

	@RequestMapping("/BoothInfo")
	@ResponseBody
	public ModelAndView boothInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/common/boothInfo");

		String boothId = request.getParameter("boothId");
		BoothDto boothDto = resManage.getBoothInfo(boothId);

		mav.addObject("boothDto", boothDto);

		return mav;
	}

	@RequestMapping("/UserDetailInfo")
	public ModelAndView userDetailInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/common/userDetailInfo");

		UserDto userDto = new UserDto();

		String userId = request.getParameter("userId");
		userDto = user.getUserInfo(userId);

		String userTypeName = null;
		CodeDto cdoeDto = code.getCodeInfo("SYSTEM", "USER_TYPE", userDto.getUserType());
		if (cdoeDto != null) userTypeName = cdoeDto.getCodeName();

		String birthDt = userDto.getBirthDt();
		if (!StringUtils.isEmpty(birthDt) && StringUtils.length(birthDt) == 8) {
			birthDt = StringUtils.substring(birthDt, 0, 2) + "/" + StringUtils.substring(birthDt, 2, 4) + "/" + StringUtils.substring(birthDt, 4);
		}
		userDto.setBirthDt(birthDt);
		userDto.setUserTypeName(userTypeName);

		mav.addObject("userPhoto", user.getProfilePhoto(userId));
		mav.addObject("userDto", userDto);

		return mav;
	}

}
