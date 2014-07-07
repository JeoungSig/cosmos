/**
 * 2013 SQLQueryController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.common.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.framework.common.Common;

/**
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/framework/query")
public class SQLQueryController {
	private static final Logger logger = LoggerFactory.getLogger(SQLQueryController.class);

	@Resource(name = "common")
	private Common common;

	@RequestMapping("/Main")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("framework/query/main");
		String sql = request.getParameter("sql");

		List<Map> resultList = null;
		Iterator<String> headers = null;
		
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String timeStr = dayTime.format(new Date(time));
		String message = "Inquery OK! : " + timeStr;

		try {
			if (StringUtils.isNotBlank(sql)) {
				resultList = common.selectCommonSQL(sql);

				if (resultList != null) {
					Map map = resultList.get(0);
					headers = map.keySet().iterator();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			message = e.getMessage();
		}

		mav.addObject("message", message);
		mav.addObject("sql", sql);
		mav.addObject("headers", headers);
		mav.addObject("resultList", resultList);

		return mav;
	}

}
