<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<html>
<head>
<tiles:insertAttribute name="globalHeader" />
<title><tiles:getAsString name="title" /></title>
<tiles:insertAttribute name="resource" />
</head>
<body onload="loadPage();">
	<table width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td><tiles:insertAttribute name="main" /></td>
		</tr>
	</table>
</body>
</html>
<tiles:insertAttribute name="globalFooter" />