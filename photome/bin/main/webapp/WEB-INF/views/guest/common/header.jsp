<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="logfile" value="<%=com.cosmos.framework.CosmosContext.SYSTEM_LOGOFILE%>" />
<c:set var="sysProp" value="<%=com.cosmos.framework.CosmosContext.SYSTEM_PROPERTY%>" />

<script type="text/javascript">
    function loadPage() {
    }
</script>
<table style="width: 100%; height: 90px" cellspacing="0" cellpadding="0" bgcolor="#002953" border="0">
	<tr>
		<td width="70px"><img src="/photome/image?file=<c:out value="${logfile.fullPath }" />" style="height: 80px" alt="<c:out value="${sysProp.sysName }" />" /></td>
		<td width="*" style="text-indent: 20px;"><b><font color="#D8D8D8" size="5px"><c:out value="${sysProp.sysName }" /></font></b></td>
	</tr>
</table>