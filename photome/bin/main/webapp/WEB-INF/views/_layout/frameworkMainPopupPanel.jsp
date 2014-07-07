<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<html>
<head>
<tiles:insertAttribute name="globalHeader" />

<title><tiles:getAsString name="title" /></title>
<tiles:insertAttribute name="resource" />

<link rel="stylesheet" type="text/css" href="/photome/resources/css/sys_admin.css" />

</head>
<body id="physical_body">
    <table style="width: 100%; background-color: #004E9B">
        <tr>
            <td style="text-indent: 5px;">
                <div class="subMenu"><tiles:getAsString name="title" /></div>
            </td>
        </tr>
    </table>
    <br/>
    <div id="main">
        <tiles:insertAttribute name="main" />
    </div>
    <table style="width: 100%;" cellspacing="0" cellpadding="0">
        <tr>
            <td style="width: 60%; text-indent: 5px; color: #BCBCBC">
                <div id="pageLog" style="display: block; height:15px; overflow: hidden;" onclick="viewPageLog(this)"></div>
            </td>
            <td style="width: *; text-indent: 5px; color: #BCBCBC">&nbsp;</td>
        </tr>
    </table>
    
</body>
</html>
<tiles:insertAttribute name="globalFooter" />