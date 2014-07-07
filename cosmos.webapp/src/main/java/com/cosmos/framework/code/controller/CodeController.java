/**
 * 2013 CodeController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.code.controller;

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

import com.cosmos.framework.code.Code;
import com.cosmos.framework.code.CodeDto;

/**
 * 코드관리 콘트롤
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/framework/codemanager")
public class CodeController {
	private static final Logger logger = LoggerFactory.getLogger(CodeController.class);

	@Resource(name = "code")
	private Code code;

	@RequestMapping("/Main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView("framework/code/main");
		return mav;
	}

	@RequestMapping(value = "/SystemCodeList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getSystemCodeList(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		List<CodeDto> list = code.getSystemCodeList();

		model.put("message", list);
		return model;
	}

	@RequestMapping(value = "/CategoryCodeList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getCategoryCodeList(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		String systemCd = request.getParameter("systemCd");
		List<CodeDto> list = code.getCategoryCodeList(systemCd);

		model.put("message", list);

		return model;
	}

	@RequestMapping(value = "/CodeList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getCodeList(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		List<CodeDto> list = null;

		String systemCd = request.getParameter("systemCd");
		String categoryCd = request.getParameter("categoryCd");
		String codeName = request.getParameter("codeName");

		if (StringUtils.isNotEmpty(systemCd)) param.put("systemCd", systemCd);
		if (StringUtils.isNotEmpty(categoryCd)) param.put("categoryCd", categoryCd);
		if (StringUtils.isNotEmpty(codeName)) param.put("codeName", "%" + codeName + "%");

		list = code.getCodeList(param);

		model.put("message", list);

		return model;
	}

	@RequestMapping(value = "/ExistCodeInfo", produces = "application/json")
	@ResponseBody
	public Map<String, Object> existCodeInfo(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		String systemCd = request.getParameter("systemCd");
		String categoryCd = request.getParameter("categoryCd");
		String codeValue = request.getParameter("codeValue");

		model.put("message", code.existCode(systemCd, categoryCd, codeValue));

		return model;
	}

	@RequestMapping("/CodeRegistForm")
	public ModelAndView codeRegistForm() {
		ModelAndView mav = new ModelAndView("framework/code/codeRegistForm");
		return mav;
	}

	@RequestMapping(value = "/CodeRegist", produces = "application/json")
	@ResponseBody
	public Map<String, Object> codeRegist(HttpServletRequest request) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String systemCd = request.getParameter("systemCd");
		String categoryCd = request.getParameter("categoryCd");
		String codeValue = request.getParameter("codeValue");
		String codeName = request.getParameter("codeName");
		String descript = request.getParameter("descript");
		String useYn = request.getParameter("useYn");
		String codeLvl = request.getParameter("codeLvl");

		param.put("systemCd", StringUtils.upperCase(systemCd));
		param.put("categoryCd", StringUtils.upperCase(categoryCd));
		param.put("codeValue", codeValue);
		param.put("codeName", codeName);
		param.put("descript", descript);
		param.put("useYn", useYn);
		param.put("codeLvl", codeLvl);

		updateCnt = code.insertCodeInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping("/CodeModifyForm")
	public ModelAndView modifyCodeInfoForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/code/codeModifyForm");

		CodeDto codeDto = new CodeDto();

		String systemCd = request.getParameter("systemCd");
		String categoryCd = request.getParameter("categoryCd");
		String codeValue = request.getParameter("codeValue");

		codeDto = code.getCodeInfo(systemCd, categoryCd, codeValue);

		mav.addObject("codeDto", codeDto);

		return mav;
	}

	@RequestMapping(value = "/CodeModify", produces = "application/json")
	@ResponseBody
	public Map<String, Object> modifyCodeInfo(HttpServletRequest request) throws Exception {
		HashMap<String, String> param = new HashMap<String, String>();
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String systemCd = request.getParameter("systemCd");
		String categoryCd = request.getParameter("categoryCd");
		String codeValue = request.getParameter("codeValue");
		String codeName = request.getParameter("codeName");
		String descript = request.getParameter("descript");
		String useYn = request.getParameter("useYn");
		String codeLvl = request.getParameter("codeLvl");

		param.put("systemCd", StringUtils.upperCase(systemCd));
		param.put("categoryCd", StringUtils.upperCase(categoryCd));
		param.put("codeValue", codeValue);
		param.put("codeName", codeName);
		param.put("descript", descript);
		param.put("useYn", useYn);
		param.put("codeLvl", codeLvl);

		updateCnt = code.modifyCodeInfo(param);

		model.put("message", updateCnt);

		return model;
	}

	@RequestMapping(value = "/CodeDelete", produces = "application/json")
	@ResponseBody
	public Map<String, Object> deleteCodeInfo(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		int updateCnt = 0;

		String jsonParam = request.getParameter("jsonParam");
		logger.info(jsonParam);

		Map<String, Object> classMap = new HashMap<String, Object>();
		JSONObject jsonObject = JSONObject.fromObject(jsonParam);

		Map<String, Object> jsonModel = (Map<String, Object>) JSONObject.toBean(jsonObject, HashMap.class, classMap);
		ArrayList<Object> keyList = (ArrayList<Object>) jsonModel.get("list");

		updateCnt = code.deleteCodeInfos(keyList);

		model.put("message", updateCnt);

		return model;
	}

}
