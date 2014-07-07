/**
 * 2013 CodeService.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.code.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.cosmos.framework.code.Code;
import com.cosmos.framework.code.CodeDto;
import com.cosmos.framework.code.dao.CodeDao;

/**
 * @author Steven J.S Min
 * 
 */
public class CodeService implements Code {

	@Resource(name = "codeDao")
	private CodeDao codeDao;

	@Override
	public CodeDto getCodeInfo(String systemCd, String categoryCd, String codeValue) throws Exception {
		if (StringUtils.isBlank(systemCd) || StringUtils.isBlank(categoryCd) || StringUtils.isBlank(codeValue))
			throw new Exception("Check SYSTEM_CD, CATEGORY_CD or CODE_VALUE value for get code information");

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("systemCd", systemCd);
		param.put("categoryCd", categoryCd);
		param.put("codeValue", codeValue);

		return codeDao.getCodeInfo(param);
	}

	@Override
	public List<CodeDto> getCodeList(HashMap<String, String> param) throws Exception {
		return codeDao.getCodeList(param);
	}

	@Override
	public List<CodeDto> getCodeList(String systemCd, String categoryCd) throws Exception {
		if (StringUtils.isBlank(systemCd) || StringUtils.isBlank(categoryCd))
			throw new Exception("SYSTEM_CD or CATEGORY_CD are can not be empty. Check these values");
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("systemCd", systemCd);
		param.put("categoryCd", categoryCd);

		return this.getCodeList(param);
	}

	@Override
	public boolean existCode(String systemCd, String categoryCd, String codeValue) throws Exception {
		boolean exist = false;

		CodeDto codeDto = this.getCodeInfo(systemCd, categoryCd, codeValue);
		if (codeDto != null) exist = true;

		return exist;
	}

	@Override
	public Integer deleteCodeInfo(String systemCd, String categoryCd, String codeValue) throws Exception {
		if (StringUtils.isBlank(systemCd) || StringUtils.isBlank(categoryCd) || StringUtils.isBlank(codeValue))
			throw new Exception("Check SYSTEM_CD, CATEGORY_CD or CODE_VALUE value for delete code information");

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("systemCd", systemCd);
		param.put("categoryCd", categoryCd);
		param.put("codeValue", codeValue);

		return codeDao.deleteCodeInfo(param);
	}

	@Override
	public Integer deleteCodeInfos(ArrayList<Object> keyList) throws Exception {
		return codeDao.deleteCodeInfos(keyList);
	}

	@Override
	public List<CodeDto> getSystemCodeList() throws Exception {
		return codeDao.getSystemCodeList();
	}

	@Override
	public List<CodeDto> getCategoryCodeList(String systemCd) throws Exception {
		if (StringUtils.isBlank(systemCd)) throw new Exception("Check SYSTEM_CD value for get category list");
		return codeDao.getCategoryCodeList(systemCd);
	}

	@Override
	public Integer insertCodeInfo(HashMap<String, String> map) throws Exception {

		String systemCd = map.get("systemCd");
		String categoryCd = map.get("categoryCd");
		String codeValue = map.get("codeValue");

		if (StringUtils.isBlank(systemCd) || StringUtils.isBlank(categoryCd) || StringUtils.isBlank(codeValue))
			throw new Exception("Check SYSTEM_CD, CATEGORY_CD or CODE_VALUE value for regist code information");

		if (this.existCode(systemCd, categoryCd, codeValue)) {
			throw new Exception("This code information already exist check value : SYSTEM_CD:" + systemCd + ", CATEGORY_CD:" + categoryCd
					+ ", CODE_VALUE:" + codeValue);
		}

		return codeDao.insertCodeInfo(map);
	}

	@Override
	public Integer modifyCodeInfo(HashMap<String, String> map) throws Exception {
		return codeDao.modifyCodeInfo(map);
	}

	@Override
	public String getOptionsForHTML(String systemCd, String categoryCd) throws Exception {
		return this.getOptionsForHTML(systemCd, categoryCd, "");
	}

	@Override
	public String getOptionsForHTML(String systemCd, String categoryCd, String defaultSelectedValue) throws Exception {
		if (StringUtils.isBlank(systemCd) || StringUtils.isBlank(categoryCd))
			throw new Exception("Check SYSTEM_CD or CATEGORY_CD for make option elements of code information");

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("systemCd", systemCd);
		param.put("categoryCd", categoryCd);
		List<CodeDto> codeList = codeDao.getCodeList(param);

		return this.generateComboOptions(codeList, defaultSelectedValue);
	}

	@Override
	public String getSystemComboOptionsForHTML(String defaultSelectedValue) throws Exception {
		List<CodeDto> list = this.getSystemCodeList();
		StringBuffer options = new StringBuffer("<option></option>");
		for (CodeDto dto : list) {
			options.append("<option value= \"" + dto.getSystemCd() + "\" "
					+ (StringUtils.equals(dto.getSystemCd(), defaultSelectedValue) ? " selected" : "") + ">" + dto.getSystemCd() + "</option>");
		}
		return options.toString();
	}

	@Override
	public String getCategoryComboOptionsForHTML(String systemCd, String defaultSelectedValue) throws Exception {
		if (StringUtils.isBlank(systemCd)) throw new Exception("Check SYSTEM_CD value for make option elements of category code information");

		List<CodeDto> list = this.getCategoryCodeList(systemCd);

		StringBuffer options = new StringBuffer("<option></option>");
		for (CodeDto dto : list) {
			options.append("<option value= \"" + dto.getSystemCd() + "\" "
					+ (StringUtils.equals(dto.getCategoryCd(), defaultSelectedValue) ? " selected" : "") + ">" + dto.getCategoryCd() + "</option>");
		}
		return options.toString();
	}

	private String generateComboOptions(List<CodeDto> codeList, String defaultSelectedValue) {
		StringBuffer options = new StringBuffer("<option></option>");
		for (CodeDto dto : codeList) {
			options.append("<option value= \"" + dto.getCodeValue() + "\" "
					+ (StringUtils.equals(dto.getCodeValue(), defaultSelectedValue) ? " selected" : "") + ">" + dto.getCodeName() + "</option>");
		}
		return options.toString();
	}

}
