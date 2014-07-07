/** 
 * 2013 BaseController.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/")
public class BaseController {

	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String welcome(ModelMap model) {

		model.addAttribute("message", "Maven Web Project + Spring 3 MVC - welcome()");

		// Spring uses InternalResourceViewResolver and return back index.jsp
		return "index";

	}

	@RequestMapping(value = "/welcome/{name}", method = RequestMethod.GET)
	public String welcomeName(@PathVariable String name, ModelMap model) {

		model.addAttribute("message", "Maven Web Project + Spring 3 MVC - " + name);
		return "index";

	}

}
