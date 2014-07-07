/**
 * 2013 ServiceController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.service.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.framework.CosmosContext;
import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.code.dao.CodeDao;
import com.cosmos.framework.service.ServiceDto;
import com.cosmos.framework.service.dao.ServiceDao;

/**
 * 서비스관리 콘트롤
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/framework/servicemanager")
public class ServiceController {
	private static final Logger logger = LoggerFactory.getLogger(ServiceController.class);

	@Resource(name = "serviceDao")
	private ServiceDao serviceDao;

	@Resource(name = "codeDao")
	private CodeDao codeDao;

	@RequestMapping("/Main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView("framework/service/main");
		return mav;
	}

	@RequestMapping(value = "/ServiceList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getServiceList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<ServiceDto> list = null;

		String svcName = request.getParameter("svcName");
		String useYn = request.getParameter("useYn");
		String isMenu = request.getParameter("isMenu");
		String svcPrefix = request.getParameter("svcPrefix");
		String authRequired = request.getParameter("authRequired");

		if (StringUtils.isEmpty(svcName)) {
			svcName = "%";
		} else {
			svcName = "%" + svcName + "%";
		}

		try {
			param.put("svcName", svcName);
			param.put("useYn", StringUtils.isEmpty(useYn) ? null : useYn);
			param.put("isMenu", StringUtils.isEmpty(isMenu) ? null : isMenu);
			param.put("svcPrefix", StringUtils.isEmpty(svcPrefix) ? null : svcPrefix);
			param.put("authRequired", StringUtils.isEmpty(authRequired) ? null : authRequired);
			list = serviceDao.getServiceList(param);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("list", list);

		return model;
	}

	@RequestMapping("/ServiceRegistForm")
	public ModelAndView serviceRegistForm() throws Exception {
		ModelAndView mav = new ModelAndView("framework/service/serviceRegistForm");
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("systemCd", "SYSTEM");
		param.put("categoryCd", "SVC_TYPE");

		List<CodeDto> list = null;

		list = codeDao.getCodeList(param);
		mav.addObject("urlPrefix", list);

		return mav;
	}

	@RequestMapping(value = "/ServiceRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> serviceRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		int updateCnt = 0;

		String svcName = request.getParameter("svcName");
		String svcDesc = request.getParameter("svcDesc");
		String isDummy = request.getParameter("isDummy");
		String isMenu = request.getParameter("isMenu");
		String upperSvc = request.getParameter("upperSvc");
		String svcPrefix = request.getParameter("svcPrefix");
		String svcUrl = request.getParameter("svcUrl");
		String creator = request.getParameter("creator");
		String authRequired = request.getParameter("authRequired");
		String useYn = request.getParameter("useYn");

		if (!svcUrl.startsWith("/")) svcUrl = "/" + svcUrl;
		if (svcPrefix.endsWith("/")) svcPrefix = StringUtils.substringBeforeLast(svcPrefix, "/");

		if (StringUtils.equals(isDummy, "Y")) {
			svcPrefix = null;
			svcUrl = null;
		}
		if (StringUtils.isEmpty(upperSvc)) upperSvc = null;

		// 서비스가 메뉴형태로 사용될 경우가 아니면 트리구조로 구성될 필요가 없다.
		if (StringUtils.equalsIgnoreCase(isMenu, "N")) {
			upperSvc = null;
		}

		// param.put("svcId", new Integer(svcId).toString());
		param.put("svcName", svcName);
		param.put("isDummy", isDummy);
		param.put("isMenu", isMenu);
		param.put("upperSvc", upperSvc);
		param.put("svcDesc", svcDesc);
		param.put("svcPrefix", svcPrefix);
		param.put("svcUrl", svcUrl);
		param.put("creator", creator);
		param.put("authRequired", authRequired);
		param.put("useYn", useYn);

		try {
			updateCnt = serviceDao.insertServiceInfo(param);
			appyContext();
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/ExistServiceByUrl", produces = "application/json")
	@ResponseBody
	public Map<String, Object> existServiceByUrl(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();

		String svcUrl = request.getParameter("svcUrl");
		String svcPrefix = request.getParameter("svcPrefix");

		if (!svcUrl.startsWith("/")) svcUrl = "/" + svcUrl;
		if (svcPrefix.endsWith("/")) svcPrefix = StringUtils.substringBeforeLast(svcPrefix, "/");

		param.put("svcPrefix", svcPrefix);
		param.put("svcUrl", svcUrl);

		if (serviceDao.existServiceInfoByUrl(svcPrefix, svcUrl)) {
			ServiceDto service = serviceDao.getServiceInfoByUrl(svcPrefix, svcUrl);
			model.put("message", "'" + service.getSvcName() + "'의 URL으로 이미 등록된 서비스입니다.");
			model.put("status", "true");
		} else {
			model.put("status", "false");
			model.put("message", "");
		}

		return model;
	}

	@RequestMapping("/ServiceModifyForm")
	public ModelAndView modifyServiceInfoForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/service/serviceModifyForm");

		ServiceDto service = new ServiceDto();

		HashMap<String, String> param = new HashMap<String, String>();
		String svcId = request.getParameter("svcId");
		param.put("svcId", svcId);

		// 서비스 Prefix목록을 구한다.
		HashMap<String, String> paramForUrlPrefix = new HashMap<String, String>();
		paramForUrlPrefix.put("systemCd", "SYSTEM");
		paramForUrlPrefix.put("categoryCd", "SVC_TYPE");
		List<CodeDto> listUrlPrefix = null;
		listUrlPrefix = codeDao.getCodeList(paramForUrlPrefix);
		mav.addObject("urlPrefix", listUrlPrefix);

		try {
			service = serviceDao.getServiceInfo(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("service", service);

		return mav;
	}

	@RequestMapping(value = "/ServiceTypes", produces = "application/json")
	@ResponseBody
	public Map<String, Object> setServiceTypes(HttpServletRequest request) throws Exception {

		// 서비스 Prefix목록을 구한다.
		HashMap<String, String> paramForUrlPrefix = new HashMap<String, String>();
		paramForUrlPrefix.put("systemCd", "SYSTEM");
		paramForUrlPrefix.put("categoryCd", "SVC_TYPE");
		List<CodeDto> listUrlPrefix = null;
		listUrlPrefix = codeDao.getCodeList(paramForUrlPrefix);

		Map<String, Object> model = new HashMap<String, Object>();

		model.put("urlPrefix", listUrlPrefix);

		return model;
	}

	@RequestMapping(value = "/ServiceModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyServiceInfo(HttpServletRequest request) {
		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String svcId = request.getParameter("svcId");
		String svcName = request.getParameter("svcName");
		String svcDesc = request.getParameter("svcDesc");
		String svcPrefix = request.getParameter("svcPrefix");
		String isDummy = request.getParameter("isDummy");
		String isMenu = request.getParameter("isMenu");
		String upperSvc = request.getParameter("upperSvc");
		String svcUrl = request.getParameter("svcUrl");
		String creator = request.getParameter("creator");
		String authRequired = request.getParameter("authRequired");
		String useYn = request.getParameter("useYn");

		if (!StringUtils.isEmpty(svcUrl)) {
			if (!svcUrl.startsWith("/")) svcUrl = "/" + svcUrl;
		}

		if (!StringUtils.isEmpty(svcPrefix)) {
			if (svcPrefix.endsWith("/")) svcPrefix = StringUtils.substringBeforeLast(svcPrefix, "/");
		}

		if (StringUtils.equals(isDummy, "Y")) {
			svcPrefix = null;
			svcUrl = null;
		}
		if (StringUtils.isEmpty(upperSvc)) upperSvc = null;

		// 서비스가 메뉴형태로 사용될 경우가 아니면 트리구조로 구성될 필요가 없다.
		if (StringUtils.equalsIgnoreCase(isMenu, "N")) {
			upperSvc = null;
		}

		param.put("svcId", svcId);
		param.put("svcName", svcName);
		param.put("isDummy", isDummy);
		param.put("isMenu", isMenu);
		param.put("upperSvc", upperSvc);
		param.put("svcDesc", svcDesc);
		param.put("svcPrefix", svcPrefix);
		if (!StringUtils.isEmpty(svcUrl)) param.put("svcUrl", svcUrl);
		param.put("creator", creator);
		param.put("authRequired", authRequired);
		param.put("useYn", useYn);

		try {
			updateCnt = serviceDao.modifyServiceInfo(param);
			appyContext();
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/ServiceDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> deleteServiceInfo(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String svcId = request.getParameter("svcId");

		try {
			updateCnt = serviceDao.deleteServiceInfo(svcId);
		} catch (Exception e) {
			e.printStackTrace();

		}

		model.put("message", updateCnt);
		appyContext();

		return model;
	}

	/**
	 * 변경된 정보를 컨텍스트 환경 변수에도 반영한다.
	 * 
	 * @throws Exception
	 */
	private void appyContext() throws Exception {
		CosmosContext.NO_LIMITED_SERVICE_MAP = serviceDao.getServiceListForNotAuthReq();

	}
}
