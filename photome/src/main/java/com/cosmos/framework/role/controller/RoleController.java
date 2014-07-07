/**
 * 2013 RoleController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.role.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.framework.role.Role;
import com.cosmos.framework.role.RoleDto;
import com.cosmos.framework.service.ServiceDto;
import com.cosmos.framework.service.dao.ServiceDao;

/**
 * 롤관리 콘트롤
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/framework/rolemanager")
public class RoleController {
	private static final Logger logger = LoggerFactory.getLogger(RoleController.class);

	@Resource(name = "role")
	private Role role;

	@Resource(name = "serviceDao")
	private ServiceDao serviceDao;

	@RequestMapping("/Main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView("framework/role/main");
		return mav;
	}

	@RequestMapping(value = "/RoleList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getRoleList(HttpServletRequest request) throws Exception {

		logger.debug("등록된 정보들을 조회한다.");
		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<RoleDto> list = null;

		String roleName = request.getParameter("roleName");
		if (StringUtils.isEmpty(roleName)) {
			roleName = "%";
		} else {
			roleName = "%" + roleName + "%";
		}

		list = role.getRoleList(param);

		model.put("list", list);

		return model;
	}

	@RequestMapping("/RoleRegistForm")
	public ModelAndView codeRegistForm() {
		ModelAndView mav = new ModelAndView("framework/role/roleRegistForm");
		return mav;
	}

	@RequestMapping(value = "/RoleRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> roleRegist(HttpServletRequest request) throws Exception {

		logger.debug("롤정보 등록");
		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String roleName = request.getParameter("roleName");
		String roleDesc = request.getParameter("roleDesc");
		String useYn = request.getParameter("useYn");

		// param.put("roleId", new Integer(roleId).toString());
		param.put("roleName", roleName);
		param.put("roleDesc", roleDesc);
		param.put("useYn", useYn);

		updateCnt = role.insertRoleInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/RoleModifyForm")
	public ModelAndView modifyRoleInfoForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/role/roleModifyForm");

		RoleDto roleDto = new RoleDto();

		HashMap<String, String> param = new HashMap<String, String>();
		String roleId = request.getParameter("roleId");

		roleDto = role.getRoleInfo(roleId);

		mav.addObject("roleDto", roleDto);

		return mav;
	}

	@RequestMapping(value = "/RoleModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyRoleInfo(HttpServletRequest request) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String roleId = request.getParameter("roleId");
		String roleName = request.getParameter("roleName");
		String roleDesc = request.getParameter("roleDesc");
		String useYn = request.getParameter("useYn");

		param.put("roleId", roleId);
		param.put("roleName", roleName);
		param.put("roleDesc", roleDesc);
		param.put("useYn", useYn);

		updateCnt = role.modifyRoleInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/RoleDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> deleteRoleInfo(HttpServletRequest request) throws Exception, NoSuchMethodException {
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String roleId = request.getParameter("roleId");

		updateCnt = role.deleteRoleInfo(roleId);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/RoleServiceMapping")
	public ModelAndView roleServiceMapping(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/role/serviceMapping");
		RoleDto roleDto = new RoleDto();

		String roleId = request.getParameter("roleId");
		roleDto = role.getRoleInfo(roleId);

		mav.addObject("roleDto", roleDto);

		return mav;

	}

	@RequestMapping(value = "/RoleServiceMappingApply", produces = "application/json")
	@ResponseBody
	public Map<String, Object> applyMapping(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String jsonParam = request.getParameter("jsonParam");
		logger.info(jsonParam);

		Map<String, Object> classMap = new HashMap<String, Object>();
		JSONObject jsonObject = JSONObject.fromObject(jsonParam);

		Map<String, Object> jsonModel = (Map<String, Object>) JSONObject.toBean(jsonObject, HashMap.class, classMap);
		ArrayList<Object> services = (ArrayList<Object>) jsonModel.get("list");

		updateCnt = role.applyMappingWithService(services);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/RoleServiceMappingRemove", produces = "application/json")
	@ResponseBody
	public Map<String, Object> applyMappingRemove(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String jsonParam = request.getParameter("jsonParam");
		logger.info(jsonParam);

		Map<String, Object> classMap = new HashMap<String, Object>();
		JSONObject jsonObject = JSONObject.fromObject(jsonParam);

		Map<String, Object> jsonModel = (Map<String, Object>) JSONObject.toBean(jsonObject, HashMap.class, classMap);
		ArrayList<Object> services = (ArrayList<Object>) jsonModel.get("list");
		String roleId = (String) jsonModel.get("roleId");

		updateCnt = role.removeRoleMappingWithService(roleId, services);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/ServiceListWithNotMapped", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getServiceListWithNotMapped(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<ServiceDto> list = null;

		String roleId = request.getParameter("roleId");
		String svcName = request.getParameter("svcName");
		String useYn = request.getParameter("useYn");
		String svcPrefix = request.getParameter("svcPrefix");
		String authRequired = request.getParameter("authRequired");

		if (StringUtils.isEmpty(svcName)) {
			svcName = "%";
		} else {
			svcName = "%" + svcName + "%";
		}

		try {
			param.put("roleId", roleId);
			param.put("svcName", svcName);
			param.put("useYn", useYn);
			param.put("svcPrefix", svcPrefix);
			param.put("authRequired", authRequired);
			list = serviceDao.getServiceListWithNotMapped(param);

		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("list", list);

		return model;
	}

	@RequestMapping(value = "/ServiceListWithMapped", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getServiceListWithMapped(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<ServiceDto> list = null;

		String roleId = request.getParameter("roleId");

		param.put("roleId", roleId);
		list = serviceDao.getServiceListWithMapped(param);

		model.put("list", list);

		return model;
	}

}
