/**
 * 2013 RefundController.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.refund;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;

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
import com.cosmos.framework.common.Common;
import com.cosmos.framework.common.PostAddrDto;
import com.cosmos.framework.user.User;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BoothDto;
import com.photome.dto.BoothGroupDto;
import com.photome.dto.RefundDto;
import com.photome.resmanage.ResourceManage;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/money/refund")
public class RefundController {

	@Resource(name = "refund")
	private Refund refund;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "common")
	private Common common;

	@Resource(name = "code")
	private Code code;

	@Resource(name = "user")
	private User user;

	@Resource(name = "auth")
	private Auth auth;

	@Resource(name = "attachFile")
	private AttachFile attachFile;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/refund/main");

		mav.addObject("refundStatusListOptions", code.getOptionsForHTML("PHOTOME", "REFUND_STATUS"));
		mav.addObject("stateListOptions", common.getStateComboOptions(""));
		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));

		return mav;
	}

	@RequestMapping(value = "/RefundList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> refundList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<RefundDto> list = null;

		String groupId = request.getParameter("groupId");
		String boothId = request.getParameter("boothId");
		String fromReqDt = request.getParameter("fromReqDt");
		String toReqDt = request.getParameter("toReqDt");
		String reqState = request.getParameter("reqState");
		String reqFirstname = request.getParameter("reqFirstname");
		String refundStatus = request.getParameter("refundStatus");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(fromReqDt)) param.put("fromReqDt", fromReqDt);
		if (StringUtils.isNotBlank(toReqDt)) param.put("toReqDt", toReqDt);
		if (StringUtils.isNotBlank(reqState)) param.put("reqState", reqState);
		if (StringUtils.isNotBlank(reqFirstname)) param.put("reqFirstname", reqFirstname);
		if (StringUtils.isNotBlank(refundStatus)) param.put("refundStatus", refundStatus);

		list = refund.getRefundList(param);

		JSONArray jsonList = new JSONArray();
		jsonList = JSONArray.fromObject(JSONSerializer.toJSON(list));

		model.put("jsonList", jsonList);

		return model;
	}

	@RequestMapping(value = "/BoothListOfGroup", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getBoothListOfGroup(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		String groupId = request.getParameter("groupId");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);

		List<BoothDto> list = resManage.getBoothInfoList(param);
		model.put("boothList", list);

		return model;
	}

	@RequestMapping("/MoneyRefundRegistForm")
	public ModelAndView moneyRefundRegistForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/refund/moneyRefundRegistForm");

		mav.addObject("refundStatusListOptions", code.getOptionsForHTML("PHOTOME", "REFUND_STATUS"));

		return mav;
	}

	@RequestMapping(value = "/MoneyRefundRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyRefundRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		String boothId = request.getParameter("boothId");
		String refundDt = request.getParameter("refundDt");
		String reqFirstname = request.getParameter("reqFirstname");
		String reqLastname = request.getParameter("reqLastname");
		String reqPostcd = request.getParameter("reqPostcd");
		String reqState = request.getParameter("reqState");
		String reqSuburb = request.getParameter("reqSuburb");
		String reqStreetNo = request.getParameter("reqStreetNo");
		String reqContactInfo = request.getParameter("reqContactInfo");
		String refundReason = request.getParameter("refundReason");
		String refundAmount = request.getParameter("refundAmount");
		String refundStatus = request.getParameter("refundStatus");
		String reqDt = request.getParameter("reqDt");
		String creator = sessionUser.getUserInfo().getUserId();

		if (!StringUtils.isBlank(boothId)) param.put("boothId", boothId);
		if (!StringUtils.isBlank(refundDt)) param.put("refundDt", refundDt);
		if (!StringUtils.isBlank(reqFirstname)) param.put("reqFirstname", reqFirstname);
		if (!StringUtils.isBlank(reqLastname)) param.put("reqLastname", reqLastname);
		if (!StringUtils.isBlank(reqPostcd)) param.put("reqPostcd", reqPostcd);
		if (!StringUtils.isBlank(reqState)) param.put("reqState", reqState);
		if (!StringUtils.isBlank(reqSuburb)) param.put("reqSuburb", reqSuburb);
		if (!StringUtils.isBlank(reqStreetNo)) param.put("reqStreetNo", reqStreetNo);
		if (!StringUtils.isBlank(reqContactInfo)) param.put("reqContactInfo", reqContactInfo);
		if (!StringUtils.isBlank(refundReason)) param.put("refundReason", refundReason);
		if (!StringUtils.isBlank(refundAmount)) param.put("refundAmount", refundAmount);
		if (!StringUtils.isBlank(refundStatus)) param.put("refundStatus", refundStatus);
		if (!StringUtils.isBlank(reqDt)) param.put("reqDt", reqDt);
		if (!StringUtils.isBlank(creator)) param.put("creator", creator);

		updateCnt = refund.registRefundInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/MoneyRefundInfo")
	public ModelAndView moneyRefundInfo(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/refund/moneyRefundInfo");

		String refundId = request.getParameter("refundId");

		RefundDto refundDto = refund.getRefundInfo(refundId);
		mav.addObject("refundDto", refundDto);

		return mav;
	}

	@RequestMapping("/MoneyRefundModifyForm")
	public ModelAndView moneyRefundModifyForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/refund/moneyRefundModifyForm");

		String refundId = request.getParameter("refundId");

		RefundDto refundDto = refund.getRefundInfo(refundId);
		mav.addObject("refundDto", refundDto);

		List<PostAddrDto> postAddrList = (List<PostAddrDto>) common.getPostAddress(refundDto.getReqPostcd()).get("postAddrList");
		mav.addObject("postAddrList", postAddrList);

		mav.addObject("refundStatusListOptions", code.getOptionsForHTML("PHOTOME", "REFUND_STATUS", refundDto.getRefundStatus()));

		return mav;
	}

	@RequestMapping(value = "/MoneyRefundModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> moneyRefundModify(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		CosmosSessionUserInfo sessionUser = auth.getSessionUserInfo(request);

		String refundId = request.getParameter("refundId");
		String boothId = request.getParameter("boothId");
		String refundDt = request.getParameter("refundDt");
		String reqFirstname = request.getParameter("reqFirstname");
		String reqLastname = request.getParameter("reqLastname");
		String reqPostcd = request.getParameter("reqPostcd");
		String reqState = request.getParameter("reqState");
		String reqSuburb = request.getParameter("reqSuburb");
		String reqStreetNo = request.getParameter("reqStreetNo");
		String reqContactInfo = request.getParameter("reqContactInfo");
		String refundReason = request.getParameter("refundReason");
		String refundAmount = request.getParameter("refundAmount");
		String refundStatus = request.getParameter("refundStatus");
		String reqDt = request.getParameter("reqDt");
		String creator = sessionUser.getUserInfo().getUserId();

		if (!StringUtils.isBlank(refundId)) param.put("refundId", refundId);
		if (!StringUtils.isBlank(boothId)) param.put("boothId", boothId);
		if (!StringUtils.isBlank(refundDt)) param.put("refundDt", refundDt);
		if (!StringUtils.isBlank(reqFirstname)) param.put("reqFirstname", reqFirstname);
		if (!StringUtils.isBlank(reqLastname)) param.put("reqLastname", reqLastname);
		if (!StringUtils.isBlank(reqPostcd)) param.put("reqPostcd", reqPostcd);
		if (!StringUtils.isBlank(reqState)) param.put("reqState", reqState);
		if (!StringUtils.isBlank(reqSuburb)) param.put("reqSuburb", reqSuburb);
		if (!StringUtils.isBlank(reqStreetNo)) param.put("reqStreetNo", reqStreetNo);
		if (!StringUtils.isBlank(reqContactInfo)) param.put("reqContactInfo", reqContactInfo);
		if (!StringUtils.isBlank(refundReason)) param.put("refundReason", refundReason);
		if (!StringUtils.isBlank(refundAmount)) param.put("refundAmount", refundAmount);
		if (!StringUtils.isBlank(refundStatus)) param.put("refundStatus", refundStatus);
		if (!StringUtils.isBlank(reqDt)) param.put("reqDt", reqDt);
		if (!StringUtils.isBlank(creator)) param.put("creator", creator);

		updateCnt = refund.updateRefundInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/SelectBooth")
	public ModelAndView selectBooth(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/refund/selectBooth");
		mav.addObject("stateListOptions", common.getStateComboOptions(""));
		mav.addObject("groupListOptions", resManage.getGroupComboOptions(""));
		return mav;
	}

	@RequestMapping("/SelectAddressFrom")
	public ModelAndView selectAddressForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("business/money/refund/selectAddress");
		mav.addObject("stateListOptions", common.getStateComboOptions(""));
		return mav;
	}

	@RequestMapping(value = "/SelectAddress", produces = "application/json")
	@ResponseBody
	public Map<String, Object> selectAddress(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<PostAddrDto> list = null;

		String state = request.getParameter("state");
		String locality = request.getParameter("suburb");

		if (StringUtils.isNotBlank(state)) param.put("state", state);
		if (StringUtils.isNotBlank(locality)) param.put("locality", locality);

		list = common.getAddressList(param);

		JSONArray jsonList = new JSONArray();
		jsonList = JSONArray.fromObject(JSONSerializer.toJSON(list));

		model.put("jsonList", jsonList);

		return model;
	}

	@RequestMapping(value = "/BoothInfoList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothInfoList(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		HashMap<String, String> param = new HashMap<String, String>();
		List<BoothDto> list = null;

		String groupId = request.getParameter("groupId");
		String boothId = request.getParameter("boothId");
		String locState = request.getParameter("locState");
		String serialNo = request.getParameter("serialNo");

		if (StringUtils.isNotBlank(groupId)) param.put("groupId", groupId);
		if (StringUtils.isNotBlank(boothId)) param.put("boothId", boothId);
		if (StringUtils.isNotBlank(locState)) param.put("locState", locState);
		if (StringUtils.isNotBlank(serialNo)) param.put("serialNo", serialNo);

		list = resManage.getBoothInfoList(param);

		model.put("list", list);

		return model;
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

	@RequestMapping(value = "/DeleteRefundInfo", produces = "application/json")
	@ResponseBody
	public Map<String, Object> deleteRefundInfo(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String refundId = request.getParameter("refundId");
		updateCnt = refund.deleteRefundInfo(refundId);

		model.put("message", updateCnt);

		return model;
	}

}
