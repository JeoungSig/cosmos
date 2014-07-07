/**
 * 2013 PhotoMeReport_03_Controller.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.report.controller;

import java.util.Calendar;
import java.util.GregorianCalendar;
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

import com.cosmos.framework.code.Code;
import com.cosmos.framework.user.UserDto;
import com.photome.dto.BoothDto;
import com.photome.dto.MoneyCollectRptDto;
import com.photome.report.service.PhotoMeReport;
import com.photome.resmanage.ResourceManage;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/business/report/photome/03")
public class PhotoMeReport_03_Controller {

	@Resource(name = "photoMeReport")
	private PhotoMeReport photoMeReport;

	@Resource(name = "resManage")
	private ResourceManage resManage;

	@Resource(name = "code")
	private Code code;

	@RequestMapping("/Main")
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView("business/report/photome/03/main");

		int curYear = GregorianCalendar.getInstance().get(Calendar.YEAR);

		StringBuffer yearOptions = new StringBuffer("");
		yearOptions.append("<option></option>");
		for (int i = (curYear + 3); i > (curYear - 5); i--) {
			yearOptions.append("<option value=\"" + i + "\"" + (i == curYear ? " selected " : "") + ">" + i + "</option>");
		}

		List<UserDto> collectorList = photoMeReport.getCollectorList(Integer.toString(curYear), null);
		StringBuffer collectorOptions = new StringBuffer("<option></option>");
		for (UserDto userDto : collectorList) {
			collectorOptions.append("<option value=\"" + userDto.getUserId() + "\">" + userDto.getFirstName() + "</option>");
		}

		mav.addObject("yearOptions", yearOptions.toString());
		mav.addObject("collectorOptions", collectorOptions.toString());

		return mav;
	}

	@RequestMapping(value = "/ReportDataList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> boothInfoList(HttpServletRequest request) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		HashMap<String, String> param = new HashMap<String, String>();

		List<MoneyCollectRptDto> list = null;

		String collectYear = request.getParameter("collectYear");
		String userId = request.getParameter("collectCollector");

		if (StringUtils.isNotBlank(collectYear)) param.put("collectYear", collectYear);
		if (StringUtils.isNotBlank(userId)) param.put("userId", userId);

		list = photoMeReport.getReportDataForRpt03(param);

		model.put("list", list);

		return model;
	}

}
