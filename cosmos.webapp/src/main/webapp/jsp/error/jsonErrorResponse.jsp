<%@ page language="java" contentType="application/x-json; charset=UTF-8" pageEncoding="utf-8"%>
<% 
String errorCode = (String)request.getAttribute("dshr.framework.foundation.servlet.error.code");

if (errorCode == null || errorCode.equals("")) {
	response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "System Error Occured!!");
} else if (errorCode.equals("dshr.err.com.nosession")){
	response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Your session is expired!!");
}

%>
