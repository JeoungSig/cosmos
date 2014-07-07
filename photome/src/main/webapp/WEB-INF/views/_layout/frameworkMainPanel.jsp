<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="logfile" value="<%=com.cosmos.framework.CosmosContext.SYSTEM_LOGOFILE%>" />
<c:set var="sysProp" value="<%=com.cosmos.framework.CosmosContext.SYSTEM_PROPERTY%>" />

<html>
<head>
<tiles:insertAttribute name="globalHeader" />
<title><tiles:getAsString name="title" /></title>
<tiles:insertAttribute name="resource" />
<link rel="stylesheet" type="text/css" href="/photome/resources/css/sys_admin.css" />

<script type="text/javascript">
    function goHome() {
        document.location.href = "/photome/common/auth/Welcome.action";
    }
</script>
</head> 

<body id="physical_body">
    <table style="width: 100%;" cellspacing="0" cellpadding="0" bgcolor="#1A1A1A" border="0">
        <tr>
            <td rowspan="3" width="70px"><img src="/photome/image?file=<c:out value="${logfile.fullPath }" />" style="height: 80px;cursor: pointer; " alt="Cosmos Framework Ver.1.0"  onclick="javascript:goHome();"/></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td style="width: 230px; vertical-align: bottom;" rowspan="3"><tiles:insertAttribute name="header" /></td>
        </tr>
        <tr>
            <td style="width: 20px">&nbsp;</td>
            <td rowspan="2" style="vertical-align: bottom;"><div id="menu" style="vertical-align: bottom;">
                    <tiles:insertAttribute name="menu" />
                </div></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr style="height: 3px; background-color: #004E9B">
            <td colspan="5" style="height: 3px;"></td>
        </tr>
    </table>

    <table style="width: 100%" cellspacing="0" cellpadding="0">
        <tr>
            <td><div id="nav"><tiles:getAsString name="title" /></div></td>
        </tr>
    </table>

    <div id="main">
        <tiles:insertAttribute name="main" />
    </div>

    <table cellspacing="0" cellpadding="0">
        <tr>
            <td style="width: 400px; text-indent: 5px; color: #BCBCBC"><div id="pageLog" style="display: block; height:15px; overflow: hidden;" onclick="viewPageLog(this)"></div></td> 
        </tr>
    </table>

    <div id="footer">
        <tiles:insertAttribute name="footer" />
    </div>

</body>
</html>
<tiles:insertAttribute name="globalFooter" />