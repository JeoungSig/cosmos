/**
 * 2013 GroupManageController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.resmanage.controller;

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
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.resmanage.ResourceManage;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/resmanage/group")
public class GroupManageController {

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "attachFile")
	private AttachFile attachFile;

	@Resource(name = "auth")
	private Auth auth;

	@Resource(name = "code")
	private Code code;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/group/main");

		String groupName = request.getParameter("groupName");
		String useYn = request.getParameter("useYn");

		HashMap<String, Object> returnMap = resManage.resourceMainPage(groupName, useYn);
		HashMap<String, BoothGroupDto> groupMap = (HashMap<String, BoothGroupDto>) returnMap.get("groupMap");
		HashMap<String, List<BoothDto>> groupBoothMap = (HashMap<String, List<BoothDto>>) returnMap.get("groupBoothMap");

		mav.addObject("useYn", useYn);
		mav.addObject("groupMap", groupMap); // key:그룹ID, value:그룹DTO
		mav.addObject("groupBoothMap", groupBoothMap); // key:그룹ID, value:List<BoothDTO>
		mav.addObject("groupName", groupName);

		return mav;
	}

	@RequestMapping("/GroupInfo")
	@ResponseBody
	public ModelAndView groupInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/group/groupInfo");
		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		String groupId = request.getParameter("groupId");
		BoothGroupDto groupDto = resManage.getBoothGroupInfo(groupId);

		AttachFileDto attachFileDto = null;
		String attachFileId = groupDto.getAttachFile();
		if (!StringUtils.isEmpty(attachFileId)) {
			attachFileDto = attachFile.getFileInfo(attachFileId);
		}

		mav.addObject("sessionUser", sessionUser);
		mav.addObject("groupDto", groupDto);
		mav.addObject("attachFileDto", attachFileDto);

		return mav;
	}

	@RequestMapping(value = "/GroupList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getBoothGroupInfoList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<BoothGroupDto> list = null;

		String groupName = request.getParameter("groupName");
		String groupDescript = request.getParameter("groupDescript");
		String managerName = request.getParameter("managerName");

		param.put("groupName", groupName);
		param.put("groupDescript", groupDescript);
		param.put("managerName", managerName);
		
		list = resManage.getBoothGroupInfoList(param);
	
		model.put("list", list);

		return model;
	}

	@RequestMapping("/GroupInfoRegistForm")
	public ModelAndView groupInfoRegistForm() throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/group/groupInfoRegistForm");
		return mav;
	}

	@RequestMapping(value = "/GroupInfoRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> groupInfoRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String groupName = request.getParameter("groupName");
		String groupDescript = request.getParameter("groupDescript");
		String managerName = request.getParameter("managerName");
		String managerTel = request.getParameter("managerTel");
		String managerMobile = request.getParameter("managerMobile");
		String managerEmail = request.getParameter("managerEmail");
		String contractCondition = request.getParameter("contractCondition");
		String groupComment = request.getParameter("groupComment");
		String attachFile = request.getParameter("attachFile");

		param.put("groupName", groupName);
		param.put("groupDescript", groupDescript);
		param.put("managerName", managerName);
		param.put("managerTel", managerTel);
		param.put("managerMobile", managerMobile);
		param.put("managerEmail", managerEmail);
		param.put("contractCondition", contractCondition);
		param.put("groupComment", groupComment);
		if (!StringUtils.isEmpty(attachFile)) param.put("attachFile", attachFile);

		updateCnt = resManage.insertBoothGroupInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/GroupInfoUpdateForm")
	public ModelAndView groupInfoUpdateForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/resmanage/group/groupInfoUpdateForm");

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

	@RequestMapping(value = "/GroupInfoUpdate", produces = "application/json")
	@ResponseBody
	public Map<String, Object> groupInfoUpdate(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String groupId = request.getParameter("groupId");
		String groupName = request.getParameter("groupName");
		String groupDescript = request.getParameter("groupDescript");
		String managerName = request.getParameter("managerName");
		String managerTel = request.getParameter("managerTel");
		String managerMobile = request.getParameter("managerMobile");
		String managerEmail = request.getParameter("managerEmail");
		String contractCondition = request.getParameter("contractCondition");
		String groupComment = request.getParameter("groupComment");
		String attachFile = request.getParameter("attachFile");

		param.put("groupId", groupId);
		param.put("groupName", groupName);
		param.put("groupDescript", groupDescript);
		param.put("managerName", managerName);
		param.put("managerTel", managerTel);
		param.put("managerMobile", managerMobile);
		param.put("managerEmail", managerEmail);
		param.put("contractCondition", contractCondition);
		param.put("groupComment", groupComment);
		if (!StringUtils.isEmpty(attachFile)) param.put("attachFile", attachFile);

		updateCnt = resManage.updateBoothGroupInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/GroupInfoDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> groupInfoDelete(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String groupId = request.getParameter("groupId");
		updateCnt = resManage.deleteBoothGroupInfo(groupId);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/SetGroupUseYN", produces = "application/json")
	@ResponseBody
	public Map<String, Object> setGroupUseYN(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String groupId = request.getParameter("groupId");
		String useYn = request.getParameter("useYn");
		updateCnt = resManage.setGroupUseYN(groupId, useYn);

		model.put("message", updateCnt);

		return model;
	}

}
