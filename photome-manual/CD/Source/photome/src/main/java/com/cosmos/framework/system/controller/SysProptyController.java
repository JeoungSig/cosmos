/**
 * 2013 SysProptyController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.system.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.common.AttachFileDto;
import com.cosmos.framework.CosmosContext;
import com.cosmos.framework.system.SysProptyDto;
import com.cosmos.framework.system.dao.SysProptyDao;
import com.cosmos.framework.user.UserDto;

/**
 * 시스템 속성관리 콘트롤 클래스
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/framework/sysproperty")
public class SysProptyController {
	private static final Logger logger = LoggerFactory.getLogger(SysProptyController.class);

	@Resource(name = "sysProptyDao")
	private SysProptyDao sysProptyDao;

	@RequestMapping("/Main")
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView("framework/sysproperty/main");
		HashMap<String, Object> sysProperty = getSysPropertyInfo();

		UserDto userDto = (UserDto) sysProperty.get("userDto");
		AttachFileDto fileDto = (AttachFileDto) sysProperty.get("fileDto");
		SysProptyDto propertyDto = (SysProptyDto) sysProperty.get("propertyDto");

		mav.addObject("propertyDto", propertyDto);
		mav.addObject("userDto", userDto);
		mav.addObject("fileDto", fileDto);

		return mav;
	}

	@RequestMapping("/AdministratorModifyForm")
	public ModelAndView modifyAdministratorForm() throws Exception {
		ModelAndView mav = new ModelAndView("framework/sysproperty/administratorModifyForm");
		return mav;
	}

	@RequestMapping(value = "/AdministratorModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyAdministrator(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		String userId = request.getParameter("userId");
		sysProptyDao.modifyAdministrator(userId);
		model.put("message", "Success to modify for administrator information");

		return model;
	}

	@RequestMapping("/AccessCheckExceptUrlModifyForm")
	public ModelAndView AccessCheckExceptUrlModifyForm() throws Exception {
		ModelAndView mav = new ModelAndView("framework/sysproperty/accessCheckExceptUrlModifyForm");

		Map<String, String> property = sysProptyDao.getSysPropertyInfo();
		mav.addObject("acessChkExceptUrl", property.get("acessChkExceptUrl"));
		return mav;
	}

	@RequestMapping(value = "/AccessCheckExceptUrlModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> accessCheckExceptUrlModify(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		String acessChkExceptUrl = request.getParameter("acessChkExceptUrl");

		// URL목록을 정렬하여 저장하도록 한다.
		StringBuffer sortedUrls = new StringBuffer("");
		ArrayList<String> ignorUrlList = null;
		if (StringUtils.isNotEmpty(acessChkExceptUrl)) {
			String tmpVar = org.springframework.util.StringUtils.trimAllWhitespace(acessChkExceptUrl);
			StringTokenizer token = new StringTokenizer(tmpVar, ",");
			ignorUrlList = new ArrayList<String>();
			while (token.hasMoreTokens()) {
				ignorUrlList.add(token.nextToken());
			}
			Collections.sort(ignorUrlList);

			for (int i = 0; ignorUrlList.size() > i; i++) {
				sortedUrls.append(ignorUrlList.get(i));
				if ((ignorUrlList.size() - 1) != i) {
					sortedUrls.append(",");
					sortedUrls.append("\n");
				}
			}
			acessChkExceptUrl = sortedUrls.toString();
		} else {
			acessChkExceptUrl = null;
		}

		sysProptyDao.accessCheckExceptUrlModify(acessChkExceptUrl);
		appyContext();// 시스템에 바로 변경을 적용하기위해 컨텍스트 변수에 적용한다.
		model.put("message", "Success to modify for excption URL of Access Check");

		return model;
	}

	@RequestMapping("/BasicInfoModifyForm")
	public ModelAndView basicInfoModifyForm() throws Exception {
		ModelAndView mav = new ModelAndView("framework/sysproperty/basicInfoModifyForm");

		Map<String, String> property = sysProptyDao.getSysPropertyInfo();

		AttachFileDto fileDto = new AttachFileDto();
		SysProptyDto propertyDto = new SysProptyDto();

		propertyDto.setSysId(((Integer) ((Object) property.get("sysId"))).toString());
		propertyDto.setSysName(property.get("sysName"));
		propertyDto.setSysDescript(property.get("sysDescript"));
		propertyDto.setCopyright(property.get("copyright"));
		fileDto.setFileId(((Integer) ((Object) property.get("fileId"))).toString());
		fileDto.setFileName(property.get("fileName"));
		fileDto.setSavedName(property.get("savedName"));
		fileDto.setInfoType(property.get("infoType"));

		mav.addObject("propertyInfo", propertyDto);
		mav.addObject("fileInfo", fileDto);

		return mav;
	}

	@RequestMapping(value = "/BasicInfoModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> basicInfoModify(HttpServletRequest request) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String sysName = request.getParameter("sysName");
		String sysDescript = request.getParameter("sysDescript");
		String copyright = request.getParameter("copyright");
		String fileId = request.getParameter("fileId");

		param.put("sysName", sysName);
		param.put("sysDescript", sysDescript);
		param.put("copyright", copyright);
		param.put("fileId", StringUtils.isEmpty(fileId) ? null : fileId);

		updateCnt = sysProptyDao.modifyBasicInfo(param);
		appyContext();// 시스템에 바로 변경을 적용하기위해 컨텍스트 변수에 적용한다.

		model.put("message", "Modified successfully");

		return model;
	}

	@RequestMapping("/DataUploadRootPathModifyForm")
	public ModelAndView DataUploadRootPathModifyForm() throws Exception {
		ModelAndView mav = new ModelAndView("framework/sysproperty/dataUploadRootPathModifyForm");

		Map<String, String> property = sysProptyDao.getSysPropertyInfo();

		mav.addObject("dataUploadRootpath", property.get("dataUploadRootpath"));

		return mav;
	}

	@RequestMapping(value = "/DataUploadRootPathModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> DataUploadRootPathModify(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String dataUploadRootpath = request.getParameter("dataUploadRootpath");
		updateCnt = sysProptyDao.modifyDataUploadRootPath(dataUploadRootpath);
		appyContext(); // 시스템에 바로 변경을 적용하기위해 컨텍스트 변수에 적용한다.

		model.put("message", "Modified successfully");

		return model;
	}

	/**
	 * 변경된 정보를 바로 반영하기위하여 적용한다.
	 * 
	 * @throws Exception
	 */
	private void appyContext() throws Exception {
		HashMap<String, Object> sysProperty = getSysPropertyInfo();

		UserDto userDto = (UserDto) sysProperty.get("userDto");
		AttachFileDto fileDto = (AttachFileDto) sysProperty.get("fileDto");
		SysProptyDto propertyDto = (SysProptyDto) sysProperty.get("propertyDto");

		// 시스템 기본속성, 로고 이미지, 시스템관리자 정보 설정
		CosmosContext.SYSTEM_PROPERTY = propertyDto;
		CosmosContext.SYSTEM_LOGOFILE = fileDto;
		CosmosContext.SYSTEM_ADMINISTRATOR = userDto;

	}

	/**
	 * 시스템 기본 설정값들을 구성하여 얻어온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	private HashMap<String, Object> getSysPropertyInfo() throws Exception {

		HashMap<String, Object> sysProperty = new HashMap<String, Object>();

		try {

			Map<String, String> property = sysProptyDao.getSysPropertyInfo();

			UserDto userDto = new UserDto();
			AttachFileDto fileDto = new AttachFileDto();
			SysProptyDto propertyDto = new SysProptyDto();

			propertyDto.setSysId(((Integer) ((Object) property.get("sysId"))).toString());
			propertyDto.setSysName(property.get("sysName"));
			propertyDto.setSysDescript(property.get("sysDescript"));
			propertyDto.setCopyright(property.get("copyright"));
			propertyDto.setAcessChkExceptUrl(property.get("acessChkExceptUrl"));
			propertyDto.setDataUploadRootpath(property.get("dataUploadRootpath"));

			userDto.setUserId(property.get("adminUserId"));
			userDto.setFirstName(property.get("firstName"));
			userDto.setEmail(property.get("email"));
			userDto.setMobilePhone(property.get("mobilePhone"));
			userDto.setTelephone(property.get("telephone"));

			fileDto.setFileId(((Integer) ((Object) property.get("fileId"))).toString());
			fileDto.setFileName(property.get("fileName"));
			fileDto.setSavedName(property.get("savedName"));
			fileDto.setFullPath(property.get("savedName"));
			fileDto.setInfoType(property.get("infoType"));

			sysProperty.put("propertyDto", propertyDto);
			sysProperty.put("userDto", userDto);
			sysProperty.put("fileDto", fileDto);
		} catch (Exception e) {
			logger.debug("시스템 기본정보를 조회하여 구성하는데 예외가 발생하였습니다.");
			e.printStackTrace();
		}

		return sysProperty;

	}

}
